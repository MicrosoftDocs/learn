
## Investigate Benefits of migration

The benefits of migrating your application to an Azure hosted environment revolve around key aspects of application performance and security. If you cannot achieve these facets on par with, or exceeding, your on-premises environment, the cost, and workload associated with the migration may not seem feasible. This section looks at evaluating the benefits that can be realized in an ASP.NET migration.

### Evaluate performance considerations

Performance of your application is a key consideration for your customers and for customer satisfaction. Your application may experience peaks and troughs in a demand cycle. Holiday shopping or marketing campaigns can contribute to increased demand on your application and the servers hosting them.

In an on-premises world, increasing demand means your systems may become overloaded. Supporting increasing demand may require the addition of server hardware and the management that goes along with adding the hardware, installing and configuring software, and setting up the necessary traffic routing to ensure your systems remain available to customers.  If demand is reduced, you are then left with server hardware that is unused until the next peak in the cycle.

### Evaluate scaling options

Azure provides scaling options for web apps and for your SQL databases. Scaling allows you to meet demand when required and scale back when demand is reduced. These scaling options also do not require you to make any changes to your existing code or redeploy your application. Two main scaling options are available.

- Scale up: Get more CPU, memory, disk space, and extra features like dedicated virtual machines (VMs), custom domains and certificates, staging slots, autoscaling, and more. You scale up by changing the pricing tier of the App Service plan that your app belongs to.
- Scale out: Increase the number of VM instances that run your app. You can scale out to as many as 30 instances, depending on your pricing tier.

It's important to note that the App Service will not automatically scale related resources such as an Azure SQL Database. Those resources are not managed by the App Service Plan. However, it is easy to configure scaling on these other resources as well.

Azure SQL Database and SQL Managed Instance enable you to dynamically add more resources to your database with minimal downtime. Adding more resources enables you to quickly react when your database hits the current resource limits and needs more power to handle the incoming workload. Azure SQL Database also enables you to scale-down the resources when they are not needed to lower the cost.  Single databases in Azure SQL Database support manual dynamic scalability, but not autoscale. For a more automatic experience, consider using elastic pools, which allow databases to share resources in a pool based on individual database needs.

### Evaluate security considerations for app and data

Securing your application and associated data is a critical consideration. Your web app may present a publicly accessible interface but you do not want unauthorized users accessing your database or administration pages of the web app. Who should have access to specific areas of the app and which areas require tighter security? How do users authenticate with secure areas?

Assess your current environment security configuration and use that assessment to map out your security needs for the hosted environment. Some aspects in an on-premises environment, such as firewall hardware, will be slightly different in the Azure world. For example, virtual networks on Azure will act as a firewall for apps and services. 

Other areas are new, such as the Azure Key Vault for storing secrets that the application may need. A prime example is storing a SQL connection string in the Azure Key Vault rather in application configuration files, adding an extra security layer around database credentials.

## Investigate networking requirements

Azure can help you mimic your on-premises networking environment by using services such as virtual networks and DNS. Understanding these options will help you configure a secure and operational networking environment that hosts your application.

### Explore Azure networking options

Azure can help secure various aspects of your app and data by using virtual networks (VNETs), which act in a similar fashion to firewalls. Setting up VNETs is a simple process and provides control over the network security of your application. You can configure subnets using CIDR notation, create perimeter networks to isolate traffic domains, and control access using network ports.
<!-- GLOBAL: Replace "VNET" with "VNet" and "VNETs" with "VNets". -->
An Azure Virtual Network allows your applications to securely communicate with each other, to the Internet, and to your on-premises networks. By default, apps are permitted outbound communication with the Internet but inbound connections are denied until you explicitly open the necessary application ports.

Communication between your Azure resources is accomplished through:

- a VNET - deploying your VMs and other resources to a VNET provides direct communication between these resources.
- a service endpoint - service endpoints allow you to secure your critical Azure service resources to only a virtual network
- VNET peering - You can connect virtual networks to each other, enabling resources in either virtual network to communicate with each other, using virtual network peering

Communication with your on-premises network is accomplished through:

- point-to-site virtual private network (VPN): established between a virtual network and a single computer in your network. Each computer that wants to establish connectivity with a virtual network must configure its connection.
- Site-to-site VPN: Established between your on-premises VPN device and an Azure VPN Gateway that is deployed in a virtual network. This connection type enables any on-premises resource that you authorize to access a virtual network.
- Azure ExpressRoute: Established between your network and Azure, through an ExpressRoute partner. This connection is private. Traffic does not go over the internet

## Explore Azure Active Directory for Security

Azure Active Directory (Azure AD) is a cloud-based identity and access management service that helps your employees sign in and access resources. It provides access to:

- External resources - these include Microsoft 365, the Azure portal, and many other SaaS applications.

- Internal resources - these may be applications on your corporate network, along with any cloud apps developed by your own organization.

### Explore authentication and access control with Azure Active Directory

Azure Active Directory authentication can provide verification of a username and password but it also much more. To improve security and reduce the need for help desk assistance, Azure AD authentication includes the following components:

- Self-service password reset - let users update or change their passwords using a web browser from any device.
- Azure AD Multi-Factor Authentication - lets users choose an additional form of authentication during sign-in, such as a phone call or mobile app notification.
- Hybrid integration to write password changes back to on-premises environment - when a user updates or resets their password using self-service password reset, that password can also be written back to an on-premises Active Directory environment
- Hybrid integration to enforce password protection policies for an on-premises environment
- Password-less authentication - this option includes entering credentials that are provided by using methods like biometrics with Windows Hello for Business, or a FIDO2 security key.

Access control to resources on Azure can all be controlled by using Azure AD and the single sign-on capabilities mean your users won't need to remember multiple sign-on credentials.

## Explore cost considerations

To determine if migration is the right choice, cost considerations also need to be a factor. You may already know the costs associated with hosting your application and database on-premises.  What can you expect to incur in a cloud-hosted environment? Azure provides cost analysis tools that can aid in your evaluation.

### Introducing the Azure Pricing Calculator

The [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/?OCID=AID2100131_SEM_cafa6bf89b9517d378db3426c0f6299e:G:s&ef_id=cafa6bf89b9517d378db3426c0f6299e:G:s&msclkid=cafa6bf89b9517d378db3426c0f6299e) can help you determine the cost of resources you plan to use on Azure. With this tool, you can select from the various categories available, which cover the Azure resources, and then choose specific configurations that will display the estimate monthly costs for that service.

For example, if you want to evaluate the cost of using Azure virtual machines (VMs), you select the Virtual Machine category then scrolls down to view the configuration options.  Making changes to the options, such as region, OS, pricing tier, and size, will update the charts to reflect the chosen options.

:::image type="content" source="../media/vm-cost-calculator.png" alt-text="pricing calculator displaying cost of VM with configured parameters":::

### Determine Azure SQL Database costs

You can evaluate your SQL Server costs by selecting the **Databases** category on the **pricing calculator** page. This will present you with the available database options on Azure. Selecting **Azure SQL Database** will open the estimator panel at the bottom of the pricing calculator page.  Scrolling down, you will be able to modify the parameters to match your needs and view the monthly costs that you would be billed.

There are various options on this estimator that will impact the cost. The first option deals with the instance configuration.

:::image type="content" source="../media/sql-instance-pricing.png" alt-text="SQL instance options in pricing calculator":::

Note the use of the region for hosting, the type (single or elastic pool), and the service tier among the options available here.

You will also need to select the compute resource options to tailor your pricing model.  For example, you may choose to use the hybrid model to reduce the licensing costs as shown in this compute option screenshot.

:::image type="content" source="../media/hybrid-benefit.png" alt-text="Azure Hybrid benefit selected showing reduction in cost":::

The remaining options deal with the storage account options and any support that you may want to include as a part of your Azure SQL Database hosting.

### Determine App Service costs

You can use the pricing calculator to determine the costs of hosting your ASP.NET application on Azure by selecting the App Service category.

:::image type="content" source="../media/app-service-pricing-option.png" alt-text="Azure App Service category option":::

Adjusting the pricing tier option from the **Tier** drop-down will change the cost model. This will change the compute configuration by selecting specific configurations of CPU cores and memory options. You can select a tier that matches your on-premises environment to view a monthly hosting cost for that compute environment.

To get an idea of costs associated with scaling the app, you can increase the counter for the number of instances.

:::image type="content" source="../media/instances-counter.png" alt-text="instance counter set to 3":::

Continue to modify the options on this pane to evaluate the monthly costs associated with the Azure App Service.
