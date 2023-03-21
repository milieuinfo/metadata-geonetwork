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
import org.fao.geonet.utils.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.oidc.web.logout.OidcClientInitiatedLogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * Based on GeonetworkOidcLogoutHandler, modified to suit ACM/IDM and the Metadata Vlaanderen setup.
 */
public class GeonetworkACMIDMLogoutHandler implements LogoutSuccessHandler {

    @Autowired
    ServletContext servletContext;

    OidcClientInitiatedLogoutSuccessHandler oidcClientInitiatedLogoutSuccessHandler;

    public GeonetworkACMIDMLogoutHandler(OidcClientInitiatedLogoutSuccessHandler oidcClientInitiatedLogoutSuccessHandler) throws URISyntaxException {
        this.oidcClientInitiatedLogoutSuccessHandler = oidcClientInitiatedLogoutSuccessHandler;
    }

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // TODO we had the same issue 'on login': at least here we can determine the http/https switch
        // only {baseUrl} is available in this method, so need to resort to non-template string.
        this.oidcClientInitiatedLogoutSuccessHandler.setPostLogoutRedirectUri(createPostLogoutRedirectUrl(request));
        oidcClientInitiatedLogoutSuccessHandler.onLogoutSuccess(request, response, authentication);
    }

    private String createPostLogoutRedirectUrl(HttpServletRequest request) {
        // TODO this might require a proper solution - for now using the same variable as in the login procedure, keeping it similar
        // Originally, the protocol was retrieved from the request. This is now disregarded.
        String protocol = System.getenv("ACMIDM_REDIRECTURI_SCHEME");
        if (protocol == null) {
            protocol = "https";
        }
        // String protocol = request.getProtocol();
        String host = request.getServerName();
        // int port = request.getServerPort();
        String path = servletContext.getContextPath();
        String result = protocol + "://" + host + path;
        return result;
    }
}
