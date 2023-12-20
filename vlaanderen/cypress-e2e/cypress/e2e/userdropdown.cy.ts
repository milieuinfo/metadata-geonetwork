describe('userdropdown', () => {
  beforeEach('passes', () => {
    cy.visit(`/`)
    cy.acceptCookies()
    // should be able to run this function twice without crashing
    cy.acceptCookies()
  })
  it.only('should show the user info when logged in', () => {
    cy.visit('/')
    cy.login()
    cy.get('.aiv-login-wrapper').click()
    cy.get('.logged-in-container[data-ng-show="authenticated"] ul.aiv-signin-dropdown').within(() => {
      cy.get('li:nth-child(3)').should('have.text', 'Gebruikersnaam')
      cy.get('li:nth-child(4)').should('contain.text', 'mdv admin')
    })
  })
})
