describe('template spec', () => {
  beforeEach('passes', () => {
    cy.visit(`/`);
    cy.get('[data-ng-click="acceptCookies()"]').click();
  });

  it.only('should show the admin username on the top bar when logged in', () => {
  cy.visit('/');
    cy.get('.dropdown-toggle').contains('Inloggen')
    cy.login();
    cy.get('.dropdown-toggle').contains('mdv admin')
  });
});
