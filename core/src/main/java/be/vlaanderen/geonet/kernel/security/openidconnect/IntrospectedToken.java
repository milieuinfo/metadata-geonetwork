package be.vlaanderen.geonet.kernel.security.openidconnect;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import org.springframework.security.oauth2.server.resource.InvalidBearerTokenException;

import java.time.Instant;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Represents the resulting token that we get from ACM/IDM API after introspection.
 */
public class IntrospectedToken {

    final boolean isActive;
    final Instant expiresAt;
    final Instant issuedAt;
    final List<String> scopes;
    final String applicationName;
    final String orgName;
    final String sub;
    final JsonNode json;
    final String jwt;

    public IntrospectedToken(JsonNode json) {
        try {
            this.isActive = json.get("active").asBoolean();
            if (isActive) {
                //when is this token valid until
                this.expiresAt = Instant.ofEpochMilli(json.get("exp").asLong() * 1000);
                this.issuedAt = Instant.ofEpochMilli(json.get("iat").asLong() * 1000);
                this.scopes = Arrays.stream(json.get("scope").asText().split(" "))
                    .filter(s -> !s.isEmpty())
                    .collect(Collectors.toList());
                this.applicationName = json.get("vo_applicatienaam").asText();
                this.orgName = json.get("vo_orgnaam").asText();
                this.sub = json.get("sub").asText();
                this.jwt = json.get("jwt").asText();
            } else {
                this.expiresAt = null;
                this.issuedAt = null;
                this.scopes = null;
                this.applicationName = null;
                this.orgName = null;
                this.sub = null;
                this.jwt = null;
            }
            this.json = json;
        } catch (Exception e) {
            List<String> missingFields = Lists.newArrayList("exp", "iat", "scope", "vo_applicatienaam", "vo_orgnaam", "sub", "jwt")
                .stream().filter(s -> !json.has(s)).collect(Collectors.toList());
            throw new InvalidBearerTokenException("Invalid json supplied, could not create an IntrospectedToken. Perhaps you forgot to supply the vo_info scope? The following desired fields were not found in the json: "+ String.join(", ", missingFields));
        }
    }

    public Map<String, Object> toMap() {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> stringObjectMap = objectMapper.convertValue(json, new TypeReference<>() {
        });
        stringObjectMap.put("vo_email", this.sub);
        return stringObjectMap;
    }

    public boolean isExpired() {
        return (expiresAt.compareTo(Instant.now()) < 0);
    }
}
