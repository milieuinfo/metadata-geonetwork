package be.vlaanderen.geonet.kernel.security.openidconnect;

import java.util.HashMap;
import java.util.Map;

public class ACMIDMTokenCache {

    static final Object lockobj = new Object();
    Map<String, IntrospectedToken> cache = new HashMap<>();

    public IntrospectedToken getItem(String bearerToken) {
        synchronized (lockobj) {
            removeExpiredTokens();
            if (!cache.containsKey(bearerToken))
                return null;
            return cache.get(bearerToken);
        }
    }

    public void putItem(String bearerToken, IntrospectedToken item) {
        synchronized (lockobj) {
            cache.put(bearerToken, item);
        }
    }

    private void removeExpiredTokens() {
        cache.entrySet().removeIf(e -> e.getValue().isExpired());
    }
}
