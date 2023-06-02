describe('template spec', () => {
  beforeEach('passes', () => {
    cy.visit(`/`);
    cy.get('.gn-alerts > .alert > .btn').click();
    cy.get('[data-ng-click="acceptCookies()"]').click();
  });

  it.only('should have results when logged in but not logged out', () => {
  cy.visit('/');
    cy.get('.search-over').contains('Search 0');
    cy.login();
    cy.get('.search-over').contains('Search 3')
  });
});
