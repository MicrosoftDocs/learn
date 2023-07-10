Once the binaries are built for your app to support Arm64, you’ll want to test them. That will require having a device or a virtual machine running Windows on Arm. In this exercise, we'll build upon the previous exercise and run the application on a Windows on Arm virtual machine.

1. In a web browser, access and login to the [Azure portal](https://portal.azure.com).

1. In the top search bar, search for `Virtual machines` and select the **Virtual machines** item from the search results beneath the **Services** heading.

    :::image type="content" source="../media/azure-portal-search-virtual-machines.png" alt-text="The Azure portal displays with the search bar populated with the text Virtual Machines and the Virtual machines item highlighted from the search results.":::

1. On the **Virtual machines** screen, expand the **Create** menu and select **Azure virtual machine**.

    :::image type="content" source="../media/azure-portal-virtual-machines-create-azure-virtual-machine.png" alt-text="The Azure portal Virtual machines screen displays with the Create menu expanded and the Azure virtual machine item highlighted.":::

1. On the **Basics** tab of the **Create a virtual machine** screen, select the **Subscription** and **Resource group** to use for the virtual machine. Then, in the **Instance details** section, enter a **Virtual machine name** and select a **Region** to deploy the virtual machine to. These values will be based on your preferences and the available resources in your Azure subscription.

    :::image type="content" source="../media/azure-portal-create-a-virtual-machine-basics.png" alt-text="The Azure portal Create a virtual machine screen displays with the Basics tab selected and the Subscription, Resource group, Virtual machine name and Region fields populated and highlighted.":::

1. Remaining on the **Basics** tab, select the **See all images** link below the **Image** field.

    :::image type="content" source="../media/azure-portal-create-a-virtual-machine-basics-see-all-images.png" alt-text="The See all images link is highlighted beneath the Image field.":::

1. On the **Marketplace** screen, search for `Microsoft Windows 11 on Arm`. In the search results, locate the **Microsoft Windows 11 Preview arm64** item, expand the **Select** drop-down and choose **Windows 11 Professional - Arm64**.

    :::image type="content" source="../media/azure-portal-marketplace-windows-11-on-arm.png" alt-text="The Virtual machines Select an image Marketplace screen displays with the search bar populated with the text Microsoft Windows 11 on Arm and the Microsoft Windows 11 Preview arm64 item highlighted from the search results.":::

1. Back on the **Basics** tab of the **Create a virtual machine** screen, select **Standard_D2ps_v5** from the **Size** drop-down list and assign a username and password for the Administrator account. Check the box for the licensing, then select the **Review + create** button. Once validation succeeds, select **Create** to initiate the deployment.

    :::image type="content" source="../media/azure-portal-create-a-virtual-machine-basics-size-admin-licensing.png" alt-text="The Azure portal Create a virtual machine screen displays with the Basics tab selected and the Size drop-down list populated with the Standard_D2ps_v5 item and the Administrator account fields populated. The Licensing checkbox is enabled and the Review + create button is highlighted.":::

1. Wait for the deployment to complete, then open the Virtual machine resource in the Azure portal.

1. On the Virtual machine resource screen, select the **Connect** button.

    :::image type="content" source="../media/azure-portal-virtual-machine-connect.png" alt-text="The Azure portal Virtual machine screen displays with the Connect button highlighted.":::

1. On the **Connect** screen, remain on the **RDP** tab and select the **Download RDP file** button. Save the RDP file to your local machine.

    :::image type="content" source="../media/azure-portal-virtual-machine-connect-rdp.png" alt-text="The Azure portal Virtual machine Connect screen displays with the RDP tab selected and the Download RDP file button highlighted.":::

1. Double-click the RDP file that you downloaded and authenticate to the virtual machine using the username and password you assigned during the virtual machine deployment. Once connected, you should see the Windows 11 desktop, accept any configuration defaults.

1. On the virtual machine, open the **Microsoft Edge** internet browser and navigate to the [.NET 6 download page](https://dotnet.microsoft.com/en-us/download/dotnet/6.0). Download and install the Windows Arm64 SDK.

    :::image type="content" source="../media/winarm-download-dotnet-6-sdk.png" alt-text="The Microsoft Edge browser displays the .NET 6 download page and the Windows Arm64 SDK highlighted.":::

    > **Note**: Alternatively you can choose to install the .NET 6 runtime instead of the full SDK. Both are sufficient in running the application.

1. On the virtual machine desktop, open File Explorer and create a folder on the C: drive named `HelloArm64`.

    :::image type="content" source="../media/winarm-create-helloarm64-folder.png" alt-text="The Windows 11 on Arm desktop displays with the File Explorer icon highlighted in the taskbar. The File Explorer displays with the C: drive highlighted in the left tree menu and the HelloArm64 folder is highlighted in the files listing.":::

1. Return to your local File Explorer containing the build artifacts for the HelloArm64 application. Copy the contents of the **bin/ARM64/Debug/net6.0** folder to the `HelloArm64` folder on the virtual machine.

    :::image type="content" source="../media/winarm-copy-helloarm64-build-artifacts.png" alt-text="The local File Explorer window with the build artifacts displays next to the Windows 11 on Arm File Explorer HelloArm64 folder. An arrow indicates a copy operation between the local machine and the virtual machine.":::

1. On the virtual machine, double-click on the **HelloWorldArm** application executable in the **HelloArm64** folder. The application will launch and display the prompt **Please enter your name:**.

    :::image type="content" source="../media/winarm-run-helloarm64.png" alt-text="The Windows 11 on Arm desktop displays with the HelloArm64 folder open in File Explorer and the HelloWorldArm application open displaying the prompt Please enter your name.":::

1. Enter your name and press <kbd>Enter</kbd>, the application will respond with the message **Hello &lt;your name&gt;!, Welcome to Arm! Press &lt;Enter&gt; to exit**.

    :::image type="content" source="../media/winarm-run-helloarm64-running.png" alt-text="The HelloWorldArm application window displays the prompt Please enter your name. The name Learner is entered and the application responds with the message Hello, Learner!":::

Congratulations! You have successfully run the application on Windows 11 on Arm64! In the next exercise, we'll cover how to remotely connect to the application running on the virtual machine from your local Visual Studio instance.

[!include[](../../../includes/azure-exercise-subscription-cleanup.md)]
