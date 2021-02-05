Our goal in this module was to automate building and publishing container images into GitHub Packages.

You learned about: 

- When to use a Package Repository
- Set up a Continuous Integration (CI) workflow with GitHub Actions
- Create a Dockerfile
- Build a container image in CI
- Run locally a container image hosted on GitHub Docker Registry

By using GitHub Actions, we build our code and tested it, build a container image and then publish it to GitHub Packages.

While you can do all these steps in your local environment, we've automated the process. It will now run each time you made a change 
in the `Dockerfile`. With a small modification, we can run this automated process each time a pull request is opened, or merged into your main branch.

## Learn more

Here are some links to more information on the topics we discussed in this module.

- [Publishing a Package](https://docs.github.com/en/free-pro-team@latest/packages/publishing-and-managing-packages/publishing-a-package)
- [Using GitHub Packages with your project's ecosystem](https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem)
