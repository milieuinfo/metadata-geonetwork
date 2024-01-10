// ***********************************************
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************

/**
 * Login with the admin user. To be refined with other types of logins?
 */
Cypress.Commands.add('login', () => {
  cy.get('.logged-in-container:not(.ng-hide)').click();
  cy.get('#inputUsername').type('mdv');
  cy.get('#inputPassword').type('admin');
  cy.get(".signin-dropdown > .dropdown-menu [type='submit']").click();
});

/**
 * Accept cookies, if the button is present. Should be conditional, otherwise cypress fails on not finding the button,
 * which happens if the session has already accepted the cookie in a previous test.
 */
Cypress.Commands.add('acceptCookies', () => {
  cy.get('body').then(($body) => {
    var selector = 'button[data-ng-click="acceptCookies()"]';
    if($body.find(selector).length > 0) {
      cy.get(selector).then($button => {
        if($button.is(':visible')) {
          cy.get(selector).click();
        }
      });
    }
  });
});
