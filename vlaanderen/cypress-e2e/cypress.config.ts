const { defineConfig } = require('cypress')

module.exports = defineConfig({
  reporter: "junit",
  reporterOptions: {
    mochaFile: "./cypress/results/TEST-[hash].xml"
  },
  viewportWidth: 1280,
  viewportHeight: 700,
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
    baseUrl: 'http://localhost:8080',
    env: {
      GN_BASE_URL: 'http://localhost:8080',
      ELECTRON_EXTRA_LAUNCH_ARGS: '--disable-gpu'
    }
  },
})
