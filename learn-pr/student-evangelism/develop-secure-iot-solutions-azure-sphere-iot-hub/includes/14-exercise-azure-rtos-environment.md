In this exercise, you'll deploy the Eclipse ThreadX (formerly Azure RTOS ThreadX) real-time application included with this lab to your Azure Sphere device. The lab folder is named `Lab_6_AzureRTOS_Environment`, reflecting the original Azure RTOS branding. Note: the RTOS used by this lab — Azure RTOS ThreadX — has since been contributed to the Eclipse Foundation and is now known as **Eclipse ThreadX**. The Microsoft Learn pages used here remain valid for the version distributed with this lab.

> [!IMPORTANT]
> Before you start, verify that the Azure Sphere SDK, Azure Sphere Visual Studio Code extension, CMake, Ninja, and the GNU Arm Embedded toolchain are installed; the device is connected over USB, claimed to your Azure Sphere catalog, and has network access. Sideloading and debugging require the device to have the **appDevelopment** capability. Real-time core debugging also requires RT-core debugging support. With Azure Sphere Integrated, sign in with `az login`, then run the following command. On Windows, run it from an elevated PowerShell or Windows Command Prompt because the RT-core debugging option installs USB debugging drivers.
>
> ```azurecli
> az sphere device enable-development --enable-rt-core-debugging --catalog <CatalogName> --resource-group <ResourceGroupName>
> ```
>
> The command moves the device to a Development device group, which prevents cloud application updates from overwriting the app while you're debugging. After the command completes on Windows, close the elevated shell and continue from a non-elevated shell or Visual Studio Code. If you still use the Legacy CLI, use `azsphere device enable-development --enable-rt-core-debugging`.

## Step 1: Delete the existing applications on the Azure Sphere

1. Peripheral ownership changes in this exercise: the environment sensor peripheral moves from the existing high-level application to the new real-time application. Concurrently loaded applications can't share a peripheral; when Azure Sphere loads an app, it configures pin multiplexing and core mapping and fails the load if another app already claims the same resource. Delete any existing sideloaded applications on the Azure Sphere device to avoid resource conflicts.

    From the Windows **PowerShell command line** or Linux **Terminal**, delete the existing application by running:

    - Azure Sphere Integrated CLI (current):

      ```
      az sphere device sideload delete
      ```

    - Legacy CLI (still supported):

      ```
      azsphere device sideload delete
      ```

2. Restart the Azure Sphere device to reset peripherals and core mappings before you deploy the RTApp. From the Windows **PowerShell command line** or Linux **Terminal**, run:

    - Azure Sphere Integrated CLI (current):

      ```
      az sphere device restart
      ```

    - Legacy CLI (still supported):

      ```
      azsphere device restart
      ```

## Step 2: Open the project

1. Start Visual Studio Code.

1. From the menu, click **File**, then **Open Folder**.

1. Open the **Azure-Sphere lab** folder.

1. Open the **Lab_6_AzureRTOS_Environment** folder.

1. Click **Select Folder** or the **OK** button to open the project.

If you installed the Visual Studio Code Peacock extension, then Visual Studio Code will turn red. We will be connecting two instances of Visual Studio Code to the Azure Sphere. The red colored instance is connected to the real-time core.

## Step 3: Set your developer board configuration

These labs support developer boards from AVNET and Seeed Studio. You need to set the configuration that matches your developer board.

The default developer board configuration is for the Avnet Azure Sphere Starter Kit Revision 1. If you have this board, there's no additional configuration required.

1. Open the **CMakeLists.txt** file.

2. Add a `#` at the beginning of the set Avnet line to disable it.

3. Uncomment the `set` command that corresponds to your Azure Sphere device developer board.

   ```text
   set(AVNET TRUE "AVNET Azure Sphere Starter Kit Revision 1 ")
   # set(AVNET_REV_2 TRUE "AVNET Azure Sphere Starter Kit Revision 2 ")
   # set(SEEED_STUDIO_RDB TRUE "Seeed Studio Azure Sphere MT3620 Development Kit (aka Reference Design Board or rdb)")
   # set(SEEED_STUDIO_MINI TRUE "Seeed Studio Azure Sphere MT3620 Mini Dev Board")
   ```

4. Save the file. If CMake doesn't configure automatically, run **CMake: Delete Cache and Reconfigure** from the Visual Studio Code Command Palette so IntelliSense and the generated build files use the selected board.

## Step 4: Deploy the Eclipse ThreadX (Azure RTOS) application to Azure Sphere

1. Ensure Visual Studio Code is using the **Debug** CMake build variant. The status bar might show **CMake: [Debug]: Ready**; if it doesn't, run **CMake: Set Build Variant** from the Command Palette and select **Debug**.

    :::image type="content" source="../media/visual-studio-code-start-application.png" alt-text="This illustration shows you how to set the debug build." lightbox="../media/visual-studio-code-start-application.png":::

2. From Visual Studio Code, press <kbd>F5</kbd> to build, deploy, start, and connect the remote debugger to the application now running on the Azure Sphere device.

## Step 5: Debugging real-time core applications

You can debug the Eclipse ThreadX real-time application running on an Azure Sphere Cortex-M4F real-time core.

1. From Visual Studio Code, navigate to the **demo_threadx** directory, and open the **demo_azure_rtos.c** file.
2. Scroll down to the function named **intercore_thread**.
    > [!NOTE]
    > Use **Go to Symbol in Editor** in Visual Studio Code. Use the keyboard shortcut Ctrl+Shift+O and start typing *intercore_thread*. You'll often see a function name listed twice in the drop-down. The first is the function prototype or forward signature declaration, and the second is the implementation of the function.
3. Set a breakpoint in the **intercore_thread** function on the line that reads **switch (ic_control_block.cmd)**
    > [!NOTE]
    > You can learn how to set breakpoints from this [Visual Studio Code Debugging](https://code.visualstudio.com/docs/editor/debugging#_debug-actions?azure-portal=true) article.

    :::image type="content" source="../media/visual-studio-debug-intercore-thread.png" alt-text="The illustration shows how to set a breakpoint in Visual Studio Code." lightbox="../media/visual-studio-debug-intercore-thread.png":::

4. Leave Visual Studio Code and the app running with the breakpoint set. Next, you'll deploy a high-level application to the Cortex-A7 core that will request environment telemetry from the RTApp running on the Cortex-M4F core.
