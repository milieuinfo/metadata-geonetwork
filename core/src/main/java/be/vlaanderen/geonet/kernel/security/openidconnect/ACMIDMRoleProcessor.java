/*
 * Copyright (C) 2022 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */
package be.vlaanderen.geonet.kernel.security.openidconnect;

import org.fao.geonet.constants.Geonet;
import org.fao.geonet.domain.Profile;
import org.fao.geonet.kernel.security.openidconnect.OIDCConfiguration;
import org.fao.geonet.kernel.security.openidconnect.OIDCRoleProcessor;
import org.fao.geonet.utils.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;


/**
 * Custom implementation (ACM-IDM for Metadata Vlaanderen) for the OIDCRoleProcessor.
 */
public class ACMIDMRoleProcessor extends OIDCRoleProcessor {

    public List<String> simpleConvertRoles(List<String> originalRoleNames) {
        String roleGroupSeparator = oidcConfiguration.groupPermissionSeparator;
        String prefix = "DVMetadataVlaanderenGebruiker-";
        List<String> converted = originalRoleNames.stream()
                .filter(s -> s.startsWith(prefix) || s.equals(oidcConfiguration.minimumProfile))
                .map(s -> s.replaceFirst(prefix, ""))
                .map(s -> {
                    String[] split = s.split(roleGroupSeparator);
                    return split[1] + roleGroupSeparator + convertProfile(split[0]);
                })
                .collect(Collectors.toList());
        return super.simpleConvertRoles(converted);
    }

    private String convertProfile(String s) {
        switch (s) {
            case "hoofdeditor": return "Reviewer";
            case "editor": return "Editor";
            case "admin": return "Administrator";
            default: return s;
        }
    }
}
