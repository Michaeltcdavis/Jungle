describe('Product Detail Page', () => {
  beforeEach(() => {
    cy.visit("/");
    cy.get(".products article")
      .first()
      .click();
  });

  it("should contain the products show section", () => {
    cy.get("section.products-show").should("be.visible");
  });

})