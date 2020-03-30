The testing team has been monitoring the uptime of our IoT Edge Gateway.  Their test is performed by pinging the ip address of the virtual machine at regular intervals.  It seems they are having difficulty getting a response. Perhaps we forgot to set up a static ip?  

Using a static ip may not be enough since we'll eventually deploy the solution in our internal environment.  Maybe there is a better way. 

[![Developer](../media/developer2.png)](../media/developer2.png#lightbox)

We need a reliable mechanism for connecting to our IoT Edge Gateway.  IP addresses are fine for testing, but are subject to change, especially in our production environment.  To accommodate this need, we will set a up DNS Name for our IoT Edge Gateway then update the associated IoT Edge configuration.

In this unit, you'll configure a DNS name for the **Public IP Address** of AZ-220-VM-EDGEGW-_{YOUR-ID}_, and configure that DNS name as the hostname of the IoT Edge Gateway device.

## Set up an IoT Edge Gateway Hostname

1. If necessary, sign in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, ensure that you are logged in with the account that is tied to the subscription that you intend to use for this course.

1. Navigate to the IoT Edge virtual machine.

1. On the **Overview** pane of the **Virtual machine** blade, click the **Configure** link next to **DNS name**.

1. On the **Public IP Address** Configuration blade for the * virtual machine, take note of into the **DNS name label** field, which should be in the format:

    `az-220-vm-edgegw-{YOUR-ID}`

1. Note the full DNS name for the Public IP Address of the virtual machine, and save it for reference later.

    The full DNS name is composed of the az-220-vm-edgegw-{YOUR-ID} value suffixed by the text below the DNS name label field.

    For example, the full DNS name will be:

    ```bash
     az-220-vm-edgegw-cah191230.eastus.cloudapp.azure.com
    ```
    
    All Public IP Address DNS names will be at the **.cloudapp.azure.com** domain name. This example is for the VM being hosted in the eastus Azure region. This part fo the DNS name will vary depending on what Azure region the VM is hosted within.

    The DNS name for the Public IP Address of the virtual machine provides an FQDN (Fully Qualified Domain Name) for the downstream device(s) to use as the **GatewayHostName** to connect to it. Since the VM, in this case, is accessible across the Internet an Internet DNS name is needed. If the Azure IoT Edge Gateway is hosted in a Private or Hybrid network, then the machine name would meet the requirements of a **GatewayHostName** for on-premises downstream devices to connect.

1. Navigate to the IoT Edge virtual machine within the Azure portal.

1. On the **Overview** pane of the **Virtual machine** blade, click the **Connect** button at the top.

1. Within the **Connect to virtual machine** pane, select the **SSH** option, then copy the **Login using VM local** account value.

    You can modify this sample SSH command, which will be used to connect to the virtual machine.  Notice that it contains the IP Address for the VM and the Administrator username. Now that the DNS name label has been configured, the command is formatted similar to `ssh demouser@AZ-220-VM-EDGEGW.eastus.cloudapp.azure.com`.

    >[!NOTE]
    > If a "Host key verification failed" messages displays, then use the VM's IP Address with the `ssh` command to connect to the virtual machine.

1. Navigate to the Azure portal and click on the **cloud shell** icon to open up the **Azure cloud shell**. When the pane opens, choose the option for the **Bash** terminal within the cloud shell.

1. Within the **Connect to virtual machine pane**, select the **SSH** option, then look for the section "**Run the example command below to connect to your VM.**".

    This section should contain an entry that looks similar to the text below: 
    
    `ssh -i <private key path> usernam@az-220-vm-edgegw-{YOUR-ID}.westus.cloudapp.azure.com
    `

    This entry is a sample SSH command that will be used to connect to the virtual machine that contains the hostname for the VM and the Administrator username. Modify this command so that it is formatted similar to `ssh username@az-220-vm-edgegw-{YOUR-ID}.westus.cloudapp.azure.com`.

1. Within the cloud shell, paste in the modified `ssh` command, and press **Enter**.

1. When prompted to enter the password, enter the Administrator password that was entered when the VM was provisioned.

1. Run the following command to open the `config.yaml` file within the vi/vim editor:

    ```bash
    sudo vi /etc/iotedge/config.yaml
    ```
1. Locate the **Edge device hostname** section within the file. Update the **hostname** value to be set to the **DNS name** set previously for the Public IP Address of the Azure IoT Edge Gateway Virtual Machine.

    The resulting value will look similar to the following:

    ```bash
    hostname: "az-220-vm-edgegw-{YOUR-ID}.eastus.cloudapp.azure.com"
    ```

    The `hostname` setting configures the Edge Hub server hostname. Regardless of the case used for this setting, a lowercase value is used to configure the Edge Hub server. This value is also the hostname that downstream IoT devices will need to use when connecting to the IoT Edge Gateway for secure communication to work properly.

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

1. Now restart the IoT Edge Service to take into account the new hostname and ensure that it starts successfully.  

    ```bash
    sudo service iotedge restart
    ```

    If the Edge runtime does not restart successfully, ensure that you have modified `/etc/iotedge/config.yaml` appropriately.

Congratulations, that's the end of the unit! In the next unit, we'll open IoT Edge Gateway Device Ports for communication with Downstream Devices.