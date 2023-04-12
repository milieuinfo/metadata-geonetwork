package be.vlaanderen.geonet.kernel.security.openidconnect;

import org.fao.geonet.kernel.security.openidconnect.OIDCConfiguration;
import org.fao.geonet.kernel.security.openidconnect.OIDCRoleProcessor;
import org.fao.geonet.kernel.security.openidconnect.SimpleOidcUserFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;

import java.util.Map;

public class SimpleACMIDMUserFactory extends SimpleOidcUserFactory {
    @Autowired
    OIDCConfiguration oidcConfiguration;

    @Autowired
    OIDCRoleProcessor oidcRoleProcessor;


    public SimpleACMIDMUser create(OidcIdToken idToken, Map attributes) throws Exception {
        return new SimpleACMIDMUser(oidcConfiguration, oidcRoleProcessor, idToken, attributes);
    }

    public SimpleACMIDMUser create(Map attributes) throws Exception {
        return new SimpleACMIDMUser(oidcConfiguration, oidcRoleProcessor, attributes);
    }
}
