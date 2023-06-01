# Install cypress

First install cypress as a dev dependency
```bash
npm install cypress --save-dev
```

# Run cypress manually

Execute using `npx`:
```bash
npx cypress open
```

# Run cypress through docker

Execute in this folder:
```bash
npm run up
```

This will start up all relevant services (dummy geonetwork for now), wait until geonetwork responds, then run tests in `e2e/cypress/e2e`
