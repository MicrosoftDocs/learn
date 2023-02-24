
An **App Service Environment** is an Azure App Service feature that provides a fully isolated and dedicated environment for running App Service apps securely at high scale.

An App Service Environment can host:

 -  Windows web apps
 -  Linux web apps
 -  Docker containers (**Windows** and **Linux**)
 -  Functions
 -  Logic apps (Standard)

App Service Environments are appropriate for application workloads that require:

 -  High scale.
 -  Isolation and secure network access.
 -  High memory utilization.
 -  High requests per second (RPS). You can create multiple App Service Environments in a single Azure region or across multiple Azure regions. This flexibility makes an App Service Environment ideal for horizontally scaling stateless applications with a high RPS requirement.

An App Service Environment can host applications from only one customer, and they do so on one of their virtual networks. Customers have fine-grained control over inbound and outbound application network traffic. Applications can establish high-speed secure connections over VPNs to on-premises corporate resources.

## Usage scenarios

App Service Environments have many use cases, including:

 -  Internal line-of-business applications.
 -  Applications that need more than 30 App Service plan instances.
 -  Single-tenant systems to satisfy internal compliance or security requirements.
 -  Network-isolated application hosting.
 -  Multi-tier applications.

There are many networking features that enable apps in a multi-tenant App Service to reach network-isolated resources or become network-isolated themselves. These features are enabled at the application level. With an App Service Environment, no added configuration is required for the apps to be on a virtual network. The apps are deployed into a network-isolated environment that's already on a virtual network. If you really need a complete isolation story, you can also deploy your App Service Environment onto dedicated hardware.

## Dedicated environment

An App Service Environment is a single-tenant deployment of Azure App Service that runs on your virtual network.

Applications are hosted in App Service plans, which are created in an App Service Environment. An App Service plan is essentially a provisioning profile for an application host. As you scale out your App Service plan, you create more application hosts with all the apps in that App Service plan on each host. A single App Service Environment v3 can have up to 200 total App Service plan instances across all the App Service plans combined. A single App Service Isolated v2 (Iv2) plan can have up to 100 instances by itself.

When you're deploying onto dedicated hardware (hosts), you're limited in scaling across all App Service plans to the number of cores in this type of environment. An App Service Environment that's deployed on dedicated hosts has 132 vCores available. I1v2 uses two vCores, I2v2 uses four vCores, and I3v2 uses eight vCores per instance.
