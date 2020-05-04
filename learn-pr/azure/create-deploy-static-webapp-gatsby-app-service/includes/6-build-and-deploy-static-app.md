
Up to this point we have focused on authoring our Gatsby app using React, GraphQL and plugins. The next step once you are done authoring is to build your application. After that you are able to deploy to any web server or hosting service that can serve static files.

## Build your app

Gatsby's command-line tool provides a command to *build* your project to create something that you can deploy anywhere you like. The *production build* consists of HTML, JavaScript, CSS, and any additional assets you've included. This *production build* is the result of your Gatsby project being compiled and optimized and having JavaScript and CSS put into optimized bundles by Gatsby and the underlying React compiler.

```
Be a little more explicit about what "compiled" means - all the queries are run (and what else) to build a set of static files.
You call out production build a few times - is there another kind of build? What's the difference?
```

## Deploy it

There are many technologies and services capable of hosting built app. After all it's just HTML, CSS and JavaScript and can be hosted by most web services out there. For this tutorial, we'll deploy to Static Web Apps, an Azure service that specializes in hosting static apps like those built with Gatsby.

### Azure Static Web Apps

Static Web Apps is an Azure service that allows you to take some static files and serve them from the cloud. What you deploy is not a deployment package but just a set of static files. This is a good fit for Gatsby as what Gatsby ends up producing from a build is static files.

Speaking of build, the service actually does the build step for you so there's no need to build anything up front. How it does this is by locating the `build` command in the `package.json` of the Gatsby project. All you need to do is put your project in a GitHub repository.

Currently your code sits in a directory on your machine, so you'll need to do a few things to deploy Azure:

1. **Initialize a Git repository**: Right now, your Gatsby project is in a directory that hasn't been initialized as a Git repository.
2. **Create a GitHub repository and push to it**:  Once you initialize your repository, you'll push it to GitHub.
3. **Create an Azure Static Web Apps instance**: When you use the Azure portal to create an Azure Static Web Apps instance, you'll provide the URL to your GitHub repository and the name for the sub directory where the static files live in your project. In Gatsby's case, this directory is called `public/`.
