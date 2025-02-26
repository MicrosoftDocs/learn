Coding an app with ASP.NET Core is different from designing a static website with HTML, CSS, and JavaScript. A static website can be deployed to any web server that supports static files. The web server doesn’t need to process static files; it simply serves them over HTTP. When a web browser requests a resource, the web server simply sends the file back to the browser.

An ASP.NET Core app, on the other hand, is a dynamic web application. It runs as a program on the web server. When the user's web browser sends a request to the web server, the web server runs the app to generate a response, and then the web server sends the response back to the browser.

Publishing a .NET app is the process of preparing the app for deployment on a server. When you publish a .NET app, you package your app and its dependencies into a folder that can be easily deployed. The published app doesn't include any source code files, but it does include all the files needed to run the app, including the compiled assemblies (DLLs), configuration files, and any other assets your app needs. The app can then be deployed to a web server, cloud service, or other hosting environment.

## Types of deployments

When you publish a .NET app, you can choose between two different types of deployments: framework-dependent and self-contained. The type of deployment you choose affects how your app is packaged and deployed. 

### Framework-dependent deployment

:::image type="content" source="../media/framework-dependent.gif" alt-text="An animation showing how a framework-dependent deployment depends on the presence of the .NET runtime on the target machine.":::

A framework-dependent deployment includes only your app's files and dependencies. It doesn't include the .NET runtime. Instead, the target machine must have the .NET runtime installed in order to run the app. This type of deployment is the default for .NET apps.

### Self-contained deployment

:::image type="content" source="../media/self-contained.gif" alt-text="An animation showing how a self-contained deployment includes the .NET runtime with the app.":::

A self-contained deployment includes your app's files, dependencies, and the .NET runtime. The .NET runtime is included with the app, so the target machine doesn't need to have the .NET runtime installed in order to run the app. Including the runtime makes self-contained deployments larger than framework-dependent deployments, but it also makes them more portable. It also makes it easier to run multiple versions of the .NET runtime side by side on the same machine.

### Choosing a deployment type

The deployment type you choose depends on your app's requirements and the target environment. Consider the following factors when choosing a deployment type:

:::row:::
    :::column:::
        **Deployment Type**
    :::column-end:::
    :::column:::
        **Advantages**
    :::column-end:::
    :::column:::
        **Disadvantages**
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Framework-dependent**
    :::column-end:::
    :::column:::
        - Smaller deployment size
        - Faster deployment times
        - Uses the .NET runtime installed on the target machine, regardless of operating system
    :::column-end:::
    :::column:::
        - Requires the .NET runtime to be installed on the target machine
        - Requires managing the .NET runtime versions installed on the target machine
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        **Self-contained**
    :::column-end:::
    :::column:::
        - No need to install .NET runtime on the target machine
        - Easier to run multiple versions of .NET side by side
    :::column-end:::
    :::column:::
        - Larger deployment size
        - Slower deployment times
        - .NET runtime updates must be deployed with the app
    :::column-end:::
:::row-end:::

## Where to deploy your app

Once you've published your app, you can deploy it to any environment that supports ASP.NET Core. Here are a few options:

### Kestrel

By default, ASP.NET Core apps run in ASP.NET Core's built-in web server, Kestrel. Kestrel is cross-platform and tuned for high performance. It supports all modern web server features, including HTTPS, HTTP/2, HTTP/3, and WebSockets. It's also customizable and extensible, so you can configure it to meet your app's needs. Kestrel is the recommended web server for ASP.NET Core apps.

Since Kestrel is built into ASP.NET Core, you can deploy your app to any machine capable of running .NET, including Windows, macOS, and Linux. Kestrel works great by itself, but apps running on Kestrel are often deployed behind a reverse proxy server, such as Internet Information Services (IIS), Nginx, or Apache. The reverse proxy server handles incoming requests from the internet and forwards them to Kestrel. This allows you to take advantage of the reverse proxy server's features, such as load balancing, caching, and SSL termination.

### Internet Information Services (IIS)

If you're deploying to Windows, you can host your ASP.NET Core app in IIS. To do this, you need to install the ASP.NET Core Module for IIS. The module forwards requests from IIS to Kestrel, which runs your app. This allows you to take advantage of IIS's features, such as process management, logging, and security.

### Containers

If you're deploying to a containerized environment, you can package your ASP.NET Core app as a Docker container. This allows you to run your app in any container runtime that supports Docker, such as Docker Desktop, Docker Enterprise, or Kubernetes. Containers are portable and scalable, so you can run your app on any machine that supports Docker, regardless of the underlying operating system.

### Azure

If you're deploying to Azure, you can host your ASP.NET Core app in Azure App Service or Azure Container Apps. Various tools make it easy to deploy your app to Azure from the command line. These tools include:

- Azure Tools extension for Visual Studio Code
- Visual Studio
- Azure CLI
- Azure Developer CLI (azd)
