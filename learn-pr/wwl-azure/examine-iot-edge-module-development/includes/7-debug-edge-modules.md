## Debug a module without a container in Visual Studio Code (C\#)

Visual Studio Code can be used as your primary tool to develop and debug IoT Edge modules.

If you're developing in C\#, Node.js, or Java, your module requires use of a `ModuleClient` object in the default module code so that it can start, run, and route messages. You'll also use the default input channel `input1` to take action when the module receives messages.

With Visual Studio Code, there are two ways to debug modules written in C\#, Node.js, or Java: You can either attach a process in a module container or launch the module code in debug mode. To debug modules written in Python or C, you can only attach to a process in Linux amd64 containers.

### Set up IoT Edge simulator for IoT Edge solution

On your development machine, you can use Visual Studio Code to start an IoT Edge simulator instead of installing the IoT Edge security daemon so that you can run your IoT Edge solution.

1.  In device explorer on the left side, right-click on your IoT Edge device ID, and then select Setup IoT Edge Simulator to start the simulator with the device connection string.
2.  You can see the IoT Edge Simulator has been successfully set up by reading the progress detail in the integrated terminal.

### Set up IoT Edge simulator for single module app

To set up and start the simulator, run the command Azure IoT Edge: Start IoT Edge Hub Simulator for Single Module from the Visual Studio Code command palette. When prompted, use the value `input1` from the default module code (or the equivalent value from your code) as the input name for your application. The command triggers the `iotedgehubdev` CLI and then starts the IoT Edge simulator and a testing utility module container. You can see the outputs below in the integrated terminal if the simulator has been started in single module mode successfully. You can also see a curl command to help send message through. You will use it later.

:::image type="content" source="../media/m07-l01-edge-modules-containers-start-simulator-single-module-4daf82ac.png" alt-text="Screenshot that shows the terminal output for an IoT Edge simulator that has been started in single module mode.":::


You can use the Docker Explorer view in Visual Studio Code to see the module's running status.

:::image type="content" source="../media/m07-l01-edge-modules-containers-simulator-status-f88b0600.png" alt-text="Screenshot that shows the module's running status in the Docker Explorer view of Visual Studio Code.":::


The `edgeHubDev` container is the core of the local IoT Edge simulator. It can run on your development machine without the IoT Edge security daemon and provides environment settings for your native module app or module containers. The input container exposes REST APIs to help bridge messages to the target input channel on your module.

### Debug module in launch mode

1.  Prepare your environment for debugging according to the requirements of your development language (C\# in this case), set a breakpoint in your module, and select the debug configuration to use:
    
    1.  In the Visual Studio Code integrated terminal, change the directory to the `<your module name>` folder, and then run the following command to build .NET Core application.
        
        ```cmd
        dotnet build
        
        ```
    2.  Open the file `Program.cs` and add a breakpoint.
    3.  Navigate to the Visual Studio Code Debug view by selecting **View** &gt; **Debug**. Select the debug configuration ***&lt;your module name&gt;* Local Debug (.NET Core)** from the dropdown.
        
        > [!NOTE]
        > If your .NET Core \`TargetFramework\` is not consistent with your program path in \`launch.json\`, you'll need to manually update the program path in \`launch.json\` to match the \`TargetFramework\` in your .csproj file so that Visual Studio Code can successfully launch this program.
2.  Click **Start Debugging** or press **F5** to start the debug session.
3.  In the Visual Studio Code integrated terminal, run the following command to send a Hello World message to your module. This is the command shown in previous steps when you set up IoT Edge simulator.

```bash
curl --header "Content-Type: application/json" --request POST --data '{"inputName": "input1","data":"hello world"}' http://localhost:53000/api/v1/messages

```

    > [!NOTE]
    > If you are using Windows, making sure the shell of your Visual Studio Code integrated terminal is \*\*Git Bash\*\* or \*\*WSL Bash\*\*. You cannot run the \`curl\` command from a PowerShell or command prompt.

    > [!TIP]
    > You can also use the PostMan tool or other API tools to send messages instead of using curl.

4.  In the Visual Studio Code Debug view, you'll see the variables in the left panel.
5.  To stop your debugging session, select the **Stop** button or press **Shift** \+ **F5**, and then run **Azure IoT Edge: Stop IoT Edge Simulator** in the command palette to stop the simulator and clean up.

## Debug in attach mode with IoT Edge simulator (C\#)<br>

Your default solution contains two modules, one is a simulated temperature sensor module and the other is the pipe module. The simulated temperature sensor sends messages to the pipe module and then the messages are piped to the IoT Hub. In the module folder you created, there are several Docker files for different container types. Use any of the files that end with the extension .debug to build your module for testing.

Currently, debugging in attach mode is supported only as follows:

 -  C\# modules, including those for Azure Functions, support debugging in Linux amd64 containers.
 -  Node.js modules support debugging in Linux amd64 and arm32v7 containers, and Windows amd64 containers.
 -  Java modules support debugging in Linux amd64 and arm32v7 containers.

### Set up IoT Edge simulator for IoT Edge solution

In your development machine, you can start an IoT Edge simulator instead of installing the IoT Edge security daemon so that you can run your IoT Edge solution.

1.  In device explorer on the left side, right-click on your IoT Edge device ID, and then select Setup IoT Edge Simulator to start the simulator with the device connection string.
2.  You can see the IoT Edge Simulator has been successfully set up by reading the progress detail in the integrated terminal.

### Build and run container for debugging and debug in attach mode

1.  Open your module file (Program.cs, app.js, App.java, or &lt;your module name&gt;.cs) and add a breakpoint.
2.  In the Visual Studio Code Explorer view, right-click the `deployment.debug.template.json` file for your solution and then select **Build and Run IoT Edge solution in Simulator**. You can watch all the module container logs in the same window. You can also navigate to the Docker view to watch container status. :::image type="content" source="../media/m07-l01-edge-modules-containers-view-container-status-log-3ae95d80.png" alt-text="Screenshot that shows the module container logs for an IoT Edge simulator in the Visual Studio Code terminal.":::
    
3.  Navigate to the Visual Studio Code Debug view and select the debug configuration file for your module. The debug option name should be similar to ***&lt;your module name&gt;* Remote Debug**.
4.  Select **Start Debugging** or press **F5**. Select the process to attach to.
5.  In Visual Studio Code Debug view, you'll see the variables in the left panel.
6.  To stop the debugging session, first select the Stop button or press **Shift** \+ **F5**, and then select **Azure IoT Edge: Stop IoT Edge Simulator** from the command palette.

## Debug a module with the IoT Edge runtime

In each module folder, there are several Docker files for different container types. Use any of the files that end with the extension **.debug** to build your module for testing.

When debugging modules using this method, your modules are running on top of the IoT Edge runtime. The IoT Edge device and your Visual Studio Code can be on the same machine, or more typically, Visual Studio Code is on the development machine and the IoT Edge runtime and modules are running on another physical machine. In order to debug from Visual Studio Code, you must:

 -  Set up your IoT Edge device, build your IoT Edge module(s) with the **.debug** Dockerfile, and then deploy to the IoT Edge device.
 -  Expose the IP and port of the module so that the debugger can be attached.
 -  Update the `launch.json` so that Visual Studio Code can attach to the process in the container on the remote machine. This file is located in the `.vscode` folder in your workspace and updates each time you add a new module that supports debugging.

### Build and deploy your module to the IoT Edge device

1.  In Visual Studio Code, open the `deployment.debug.template.json` file, which contains the debug version of your module images with the proper `createOptions` values set.
2.  In the Visual Studio Code command palette:
    
    1.  Run the command **Azure IoT Edge: Build and Push IoT Edge solution**.
    2.  Select the `deployment.debug.template.json` file for your solution.
3.  In the **Azure IoT Hub Devices** section of the Visual Studio Code Explorer view:
    
    1.  Right-click an IoT Edge device ID and then select **Create Deployment for Single Device**.
        
        > [!TIP]
        > To confirm that the device you've chosen is an IoT Edge device, select it to expand the list of modules and verify the presence of \`$edgeHub\` and \`$edgeAgent\`. Every IoT Edge device includes these two modules.
    2.  Navigate to your solution's **config** folder, select the `deployment.debug.amd64.json` file, and then select **Select Edge Deployment Manifest**.

You'll see the deployment successfully created with a deployment ID in the integrated terminal.

You can check your container status by running the docker ps command in the terminal. If your Visual Studio Code and IoT Edge runtime are running on the same machine, you can also check the status in the Visual Studio Code Docker view.

### Expose the IP and port of the module for the debugger

You can skip this section if your modules are running on the same machine as Visual Studio Code, as you are using localhost to attach to the container and already have the correct port settings in the **.debug** Dockerfile, module's container `createOptions` settings, and `launch.json` file.

> [!NOTE]
> If your modules and Visual Studio Code are running on separate machines, follow the instructions (for C\#, including Azure Functions) below:

1.  Complete the steps provided here: Configure the SSH channel on your development machine and IoT Edge device [https://github.com/OmniSharp/omnisharp-vscode/wiki/Attaching-to-remote-processes](https://github.com/OmniSharp/omnisharp-vscode/wiki/Attaching-to-remote-processes).
2.  And then edit the `launch.json` file to attach.

### Debug your module

1.  In the Visual Studio Code Debug view, select the debug configuration file for your module. The debug option name should be similar to ***&lt;your module name&gt;* Remote Debug**.
2.  Open the module file for your development language and add a breakpoint:
    
     -  Azure Function (C\#): Add your breakpoint to the file `<your module name>.cs`.
     -  C\#: Add your breakpoint to the file `Program.cs`.
3.  Select **Start Debugging** or press **F5**. Select the process to attach to.
4.  In the Visual Studio Code Debug view, you'll see the variables in the left panel.

> [!NOTE]
> The preceding example shows how to debug IoT Edge modules on containers. It added exposed ports to your module's container \`createOptions\` settings. After you finish debugging your modules, we recommend you remove these exposed ports for production-ready IoT Edge modules.

## Build and debug a module remotely

With recent changes in both the Docker and Moby engines to support SSH connections, and a new setting in Azure IoT Tools that enables injection of environment settings into the Visual Studio Code command palette and Azure IoT Edge terminals, you can now build and debug modules on remote devices.
