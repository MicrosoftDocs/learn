When you build a .NET app, that's only the first step to making your app available to users. The next step is to deploy your app to a web server or cloud service, but before you can do that, you need to prepare a deployment-ready version your app. This process is called publishing.

## Building vs. publishing

When you build a .NET app, the .NET SDK compiles your source code into an executable form that can be run with the .NET runtime. The build process creates a set of files that are needed to run your app, but it doesn't package those files in a way that makes them easy to deploy.

When you publish a .NET app, you package your app and its dependencies into a folder that can be easily deployed to a server. The published app doesn't include any source code files, but it does include all the files needed to run the app, including the compiled assemblies (DLLs), configuration files, and any other assets your app needs.

## Where to publish

A static website built with HTML, CSS, and JavaScript can be deployed to any web server that supports static files. The web server doesn't need to know anything about static files because they're just files that can be served over HTTP. When a web browser requests a static file, the web server simply sends the file back to the browser.

An ASP.NET Core app, on the other hand, is a dynamic web application. It runs as a program on the web server. The user's web browser sends a request to the web server, the web server runs the app to generate a response, and then the web server sends the response back to the browser.  

## Framework-dependent vs. self-contained deployments

When you publish a .NET app, you can choose between two different types of deployments: framework-dependent and self-contained.

### Framework-dependent deployment

:::image type="content" source="../media/framework-dependent.gif" alt-text="An animation showing how a framework-dependent deployment depends on the presence of the .NET runtime on the target machine.":::

### Self-contained deployment

:::image type="content" source="../media/self-contained.gif" alt-text="An animation showing how a self-contained deployment includes the .NET runtime with the app.":::