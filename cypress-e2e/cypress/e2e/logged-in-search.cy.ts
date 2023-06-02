describe('template spec', () => {
  beforeEach('passes', () => {
    cy.visit(`/srv/eng/catalog.search`);
    cy.get('[data-ng-click="acceptCookies()"]').click();
  });

  it.only('should have results when logged in but not logged out', () => {
    cy.get('.search-over').contains('Search 0');
    cy.login();
    cy.get('.search-over').contains('Search 3')
  });
});
