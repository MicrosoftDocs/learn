# Security capabilities  

TODO supporting markdown.  






### Enhancing network security and control

You've now seen how to update firewall rules for specific IP addresses or ranges of IP addresses. If you were running in production, you may also need access from various virtual networks, resources (e.g. Azure Apps or Azure VMs). If you take an Azure VM as an example, they have dynamic IP addresses (they change). You can set up static IP addresses, but even this can be difficult to maintain using firewall rules. You can, alternatively, use virtual network (VNet) rules to manage access from specific subnet(s) that contain your VMs or other services. Let's see how.  

In the Azure portal view of your Azure SQL Database, under Firewalls and virtual networks, you can manage your network security options, including TLS, access to Azure Services, Virtual Network/Firewall rules, and more.

If you configure access from a Virtual Network with a Virtual Network rule, then any resources in your VNet can access to your Azure SQL Database logical server, which can simplify the challenge of configuring access to all the IP addresses (static and dynamic) that need to access the data. This could allow you to specify one or multiple subnets within a virtual network or networks, encompassing all of the resources within.  

### Private Link for Azure SQL Database

You've learned and seen how to configure the most secure network using Azure SQL Database with the public endpoint. This method of securing Azure SQL Database has been used for years. However, in 2019, Azure began moving towards a concept of a Private Link, which is more similar to the way that Azure SQL Managed Instance is deployed. Private Link allows you to connect to Azure SQL Database (and several other PaaS services) using a private endpoint, which means it has a private IP address within a specific VNet and Subnet. You can learn more about Private Link [in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview).  
  
In the video that follows, you can see how to create, configure and compare all the various methods of connecting to Azure SQL Database: Allow access to Azure resources, Firewall rules, Virtual Network rules using the Azure portal (also possible with PowerShell and the Azure CLI).

> Note: If you complete this activity, you must complete up until the last step, otherwise you may have issues in future activities. If you're not sure if you will have time to complete, most of the screenshots and results are included below, so you can simply read and review the activity.  

### Steps

In this activity, you will complete the following steps:  

0. Examine the current connection
1. Navigate to the private endpoint experience in the Azure portal  
2. Create a private endpoint - Basics
3. Create a private endpoint - Resource
4. Create a private endpoint - Configuration
5. Create a private endpoint - Confirm creation
6. Connect to the private endpoint  

#### Step 0: Examine the current connection  

When you deployed Azure SQL Database in Module 2, you set up access for your Azure VM through its public endpoint, and the public IP address of your Azure VM. This means you will connect to the database with the public IP address of your VM.  

By adding access from your specific VNet instead of the public IP address of your VM, connections to Azure SQL Database from your VM will appear to come through the private IP address of your VM (you confirmed this at the end of the last activity by running `SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;`). You will see the same result once you configure Private Link, so on the surface it may appear that there is no difference. However, there is quite a significant difference, so in this step you will examine how you connect to the database when you have VNet rules configured, and after you configure Private Link, you'll check this again.  

Open the command prompt and run the following command, replacing the `<ID>` with your ID for the workshop.  

```cmd
nslookup aw-server<ID>.database.windows.net  
```

This command allows you to understand details related to the DNS infrastructure. Your results should be similar to below:  

```cmd
Server: Unknown
Address: 168.63.129.16

Non-authoritative answer:
Name:   cr2.eastus1-a.control.database.windows.net
Address:    40.222.222.22
Aliases:    aw-server<ID>.database.windows.net
            dataslice2.eastus.database.windows.net
```

The important things to look at are under the Non-authoritative answer:  

* **Name**: The endpoint starting with `cr2` is part of the public DNS hierarchy. Without getting too much into the hierarchy, `cr2` is the Control Ring 2 and then there are multiple data "slices" below it.  
* **Address**: The IP address returned here should match the public IP address of your Azure VM. So even though SSMS' final hop might be through your VM's private IP address, the public IP address of your VM is still being used to connect in some capacity.  
* **Aliases**: These are just various points within the DNS hierarchy, in this case the specific data "slice" and the endpoint you connect to.  

> Fun fact: the **Address 168.63.129.16** is a virtual public IP address used to facilitate a communication channel to Azure platform resources. It's the case for all regions and all national clouds, and it will not change. You can read more about it in the [documentation](https://docs.microsoft.com/azure/virtual-network/what-is-ip-address-168-63-129-16).

Leave this command prompt open, so you can compare to Private Link in a later step.  

#### Step 1: Navigate to the private endpoint experience in the Azure portal  

In the Azure portal, in the top taskbar search bar, enter **private link** and select **Private Link** under *Services*.  

![Find Private Link service](../media/plservice.png)  

This is the center you can use for managing your various Private Link services across Azure.  

Select **Private endpoints** from the left-hand menu, and select **+ Add**.  

![Select Private endpoints blade](../media/privateendpoints.png)

#### Step 2: Create a private endpoint - Basics  

There are several pages you need to configure in order to create a private endpoint: Basics, Resource, Configuration, and Confirm creation. In this first step, fill in the subscription and resource group that you are using for the workshop.  

For name, enter the name of your server + **-pe**. For example, for "aw-server0218", you would enter **aw-server0218-pe**. Finally, select the region that you deployed your Azure SQL Database in.  

![Private endpoint basics pane](../media/pebasics.png)  

Next, select **Next : Resource >**.  

#### Step 3: Create a private endpoint - Resource  

In this section, you're asked to connect to the resource you want to set up the private endpoint for. In this case, you want to connect to an Azure resource in your directory. Then, select the subscription, resource type, and resource name that you are using for the workshop.  

> Note: If you were provided an environment for this workshop, be sure to select your assigned Azure SQL Database logical server.  

![Private endpoint resource pane](../media/peresource.png)  

Next, select **Next : Configuration**.  

#### Step 4: Create a private endpoint - Configuration  

In this step, you will configure your private endpoint to be created in the **same virtual network subnet as your Azure VM** for the workshop. This is the easiest way to ensure that you can connect to it from your virtual machine. There are other ways available (virtual network peering, VNet-to-VNet, VPN from on-premises), but you will not use those in this workshop.  

Select your VM virtual network, it should be similar to **azuresqlworkshop<ID>-vnet** or **win-vm-vnet** *under your resource group* and the subnet should be **default**.  

In order to connect privately with the endpoint you create, you'll also need a DNS record. This won't be covered in this activity, but you can learn more [here](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#dns-configuration). You can just leave the defaults.  

Review and confirm your view looks similar to the following.  

![Private endpoint configuration pane](../media/peconfig.png)   

Then, select **Review + create**. For this activity, you'll skip Tags, but you can add them similar to how you did during deployment.  

#### Step 5: Create a private endpoint - Confirm creation  

Review your deployment selections and then select **Create**.  

The deployment may take 1-2 minutes, but when it is finished, select **Go to resource**.  

In the overview tab, you should now see your Azure SQL Database logical server associated with a Private IP.  

![Private endpoint overview pane](../media/peoverview.png)  

#### Step 6: Connect to the private endpoint

In this step, you'll try to connect to the private endpoint. Using SSMS, right-click on your AdventureWorks<ID> database and select **New Query**. Run the following command:  

```sql
SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
```

When you deployed Azure SQL Database in Module 2, you set up access for your Azure VM through its public endpoint, and the public IP address of your Azure VM. This means you will connect to the database with the public IP address of your VM.  

By adding access from your specific VNet instead of the public IP address of your VM, connections to Azure SQL Database from your VM will appear to come through the private IP address of your VM. You will see the same result now that you've configured Private Link. So where are the differences?  

Return to the command prompt window that you used in Step 0. If you have since closed this window, open a new command prompt. Run the following command, replacing the `<ID>` with your ID for the workshop.  

```cmd
nslookup aw-server<ID>.database.windows.net  
```

As you saw in Step 0, this command allows you to understand details related to the DNS infrastructure. However, your results will be slightly different now. Your results with Private Link should be similar to below:  

```cmd
Server: Unknown
Address: 168.63.129.16

Non-authoritative answer:
Name:   aw-server<ID>.privatelink.database.windows.net
Address:    10.2.0.5
Aliases:    aw-server<ID>.database.windows.net
```

The important things to look at are under the Non-authoritative answer, and let's examine the differences:  

* **Name**: Note that you're no longer pointing to the public DNS hierarchy, only to the Private Link DNS. This means less information is revealed about your database server.  
* **Addresses**: For VNet rules, the address returned was the public IP address of your VM, but it should now be one or more *private* IP addresses within the Private Link hierarchy (one is the private endpoint of your Azure SQL Database).
* **Aliases**: Similar to the Name field, you're not seeing anything related to the DNS hierarchy, except that you can still connect to the server name (e.g. `aw-server0406.database.windows.net`).  

One thing you might be wondering, is if you are connecting to the private endpoint, **why are you still using the same server name?** In the backend, when you used solely the Private Link method of connecting (i.e. no firewall or virtual network rules), the information is processed as follows:  

* `aw-server<ID>.database.windows.net`  
  * Resolved by service to `aw-server<ID>.privatelink.database.net`  
    * Resolved by service to `10.2.0.5` (the IP address of your private endpoint)  

Additionally, the service will block you from directly connecting using anything apart from `aw-server<ID>.database.windows.net`.  

Microsoft is actively investing heavily in Private Link for SQL and other services, to learn more refer to the [documentation](https://docs.microsoft.com/azure/private-link/index).  