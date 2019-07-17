You have identified the need to use a scale set to run the web application for the shipping company. Using a scale set will enable the shipping company to maintain short response times for users, as the workload varies.

Your first task is to create a scale set, and configure it to run a web server – in this case, **nginx**. When you've configured the scale set correctly, you'll deploy your web application. Then you'll set up a health probe that Azure uses to verify the availability of each virtual machine in the scale set. Finally, you'll test the scale set by sending requests from a web browser.

## Deploy a virtual machine scale set

[!include[](../../../includes/azure-sandbox-activate.md)]

1. In the Cloud Shell window on the right, start the Code editor and create a file named **cloud-init.yaml**.

    ```bash
    code cloud-init.yaml
    ```

2. Add the following text to the file:

    ```Text
    #cloud-config
    package_upgrade: true
    packages:
      - nginx
    write_files:
      - owner: www-data:www-data
      - path: /var/www/html/index.html
        content: |
            Hello world from VM Scale Set !
    runcmd:
      - service nginx restart
    ```

    This file contains the configuration information for installing nginx on the VMs in the scale set:

3. Press Ctrl-S to save the file, and then press Ctrl-Q to close the Code editor.

4. Run the following command to create the virtual machine scale set:

    ```azurecli
    az vmss create \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name webServerScaleSet \
      --image UbuntuLTS \
      --upgrade-policy-mode automatic \
      --custom-data cloud-init.yaml \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    By default, the virtual machine scale set is created with two instances and a load balancer.

    > [!NOTE]
    > The **custom-data** flag specifies that the virtual machine should be configured using the settings in the **cloud-init.yaml** file once it has been created. You can use a cloud-init file to install additional packages, configure security, and write to files when the machine is first installed. For more information, see [Cloud-init support for virtual machines in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init)

## Configure the virtual machine scale set

1. Run the following command to add a health probe to the load balancer:

    ```azurecli
    az network lb probe create \
      --lb-name webServerScaleSetLB \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name webServerHealth \
      --port 80 \
      --protocol Http \
      --path /
    ```

    The health probe pings the root of the website through port 80. If the website doesn't respond, the server is considered unavailable, and the load balancer won't route traffic towards it.

2. Run the following command to configure the load balancer to route HTTP traffic to the instances in the scale set:

    ```azurecli
    az network lb rule create \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name webServerLoadBalancerRuleWeb \
      --lb-name webServerScaleSetLB \
      --probe-name webServerHealth \
      --backend-pool-name webServerScaleSetLBBEPool \
      --backend-port 80 \
      --frontend-ip-name loadBalancerFrontEnd \
      --frontend-port 80 \
      --protocol tcp
    ```

## Test the virtual machine scale set

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your MSLearn account.

2. In the left pane, select **Resource groups**, and then select the <rgn>[sandbox resource group]</rgn> resource group.

3. Select the **webServerScaleSet** virtual machine scale set.

4. On the **Overview** page, note the public IP address of the virtual machine scale set.

    ![Screenshot of the Azure portal, showing the Overview page for the virtual machine scale set](../media/3-vmss-properties.png)

5. Under **Settings**, select **Instances**, and verify that the scale set contains two running VMs.

    ![Screenshot of the Azure portal, showing the instances for the virtual machine scale set](../media/3-vmss-instances.png)

6. Select **Operating system,** and verify that the VMs are running Ubuntu Linux.

    ![Screenshot of the Azure portal, showing the operating system for the virtual machine scale set](../media/3-vmss-operating-system.png)

7. Select **Size**. The VMs should be running on DS1_v2 hardware

    ![Screenshot of the Azure portal, showing the size of the virtual machines in the scale set](../media/3-vmss-size.png)

8. In your web browser, go to the public IP address of the scale set. Verify that the message **Hello World from VM Scale Set !**<!--CE:Is this correct, with a space between 'Set' and '!'?--> appears.

    ![Screenshot of the web app](../media/3-web-app.png)
