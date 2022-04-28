Visual Studio Code and the Azure IoT Tools can be used to create an IoT Edge module in your preferred development language (including Azure Functions, written in C\#).

At a high level, the process for developing a custom Edge module in Visual Studio Code will be similar to the following steps:

 -  Prepare the development environment with the required tools. For example, Azure IoT tools, Docker tools, and Visual Studio Code tools.
    
     -  You will need Docker to build the module image and you will need a container registry to hold the module image. For example, Docker Community Edition on your development machine, and Azure Container Registry in Azure.
     -  Unless you're developing your module in C, you will also need the Python-based Azure IoT EdgeHub Dev Tool in order to set up your local development environment to debug, run, and test your IoT Edge solution.
 -  Use the Visual Studio Code command palette to create a solution template for your module(s).
    
     -  The solution template provides you with a sample module and deployment.template.json file that are set up so that you can build the solution, push it to your container registry, and deploy it to a device to start testing without touching any code.
     -  The sample module is built to take input from a source (in this case, the SimulatedTemperatureSensor module that simulates data) and send it to IoT Hub.
 -  Develop and debug the business logic of your custom module(s). There are several options available for debugging, which include using the IoT Edge Simulator.

Once you are done testing, you can create the JSON deployment manifest and deploy your custom module(s).

## Azure IoT Edge for Visual Studio Code

The Azure IoT Edge extension, which is included with Azure IoT Tools, makes it easy to code, build, deploy, and debug your IoT Edge solutions in Visual Studio Code, by providing a rich set of functionalities:

 -  Create new IoT Edge solution.
 -  Add new IoT Edge module to Edge solution.
 -  Build and publish IoT Edge modules.
 -  Debug IoT Edge modules locally and remotely.
 -  IntelliSense and code snippets for the deployment manifest.
 -  Manage IoT Edge devices and modules in IoT Hub (with Azure IoT Toolkit).
 -  Deploy IoT solutions to IoT Edge devices.

## Example process: Create a new solution template

1.  Open VS Code.
2.  Select View &gt; Command Palette.
3.  In the command palette, enter and run the command Azure IoT Edge: New IoT Edge Solution. :::image type="content" source="../media/m07-l01-edge-modules-containers-create-custom-module-new-solution-3f8a542a.png" alt-text="Screenshot that shows how to use the Visual Studio Code command palette to create a new IoT Edge solution template.":::
    
4.  Browse to the folder where you want to create the new solution and then select Select folder.
5.  Enter a name for your solution.
6.  Select a module template for your preferred development language to be the first module in the solution.
7.  Enter a name for your module. Choose a name that's unique within your container registry.
8.  Provide the name of the module's image repository. Visual Studio Code autopopulates the module name with `localhost:5000/<your module name>`. Replace it with your own registry information. If you use a local Docker registry for testing, then `localhost` is fine. If you use Azure Container Registry, then use the login server from your registry's settings. The login server looks like `<registry name>.azurecr.io`. Only replace the `localhost:5000` part of the string so that the final result looks like `<registry name>.azurecr.io/<your module name>`.:::image type="content" source="../media/m07-l01-edge-modules-containers-create-custom-module-repository-f3734869.png" alt-text="Screenshot that shows how to specify the image repository name for an IoT Edge module using Visual Studio Code.":::
    

Visual Studio Code takes the information you provided, creates an IoT Edge solution, and then loads it in a new window.

There are four items within the solution:

 -  A .vscode folder contains debug configurations.
 -  A modules folder has subfolders for each module. Within the folder for each module, there is a file, module.json, that controls how modules are built and deployed. This file would need to be modified to change the module deployment container registry from localhost to a remote registry. At this point, you only have one module. But you can add more in the command palette with the command Azure IoT Edge: Add IoT Edge Module.
 -  An .env file lists your environment variables. If Azure Container Registry is your registry, you'll have an Azure Container Registry username and password in it.
    
     -  > [!NOTE]
        > The environment file is only created if you provide an image repository for the module. If you accepted the localhost defaults to test and debug locally, then you don't need to declare environment variables.
 -  A deployment.template.json file lists your new module along with a sample SimulatedTemperatureSensor module that simulates data you can use for testing.

## Add additional modules

To add more modules to your solution, run the command Azure IoT Edge: Add IoT Edge Module from the command palette. You can also right-click the modules folder or the deployment.template.json file in the Visual Studio Code Explorer view and then select Add IoT Edge Module.

## Develop your module

The default module code that comes with the solution is located at the following location:

 -  Azure Function (C\#): modules &gt; &lt;your module name&gt; &gt; &lt;your module name&gt;.cs
 -  C\#: modules &gt; &lt;your module name&gt; &gt; Program.cs
 -  Python: modules &gt; &lt;your module name&gt; &gt; main.py
 -  Node.js: modules &gt; &lt;your module name&gt; &gt; app.js
 -  Java: modules &gt; &lt;your module name&gt; &gt; src &gt; main &gt; java &gt; com &gt; edgemodulemodules &gt; App.java
 -  C: modules &gt; &lt;your module name&gt; &gt; main.c

The module and the deployment.template.json file are set up so that you can build the solution, push it to your container registry, and deploy it to a device to start testing without touching any code. The module is built to take input from a source (in this case, the SimulatedTemperatureSensor module that simulates data) and then send the data to IoT Hub.

When you're ready to customize the template with your own code, use the Azure IoT Hub SDKs to build modules that address the key needs for IoT solutions such as security, device management, and reliability.
