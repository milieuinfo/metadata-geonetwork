const { defineConfig } = require('cypress')

module.exports = defineConfig({
  reporter: 'mochawesome',
  reporterOptions: {
    mochaFile: 'cypress/results/output.xml',
  },
  viewportWidth: 1280,
  viewportHeight: 700,
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
    baseUrl: 'http://localhost:8080/geonetwork',
    env: {
      GN_BASE_URL: 'http://localhost:8080'
    }
  },
})
