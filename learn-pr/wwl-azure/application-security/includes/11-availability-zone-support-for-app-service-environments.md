
Azure App Service Environment can be deployed across **availability zones (AZ)** to help you achieve resiliency and reliability for your business-critical workloads. This architecture is also known as zone redundancy.

:::image type="content" source="../media/app-service-availability-zone-710690d2.png" alt-text="Screenshot showing Azure region availability zones.":::


When you configure it to be zone redundant, the platform automatically spreads the instances of the Azure App Service plan across three zones in the selected region. This means that the minimum App Service Plan instance count will always be three. If you specify a capacity larger than three, and the number of instances is divisible by three, the instances are spread evenly. Otherwise, **instance counts beyond 3\*N** are spread across the remaining one or two zones.

## Prerequisites

 -  You configure availability zones when you create your App Service Environment.
     -  All App Service plans created in that App Service Environment will need a **minimum of 3 instances**, and those will automatically be zone redundant.
 -  You can only specify availability zones when creating a new App Service Environment. A pre-existing App Service Environment can't be converted to use availability zones.
 -  Availability zones are **only supported in a subset of regions**.

## Downtime requirements

Downtime will be dependent on how you decide to carry out the migration. Since you can't convert pre-existing App Service Environments to use availability zones, migration will consist of a side-by-side deployment where you'll create a new App Service Environment with availability zones enabled.

Downtime will depend on how you choose to redirect traffic from your old to your new availability zone-enabled App Service Environment. For example, if you're using an **Application Gateway**, a **custom domain**, or **Azure Front Door**, downtime will be dependent on the time it takes to update those respective services with your new app's information. Alternatively, you can route traffic to multiple apps at the same time using a service such as **Azure Traffic Manager** and only fully cutover to your new availability zone-enabled apps when everything is deployed and fully tested. For more information on App Service Environment migration options, see App Service Environment migration. If you're already using App Service Environment v3, disregard the information about migration from previous versions and focus on the app migration strategies.
