Use this short Try-This exercises to get some hands-on experience with using Azure. An individual Azure subscription is required to perform the exercise tasks. To subscribe, browse to https://www.azure.microsoft.com/free.

In this demonstration, we'll configure a network security group to filter inbound and outbound network traffic to and from Azure resources in an Azure virtual network. Network security groups contain security rules that filter network traffic by IP address, port, and protocol. When a network security group is associated with a subnet, security rules are applied to resources deployed in that subnet.

## Task 1 - Create a virtual network

1. From the Azure portal menu, select + Create a resource &gt; Networking &gt; Virtual network, or search for *Virtual Network* in the portal search box.

2. Select Create.

3. On the Basics tab of Create virtual network, enter or select this information:

| Setting          | Value                                                  |
| ---------------- | ------------------------------------------------------ |
| Project details  |                                                        |
| Subscription     | Select your subscription.                              |
| Resource group   | Select Create new. Enter *myResourceGroup*. Select OK. |
| Instance details |                                                        |
| Name             | Enter *myVNet*.                                        |
| Region           | Select East US.                                        |

4. Select the Review + create tab, or select the blue Review + create button at the bottom of the page.

5. Select Create.

## Task 2 - Create an application security group

> [!NOTE]
> An application security group (ASG) enables you to group together servers with similar functions, such as web servers.

1. From the Azure portal menu, select + Create a resource &gt; Networking &gt; Application security group, or search for Application security group in the portal search box.

2. Select Create.

3. On the Basics tab of Create an application security group, enter or select this information:

| Setting          | Value                     |
| ---------------- | ------------------------- |
| Project details  |                           |
| Subscription     | Select your subscription. |
| Resource group   | Select myResourceGroup.   |
| Instance details |                           |
| Name             | Enter *myAsgWebServers*.  |
| Region           | Select (US) East US.      |

4. Select the Review + create tab, or select the blue Review + create button at the bottom of the page.

5. Select Create.

> [!NOTE]
> Repeat the previous steps, specifying the following values:

| Setting          | Value                     |
| ---------------- | ------------------------- |
| Project details  |                           |
| Subscription     | Select your subscription. |
| Resource group   | Select myResourceGroup.   |
| Instance details |                           |
| Name             | Enter *myAsgMgmtServers*. |
| Region           | Select (US) East US.      |

6. Select the Review + create tab, or select the blue Review + create button at the bottom of the page.

7. Select Create.

## Task 3 - Create a network security group

1. From the Azure portal menu, select + Create a resource &gt; Networking &gt; Network security group, or search for *Network security group* in the portal search box.

2. Select Create.

3. On the Basics tab of Create network security group, enter or select this information:

| Setting          | Value                     |
| ---------------- | ------------------------- |
| Project details  |                           |
| Subscription     | Select your subscription. |
| Resource group   | Select myResourceGroup.   |
| Instance details |                           |
| Name             | Enter *myNSG*.            |
| Location         | Select (US) East US.      |

4. Select the Review + create tab, or select the blue Review + create button at the bottom of the page.

5. Select Create.

## Task 4 - Associate network security group to subnet

1. Search for *myNsg* in the portal search box.

2. Select Subnets from the Settings section of myNSG.

3. In the Subnets page, select + Associate:

4. Under Associate subnet, select myVNet for Virtual network.

5. Select default for Subnet, and then select OK.

## Task 5 - Create security rules

1. Select Inbound security rules from the Settings section of myNSG.

2. In Inbound security rules page, select + Add:

3. Create a security rule that allows ports 80 and 443 to the myAsgWebServers application security group. In Add inbound security rule page, enter or select this information:

| Setting                                 | Value                              |
| --------------------------------------- | ---------------------------------- |
| Source                                  | Leave the default of Any.          |
| Source port ranges                      | Leave the default of (\*).         |
| Destination                             | Select Application security group. |
| Destination application security groups | Select myAsgWebServers.            |
| Service                                 | Leave the default of Custom.       |
| Destination port ranges                 | Enter *80,443*.                    |
| Protocol                                | Select TCP.                        |
| Action                                  | Leave the default of Allow.        |
| Priority                                | Leave the default of 100.          |
| Name                                    | Enter *Allow-Web-All*.             |

4. Select Add.

5. Complete steps 3-4 again using this information:

| Setting                                | Value                              |
| -------------------------------------- | ---------------------------------- |
| Source                                 | Leave the default of Any.          |
| Source port ranges                     | Leave the default of (\*).         |
| Destination                            | Select Application security group. |
| Destination application security group | Select myAsgMgmtServers.           |
| Service                                | Leave the default of Custom.       |
| Destination port ranges                | Enter *3389*.                      |
| Protocol                               | Select Any.                        |
| Action                                 | Leave the default of Allow.        |
| Priority                               | Leave the default of 110.          |
| Name                                   | Enter *Allow-RDP-All*.             |

6. Select Add.

> [!CAUTION]
> Remote Desktop Protocol (port 3389) is exposed to the internet for the VM that is assigned to the myAsgMgmtServers application security group. For production environments, instead of exposing port 3389 to the internet, it's recommended that you connect to Azure resources that you want to manage using a VPN, private network connection, or Azure Bastion.

## Task 6 - Create virtual machines

1. From the Azure portal menu, select + Create a resource &gt; Compute &gt; Virtual machine, or search for Virtual machine in the portal search box.

2. In Create a virtual machine, enter or select this information in the Basics tab:

| Setting               | Value                                                       |
| --------------------- | ----------------------------------------------------------- |
| Project details       |                                                             |
| Subscription          | Select your subscription.                                   |
| Resource group        | Select myResourceGroup.                                     |
| Instance details      |                                                             |
| Virtual machine name  | Enter *myVMWeb*.                                            |
| Region                | Select (US) East US.                                        |
| Availability options  | Leave the default of No infrastructure redundancy required. |
| Security type         | Leave the default of Standard.                              |
| Image                 | Select Windows Server 2019 Datacenter - Gen2.               |
| Azure Spot instance   | Leave the default of unchecked.                             |
| Size                  | Select Standard\_D2s\_V3.                                   |
| Administrator account |                                                             |
| Username              | Enter a username.                                           |
| Password              | Enter a password.                                           |
| Confirm password      | Reenter password.                                           |
| Inbound port rules    |                                                             |
| Select inbound ports  | Select None.                                                |

3. Select the Networking tab.

4. In the Networking tab, enter or select the following information:

| Setting                    | Value                                 |
| -------------------------- | ------------------------------------- |
| Network interface          |                                       |
| Virtual network            | Select myVNet.                        |
| Subnet                     | Select default (10.0.0.0/24).         |
| Public IP                  | Leave the default of a new public IP. |
| NIC network security group | Select None.                          |

5. Select the Review + create tab, or select the blue Review + create button at the bottom of the page.

6. Select Create. The VM may take a few minutes to deploy.

Create the second virtual machine

> [!NOTE]
> Complete steps 1-6 again, but in step 2, enter *myVMMgmt* for Virtual machine name. Wait for the VMs to complete deployment before advancing to the next section.

Associate network interfaces to an Application Security Group

> [!NOTE]
> When you created the VMs, Azure created a network interface for each VM, and attached it to the VM.

Add the network interface of each VM to one of the application security groups you created previously:

1. Search for myVMWeb in the portal search box.

2. Select Networking from the Settings section of myVMWeb VM.

3. Select the Application security groups tab, then select Configure the application security groups.

4. In Configure the application security groups, select myAsgWebServers. Select Save.

> [!NOTE]
> Complete steps 1 and 2 again, searching for the myVMMgmt virtual machine and selecting the myAsgMgmtServers ASG.

## Task 7 - Test traffic filters

1. Search for myVMMgmt in the portal search box.

2. On the Overview page, select the Connect button and then select RDP.

3. Select Download RDP file.

4. Open the downloaded rdp file and select Connect. Enter the username and password you specified when creating the VM.

5. Select OK.

6. You may receive a certificate warning during the connection process. If you receive the warning, select Yes or Continue, to continue with the connection.

7. The connection succeeds, because inbound traffic from the internet to the myAsgMgmtServers application security group is allowed through port 3389.

> [!NOTE]
> The network interface for myVMMgmt is associated with the myAsgMgmtServers application security group and allows the connection.

8. Open a PowerShell session on myVMMgmt. Connect to myVMWeb using the following:

```powershell
mstsc /v:myVmWeb
```

> [!IMPORTANT]
> The RDP connection from myVMMgmt to myVMWeb succeeds because virtual machines in the same network can communicate with each other over any port by default. You can't create an RDP connection to the myVMWeb virtual machine from the internet. The security rule for the myAsgWebServers prevents connections to port 3389 inbound from the internet. Inbound traffic from the Internet is denied to all resources by default.

9. To install Microsoft Internet Information Services (IIS) on the myVMWeb virtual machine, enter the following command from a PowerShell session on the myVMWeb virtual mfferent:

```powershell
Install-WindowsFeature -name Web-Server -IncludeManagementTools
```

10. After the Internet Information Services (IIS) installation is complete, disconnect from the myVMWeb virtual machine, which leaves you in the myVMMgmt virtual machine remote desktop connection.

11. Disconnect from the myVMMgmt VM.

12. Search for *myVMWeb* in the portal search box.

13. On the Overview page of myVMWeb, note the Public IP address for your VM.

14. To confirm that you can access the myVMWeb web server from the internet, open an internet browser on your computer and browse to http://&lt;public-ip-address-from-previous-step&gt;.

> [!NOTE]
> You see the Internet Information Services (IIS) default page, because inbound traffic from the internet to the myAsgWebServers application security group is allowed through port 80. The network interface attached for myVMWeb is associated with the myAsgWebServers application security group and allows the connection.
