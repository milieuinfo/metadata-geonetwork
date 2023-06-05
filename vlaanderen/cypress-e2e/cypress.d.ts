export {};

declare global {
  namespace Cypress {
    interface Chainable {
      login(): Chainable<void>;
      acceptCookies(): Chainable<void>;
    }
  }
}