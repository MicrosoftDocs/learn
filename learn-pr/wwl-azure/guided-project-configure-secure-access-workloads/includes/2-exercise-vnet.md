## Scenario 

Your organization is migrating a web-based application to Azure. Your first task is to put in place the virtual networks and subnets. You also need to securely peer the virtual networks. You identify these requirements.

+ Two virtual networks are required, **app-vnet** and **hub-vnet**. 
+ The app-vnet hosts the application. This virtual network requires two subnets. The **frontend** subnet hosts the web servers. The **backend** subnet hosts the database servers.
+ The hub-vnet only requires a subnet for the firewall. 
+ The two virtual networks must be able to communicate with each other securely and privately through virtual network peering. 
+ Both virtual networks should be in the same region. 

## Skilling Tasks

+ Create a virtual network. 
+ Create a subnet. 
+ Configure virtual network peering. 
 
## Architecture diagram

:::image type="content" source="../media/task-1.png" alt-text="Diagram that shows two virtual networks that are peered." border="true"::: 

Launch the exercise and follow the instructions. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
> To complete this lab you need an [Azure subscription](https://azure.microsoft.com/free/).

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2261590)


