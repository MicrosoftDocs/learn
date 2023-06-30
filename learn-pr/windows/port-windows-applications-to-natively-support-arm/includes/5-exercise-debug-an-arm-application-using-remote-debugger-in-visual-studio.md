## Debugging the application

If you are doing development on a Windows on Arm device, then you have an easy setup with Visual Studio local debugging. If cross-compiling (using a device that is not running on an Arm-processor), then you will want to use remote debugging on a Windows on Arm device or a virtual machine to enable your development experience in Visual Studio while running the Arm64 app on another device.

In this exercise, we'll use remote debugging to connect to the HelloArm64 application running on the Windows on Arm virtual machine.

1. On the Windows on Arm virtual machine, open the Microsoft Edge browser and navigate to the [Remote tools for Visual Studio 2022](https://visualstudio.microsoft.com/downloads/#remote-tools-for-visual-studio-2022) download page. Select the **ARM64** option and select **Download**. Once the download has completed, install the **Remote tools for Visual Studio 2022**.

    :::image type="content" source="../media/winarm-download-remote-tools.png" alt-text="The Microsoft Edge browser displays the Remote Tools for Visual Studio 2022 download section. The ARM64 option is selected and the Download button is highlighted.":::

1. Once installed, enter **Remote Debugger** into the Windows 11 search box and select **Remote Debugger (ARM64)** from the search results.

    :::image type="content" source="../media/winarm-search-remote-debugger.png" alt-text="The Windows 11 search box displays with the text Remote Debugger entered in the search box and Remote Debugger (ARM64) highlighted in the search results.":::

1. On the **Visual Studio 2022 Remote Debugger** screen, expand the **Tools** menu, and select **Options**.

    :::image type="content" source="../media/winarm-remote-debugger-options.png" alt-text="The Visual Studio 2022 Remote Debugger screen displays with the Tools menu expanded and the Options menu item highlighted.":::

1. If you need to change the Authentication mode or the port number, or specify a timeout value for the remote tools: choose **Tools > Options**. The default TCP/IP port number will be listed as 4026 for Visual Studio 2022. By default, the current user executing "msvsmon.exe" (the Visual Studio Remote Debugging Monitor) will be added and provided debug access. You can run the remote debugger under a user account that differs from the account you are using on the Visual Studio computer, but you must add the different user account to the remote debugger's permissions (**Tools > Permissions**). Exercise caution if you choose to select the **No Authentication** option and **Allow any user to debug** checkbox. This should only be used if you are confident your network is secure and is not recommended. Once you've set your authentication mode, established debug permissions, recorded your port number, and set the maximum number of seconds you are comfortable with allowing the remote debug session to idle, select **OK**.

    :::image type="content" source="../media/winarm-remote-debugger-options-authentication.png" alt-text="The Visual Studio 2022 Remote Debugger Options screen displays TCP/IP port number, Authentication mode, and Max idle time in seconds.":::

1. Back in the Azure portal, open to the **Network security group** resource that shares the name of the virtual machine you created earlier and has the suffix **-nsg**.

    :::image type="content" source="../media/azure-portal-network-security-group.png" alt-text="The resource group resources are listed with the arm-vm-nsg Network security group item highlighted.":::

1. On the **Network security group** screen, from the left menu, select the **Inbound security rules** item from beneath the **Settings** header.  Select the **+ Add** button.

    :::image type="content" source="../media/azure-portal-network-security-group-inbound-rules.png" alt-text="The Network security group screen displays with the Inbound security rules item selected from the left menu and the + Add button highlighted.":::

1. On the **Add inbound security rule** screen, enter the TCP/IP port number from the Remote Debugger into the **Destination port ranges** field. Change the **Name** field to **AllowVisualStudioDebugger**, then select **Add**.

    :::image type="content" source="../media/azure-portal-network-security-group-add-inbound-rule.png" alt-text="The Add inbound security rule screen displays with the Destination port ranges field populated with the Remote Debugger port number and the Name field populated with AllowVisualStudioDebugger. The Add button is highlighted.":::

1. From the RDP window, record the IP address of the Windows on Arm virtual machine.

    :::image type="content" source="../media/winarm-rdp-ip-address.png" alt-text="The Windows 11 on Arm desktop displays with the RDP window open and the IP address highlighted.":::

1. On the Windows on Arm virtual machine, open File Explorer and navigate to the **C:\HelloArm64** folder. Double-click on the **HelloWorldArm** application. The application will launch and display the prompt **Please enter your name:**. Leave the application running.

    :::image type="content" source="../media/winarm-run-helloarm64.png" alt-text="The Windows 11 on Arm desktop displays with the HelloArm64 folder open in File Explorer and the HelloWorldArm application open displaying the prompt Please enter your name.":::

1. On your local machine, open the **HelloWorldArm.sln** file using Visual Studio 2022.

1. In Visual Studio, from the **Debug** menu, select **Attach to Process**.

    :::image type="content" source="../media/vs-2022-attach-to-process.png" alt-text="The Visual Studio 2022 screen displays with the Debug menu expanded and the Attach to Process item highlighted.":::

1. In the **Attach to Process** dialog perform the following steps:

   1. For **Connection type** select **Remote (no authentication)**

   1. For **Connection target**, enter the IP address of the virtual machine followed by colon (:) and the Remote Debugger TCP/IP port, example: `20.127.87.219:4026`.

   1. Uncheck the **Automatic refresh** checkbox.

   1. Press the **Refresh** button to refresh the list of processes.

   1. Locate and select the **HelloWorldArm.exe** process from the list of processes.

   1. Press **Attach**.

    :::image type="content" source="../media/vs-2022-attach-to-process-remote.png" alt-text="The Visual Studio 2022 Attach to Process dialog displays with the Connection type set to Remote (no authentication), the Connection target set to the IP address of the virtual machine followed by colon (:) and the Remote Debugger TCP/IP port. The HelloWorldArm process is selected from the list of processes and the Attach button is highlighted.":::

1. In Visual Studio, open the **Program.cs** file and set a breakpoint on the last line of code.

    :::image type="content" source="../media/vs-2022-set-breakpoint.png" alt-text="The Visual Studio 2022 screen displays with the Program.cs file open and the last line of code set with a breakpoint.":::

1. Return to the Windows on Arm virtual machine, and enter your name into the **HelloWorldArm** application and press **Enter**. You will see an entry that a user has connected to the debugger.

    :::image type="content" source="../media/winarm-helloarm64-enter-name.png" alt-text="The Windows 11 on Arm desktop displays with the HelloWorldArm application open displaying the prompt Please enter your name. The name Learner is entered into the prompt. To the left, the Visual Studio Remote Debugger shows that a user has connected.":::

1. On the local machine, the breakpoint will be hit. Note the locals value for the **name** variable shows the value entered into the application in the virtual machine. Press **F5** to continue execution.

    :::image type="content" source="../media/vs-2022-breakpoint-hit.png" alt-text="The Visual Studio 2022 screen displays with the Program.cs file open and the last line of code shows a hit breakpoint. The locals show the variable name has a value of Learner":::

You have now successfully debugged an application running on Windows on Arm using remote debugging in Visual Studio 2022.

> [!IMPORTANT]
> Reminder that if you used a VM in your remote debugging process to clean up any associated resources so that you will not continue to be charged for them. If using Azure, you can delete resources individually or delete the resource group to delete the entire set of resources.
