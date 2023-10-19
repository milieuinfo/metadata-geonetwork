package be.vlaanderen.geonet.kernel.security.openidconnect;

import org.fao.geonet.constants.Geonet;
import org.fao.geonet.domain.*;
import org.fao.geonet.kernel.security.openidconnect.OidcUser2GeonetworkUser;
import org.fao.geonet.kernel.security.openidconnect.SimpleOidcUser;
import org.fao.geonet.repository.specification.UserGroupSpecs;
import org.fao.geonet.utils.Log;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

public class ACMIDMUser2GeonetworkUser extends OidcUser2GeonetworkUser {

    public UserDetails getUserDetails(OidcIdToken idToken, Map attributes, boolean withDbUpdate) throws Exception {
        SimpleOidcUser simpleUser = simpleOidcUserFactory.create(idToken, attributes);
        if (!StringUtils.hasText(simpleUser.getUsername()))
            return null;

        User user;
        boolean newUserFlag = false;
        try {
            user = (User) geonetworkAuthenticationProvider.loadUserByUsername(simpleUser.getUsername());
        } catch (UsernameNotFoundException e) {
            user = new User();
            user.setUsername(simpleUser.getUsername());
            newUserFlag = true;
            Log.debug(Geonet.SECURITY, "Adding a new user: " + user);
        }

        simpleUser.updateUser(user); // copy attributes from the IDToken to the GN user

        Map<Profile, List<String>> profileGroups = oidcRoleProcessor.getProfileGroups(idToken);
        user.setProfile(oidcRoleProcessor.getProfile(idToken));

        //Apply changes to database is required.
        if (withDbUpdate) {
            if (newUserFlag || oidcConfiguration.isUpdateProfile()) {
                userRepository.save(user);
            }
            if (newUserFlag || oidcConfiguration.isUpdateGroup()) {
                // ACM/IDM specific modification: pass the idtoken
                updateGroups(profileGroups, user, idToken);
            }
        }
        return user;
    }

    protected void updateGroups(Map<Profile, List<String>> profileGroups, User user, OidcIdToken idToken) {
        // First we remove all previous groups
        userGroupRepository.deleteAll(UserGroupSpecs.hasUserId(user.getId()));

        // ACM/IDM specific claims
        String userOrgCode = idToken.getClaim("vo_orgcode").toString();
        String userOrgName = idToken.getClaim("vo_orgnaam").toString();

        // Now we add the groups
        for (Profile p : profileGroups.keySet()) {
            List<String> groups = profileGroups.get(p);
            for (String technicalGroupName : groups) {

                String roleOrgCode = technicalGroupName.replaceFirst("(dp|mdv)-", "");
                boolean isDp = technicalGroupName.startsWith("dp-");
                // figure out the 'groupOwner' type, eventually used as a filter for the geonetwork portals
                String vlType = null;
                if(technicalGroupName.startsWith("mdv-")) {
                    vlType = "metadatavlaanderen";
                }
                else if(technicalGroupName.startsWith("dp-")) {
                    vlType = "datapublicatie";
                }
                else if(roleOrgCode.equals("OVO002949")) {
                    vlType = "digitaalvlaanderen";
                }

                Group group = groupRepository.findByOrgCodeAndVlType(roleOrgCode, vlType);
                String groupName = computeGroupName(userOrgCode, userOrgName, roleOrgCode, isDp);

                if (group == null) {
                    group = new Group();
                    group.setOrgCode(roleOrgCode);
                    group.setName(groupName);
                    // Populate languages for the group
                    for (Language l : langRepository.findAll()) {
                        group.getLabelTranslations().put(l.getId(), group.getName());
                    }
                }

                if (userOrgCode.equals(group.getOrgCode()) && !groupName.equals(group.getName())) {
                    // check if we need to modify the group name
                    group.setName(groupName);
                    // Populate languages for the group
                    for (Language l : langRepository.findAll()) {
                        group.getLabelTranslations().put(l.getId(), group.getName());
                    }
                }

                group.setVlType(vlType);
                groupRepository.save(group);

                UserGroup usergroup = new UserGroup();
                usergroup.setGroup(group);
                usergroup.setUser(user);

                Profile profile = p;
                if (profile.equals(Profile.Administrator)) {
                    // As we are assigning to a group, it is UserAdmin instead
                    profile = Profile.UserAdmin;
                }
                usergroup.setProfile(profile);

                //Todo - It does not seem necessary to add the user to the editor profile
                // since the reviewer is the parent of the editor
                // Seems like the permission checks should be smart enough to know that if a user
                // is a reviewer then they are also an editor.  Need to test and fix if necessary
                if (profile.equals(Profile.Reviewer)) {
                    UserGroup ug = new UserGroup();
                    ug.setGroup(group);
                    ug.setUser(user);
                    ug.setProfile(Profile.Editor);
                    userGroupRepository.save(ug);
                }

                userGroupRepository.save(usergroup);
            }
        }
    }

    private String computeGroupName(String userOrgCode,
                                    String userOrgName,
                                    String roleOrgCode,
                                    boolean isDp) {
        String dpPrefix = "Datapublicatie ";
        String result = "";
        if(roleOrgCode.equals(userOrgCode)) {
            result = (isDp ? dpPrefix + userOrgName : userOrgName);
        } else {
            result = (isDp ? dpPrefix + roleOrgCode : roleOrgCode);
        }
        return result;
    }
}
