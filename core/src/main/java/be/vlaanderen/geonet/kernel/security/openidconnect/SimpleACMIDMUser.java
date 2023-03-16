package be.vlaanderen.geonet.kernel.security.openidconnect;

import org.fao.geonet.kernel.security.openidconnect.OIDCConfiguration;
import org.fao.geonet.kernel.security.openidconnect.OIDCRoleProcessor;
import org.fao.geonet.kernel.security.openidconnect.SimpleOidcUser;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;

import java.util.Map;

public class SimpleACMIDMUser extends SimpleOidcUser {
    SimpleACMIDMUser(OIDCConfiguration oidcConfiguration, OIDCRoleProcessor oidcRoleProcessor, OidcIdToken idToken, Map userAttributes) throws Exception {
        super(oidcConfiguration, oidcRoleProcessor, idToken, userAttributes);
        super.setEmail(super.getUsername());
    }

    SimpleACMIDMUser(OIDCConfiguration oidcConfiguration, OIDCRoleProcessor oidcRoleProcessor, Map attributes) throws Exception {
        super(oidcConfiguration, oidcRoleProcessor, attributes);
        super.setEmail(super.getUsername());
    }
}
