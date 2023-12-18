/*
describe('template spec', () => {
  beforeEach('passes', () => {
    cy.visit(`/`);
    cy.acceptCookies();
    // should be able to run this function twice without crashing
    cy.acceptCookies();
  });
  it.only('should show all default group options when editing a record', () => {
    cy.visit('/')
    cy.login();
    cy.visit('/srv/dut/catalog.edit#/metadata/108?redirectUrl=catalog.search%23%2Fmetadata%2Fb6934c23-bffa-40de-ac34-7f1f6e1dbdf1')
    // cy.get('#gn-info-list-mw-b6934c23-bffa-40de-ac34-7f1f6e1dbdf1').click()
    // cy.get('.gn-md-edit-btn').click()
    cy.get('[data-gn-metadata-group-updater="groupOwner"] > button').click()

    // check if we see all the expected vlheaders
    const vlHeaders = ['ABC', 'sample']
    cy.get('[data-ng-if="g.vlheader"]').should('have.length', vlHeaders.length);
    cy.get('[data-ng-if="g.vlheader"]').each((h) => {
      expect(vlHeaders).to.include(h.text());
    });
    cy.get('[data-gn-metadata-group-updater="groupOwner"] > ul > li').first().should('have.text', 'Verandering metadata groep');
    const expectedOptions = ['Digitaal Vlaanderen', 'DataPublicatie Digitaal Vlaanderen', 'Beheerd door jezelf', 'Beheerd door DataPublicatie', 'Beheerd door jezelf'];
    for (let i = 0; i < expectedOptions.length; i++) {
      cy.get('[data-ng-if="!g.vlheader"]').eq(i).should('contain', expectedOptions[i]);
    }
  })
})
*/
