> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

Being part of the Network Security team at Contoso, your next task is to create firewall rules to allow/deny access to certain websites. The following steps walk you through creating a resource group, a virtual network and subnets, and a virtual machine as environment preparation tasks, and then deploying a firewall and firewall policy, configuring default routes and application, network and DNAT rules, and finally testing the firewall.

In this exercise, you will:

 -  Task 1: Create a resource group
 -  Task 2: Create a virtual network and subnets
 -  Task 3: Create a virtual machine
 -  Task 4: Deploy the firewall and firewall policy
 -  Task 5: Create a default route
 -  Task 6: Configure an application rule
 -  Task 7: Configure a network rule
 -  Task 8: Configure a Destination NAT (DNAT) rule
 -  Task 9: Change the primary and secondary DNS address for the server's network interface
 -  Task 10: Test the firewall
 -  Task 11: Clean up resources

## Task 1: Create a resource group

In this task, you will create a new resource group.

1.  Log in to your Azure account.
2.  On the Azure portal home page, select **Resource groups**.
3.  Select **Create**.
4.  On the **Basics** tab, in **Resource group**, enter **Test-FW-RG**.
5.  In **Region**, select your region from the list.

    :::image type="content" source="../media/create-resource-group-for-azure-firewall-8a06ad6e.png" alt-text="Create a resource group for Azure firewall":::


6.  Select **Review + create**.
7.  Select **Create**.

## Task 2: Create a virtual network and subnets

In this task, you will create a single virtual network with two subnets.

1.  On the Azure portal home page, select **Create a resource**, then in the search box, enter **virtual network** and select **Virtual Network** when it appears.
2.  Select **Create**.
3.  Select the **Test-FW-RG** resource group you created previously.
4.  In the **Name** box, enter **Test-FW-VN**.

    :::image type="content" source="../media/create-vnet-basics-for-azure-firewall-4329b2da.png" alt-text="Create a virtual network - Basics tab":::


5.  Select **Next: IP Addresses**.
6.  Under **Subnet name**, select the word **default**.
7.  In the **Edit subnet** dialog box, change the name to **AzureFirewallSubnet**.
8.  Change the **Subnet address range** to **10.0.1.0/26**.
9.  Select **Save**.

    :::image type="content" source="../media/edit-default-subnet-for-firewall-1d1c71b4.png" alt-text="Create a virtual network - edit subnet":::


10. Select **Add subnet**, to create another subnet, which will host the workload server that you will create shortly.
11. In the **Edit subnet** dialog box, change the name to **Workload-SN**.
12. Change the **Subnet address range** to **10.0.2.0/24**.
13. Select **Add**.

    :::image type="content" source="../media/add-workload-subnet-28b92aae.png" alt-text="Add subnet":::


14. Select **Review + create**.
15. Select **Create**.

## Task 3: Create a virtual machine

In this task, you will create the workload virtual machine and place it in the Workload-SN subnet created previously.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. In the toolbar of the Cloud Shell pane, select the Upload/Download files icon, in the drop-down menu, select Upload and upload the following files **firewall.json** and **firewall.parameters.json** into the Cloud Shell home directory from the source folder **F:\Allfiles\Exercises\M06**.

3. Deploy the following ARM templates to create the VM needed for this exercise:

   ```powershell
   $RGName = "Test-FW-RG"
   
   New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile firewall.json -TemplateParameterFile firewall.parameters.json
   ```
  
4. When the deployment is complete, go to the Azure portal home page, and then select **Virtual Machines**.

5. Verify that the virtual machine has been created.

6. When deployment of the VM completes, select **Go to resource**.

7. On the **Overview** page of **Srv-Work**, on the right of the page under **Networking**, take a note of the **Private IP address** for this VM (e.g., **10.0.2.4**).

## Task 4: Deploy the firewall and firewall policy

In this task, you will deploy the firewall into the virtual network with a firewall policy configured.

1.  On the Azure portal home page, select **Create a resource**, then in the search box, enter **firewall** and select **Firewall** when it appears.
2.  On the **Firewall** page, select **Create**.
3.  On the **Basics** tab, create a firewall using the information in the table below.
    
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
        **Test-FW-RG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Firewall name
      :::column-end:::
      :::column:::
        **Test-FW01**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        Your region
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Firewall tier
      :::column-end:::
      :::column:::
        **Standard**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Firewall management
      :::column-end:::
      :::column:::
        **Use a Firewall Policy to manage this firewall**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Firewall policy
      :::column-end:::
      :::column:::
        Select **Add new**
    Name: **fw-test-pol**
    Region: **your region**
      :::column-end:::
    :::row-end:::
    

    :::image type="content" source="../media/create-firewall-policy-a358f60d.png" alt-text="Create a new firewall policy":::


    :::row:::
      :::column:::
        **Choose a virtual network**
      :::column-end:::
      :::column:::
        **Use existing**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        **Test-FW-VN**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP address
      :::column-end:::
      :::column:::
        Select **Add new**
    Name: **fw-pip**
      :::column-end:::
    :::row-end:::


    :::image type="content" source="../media/assign-public-ip-firewall-e37b1372.png" alt-text="Add public IP address to firewall":::


4.  Review all the settings to ensure they match the screenshot below.

:::image type="content" source="../media/review-all-configurations-firewall-edcf9005.png" alt-text="Create a firewall - review settings":::


5.  Select **Review + create**.
6.  Select **Create** and wait for the firewall deployment to complete.
7.  When deployment of the firewall is completed, select **Go to resource**.
8.  On the **Overview** page of **Test-FW01**, on the right of the page, take a note of the **Firewall private IP** for this firewall (e.g., **10.0.1.4**).
9.  In the menu on the left, under **Settings**, select **Public IP configuration**.
10. Take a note of the address under **IP Address** for the **fw-pip** public IP configuration (e.g., **20.90.136.51**).

## Task 5: Create a default route

In this task, on the Workload-SN subnet, you will configure the outbound default route to go through the firewall.

1.  On the Azure portal home page, select **Create a resource**, then in the search box, enter **route** and select **Route table** when it appears.
2.  On the **Route table** page, select **Create**.
3.  On the **Basics** tab, create a new route table using the information in the table below.
    
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
        **Test-FW-RG**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        Your region
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **Firewall-route**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Propagate gateway routes
      :::column-end:::
      :::column:::
        **Yes**
      :::column-end:::
    :::row-end:::
    
4.  Select **Review + create**.
5.  Select **Create**.

    :::image type="content" source="../media/create-route-table-f85aaf16.png" alt-text="Create a route table":::


6.  After deployment completes, select **Go to resource**.
7.  On the **Firewall-route** page, under **Settings**, select **Subnets** and then select **Associate**.
8.  In **Virtual network**, select **Test-FW-VN**.
9.  In **Subnet**, select **Workload-SN**. Make sure that you select only the Workload-SN subnet for this route, otherwise your firewall won't work correctly.
10. Select **OK**.
11. Under **Settings**, select **Routes** and then select **Add**.
12. In **Route name**, enter **fw-dg**.
13. In **Address prefix**, enter **0.0.0.0/0**.
14. In **Next hop type**, select **Virtual appliance**.
15. In **Next hop address**, enter the private IP address for the firewall that you noted previously (e.g., **10.0.1.4**)
16. Select **OK**.

:::image type="content" source="../media/add-firewall-route-59f3994f.png" alt-text="Add firewall route":::


## Task 6: Configure an application rule

In this task, you will add an application rule that allows outbound access to www.google.com.

1.  On the Azure portal home page, select **All resources**.
2.  In the list of resources, select your firewall policy, **fw-test-pol**.
3.  Under **Settings**, select **Application Rules**.
4.  Select **Add a rule collection**.
5.  On the **Add a rule collection** page, create a new application rule using the information in the table below.
    
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
        **App-Coll01**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection type
      :::column-end:::
      :::column:::
        **Application**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Priority
      :::column-end:::
      :::column:::
        **200**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection action
      :::column-end:::
      :::column:::
        **Allow**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection group
      :::column-end:::
      :::column:::
        **DefaultApplicationRuleCollectionGroup**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Rules Section**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **Allow-Google**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source type
      :::column-end:::
      :::column:::
        **IP Address**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source
      :::column-end:::
      :::column:::
        **10.0.2.0/24**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Protocol
      :::column-end:::
      :::column:::
        **http,https**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination type
      :::column-end:::
      :::column:::
        **FQDN**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination
      :::column-end:::
      :::column:::
        **www.google.com**
      :::column-end:::
    :::row-end:::
    

    :::image type="content" source="../media/add-application-rule-firewall-1e859aaa.png" alt-text="Add an application rule collection":::


6.  Select **Add**.

## Task 7: Configure a network rule

In this task, you will add a network rule that allows outbound access to two IP addresses at port 53 (DNS).

1.  On the **fw-test-pol** page, under **Settings**, select **Network Rules**.
2.  Select **Add a rule collection**.
3.  On the **Add a rule collection** page, create a new network rule using the information in the table below.
    
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
        **Net-Coll01**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection type
      :::column-end:::
      :::column:::
        **Network**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Priority
      :::column-end:::
      :::column:::
        **200**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection action
      :::column-end:::
      :::column:::
        **Allow**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection group
      :::column-end:::
      :::column:::
        **DefaultNetworkRuleCollectionGroup**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Rules Section**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **Allow-DNS**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source type
      :::column-end:::
      :::column:::
        **IP Address**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source
      :::column-end:::
      :::column:::
        **10.0.2.0/24**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Protocol
      :::column-end:::
      :::column:::
        **UDP**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination Ports
      :::column-end:::
      :::column:::
        **53**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination Type
      :::column-end:::
      :::column:::
        **IP Address**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination
      :::column-end:::
      :::column:::
        **209.244.0.3, 209.244.0.4**
    These are public DNS servers operated by Century Link
      :::column-end:::
    :::row-end:::
    

    :::image type="content" source="../media/add-network-rule-for-firewall-36af2895.png" alt-text="Add a network rule collection":::


4.  Select **Add**.

## Task 8: Configure a Destination NAT (DNAT) rule

In this task, you will add a DNAT rule that allows you to connect a remote desktop to the Srv-Work virtual machine through the firewall.

1.  On the **fw-test-pol** page, under **Settings**, select **DNAT Rules**.
2.  Select **Add a rule collection**.
3.  On the **Add a rule collection** page, create a new DNAT rule using the information in the table below.
    
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
        **rdp**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection type
      :::column-end:::
      :::column:::
        **DNAT**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Priority
      :::column-end:::
      :::column:::
        **200**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Rule collection group
      :::column-end:::
      :::column:::
        **DefaultDnatRuleCollectionGroup**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Rules Section**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **rdp-nat**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source type
      :::column-end:::
      :::column:::
        **IP Address**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source
      :::column-end:::
      :::column:::
        \*
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
        Destination Ports
      :::column-end:::
      :::column:::
        **3389**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination Type
      :::column-end:::
      :::column:::
        **IP Address**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Destination
      :::column-end:::
      :::column:::
        Enter the firewall public IP address from **fw-pip** that you noted earlier.
    **e.g. - 20.90.136.51**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Translated address
      :::column-end:::
      :::column:::
        Enter the private IP address from **Srv-Work** that you noted earlier.
    **e.g. - 10.0.2.4**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Translated port
      :::column-end:::
      :::column:::
        **3389**
      :::column-end:::
    :::row-end:::
    

    :::image type="content" source="../media/add-dnat-rule-deeda5f7.png" alt-text="Add a DNAT rule collection":::


4.  Select **Add**.

## Task 9: Change the primary and secondary DNS address for the server's network interface

For testing purposes in this exercise, in this task, you will configure the Srv-Work server's primary and secondary DNS addresses. However, this is not a general Azure Firewall requirement.

1.  On the Azure portal home page, select **Resource groups**.
2.  In the list of resource groups, select your resource group, **Test-FW-RG**.
3.  In the list of resources in this resource group, select the network interface for the **Srv-Work** virtual machine (e.g., **srv-work350**).

    :::image type="content" source="../media/change-dns-servers-srv-work-nic-1-a5c017a0.png" alt-text="Select NIC in resource group":::


4.  Under **Settings**, select **DNS servers**.
5.  Under **DNS servers**, select **Custom**.
6.  Enter **209.244.0.3** in the **Add DNS server** text box, and **209.244.0.4** in the next text box.
7.  Select **Save**.

    :::image type="content" source="../media/change-dns-servers-srv-work-nic-2-a4b78793.png" alt-text="Change DNS servers on NIC":::


8.  Restart the **Srv-Work** virtual machine.

## Task 10: Test the firewall

In this final task, you will test the firewall to verify that the rules are configured correctly and working as expected. This configuration will enable you to connect a remote desktop connection to the Srv-Work virtual machine through the firewall, via the firewall's public IP address.

1.  Open **Remote Desktop Connection** on your PC.
2.  In the **Computer** box, enter the firewall's public IP address (e.g., **20.90.136.51**) followed by **:3389** (e.g., **20.90.136.51:3389**).
3.  In the **Username** box, enter **TestUser**.
4.  Select **Connect**.

    :::image type="content" source="../media/remote-desktop-connection-1-f59fb40f.png" alt-text="RDP connection to firewall's public IP address":::


5.  In the **Enter your credentials** dialog box, log into the **Srv-Work** server virtual machine, by using the password, **TestPa$$w0rd!**.
6.  Select **OK**.
7.  Select **Yes** on the certificate message.
8.  Open Internet Explorer and browse to **https://www.google.com**.
9.  In the **Security Alert** dialog box, select **OK**.
10. Select **Close** on the Internet Explorer security alerts that may pop-up.
11. You should see the Google home page.

    :::image type="content" source="../media/remote-desktop-connection-2-b55cf5da.png" alt-text="RDP session on Srv-work server - browser on google.com":::


12. Browse to **https://www.microsoft.com**.
13. You should be blocked by the firewall.

    :::image type="content" source="../media/remote-desktop-connection-3-a750974c.png" alt-text="RDP session on Srv-work server - browser blocked on microsoft.com":::

## Task 11: Clean up resources 

> [!NOTE]
> Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. Delete all resource groups you created throughout the labs of this module by running the following command:

    ```powershell
    Remove-AzResourceGroup -Name 'Test-FW-RG' -Force -AsJob
    
    ```
> [!NOTE]
> The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.



