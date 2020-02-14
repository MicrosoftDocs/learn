In this module, you will configure the DNS name for Public IP Address of the AZ-220-VM-EDGEGW-_{YOUR-ID}_, and configure that DNS name as the hostname of the IoT Edge Gateway device.

## Setup an IoT Edge Gateway Hostname

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. Navigate to the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** IoT Edge virtual machine.

1. On the **Overview** pane of the **Virtual machine** blade, click the **Configure** link next to **DNS name**.

1. On the **Public IP Address** Configuration blade for the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** virtual machine, enter `az-220-vm-edgegw-{YOUR-ID}` into the **DNS name label** field (the label must be globally unique, and only lowercase letters, numbers, and hyphens).

1. Click **Save**.

1. Note the full DNS name for the Public IP Address of the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** virtual machine, and save it for reference later.

    The full DNS name is composed of the AZ-220-VM-EDGEGW-{YOUR-ID} value suffixed by the text below the DNS name label field.

    For example, the full DNS name will be:

    ```bash
     az-220-vm-edgegw-cah191230.eastus.cloudapp.azure.com
    ```
    
    All Public IP Address DNS names will be at the **.cloudapp.azure.com** domain name. This example is for the VM being hosted in the eastus Azure region. This part fo the DNS name will vary depending on what Azure region the VM is hosted within.

    Setting the DNS name for the Public IP Address of the **AZ-220-VM-EDGEGW** will give it an FQDN (Fully Qualified Domain Name) for the downstream device(s) to use as the **GatewayHostName** to connect to it. Since the VM, in this case, is accessible across the Internet an Internet DNS name is needed. If the Azure IoT Edge Gateway were hosted in a Private or Hybrid network, then the machine name would meet the requirements of a **GatewayHostName** for on-premises downstream devices to connect.

1. Navigate to the **AZ-220-VM-EDGEGW** IoT Edge virtual machine within the Azure portal.

1. On the **Overview** pane of the **Virtual machine** blade, click the **Connect** button at the top.

1. Within the **Connect to virtual machine** pane, select the **SSH** option, then copy the **Login using VM local** account value.

    You can modify this sample SSH command which will be used to connect to the virtual machine that contains the IP Address for the VM and the Administrator username. Now that the DNS name label has been configured, the command is formatted similar to `ssh demouser@AZ-220-VM-EDGEGW.eastus.cloudapp.azure.com`.

    >[!NOTE]
    > If a “Host key verification failed” messages displays, then use the VM’s IP Address with the `ssh` command to connect tot he virtual machine.

1. Navigate to the Azure portal and click on the **Cloud Shell** icon to open up the **Azure Cloud Shell**. When the pane opens, choose the option for the **Bash** terminal within the Cloud Shell.

1. Within the Cloud Shell, paste in the `ssh` command that was copied, and press **Enter**.

1. When prompted to enter the password, enter the Administrator password that was entered when the VM was provisioned.

1. Run the following command to open the `config.yaml` file within the vi/vim editor:

    ```bash
    sudo vi /etc/iotedge/config.yaml
    ```
1. Locate the **Edge device hostname** section within the file. Update the **hostname** value to be set to the **DNS name** set previously for the Public IP Address of the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** virtual machine.

    The resulting value will look similar to the following:

    ```bash
    hostname: "az-220-vm-edgegw-{YOUR-ID}.eastus.cloudapp.azure.com"
    ```

    The `hostname` setting configures the Edge Hub server hostname. Regardless of the case used for this setting, a lowercase value is used to configure the Edge Hub server. This value is also the hostname that downstream IoT devices will need to use when connecting to the IoT Edge Gateway for the encrypted communication to work properly.

    >[!NOTE]
    > Here are some tips for using **vi** when editing the `config.yaml file`: 
    >- Press `Esc` and enter `/` followed by a search string, then press enter to search
    >- Pressing `n` will cycle through matches.
    >- Press the `i` key to put the editor into Insert mode, then you will be able to make changes.
    >- Press `Esc` to go stop Insert mode and return to Normal mode.
    >- To Save and Quit, type `:x`, and press `Enter`.
    >- Save the file, type `:w`, and press `Enter`.
    >- To quit vi, type `:quit` and press `Enter`.

1. Save the file and exit vi/vim.

Congratulations, that's the end of the module! In the next module, we will connect an IoT Edge Gateway Device to IoT Hub.