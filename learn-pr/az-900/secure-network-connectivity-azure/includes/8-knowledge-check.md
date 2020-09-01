Consider the following scenario. Then choose the best response for each question that follows and select "Check your answers."

Tailwind Traders is moving their online payment system to Azure. The processing of online orders begins through their website, which Tailwind Traders manages through Azure App Service. (App Service is a way to host web applications on Azure.)

The web application that runs the website passes order information to virtual machines (VMs), which further process each order. These virtual machines exist on an Azure Virtual Network (VNet), but need to access the internet to retrieve software packages and system updates.

Here's a diagram that shows the basic architecture of their payment system:

:::image type="content" source="../media/8-architecture.png" alt-text="An architecture diagram showing network traffic flowing into Azure. Azure App Service receives passes public network traffic to virtual machines running on a virtual network. These virtual machines can also access software packages from the internet." border="false":::

The security team wants to ensure that only valid network traffic reaches their Azure resources. As an extra layer of defense, they also want to ensure that the virtual machines can reach only trusted hosts on specific ports.
