When you build a .NET app, that's only the first step to making your app available to users. The next step is to deploy your app to a web server or cloud service, but before you can do that, you need to prepare a deployment-ready version your app. This process is called publishing.

## Building vs. publishing

When you build a .NET app, the .NET SDK compiles your source code into an executable form that can be run with the .NET runtime. The output of a build is a set of files that can be run on a developer's machine, but it's not yet ready to be deployed to a server or cloud service.

When you publish a .NET app, you package your app and its dependencies into a folder that can be easily deployed to a server. The published app doesn't include any source code files, but it does include all the files needed to run the app, including the compiled assemblies, configuration files, and any other assets your app needs.

## Framework-dependent vs. self-contained deployments

When you publish a .NET app, you can choose between two different types of deployments: framework-dependent and self-contained.

### Framework-dependent deployment

:::image type="content" source="../media/framework-dependent.gif" alt-text="An animation showing how a framework-dependent deployment depends on the presence of the .NET runtime on the target machine.":::