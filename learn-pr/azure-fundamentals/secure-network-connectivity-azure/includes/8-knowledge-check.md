Consider the following scenario. Then choose the best response for each question that follows and select **Check your answers**.

Tailwind Traders is moving its online payment system to Azure. The processing of online orders begins through a website, which Tailwind Traders manages through Azure App Service. (App Service is a way to host web applications on Azure.)

The web application that runs the website passes order information to virtual machines (VMs), which further process each order. These VMs exist on an Azure virtual network, but they need to access the internet to retrieve software packages and system updates.

Here's a diagram that shows the basic architecture of the company's payment system:

:::image type="content" source="../media/8-architecture.png" alt-text="An architecture diagram that shows network traffic flowing into Azure. Azure App Service receives passes public network traffic to virtual machines running on a virtual network." border="false":::

The security team wants to ensure that only valid network traffic reaches the company's Azure resources. As an extra layer of defense, the team also wants to ensure that the VMs can reach only trusted hosts on specific ports.
