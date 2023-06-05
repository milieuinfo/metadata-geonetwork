# Install cypress

First install dependencies and package-lock.json
```bash
npm install cypress
```

# Run cypress manually

Execute using `npx`:
```bash
npx cypress open
```

The base url would be `localhost:8080` as configured in `cypress.config.js`.


# Run cypress through docker

The base url would be `geonetwork:8080` as configured in `docker-compose.yml`.

Execute in this folder:
```bash
npm run up
```

This will start up all relevant services (dummy geonetwork for now), wait until geonetwork responds, then run tests in `e2e/cypress/e2e`


# Add custom command

Custom commands like `login()` are added in the `commands.ts` file. Also modify `cypress.d.ts` to make sure their definitions are properly defined and can be type checked.