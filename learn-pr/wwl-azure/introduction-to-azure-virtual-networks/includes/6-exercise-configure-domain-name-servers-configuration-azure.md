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
2.  On the Azure home page, in the search bar, type dns, and then select **Private DNS zones**.

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

### Create TestVM1

1.  On the Azure home page, select **Virtual Machines**.
2.  In Virtual Machines, select **+ Add > + Start with a preset configuration**.

    :::image type="content" source="../media/add-virtual-machine-preset-b95645b4.png" alt-text="Azure portal screenshot creating a VM":::


3.  In Choose recommended defaults that match your workload, under **Select a workload environment**, select **Dev/Test**.
4.  Under **Select a workload type**, select **General purpose (D-Series)**, and then select **Continue to create a VM**.
5.  Use the information in the following table to create your first VM.
    
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
        Virtual machine name
      :::column-end:::
      :::column:::
        TestVM1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        (US) West US
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Availability options
      :::column-end:::
      :::column:::
        No infrastructure redundancy required
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Image
      :::column-end:::
      :::column:::
        Windows 10 Pro, Version 20H2 - Gen 1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Azure Spot instance
      :::column-end:::
      :::column:::
        Not selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Size
      :::column-end:::
      :::column:::
        Standard\_D2\_v3 - 2vcpus, 8GiB memory
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Username
      :::column-end:::
      :::column:::
        TestUser
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Password
      :::column-end:::
      :::column:::
        TestPa$$w0rd!
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public inbound ports
      :::column-end:::
      :::column:::
        Allow selected ports
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Select inbound ports
      :::column-end:::
      :::column:::
        RDP (3389)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        I confirm I have an eligible Windows 10 license with multi-tenant hosting rights.
      :::column-end:::
      :::column:::
        Selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Disks
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Networking
      :::column-end:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        CoreServicesVnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet
      :::column-end:::
      :::column:::
        DatabaseSubnet (10.20.20.0/24)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public IP
      :::column-end:::
      :::column:::
        (new) TestVM1-ip
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        NIC network security group
      :::column-end:::
      :::column:::
        Basic
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public inbound ports
      :::column-end:::
      :::column:::
        Allow selected ports
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Select inbound ports
      :::column-end:::
      :::column:::
        RDP (3389)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Load balancing
      :::column-end:::
      :::column:::
        Not selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Management
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Advanced
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
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
    
6.  While the deployment is in progress, you can proceed with creating TestVM2.

### Create TestVM2

1.  On the Azure home page, select **Virtual Machines**.
2.  In Virtual Machines, select **+ Add > + Start with a preset configuration**.

    :::image type="content" source="../media/add-virtual-machine-preset-b95645b4.png" alt-text="Azure portal screenshot creating a VM from a preset configuration":::


3.  In Choose recommended defaults that match your workload, under **Select a workload environment**, select **Dev/Test**.
4.  Under **Select a workload type**, select **General purpose (D-Series)**, and then select **Continue to create a VM**.
5.  Use the information in the following table to create your second VM.
    
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
        Virtual machine name
      :::column-end:::
      :::column:::
        TestVM2
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        (US) West US
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Availability options
      :::column-end:::
      :::column:::
        No infrastructure redundancy required
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Image
      :::column-end:::
      :::column:::
        Windows 10 Pro, Version 20H2 - Gen 1
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Azure Spot instance
      :::column-end:::
      :::column:::
        Not selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Size
      :::column-end:::
      :::column:::
        Standard\_D2\_v3 - 2vcpus, 8GiB memory
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Username
      :::column-end:::
      :::column:::
        TestUser
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Password
      :::column-end:::
      :::column:::
        TestPa$$w0rd!
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public inbound ports
      :::column-end:::
      :::column:::
        Allow selected ports
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Select inbound ports
      :::column-end:::
      :::column:::
        RDP (3389)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        I confirm I have an eligible Windows 10 license with multi-tenant hosting rights.
      :::column-end:::
      :::column:::
        Selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Disks
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Networking
      :::column-end:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        CoreServicesVnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet
      :::column-end:::
      :::column:::
        DatabaseSubnet (10.20.20.0/24)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public IP
      :::column-end:::
      :::column:::
        (new) TestVM2-ip
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        NIC network security group
      :::column-end:::
      :::column:::
        Basic
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Public inbound ports
      :::column-end:::
      :::column:::
        Allow selected ports
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Select inbound ports
      :::column-end:::
      :::column:::
        RDP (3389)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Load balancing
      :::column-end:::
      :::column:::
        Not selected
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Management
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Advanced
      :::column-end:::
      :::column:::
        No changes required
      :::column-end:::
      :::column:::
        
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
        Review your settings and select **Create**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    
6.  When the deployment is complete, go to the Azure portal home page, and then select **Virtual Machines**.
7.  Verify that both virtual machines have been created.

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
18. Verify that you receive four replies from TestVM2.

Congratulations! You have created a private DNS Zone, added a name resolution and auto-registration link, and tested name resolution in your configuration.
