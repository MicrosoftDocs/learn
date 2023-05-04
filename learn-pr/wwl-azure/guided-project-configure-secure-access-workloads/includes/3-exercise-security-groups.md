

## **Scenario** 

Your oganization requires control of the network traffic to and from the web application. To further enhance the security of the web application, network security groups (NSG) and application security groups (ASG) can be configured. NSG is a security layer that filters network traffic to and from Azure resources, while ASG allows grouping of resources to be managed collectively. These security groups provide fine-grained control over the network traffic to and from the web application components.

### Architecture diagram

| Network solution  | Tasks|
| --- | --- |
| :::image type="content" source="../media/task2.png" alt-text="Diagram with one ASG and NSG associated to a virtual network ." border="true"::: | <ul><li>Create an NSG. </li><li> Create NSG rules. </li><li> Associate an NSG to a subnet. </li><li> Create and use Application Security Groups in NSG rules. </li></ul> |

## **Exercise instructions**

1. Create a new **application security group** named **app-backend-asg** in the **East US** region by using the **RG1** resource group.

> [!NOTE] You are creating the application security group in the same region as the existing virtual network. 

[Learn more about creating an application security group](/azure/virtual-network/tutorial-filter-network-traffic#create-application-security-groups).

2. Create a **network security group** named **app-vnet-nsg** in **RG1** resource group. 

[Learn more about creating a network security group](/azure/virtual-network/tutorial-filter-network-traffic#create-a-network-security-group).

3. Associate the **app-vnet-nsg** to the **backend** subnet in the **app-vnet**.

[Learn more about creating a network security group](/azure/virtual-network/tutorial-filter-network-traffic#create-a-network-security-group).

4. Create an inbound security rule named **AllowSsh** in the **app-vnet-nsg** network security group to allow incoming **TCP** traffic on **port 22** to reach the **app-backend-asg** application security group. For any property that is not specified, use the default value.

[Learn more about creating a network security group rule](/azure/virtual-network/tutorial-filter-network-traffic#create-a-network-security-group).

5. Verify that both the **VM1** and **VM2** virtual machines are running.

6. Associate the **app-backend-asg** application security group to the **VM2-nic** network interface that is attached to **VM2**.

