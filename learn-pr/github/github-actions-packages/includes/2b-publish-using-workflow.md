Here, you will learn the basics of using a workflow to publish to GitHub Packages and the necessary steps to build, authenticate, tag, and push a Docker image to the GitHub Container Registry. 


## Use a workflow to publish to GitHub Packages

GitHub Packages enable you to securely publish and consume packages, store your packages alongside your code, and share your packages privately with your team or publicly with the open source community. You can also automate your packages with the use of GitHub Actions. 

Below is an example of a basic workflow that runs whenever a new release is created in the repository. If the tests pass, then the package is published to GitHub Packages.

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

First, the workflow file needs to exist in the `.github/workflows` directory. It is common practice to name a workflow that publishes a new package whenever a new release is created along the lines of `release-package.yml` to make is easy for project collaborators to understand its purpose without navigating through the workflow file. 

The above workflow does a few things after a new release is created:

1. A job named `build` runs `npm ci` (named after Continuous Integration)  to install dependencies directly from the `package-lock.json` file.
1. Once the `build` job succeeds, the job named `publish-gpr` publishes the package.
1. The workflow publishes the package to the `registry-url: https://npm.pkg.github.com/` using an access token for authentication.

## Use GitHub Container Registry to host and manage Docker container images

GitHub Packages supports trends towards containers, Kubernetes, and other cloud-native technologies to manage their entire application lifecycle – not just through development, release, and deployment, but for production operations as well. GitHub Packages also offers a container registry designed to support the unique needs of container images. You can use GitHub Container Registry to seamlessly host and manage Docker container images in your organization or personal user account on GitHub. GitHub Container Registry enables you to configure who can manage and access packages using fine-grained permissions.

With the container registry you can:

- Store container images within your organization and user account, rather than a repository.
- Set fine-grained permissions for the container images.
- Access public container images anonymously.

After you have built the image, authenticated and signed in to the GitHub Container Registry service at `ghcr.io`, you can then tag and push the latest version of the image to the container registry using the commands below:

```bash
echo $PAT | docker login ghcr.io -u USERNAME --password-stdin

docker tag IMAGE_ID ghcr.io/OWNER/IMAGE_NAME:latest

docker push ghcr.io/OWNER/IMAGE_NAME:latest
```

> [!Note]
> To authenticate using a GitHub Actions workflow:
>
>- For package registries `PACKAGE-REGISTRY.pkg.github.com`, you can use a GITHUB_TOKEN.
>- For the container registry `ghcr.io/OWNER/IMAGE-NAME`, you must use a personal access token.

In the next unit, you will use GitHub Actions to build a container image and publish it to GitHub Packages.
