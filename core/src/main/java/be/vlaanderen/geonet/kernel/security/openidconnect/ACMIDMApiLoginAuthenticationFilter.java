package be.vlaanderen.geonet.kernel.security.openidconnect;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.minidev.json.JSONObject;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.fao.geonet.kernel.security.openidconnect.OidcUser2GeonetworkUser;
import org.fao.geonet.utils.GeonetHttpRequestFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;
import org.springframework.security.oauth2.server.resource.InvalidBearerTokenException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

public class ACMIDMApiLoginAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    // TODO
    // static UserInfoCache userInfoCache = new UserInfoCache();

    @Autowired
    protected GeonetHttpRequestFactory requestFactory;

    @Autowired
    OidcUser2GeonetworkUser oidcUser2GeonetworkUser;

    private String introspectUrl;
    private String clientId;
    private String clientSecret;

    protected ACMIDMApiLoginAuthenticationFilter() {
        super("we don't use this parameter");
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request,
                                              HttpServletResponse response, AuthenticationException failed)
        throws IOException, ServletException {
        System.out.println("ACMIDMApiLoginAuthenticationFilter unsuccessfulAuthentication.");
        super.unsuccessfulAuthentication(request, response, failed);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authResult) {
        System.out.println("ACMIDMApiLoginAuthenticationFilter successfulAuthentication.");
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, IOException, ServletException {
        String bearerToken = getBearerToken(request).orElseThrow(() -> new InvalidBearerTokenException("No bearer token supplied."));
        IntrospectedToken validationToken = introspectToken(bearerToken);
        if (validationToken.isActive) {
            if(validationToken.scopes.stream().noneMatch(s -> s != null && s.startsWith("dv_metadata"))) {
                throw new InvalidBearerTokenException("Did not find a metadata scope for this client.");
            }
            OidcIdToken oidcIdToken = new OidcIdToken(validationToken.jwt, validationToken.issuedAt, validationToken.expiresAt, validationToken.toMap());
            try {
                oidcUser2GeonetworkUser.getUserDetails(oidcIdToken, validationToken.toMap(), true);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else {
            throw new InvalidBearerTokenException("Invalid token.");
        }
        return null;
    }

    /**
     * Introspect the bearer token with ACM/IDM, thereby validating it and retrieving the necessary client information.
     *
     * @param bearerToken
     * @return
     */
    private IntrospectedToken introspectToken(String bearerToken) {
        try {
            HttpPost introspectRequest = new HttpPost(introspectUrl);
            JSONObject json = new JSONObject();
            List<NameValuePair> nvps = new ArrayList<>();
            nvps.add(new BasicNameValuePair("client_id", clientId));
            nvps.add(new BasicNameValuePair("client_secret", clientSecret));
            nvps.add(new BasicNameValuePair("token_type_hint", "access_token"));
            nvps.add(new BasicNameValuePair("token", bearerToken));
            introspectRequest.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
            introspectRequest.addHeader("Accept", "application/json");
            introspectRequest.addHeader("Content-type", "application/x-www-form-urlencoded");
            try (ClientHttpResponse introspectResponse = requestFactory.execute(introspectRequest)) {
                System.out.println("response = " + introspectResponse);
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode tokenValidation = objectMapper.readTree(introspectResponse.getBody());
                Map<String, Object> result = objectMapper.convertValue(tokenValidation, new TypeReference<>() {
                });
                return new IntrospectedToken(tokenValidation);
            }
        } catch (Exception e) {
            throw new InvalidBearerTokenException("Could not introspect the bearer token: " + e);
        }
    }

    /**
     * Retrieve the bearer token from a request.
     *
     * @param request
     * @return
     */
    private Optional<String> getBearerToken(HttpServletRequest request) {
        String authentication = request.getHeader("Authorization");
        String bearerPrefix = "bearer ";
        if (authentication != null && !authentication.toLowerCase().startsWith(bearerPrefix)) {
            return Optional.empty();
        } else {
            return Optional.of(authentication.substring(bearerPrefix.length()));
        }
    }

    /**
     * Here, we want to authenticate when there is a bearer token present - indicating an ACMIDM API client.
     * Otherwise, we fall through to the regular ACMIDM oidc authentication.
     *
     * @param request
     * @param response
     * @return
     */
    @Override
    protected boolean requiresAuthentication(HttpServletRequest request, HttpServletResponse response) {
        String authorization = request.getHeader("Authorization");
        return authorization != null && authorization.startsWith("Bearer");
    }

    public void setIntrospectUrl(String introspectUrl) {
        this.introspectUrl = introspectUrl;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }
}
