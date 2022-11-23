describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit("/");
    cy.get(".products article")
  });

  it("should contain the products show section", () => {
    cy.get(".products .btn").contains("Add")
      .first()
      .click({ force: true });
    cy.get(".navbar-nav").should("contain", "1")
  });

})