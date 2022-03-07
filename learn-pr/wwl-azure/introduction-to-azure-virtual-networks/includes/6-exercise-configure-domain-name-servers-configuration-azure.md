> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

## Exercise scenario

In this unit, you will configure DNS name resolution for Contoso Ltd. You will create a private DNS zone named contoso.com, link the VNets for registration and resolution, and then create two virtual machines and test the configuration.

In this exercise, you will:

 -  Task 1: Create a private DNS Zone
 -  Task 2: Link subnet for auto registration
 -  Task 3: Create Virtual Machines to test the configuration
 -  Task 4: Verify records are present in the DNS zone

## Task 1: Create a private DNS Zone

1.  Go to [Azure portal](https://portal.azure.com/).
2.  On the Azure home page, in the search bar, enter dns, and then select **Private DNS zones**.

    :::image type="content" source="../media/create-private-dns-zone-48970f32.png" alt-text="Azure portal home page with dns search.":::
    
3.  In Private DNS zones, select **+ Create**.
4.  Use the information in the following table to create the private DNS zone.
    
    :::row:::
      :::column:::
        **Tab**
      :::column-end:::
      :::column:::
        **Option**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Basics
      :::column-end:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        ContosoResourceGroup
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        Contoso.com
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Tags
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Review + create
      :::column-end:::
      :::column:::
        Review your settings and select Create
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    
5.  Wait until the deployment is complete, and then select **Go to resource**.
6.  Verify that the zone has been created.

## Task 2: Link subnet for auto registration

1.  In Contoso.com, under **Settings**, select **Virtual network links**.
2.  On Contoso.com \| Virtual network links, select **+ Add**.

    :::image type="content" source="../media/add-network-link-domain-name-system-9a402df1.png" alt-text="Azure portal screenshot of network links.":::


3.  Use the information in the following table to add the virtual network link.
    
    :::row:::
      :::column:::
        **Option**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Link name
      :::column-end:::
      :::column:::
        CoreServicesVnetLink
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual Network
      :::column-end:::
      :::column:::
        CoreServicesVnet (ContosoResourceGroup)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Enable auto registration
      :::column-end:::
      :::column:::
        Selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Review your settings and select OK.
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    
4.  Select **Refresh**.
5.  Verify that the CoreServicesVnetLink has been created, and that auto-registration is enabled.
6.  Repeat steps 2 - 5 for the ManufacturingVnet, using the information in the following table:
    
    :::row:::
      :::column:::
        **Option**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Link name
      :::column-end:::
      :::column:::
        ManufacturingVnetLink
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual Network
      :::column-end:::
      :::column:::
        ManufacturingVnet (ContosoResourceGroup)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Enable auto registration
      :::column-end:::
      :::column:::
        Selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Review your settings and select OK.
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    
7.  Select **Refresh**.
8.  Verify that the ManufacturingVnetLink has been created, and that auto-registration is enabled.
9.  Repeat steps 2 - 5 for the ResearchVnet, using the information in the following table:
    
    :::row:::
      :::column:::
        **Option**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Link name
      :::column-end:::
      :::column:::
        ResearchVnetLink
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual Network
      :::column-end:::
      :::column:::
        ResearchVnet (ContosoResourceGroup)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Enable auto registration
      :::column-end:::
      :::column:::
        Selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Review your settings and select OK.
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    
10. Select **Refresh**.
11. Verify that the ResearchVnetLink has been created, and that auto-registration is enabled.

## Task 3: Create Virtual Machines to test the configuration

In this section, you will create two test VMs to test the Private DNS zone configuration.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

2. In the toolbar of the Cloud Shell pane, select the Upload/Download files icon, in the drop-down menu, select Upload and upload the following files **azuredeploy.json** and **azuredeploy.parameters.json** into the Cloud Shell home directory from the source folder **F:\Allfiles\Exercises\M01**.

3. Deploy the following ARM templates to create the VMs needed for this exercise:

   ```powershell
   $RGName = "ContosoResourceGroup"
   
   New-AzResourceGroupDeployment -ResourceGroupName $RGName -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.json
   ```
  
4. When the deployment is complete, go to the Azure portal home page, and then select **Virtual Machines**.

5. Verify that both virtual machines have been created.

## Task 4: Verify records are present in the DNS zone

1.  On the Azure portal home page, select **Private DNS zones**.
2.  In Private DNS zones, select **contoso.com**.
3.  Verify that host (A) records are listed for both VMs, as shown:

    :::image type="content" source="../media/contoso-com-dns-zone-b5eaf30a.png" alt-text="Contoso.com DNS zone showing auto-registered host A records.":::


4.  Make a note of the names and IP addresses of the VMs.

### Connect to the Test VMs using RDP

1.  On the Azure portal home page, select **Virtual Machines**.
2.  Select **TestVM1**.
3.  In TestVM1, select **Connect > RDP**.

    :::image type="content" source="../media/connect-vm-e07de7ff.png" alt-text="TestVM1 with Connect and RDP highlighted.":::


4.  In TestVM1 \| Connect, select **Download RDP file**.
5.  Save the RDP file to your desktop.
6.  On the Azure portal home page, select **Virtual Machines**.
7.  Select **TestVM2**.
8.  In TestVM2, select **Connect > RDP**.
9.  In TestVM2 \| Connect, select **Download RDP file**.
10. Save the RDP file to your desktop.
11. Connect to TestVM1 using the RDP file, and the username and password you specified when you created the VM.
12. Connect to TestVM2 using the RDP file, and the username and password you specified when you created the VM.
13. On both VMs, in **Choose privacy settings for your device**, select **Accept**.
14. On both VMs, in **Networks**, select **Yes**.
15. On TestVM1, open a command prompt and enter the command ipconfig /all.
16. Verify that the IP address is the same as the one you noted in the DNS zone.
17. Enter the command ping TestVM2.contoso.com.
18. Verify that the FQDN resolves to the IP address that you noted in the Private DNS zone. The ping itself will timeout because of the Windows Firewall that is enabled on the VMs.
19. Alternatively, you can enter the command nslookup TestVM2.contoso.com and verify that you receive a successful name resolution record for VM2

Congratulations! You have created a private DNS Zone, added a name resolution and auto-registration link, and tested name resolution in your configuration.
