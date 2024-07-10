You want to browse your agency's project files on a remote machine. First, you need to set up that remote machine and configure it for SSH.

In this exercise, you'll create a Linux virtual machine (VM) in Azure to host your agency's application files. You'll also generate an SSH key that will be used to set up the virtual machine for SSH connections.

We're using Azure in this exercise, but your Linux VM can exist anywhere.

## Configure the virtual machine

First, you must set the initial configuration for your Linux VM.

1. Navigate to the [Azure portal](https://ms.portal.azure.com/#home) and login to your Azure account. You can create a [free account](https://azure.microsoft.com/free) if you don't currently have one.
2. In the portal menu, click "Create a resource."

    :::image type="content" source="../media/3-create-a-resource.png" alt-text="Screenshot showing the Create a resource action in the Azure portal menu.":::

1. Search for "virtual machine" and click the Create Virtual machine dropdown on the Virtual machine option.

    :::image type="content" source="../media/3-create-virtual-machine.png" alt-text="Screenshot highlighting how to search for and create a virtual machine resource in the Azure portal.":::

1. Select your Azure subscription and create a new resource group. 
1. Specify the details of the VM, such as the name, size, and base image. The screenshot shows some sample details, but you can choose recent versions of other Linux distros and look at [supported SSH servers](https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-server).

    :::image type="content" source="../media/3-vm-details.png" alt-text="Screenshot showing details of the Azure VM to create.":::
 
## Set up SSH

Now, you must set the SSH configuration and finalize creation of your VM so that you have a working SSH server.

1. Azure automatically generates an SSH key pair for you. You can leave the Administrator account populated with the default values. The username will be used when connecting to your VM over SSH in the next exercise.

    :::image type="content" source="../media/3-administrator-account.png" alt-text="Screenshot showing the default values of the Administrator Account section during VM creation in Azure.":::

1. Your VM also needs to accept inbound SSH traffic through the SSH port 22. By default, Azure should have this rule specified during VM creation.

    :::image type="content" source="../media/3-inbound-port-rules.png" alt-text="Screenshot showing the inbound port rules for setting up an inbound port for SSH.":::

1. Select Review + create.

    :::image type="content" source="../media/3-review-and-create.png" alt-text="Screenshot highlighting the Review + create option during VM creation.":::

1. You may receive a validation error on the Networking tab – if so, click on that error, and Create a new virtual network. Click Review + create again.

    :::image type="content" source="../media/3-virtual-network-validation.png" alt-text="Screenshot showing the validation step to create a new virtual network for the VM.":::

1. After reviewing the details, select Create, and Azure will deploy your VM. This process may take a few minutes.

    :::image type="content" source="../media/3-create-resource.png" alt-text="Screenshot highlighting the Create action for the validated VM.":::

1. When prompted with a screen for generating a new key pair, select "Download private key and create resource." This downloads a `.pem` file that contains your key. Make note of where the file is downloaded to - you'll need this file path in the next exercise!

    :::image type="content" source="../media/3-download-private-key.png" alt-text="Screenshot showing the prompt during Azure VM creation to download the private key and create resource.":::

1. Once the resource is deployed, click "Go to resource."

    :::image type="content" source="../media/3-go-to-resource.png" alt-text="Screenshot highlighting the Go to resource action once the VM is created.":::

1. Copy the Public IP address from the properties overview of the newly created VM. You'll need this IP address in the next exercise for the hostname when connecting to your VM over SSH.

    :::image type="content" source="../media/3-copy-ip-address.png" alt-text="Screenshot highlighting how to copy the public IP address of the newly created VM.":::

Great work! You have deployed a Linux VM that you can connect to using SSH.

In the next section, you'll learn how to use the VS Code Remote - SSH extension to connect to the VM.
