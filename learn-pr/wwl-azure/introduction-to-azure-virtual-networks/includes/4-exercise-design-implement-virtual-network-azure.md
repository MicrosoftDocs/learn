> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at https://azure.com/free.

## Exercise scenario

Now you're ready to deploy virtual networks in the Azure portal.

Consider the fictional organization Contoso Ltd, which is in the process of migrating infrastructure and applications to Azure. In your role as network engineer, you must plan and implement three virtual networks and subnets to support resources in those virtual networks.

The **CoreServicesVnet** virtual network is deployed in the **US West** region. This virtual network will have the largest number of resources. It will have connectivity to on-premises networks through a VPN connection. This network will have web services, databases, and other systems that are key to the operations of the business. Shared services, such as domain controllers and DNS also will be located here. A large amount of growth is anticipated, so a large address space is necessary for this virtual network.

The **ManufacturingVnet** virtual network is deployed in the **North Europe** region, near the location of your organization's manufacturing facilities. This virtual network will contain systems for the operations of the manufacturing facilities. The organization is anticipating a large number of internal connected devices for their systems to retrieve data from, such as temperature, and will need an IP address space that it can expand into.

The **ResearchVnet** virtual network is deployed in the **West India** region, near the location of the organization's research and development team. The research and development team uses this virtual network. The team has a small, stable set of resources that is not expected to grow. The team needs a small number of IP addresses for a few virtual machines for their work.

:::image type="content" source="../media/design-implement-vnet-peering-0b789104.png" alt-text="Global virtual network architecture":::


You will create the following resources:

:::row:::
  :::column:::
    **Virtual Network**
  :::column-end:::
  :::column:::
    **Region**
  :::column-end:::
  :::column:::
    **Virtual network address space**
  :::column-end:::
  :::column:::
    **Subnet**
  :::column-end:::
  :::column:::
    **Subnet**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CoreServicesVnet
  :::column-end:::
  :::column:::
    West US
  :::column-end:::
  :::column:::
    10.20.0.0/16
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    GatewaySubnet
  :::column-end:::
  :::column:::
    10.20.0.0/27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    SharedServicesSubnet
  :::column-end:::
  :::column:::
    10.20.10.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    DatabaseSubnet
  :::column-end:::
  :::column:::
    10.20.20.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    PublicWebServiceSubnet
  :::column-end:::
  :::column:::
    10.20.30.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ManufacturingVnet
  :::column-end:::
  :::column:::
    North Europe
  :::column-end:::
  :::column:::
    10.30.0.0/16
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    ManufacturingSystemSubnet
  :::column-end:::
  :::column:::
    10.30.10.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    SensorSubnet1
  :::column-end:::
  :::column:::
    10.30.20.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    SensorSubnet2
  :::column-end:::
  :::column:::
    10.30.21.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    SensorSubnet3
  :::column-end:::
  :::column:::
    10.30.22.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ResearchVnet
  :::column-end:::
  :::column:::
    West India
  :::column-end:::
  :::column:::
    10.40.0.0/16
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    ResearchSystemSubnet
  :::column-end:::
  :::column:::
    10.40.0.0/24
  :::column-end:::
:::row-end:::


These virtual networks and subnets are structured in a way that accommodates existing resources yet allows for projected growth. Let's create these virtual networks and subnets to lay the foundation for our networking infrastructure.

In this exercise, you will:

 -  Task 1: Create the Contoso resource group
 -  Task 2: Create the CoreServicesVnet virtual network and subnets
 -  Task 3: Create the ManufacturingVnet virtual network and subnets
 -  Task 4: Create the ResearchVnet virtual network and subnets
 -  Task 5: Verify the creation of VNets and Subnets

## Task 1: Create the Contoso resource group

1.  Go to [Azure portal](https://portal.azure.com/).
2.  On the home page, under **Azure services**, select **Resource groups**.
    
    :::image type="content" source="../media/azure-portal-home-page-annotated-4c34708f.png" alt-text="Azure portal home page with Resource groups highlighted.":::
    
3.  In Resource groups, select **+ Create**.
4.  Use the information in the following table to create the resource group.
    
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
        Region
      :::column-end:::
      :::column:::
        (US) West US
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
    
5.  In Resource groups, verify that **ContosoResourceGroup** appears in the list.

## Task 2: Create the CoreServicesVnet virtual network and subnets

1.  On the Azure portal home page, select **Create a resource**.
2.  In **Search services and marketplace**, enter virtual network. 

    :::image type="content" source="../media/create-resource-search-virtual-network-annotated-7b909a50.png" alt-text="Azure portal Create a resource page with Search services and marketplace box highlighted.":::
    
3.  In Marketplace, in Virtual Network, select **Create > Virtual network**. 

    :::image type="content" source="../media/virtual-network-service-annotated-438cc2d0.png" alt-text="Virtual Network tile with Create Virtual network highlighted.":::
    
4.  Use the information in the following table to create the CoreServicesVnet virtual network.<br>‎Remove or overwrite the default IP Address space 

    :::image type="content" source="../media/default-vnet-ip-address-range-annotated-22032ab7.png" alt-text="ip address configuration for azure virtual network deployment":::
    
    
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
        Resource Group
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
        CoreServicesVnet
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
        IP Addresses
      :::column-end:::
      :::column:::
        IPv4 address space
      :::column-end:::
      :::column:::
        10.20.0.0/16
      :::column-end:::
    :::row-end:::
    
5.  Use the information in the following table to create the CoreServicesVnet subnets.
6.  To begin creating each subnet, select **+ Add subnet**. To finish creating each subnet, select **Add**.
    
    :::row:::
      :::column:::
        **Subnet**
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
        GatewaySubnet
      :::column-end:::
      :::column:::
        Subnet name
      :::column-end:::
      :::column:::
        GatewaySubnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet address range
      :::column-end:::
      :::column:::
        10.20.0.0/27
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        SharedServicesSubnet
      :::column-end:::
      :::column:::
        Subnet name
      :::column-end:::
      :::column:::
        SharedServicesSubnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet address range
      :::column-end:::
      :::column:::
        10.20.10.0/24
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        DatabaseSubnet
      :::column-end:::
      :::column:::
        Subnet name
      :::column-end:::
      :::column:::
        DatabaseSubnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet address range
      :::column-end:::
      :::column:::
        10.20.20.0/24
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        PublicWebServiceSubnet
      :::column-end:::
      :::column:::
        Subnet name
      :::column-end:::
      :::column:::
        PublicWebServiceSubnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        
      :::column-end:::
      :::column:::
        Subnet address range
      :::column-end:::
      :::column:::
        10.20.30.0/24
      :::column-end:::
    :::row-end:::
    
7.  To finish creating the CoreServicesVnet and its associated subnets, select **Review + create**.
8.  Verify your configuration passed validation, and then select **Create**.
9.  Repeat steps 1 -8 for each VNet based on the tables below

## Task 3: Create the ManufacturingVnet virtual network and subnets

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
    Resource Group
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
    ManufacturingVnet
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Region
  :::column-end:::
  :::column:::
    (Europe) North Europe
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IP Addresses
  :::column-end:::
  :::column:::
    IPv4 address space
  :::column-end:::
  :::column:::
    10.30.0.0/16
  :::column-end:::
:::row-end:::


:::row:::
  :::column:::
    **Subnet**
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
    ManufacturingSystemSubnet
  :::column-end:::
  :::column:::
    Subnet name
  :::column-end:::
  :::column:::
    ManufacturingSystemSubnet
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Subnet address range
  :::column-end:::
  :::column:::
    10.30.10.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SensorSubnet1
  :::column-end:::
  :::column:::
    Subnet name
  :::column-end:::
  :::column:::
    SensorSubnet1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Subnet address range
  :::column-end:::
  :::column:::
    10.30.20.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SensorSubnet2
  :::column-end:::
  :::column:::
    Subnet name
  :::column-end:::
  :::column:::
    SensorSubnet2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Subnet address range
  :::column-end:::
  :::column:::
    10.30.21.0/24
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SensorSubnet3
  :::column-end:::
  :::column:::
    Subnet name
  :::column-end:::
  :::column:::
    SensorSubnet3
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Subnet address range
  :::column-end:::
  :::column:::
    10.30.22.0/24
  :::column-end:::
:::row-end:::


## Task 4: Create the ResearchVnet virtual network and subnets

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
    Resource Group
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
    ResearchVnet
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Region
  :::column-end:::
  :::column:::
    West India
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IP Addresses
  :::column-end:::
  :::column:::
    IPv4 address space
  :::column-end:::
  :::column:::
    10.40.0.0/16
  :::column-end:::
:::row-end:::


:::row:::
  :::column:::
    **Subnet**
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
    ResearchSystemSubnet
  :::column-end:::
  :::column:::
    Subnet name
  :::column-end:::
  :::column:::
    ResearchSystemSubnet
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Subnet address range
  :::column-end:::
  :::column:::
    10.40.0.0/24
  :::column-end:::
:::row-end:::


## Task 5: Verify the creation of VNets and Subnets

1.  On the Azure portal home page, select **All resources**.

    :::image type="content" source="../media/azure-portal-home-page-all-resources-annotated-cdf9a16f.png" alt-text="Azure portal home page with All resources highlighted.":::


2.  Verify that the CoreServicesVnet, ManufacturingVnet, and ResearchVnet are listed. Your list should look like this:

    :::image type="content" source="../media/all-resources-list-annotated-94b7c54d.png" alt-text="All resources list with CoreServicesVnet, ManufacturingVnet, and ResearchVnet highlighted.":::


3.  Note that Azure creates NetworkWatchers for each region that you use.
4.  Select **CoreServicesVnet**.
5.  In CoreServicesVnet, under **Settings**, select **Subnets**.
6.  In CoreServicesVnet \| Subnets, verify that the subnets you created are listed, and that the IP address ranges are correct.

    :::image type="content" source="../media/verify-subnets-annotated-3acfec71.png" alt-text="List of subnets in CoreServicesVnet.":::


7.  Repeat steps 4 - 6 for each VNet.

Congratulations! You have successfully created a resource group, three VNets, and their associated subnets.
