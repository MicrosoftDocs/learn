In the sample scenario, your organization is rolling out a new environment on Azure that uses virtual machines. You've already constructed a virtual machine that contains the software and tools required to support the organization's functions. You need to take this virtual machine and use it to generate a custom image that you can use to create new virtual machine instances.

In this exercise, you'll start with an existing virtual machine and generalize it. You'll create an image from the generalized virtual machine, and then use this image to create a further virtual machine.

## Setup

In this task, you'll quickly create a virtual machine that runs a simple web app. The web app displays the name of the host machine. You'll use this virtual machine as the basis for the rest of the exercise.

[!include[](../../../includes/azure-sandbox-activate.md)]

::: zone pivot="windows"

1. In the Cloud Shell window on the right, run the following commands to create a Windows DataCenter Server virtual machine running IIS. When prompted for the Admin password, enter **Pa55w.rdDemo**:

    ```azurecli
    az vm create \
        --name MyWindowsVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --image Win2012R2Datacenter \
        --admin-username azureuser

    az vm open-port \
        --name MyWindowsVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --port 80

    az vm extension set \
        --name CustomScriptExtension \
        --version 1.9.4 \
        --vm-name MyWindowsVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --publisher Microsoft.Compute \
        --settings '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'
    ```

2. Run the following command to find the public IP address of the new virtual machine:

    ```azurecli
    az vm list-ip-addresses \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --name MyWindowsVM \
        --output table
    ```

3. In the web browser, navigate to the public IP address of the virtual machine. Verify that a web page displaying the name of the virtual machine (MyWindowsVM):

    ![Screenshot of the web page from the virtual machine](../media/4-original-vm-web-page.png)

::: zone-end

::: zone-pivot="linux"

1. In the Cloud Shell window on the right, run the following commands to create an Ubuntu Server virtual machine running nginx. When prompted for the Admin password, enter **Pa55w.rdDemo**:

    ```azurecli
    az vm create \
        --name MyUbuntuVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --image UbuntuLTS \
        --generate-ssh-keys

    az vm open-port \
        --name MyUbuntuVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --port 80

    az vm extension set \
        --publisher Microsoft.Azure.Extensions \
        --version 2.0 \
        --name CustomScript \
        --vm-name MyUbuntuVM \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx && hostname > /var/www/html/index.html"}'
    ```

2. Run the following command to find the public IP address of the new virtual machine:

    ```azurecli
    az vm list-ip-addresses \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --name UbuntuVM \
        --output table
    ```

3. In the web browser, navigate to the public IP address of the virtual machine. Verify that a web page displaying the name of the virtual machine (MyUbuntuVM):

    ![Screenshot of the web page from the virtual machine](../media/4-original-ubuntu-web-page.png)

::: zone-end

## Generalize the virtual machine

::: zone pivot="windows"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your MSLearn account.

1. In the menu pane on the left, click **Resource groups**, and then click the <rgn>[Sandbox resource group name]</rgn> resource group.

1. Click the **MyWindowsVM** virtual machine.

1. On the **MyWindowsVM** page, click **Connect**.

1. In the **Connect to virtual machine** window, click **Download RDP File**.

1. When the RDP file has downloaded, click it to open an RDP connection to the virtual machine.

1. In the **Remote Desktop Connection** dialog box, click **Connect**.

1. In the **Windows Security** dialog box, click **More choices**, and then click **Use a different account**.

1. Sign in with the username **azureuser**, and password **Pa55w.rdDemo**.

1. In the **Remote Desktop Connection** dialog box, click **Yes** to proceed.

1. On the virtual machine, click the Windows button in the bottom left-hand corner of the screen.

1. On the **Start** page, click the down arrow.

1. Right-click **Command Prompt**, and then click **Run as administrator**.

1. In the Command Prompt window, run the following command the directory:

    ```command
    C:\windows\system32\sysprep\sysprep
    ```

1. In the **System Preparation Tool** dialog box, select the following settings, and then click **OK**.

    | Property  | Value  |
    |---|---|
    | System Cleanup Action | Enter System Out-of-Box Experience (OOBE) |
    | Generalize | Check  |
    | Shutdown Options | Shutdown |

1. Wait for the sysprep utility to complete. The connection to the virtual machine will be terminated when sysprep has finished and shut down the virtual machine. In the **Remote Desktop Connection** message box, click **OK**.

1. In the Cloud Shell window, run the following command to deallocate the virtual machine:

    ```azurecli
    az vm deallocate \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --name MyWindowsVM
    ```

::: zone-end

::: zone pivot="linux"

1. In the Cloud Shell window, run the following command to connect to the Ubuntu virtual machine. Replace *\<ip address\>* with the public IP address of the virtual machine, that you noted during the Setup task.

    ```bash
    ssh <ip address>
    ```

   At the **Are you sure you want to continue connecting (yes/no)?** prompt, type **yes** and press Enter

1. Run the following command to prepare the virtual machine for generalization:

    ```bash
    sudo waagent -deprovision+user
    ```

    At the **Do you want to proceed (y/n)** prompt, type **y** and press Enter.

1. When the operation has completed, run the following command to close the connection to the virtual machine:

    ```bash
    exit
    ```

1. In the Cloud Shell, run the following command to deallocate the virtual machine:

    ```azurecli
    az vm deallocate \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --name MyUbuntuVM
    ```

1. Run the following command to generalize the virtual machine:

    ```azurecli
    az vm generalize \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --name MyUbuntuVM
    ```

::: zone-end

## Create a virtual machine image

::: zone pivot="windows"

1. Run the following command to create a virtual machine image named **MyVMImage** from the generalized virtual machine:

    ```azurecli
    az image create \
        --name MyVMIMage \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --source MyWindowsVM
    ```

::: zone-end

::: zone pivot="linux"

1. Run the following command to create a virtual machine image named **MyVMImage** from the generalized virtual machine:

    ```azurecli
    az image create \
        --name MyVMIMage \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --source MyUbuntuVM
    ```

::: zone-end

## Create a virtual machine using the new image

1. Run the following command to create a new virtual machine using the **MyVMImage** image. If you're creating a virtual machine based on a Windows image, you'll be prompted for the Admin password. In this case, enter **Pa55w.rdDemo**:

    ```azurecli
    az vm create \
      --resource-group <rgn>[Sandbox reource group name]</rgn> \
      --name MyVMFromImage \
      --image MyVMImage \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

1. Run the following command to open port 80 on the new virtual machine:

    ```azurecli
    az vm open-port \
        --name MyVMFromIMage \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --port 80
    ````

1. Run the following command to find the public IP address of the new virtual machine:

    ```azurecli
    az vm list-ip-addresses \
        --resource-group <rgn>[Sandbox reource group name]</rgn> \
        --name MyVMFromImage \
        --output table
    ```

1. In the web browser, navigate to the public IP address of the new virtual machine. Verify that a web page displaying the name of the virtual machine from which the image was built (MyWindowsVM or MyUbuntuVM).
