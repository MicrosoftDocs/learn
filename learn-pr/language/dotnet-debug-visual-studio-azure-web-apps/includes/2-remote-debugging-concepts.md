## Introducing remote debugging

Visual Studio provides powerful remote debugging tools and features to troubleshoot applications running on other computers outside of our development environment. Most developers are familiar with the Visual Studio debugging tools while developing locally, but may not be aware that a similar experience is possible for apps running in other environments.  Common scenarios for remote debugging are listed below.

* Connect to and debug an app hosted in one of many Azure services, such as App Service or virtual machines.

* Debug an app hosted from an on-premise server in IIS.

* Debug an app running on another development machine to assist with troubleshooting.

* Attach to a client side process such as a web browser to debug code that runs outside of your local app context.

* Debug an application running in a containerized environment separate from your development environment.

You will focus on the first scenario in this list to learn how to debug an app running in Azure App Service.  App Service is one of the most widely used Azure services and a common place to host .NET applications.

## Understanding symbol files

Visual Studio requires access to the symbol files for your source code in order to debug applications running on other machines or environments,. Symbol files are produced as part of your build and end with a `.pdb` extension. Symbol files essentially provide an instructional bridge between your compiled code and your source code. This allows the Visual Studio debugger to step through your code line by line during execution. When running and debugging locally, these files live in the same folder as your compiled code, so Visual Studio is able to find use them automatically. 

:::image type="content" source="../media/visual-studio-remote-debug-symbols.png" alt-text="A diagram of the build and symbols process.":::

When an application is compiled and deployed in release mode, various optimizations are performed and symbol files are not included in the deployment. Remote debugging therefore requires you to provide symbol files for Visual Studio to be able to debug the production code.  This can be accomplished by either modifying the release deployment configuration to include symbol files, or by loading a local copy of the symbol files during debugging. The local build and symbol files must exactly match the deployed code so that the instructions line up correctly.

## Understanding remote debugging tools

Remote debugging encompasses a variety of Visual Studio tools and features. When remote debugging applications deployed on other servers or virtual machines, you may need to [install the Visual Studio Remote Tools](https://docs.microsoft.com/en-us/visualstudio/debugger/remote-debugging?view=vs-2022).

However, in the exercise ahead, you'll debug an app hosted Azure App Service. In this scenario, many of these types of configurations are handled for us. You can simply use the **Attach to process** feature of Visual Studio to connect directly to our App Service process.  Assuming the correct debugging symbols and source code are loaded, you can then debug the application as though it were running locally on your computer.