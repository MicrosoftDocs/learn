> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

In this exercise, you will create an internal load balancer for the fictional Contoso Ltd organization.

The steps to create an internal load balancer, are very similar to those you have already learned about in this module, to create a public load balancer. The key difference is that with a public load balancer the front end is accessed via a public IP address, and you test connectivity from a host which is located outside your virtual network; whereas, with an internal load balancer, the front end is a private IP address inside your virtual network, and you test connectivity from a host inside the same network.

The diagram below illustrates the environment you will be deploying in this exercise.

:::image type="content" source="../media/exercise-internal-standard-load-balancer-environment-diagram-1b4609f2.png" alt-text="internal standard loadbalancer diagram":::


In this exercise, you will:

 -  Task 1: Create the virtual network
 -  Task 2: Create backend servers
 -  Task 3: Create the load balancer
 -  Task 4: Create load balancer resources
 -  Task 5: Test the load balancer

## Task 1: Create the virtual network

In this section, you will create a virtual network and a subnet.

1.  Log in to the Azure portal.
2.  On the Azure portal home page, navigate to the Global Search bar and search **Virtual Networks** and select virtual networks under services.
3.  Select **Create** on the Virtual networks page

    :::image type="content" source="../media/create-virtual-network.png" alt-text="create a virtual network from the Azure portal":::


4.  On the **Basics** tab, use the information in the table below to create the virtual network.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Select your subscription
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        Select **Create new** Name: **IntLB-RG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **IntLB-VNet**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    
5.  Click **Next : IP Addresses**.
6.  On the **IP Addresses** tab, in the **IPv4 address space** box, remove the default and type **10.1.0.0/16**.
7.  On the **IP Address** tab, select **+ Add subnet**.
8.  In the **Add subnet** pane, provide a subnet name of **myBackendSubnet**, and a subnet address range of **10.1.0.0/24**.
9.  Click **Add**.
10. Click **Add subnet,** provide a subnet name of **myFrontEndSubnet**, and a subnet address range of **10.1.2.0/24.** Click **Add**
11. Click **Next : Security**.
12. Under **BastionHost** select **Enable**, then enter the information from the table below.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Bastion name
      :::column-end:::
      :::column:::
        **myBastionHost**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        AzureBastionSubnet address space
      :::column-end:::
      :::column:::
        **10.1.1.0/24**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP address
      :::column-end:::
      :::column:::
        Select **Create new** Name: **myBastionIP**
      :::column-end:::
    :::row-end:::
    
13. Click **Review + create**.
14. Click **Create**.

## 

## Task 2: Create backend servers

In this section, you will create three VMs, that will be in the same availability set, for the backend pool of the load balancer, add the VMs to the backend pool, and then install IIS on the three VMs to test the load balancer.

1.  In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.
2.  In the toolbar of the Cloud Shell pane, click the Upload/Download files icon, in the drop-down menu, click Upload and upload the following files azuredeploy.json, azuredeploy.parameters.vm1.json, azuredeploy.parameters.vm2.json and azuredeploy.parameters.vm3.json into the Cloud Shell home directory. [Azure Resource Manager Templates for this task](https://github.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/tree/master/Allfiles/Exercises/M04)
3.  Deploy the following Azure Resource Manager templates to create the virtual network, subnets, and VMs needed for this exercise:
    
    ```powershell
    $RGName = "IntLB-RG"
    
    New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.vm1.json
    New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.vm2.json
    New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.vm3.json
    ```

## Task 3: Create the load balancer

In this section, you will create an internal Standard SKU load balancer. The reason we are creating a Standard SKU load balancer here in the exercise, instead of a Basic SKU load balance, is for later exercises that require a Standard SKU version of the load balancer.

1.  On the Azure portal home page, click **Create a resource**.
2.  In the search box at the top of the page, type **Load Balancer**, then press **Enter**

> [!NOTE]
> do not select one from the list

1.  On the results page, locate and select **Load Balancer** (the one that says 'Microsoft' and 'Azure Service' under the name).
2.  Click **Create**. 

    :::image type="content" source="../media/create-load-balancer-4-4a82194d.png" alt-text="create a load balancer":::
    
3.  On the **Basics** tab, use the information in the table below to create the load balancer.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Select your subscription
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        **IntLB-RG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **myIntLoadBalancer**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Type
      :::column-end:::
      :::column:::
        **Internal**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        SKU
      :::column-end:::
      :::column:::
        **Standard**
      :::column-end:::
    :::row-end:::
    
4.  Click **Next: Frontend IP configurations.**
5.  Click Add a frontend IP
6.  On the **Add frontend IP address** blade, enter the information from the table below.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **LoadBalancerFrontEnd**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        **IntLB-VNet**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subnet
      :::column-end:::
      :::column:::
        **myFrontEndSubnet**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Assignment
      :::column-end:::
      :::column:::
        **Dynamic**
      :::column-end:::
    :::row-end:::
    
7.  Click **Review + create**.
8.  Click **Create**.

## Task 4: Create load balancer resources

In this section, you will configure load balancer settings for a backend address pool, then create a health probe and a load balancer rule.

### Create a backend pool and add VMs to the backend pool

The backend address pool contains the IP addresses of the virtual NICs connected to the load balancer.

1.  On the Azure portal home page, click **All resources**, then click on **myIntLoadBalancer** from the resources list.
2.  Under **Settings**, select **Backend pools**, and then click **Add**.
3.  On the **Add backend pool** page, enter the information from the table below.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **myBackendPool**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        **IntLB-VNet**
      :::column-end:::
    :::row-end:::

    
4.  Under **Virtual machines**, click **Add.**
5.  Select the checkboxes for all 3 VMs (**myVM1, myVM2,** and **myVM3**), then click **Add**<br>
6.  Click **Add**. 

:::image type="content" source="../media/add-vms-backend-pool-f47c982b.png" alt-text="add vms to backend pool":::
    

### Create a health probe

The load balancer monitors the status of your app with a health probe. The health probe adds or removes VMs from the load balancer based on their response to health checks. Here you will create a health probe to monitor the health of the VMs.

1.  Under **Settings**, click **Health probes**, then click **Add**.
2.  On the **Add health probe** page, enter the information from the table below.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **myHealthProbe**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Protocol
      :::column-end:::
      :::column:::
        **HTTP**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Port
      :::column-end:::
      :::column:::
        **80**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Path
      :::column-end:::
      :::column:::
        **/**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Interval
      :::column-end:::
      :::column:::
        **15**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Unhealthy threshold
      :::column-end:::
      :::column:::
        **2**
      :::column-end:::
    :::row-end:::
    
3.  Click **Add**. 

:::image type="content" source="../media/create-health-probe-1b43f23a.png" alt-text="create a health probe":::
    

### Create a load balancer rule

A load balancer rule is used to define how traffic is distributed to the VMs. You define the frontend IP configuration for the incoming traffic and the backend IP pool to receive the traffic. The source and destination port are defined in the rule. Here you will create a load balancer rule.

1.  From the **Backend pools** page of your load balancer, under **Settings**, click **Load balancing rules**, then click **Add**.
2.  On the **Add load balancing rule** page, enter the information from the table below.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **myHTTPRule**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        IP Version
      :::column-end:::
      :::column:::
        **IPv4**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Frontend IP address
      :::column-end:::
      :::column:::
        **LoadBalancerFrontEnd**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Protocol
      :::column-end:::
      :::column:::
        **TCP**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Port
      :::column-end:::
      :::column:::
        **80**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Backend port
      :::column-end:::
      :::column:::
        **80**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Backend pool
      :::column-end:::
      :::column:::
        **myBackendPool**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Health probe
      :::column-end:::
      :::column:::
        **myHealthProbe**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Session persistence
      :::column-end:::
      :::column:::
        **None**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Idle timeout (minutes)
      :::column-end:::
      :::column:::
        **15**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Floating IP
      :::column-end:::
      :::column:::
        **Disabled**
      :::column-end:::
    :::row-end:::
    
3.  Click **Add**. 

:::image type="content" source="../media/create-load-balancer-rule-ba7cac96.png" alt-text="create a load balancer rule":::
    

## Task 5: Test the load balancer

In this section, you will create a test VM, and then test the load balancer.

### Create test VM

1.  On the Azure portal home page, click **Create a resource**, then **Compute**, then select **Virtual machine** (if this resource type is not listed on the page, use the search box at the top of the page to search for it and select it).
2.  On the **Create a virtual machine** page, on the **Basics** tab, use the information in the table below to create the first VM.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Select your subscription
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        **IntLB-RG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual machine name
      :::column-end:::
      :::column:::
        **myTestVM**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Availability options
      :::column-end:::
      :::column:::
        **No infrastructure redundancy required**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Image
      :::column-end:::
      :::column:::
        **Windows Server 2019 Datacenter - Gen 1**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Size
      :::column-end:::
      :::column:::
        **Standard_DS2_v3 - 2 vcpu, 8 GiB memory**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Username
      :::column-end:::
      :::column:::
        **TestUser**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Password
      :::column-end:::
      :::column:::
        **TestPa$$w0rd!**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Confirm password
      :::column-end:::
      :::column:::
        **TestPa$$w0rd!**
      :::column-end:::
    :::row-end:::
    
3.  Click **Next : Disks**, then click **Next : Networking**.
4.  On the **Networking** tab, use the information in the table below to configure networking settings.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        **IntLB-VNet**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subnet
      :::column-end:::
      :::column:::
        **myBackendSubnet**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP
      :::column-end:::
      :::column:::
        Change to **None**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        NIC network security group
      :::column-end:::
      :::column:::
        **Advanced**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Configure network security group
      :::column-end:::
      :::column:::
        Select the existing **myNSG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Place this virtual machine behind an existing load balancing solution?
      :::column-end:::
      :::column:::
        **Off** (unchecked)
      :::column-end:::
    :::row-end:::
    
5.  Click **Review + create**.
6.  Click **Create**.
7.  Wait for this last VM to be deployed before moving forward with the next task.

### Connect to the test VM to test the load balancer

1.  On the Azure portal home page, click **All resources**, then click on **myIntLoadBalancer** from the resources list.
2.  On the **Overview** page, make a note of the **Private IP address**, or copy it to the clipboard.
3.  Click **Home**, then on the Azure portal home page, click **All resources**, then click on the **myTestVM** virtual machine that you just created.
4.  On the **Overview** page, select **Connect**, then **Bastion**.
5.  Click **Use Bastion**.
6.  In the **Username** box, type **TestUser** and in the **Password** box, type **TestPa$$w0rd!**, then click **Connect**.
7.  The **myTestVM** window will open in another browser tab.
8.  If a **Networks** pane appears, click **Yes**.
9.  Click the **Internet Explorer** icon in the task bar to open the web browser.
10. Click **OK** on the **Set up Internet Explorer 11** dialog box.
11. Enter (or paste) the **Private IP address** (e.g. 10.1.0.4) from the previous step into the address bar of the browser and press Enter.
12. The default web home page of the IIS Web server is displayed in the browser window. One of the three virtual machines in the backend pool will respond. 

    :::image type="content" source="../media/load-balancer-web-test-1-c297dca7.png" alt-text="webpage showing myVM1":::
    
13. If you click the refresh button in the browser a few times, you will see that the response comes randomly from the different VMs in the backend pool of the internal load balancer. 

:::image type="content" source="../media/load-balancer-web-test-2-15d0df1a.png" alt-text="webpage showing myVM3":::
    

## Clean up resources

> [!NOTE]
> Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1.  In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.
2.  Delete all resource groups you created throughout the labs of this module by running the following command:
    
    ```powershell
    Remove-AzResourceGroup -Name 'IntLB-RG' -Force -AsJob
    
    ```

> [!NOTE]
> The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.
