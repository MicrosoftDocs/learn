You have identified the need to use a scale set to run the web application for the shipping company. Using a scale set will enable the shipping company to maintain short response times for users, as the workload varies.

Your first task is to create a scale set, and configure it to run a web server – in this case, **nginx**. When you've configured the scale set correctly, you'll deploy your web application. Then you'll set up a health probe that Azure uses to verify the availability of each virtual machine in the scale set. Finally, you'll test the scale set by sending requests from a web browser.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the instructions so you understand how to use the REST API to retrieve metrics.
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Deploy a virtual machine scale set

1. Sign in to the [Azure portal](https://portal.azure.com) using your own account, and open the Azure Cloud Shell.
2. In the Cloud Shell, start the Code editor and create a file named **cloud-init.yaml**.

    ```bash
    code cloud-init.yaml
    ```

3. Add the following text to the file:

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

4. Press Ctrl-S to save the file, and then press Ctrl-Q to close the Code editor.

5. Run the following command to create a new resource group named **scalesetrg** for your scale set:

    ```azurecli
    az group create \
      --location westus \
      --name scalesetrg
    ```

6. Run the following command to create the virtual machine scale set:

    ```azurecli
    az vmss create \
      --resource-group scalesetrg \
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
      --resource-group scalesetrg \
      --name webServerHealth \
      --port 80 \
      --protocol Http \
      --path /
    ```

    The health probe pings the root of the website through port 80. If the website doesn't respond, the server is considered unavailable, and the load balancer won't route traffic towards it.

2. Run the following command to configure the load balancer to route HTTP traffic to the instances in the scale set:

    ```azurecli
    az network lb rule create \
      --resource-group scalesetrg \
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

1. In the Azure portal, in the left pane, select **Resource groups**, and then select the **scalesetrg** resource group.

2. Select the **webServerScaleSet** virtual machine scale set.

3. On the **Overview** page, note the public IP address of the virtual machine scale set.

    ![Screenshot of the Azure portal, showing the Overview page for the virtual machine scale set](../media/3-vmss-properties.png)

4. Under **Settings**, select **Instances**, and verify that the scale set contains two running VMs.

    ![Screenshot of the Azure portal, showing the instances for the virtual machine scale set](../media/3-vmss-instances.png)

5. Select **Operating system,** and verify that the VMs are running Ubuntu Linux.

    ![Screenshot of the Azure portal, showing the operating system for the virtual machine scale set](../media/3-vmss-operating-system.png)

6. Select **Size**. The VMs should be running on DS1_v2 hardware

    ![Screenshot of the Azure portal, showing the size of the virtual machines in the scale set](../media/3-vmss-size.png)

7. In your web browser, go to the public IP address of the scale set. Verify that the message **Hello World from VM Scale Set !**<!--CE:Is this correct, with a space between 'Set' and '!'?--> appears.

    ![Screenshot of the web app](../media/3-web-app.png)
