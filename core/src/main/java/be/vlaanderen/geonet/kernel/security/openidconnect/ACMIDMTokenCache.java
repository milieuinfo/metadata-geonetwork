package be.vlaanderen.geonet.kernel.security.openidconnect;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.server.resource.authentication.BearerTokenAuthentication;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

public class ACMIDMTokenCache {

    static final Object lockobj = new Object();
    Map<String, BearerTokenAuthentication> cache = new HashMap<>();

    public Authentication getItem(String bearerToken) {
        synchronized (lockobj) {
            removeExpiredTokens();
            if (!cache.containsKey(bearerToken))
                return null;
            return cache.get(bearerToken);
        }
    }

    public void putItem(String bearerToken, BearerTokenAuthentication item) {
        synchronized (lockobj) {
            cache.put(bearerToken, item);
        }
    }

    private void removeExpiredTokens() {
        cache.entrySet().removeIf(e -> isExpired(e.getValue().getToken()));
    }

    private boolean isExpired(OAuth2AccessToken token) {
        return token.getExpiresAt()!=null && token.getExpiresAt().isBefore(Instant.now());
    }
}
