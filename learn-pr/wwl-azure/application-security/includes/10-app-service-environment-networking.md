
App Service Environment is a single-tenant deployment of Azure App Service that hosts Windows and Linux containers, web apps, API apps, logic apps, and function apps. When you install an App Service Environment, you pick the Azure virtual network that you want it to be deployed in. All of the inbound and outbound application traffic is inside the virtual network you specify. You deploy into a single subnet in your virtual network, and nothing else can be deployed into that subnet.

## Subnet requirements

You must delegate the subnet to Microsoft.Web/hostingEnvironments, and the subnet must be empty.

The size of the subnet can affect the scaling limits of the App Service plan instances within the App Service Environment. It's a good idea to use a /24 address space (256 addresses) for your subnet to ensure enough addresses to support production scale.

> [!NOTE]
> Windows Containers uses an additional IP address per app for each App Service plan instance, and you need to size the subnet accordingly. If your App Service Environment has, for example, 2 Windows Container App Service plans, each with 25 instances and each with 5 apps running, you will need 300 IP addresses and additional addresses to support horizontal (up/down) scale.

If you use a smaller subnet, be aware of the following limitations:

 -  Any particular subnet has five addresses reserved for management purposes. In addition to the management addresses, App Service Environment dynamically scales the supporting infrastructure and uses between 4 and 27 addresses, depending on the configuration and load. You can use the remaining addresses for instances in the App Service plan. The minimal size of your subnet is a /27 address space (32 addresses).
 -  If you run out of addresses within your subnet, you can be restricted from scaling out your App Service plans in the App Service Environment. Another possibility is that you can experience increased latency during intensive traffic load if Microsoft can't scale the supporting infrastructure.

## Addresses

App Service Environment has the following network information at creation:

| **Address type**                        |                                                                                                  **Description**                                                                                                  |
|:--------------------------------------- |:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| App Service Environment virtual network |                                                                                        The virtual network deployed into.                                                                                         |
| App Service Environment subnet          |                                                                                             The subnet deployed into.                                                                                             |
| Domain suffix                           |                                                                                 The domain suffix that is used by the apps made.                                                                                  |
| Virtual IP (VIP)                        |                                                                     The VIP type is used. The two possible values are internal and external.                                                                      |
| Inbound address                         | The inbound address is the address at which your apps are reached. If you have an internal VIP, it's an address in your App Service Environment subnet. If the address is external, it's a public-facing address. |
| Default outbound addresses              |                                                                The apps use this address, by default, when making outbound calls to the internet.                                                                 |

:::image type="content" source="../media/app-service-environment-networking-page-in-azure-f216027c.png" alt-text="Screenshot showing App Service Environment IP address page.":::


As you scale your App Service plans in your App Service Environment, you'll use more addresses from your subnet. The number of addresses you use varies based on the number of App Service plan instances you have and how much traffic there is. Apps in the App Service Environment don't have dedicated addresses in the subnet. The specific addresses an app uses in the subnet will change over time.
