
Up to this point we have focused on authoring our Gatsby app using React, GraphQL, plugins, and more to do so. The next step once you are done authoring is to build your application. After that you are able to deploy anywhere, you like from GitHub to any cloud service of your choice.

## Build your app

Gatsby's command-line tool provides a command to *build* your project to create something that you can deploy anywhere you like. The *production build* consists of HTML, JavaScript, CSS, and any additional assets you've included. This *production build* is the result of your Gatsby project being compiled and optimized and having JavaScript and CSS put into optimized bundles by Gatsby and the underlying React compiler.

```
Be a little more explicit about what "compiled" means - all the queries are run (and what else) to build a set of static files.
You call out production build a few times - is there another kind of build? What's the difference?
```

## Deploy it

There are many ways you could be deploying your built app. After all it's just HTML, CSS and JavaScript and can be hosted by most web services out there.

### Azure Static Web apps

This is a service in Azure that allows you to take some static files and put them in the cloud. What you deploy is not a deployment package but just a set of static files. This is a good fit for Gatsby as what Gatsby ends up producing from a build is static files.

Speaking of build, the service actually does the build step for you so there's no need to build anything up front. How it does this is by locating the `build` command in the `package.json` of the Gatsby project.

All you need is a GitHub repo with a Gatsby project in it for the service to build and deploy your site.

Currently your code sits in a directory on our machine. You will therefore need to carry out a few steps before being able to *deploy* namely:

1. Create a Git repository, currently your Gatsby project is a bunch of files living on our local computer
2. Create a GitHub repository, you need to push your local Git repository to GitHub
3. Deploy to the Cloud, for this part you will use the Static apps service. All you need for this step is the URL to your GitHub repository and the name for the sub directory where the static files live in your project. In Gatsby's case, this directory is called `public/`.
