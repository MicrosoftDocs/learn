Here, you will learn ...


## Use a workflow to publish to GitHub Packages

GitHub Packages allow you to safely publish and consume packages, store your packages alongside your code, and share your packages privately with your team or publicly with the open source community. You can also automate your packages with the use of GitHub Actions. 

Below is an example of what this could look like for a simple workflow that will run whenever a new release is created in the repository. If the tests pass, then the package will be published to GitHub Packages.

```yml
name: Node.js Package

on:
  release:
    types: [created]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: 12
      - run: npm ci
      - run: npm test

  publish-gpr:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: 12
          registry-url: https://npm.pkg.github.com/
      - run: npm ci
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

First, the workflow file will need to exist in the `.github/workflows` directory. Since this is a workflow that will publish a new package whenever a new release is created, it's common to name these workflows along the lines of `release-package.yml` to make is easy for project collaborators to understand its purpose without navigating through the workflow file. 

The above workflow does a few things after a new release is created.

1. A job named `build` runs `npm ci` (named after Continuous Integration)  to install dependencies directly from the `package-lock.json` file.
1. The job named `publish-gpr` is dependant on the `build` job to succeed before continuing with the workflow and publish the package.
1. The workflow needs an access token for authentication before publishing the package to the `registry-url: https://npm.pkg.github.com/`.

> [!Note]
> To authenticate using a GitHub Actions workflow for package registries (PACKAGE-REGISTRY.pkg.github.com), you can use a GITHUB_TOKEN or a personal access token.

To learn more about publishing a package to GitHub Packages, check out [Publishing a package](https://docs.github.com/en/packages/learn-github-packages/publishing-a-package).


## Use a workflow to publish to GitHub Container Registry

In the next unit, we'll use GitHub Actions to build a container image, and publish it into GitHub Packages.