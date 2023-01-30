
Up to this point, we've focused on authoring our Gatsby app using React, GraphQL, and plugins. The next step after you're done authoring is to build your application. Following that, you're able to deploy to any web server or hosting service that can serve static files.

## Build your app

Gatsby's command-line tool provides a command to build your project to create something that you can deploy anywhere you like. The *build* consists of HTML, JavaScript, CSS, and any other assets you've included.

### Create the build

Gatsby runs the React compiler underneath, so when it produces the build, it does many things. It compiles the React code by translating the JSX to JavaScript and HTML. It also extracts all the JavaScript code, and places it in a set of bundles. Each bundle is then *optimized* meaning it has white space removed, variables are renamed, and expressions are optimized for speed. The styles go through a similar process. If you have chosen a library like LESS, SCSS, or Stylus for your CSS, there will be a preliminary step in which your CSS is being compiled from a high-level language to CSS. There are no further actions needed to deploy the files at this point. It's just a set of static files that can be hosted from any webserver that can serve files.

## Deploy the build

There are many technologies and services capable of hosting static apps. After all, it's just HTML, CSS, and JavaScript, and can be hosted by most web services out there. For this tutorial, we'll deploy to Static Web Apps, an Azure service that specializes in hosting static apps like those built with Gatsby.

### Azure Static Web Apps

Static Web Apps is an Azure service that allows you to take some static files and serve them from the cloud. What you deploy isn't a deployment package, but a set of static files. This is a good fit for Gatsby as what Gatsby ends up producing from a build is static files.

Speaking of build, the service actually does the build step for you so there's no need to build anything up front. It accomplishes this by locating the `build` command in the `package.json` of the Gatsby project. All you need to do is put your project in a GitHub repository.

Currently, your code sits in a directory on your machine, so you'll need to do a few things to deploy Azure:

- **Create a GitHub repository and push to it**: Gatsby creates a Git repo for you, which will need to be pushed to GitHub.

- **Create an Azure Static Web Apps instance**: When you use the Azure portal to create an Azure Static Web Apps instance, you'll provide the URL to your GitHub repository, and the name for the sub-directory where the static files live in your project. In Gatsby's case, this directory is called `public/`.
