describe('Mainpage tests', () => {
  it('Loads the main page and navigates to the right url', () => {
    cy.visit('http://localhost:8080/geonetwork')
    cy.contains('Close').click()
    cy.contains('Accept').click()
    cy.url().should('contains', 'srv/eng/catalog.search#/home')
  })
})
