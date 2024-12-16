## Scenario

Your organization requires the network traffic in the app-vnet to be tightly controlled. You identify these requirements.
+ The frontend subnet has web servers that can be accessed from the internet. An application security group (ASG) is required for those servers. The ASG should be associated with any virtual machine interface that is part of the group. 
+ An NSG rule is required to allow inbound HTTPS traffic to the ASG. This rule uses the TCP protocol on port 443. 
+ The backend subnet has database servers used by the frontend web servers. A network security group (NSG) is required to control this traffic. The NSG should be associated with any virtual machine interface accessed by the web servers. 
+ An NSG rule is required to allow inbound network traffic from the ASG to the backend servers. This rule uses the MS SQL service and port 1443. 
+ A virtual machine should be installed in the frontend subnet (VM1) and the backend subnet (VM2). The IT group has an Azure Resource Manager template to deploy these Ubuntu servers. 

## Skilling Tasks

+ Create an NSG. 
+ Create NSG rules. 
+ Associate an NSG to a subnet. 
+ Create and use Application Security Groups in NSG rules. 


## Architecture diagram

:::image type="content" source="../media/task-2.png" alt-text="Diagram that shows one ASG and NSG associated to a virtual network." border="true":::


Launch the exercise and follow the instructions. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
> To complete this lab you need an [Azure subscription](https://azure.microsoft.com/free/).

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2261960)