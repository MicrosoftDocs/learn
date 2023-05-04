

## **Scenario** 

Your oganization is looking to protect the web application from malicious traffic and block unauthorized access.

In addition to NSG and ASG, a firewall can be configured to add an extra layer of security to the web application. A firewall protects the web application from malicious traffic and blocks unauthorized access with polices you configure. Azure Policy allows you to define a rule hierarchy and enforce compliance. 

In this task you will configure application rules and network rules for the firewall using Firewall Policy. You can use Azure Firewall Policy to manage rule sets that the Azure Firewall uses to filter traffic.

### Architecture Diagram

| Network solution | Tasks|
| --- | --- |
| :::image type="content" source="../media/task3.png" alt-text="Diagram with one virtual network with a firewall and route table" border="true"::: | <ul><li>Create an Azure Firewall.</li><li>Create and configure a firewall policy.</li><li>Create and configure a route table.</li><li>Link a route to a subnet.</li></ul>|

## **Exercise instructions**

1.  Create a subnet named **AzureFirewallSubnet** in the **app-vnet** virtual network by using a subnet address range of **10.1.63.0/24**.

1.  Create a firewall by using the values in the following table. For any property that is not specified, use the default value.

    | Property | Value    |
    |:---------|:---------|
    |Resource group   | **RG1**  |
    |Name	   | **app-vnet-firewall**|
    |Firewall SKU |	Standard|
    |Firewall management | Use a Firewall Policy to manage this firewall|
    |Firewall policy| select **Add new**| 
    |Policy name| **fw-policy**|
    |Region| **East US**|
    |Policy Tier| **Standard**|
    |Choose a virtual network |	Use existing|
    |Virtual network | **app-vnet** (RG1)|
    |Public IP address | Add new: **fwpip**|

[Learn more on creating a firewall](/azure/firewall/tutorial-firewall-deploy-portal), [creating route tables](/azure/virtual-network/manage-route-table) and [associating a route table to a subnet](/azure/virtual-network/tutorial-create-route-table-portal#associate-a-route-table-to-a-subnet).

1. Record the private IP address of **app-vnet-firewall** in the following Private IP Address text box: @lab.TextBox(PrivateIP)

1. Record the public IP address of **app-vnet-firewall** in the following Public IP Address text box:  @lab.TextBox(PublicIP)

1. Create a route table named ++app-vnet-firewall-rt++ in the **RG1** resource group by using the East US region.

1. Associate the **app-vnet-firewall-rt** route table to the **frontend** and **backend** subnets in **app-vnet**. 

1. Create a route in the **app-vnet-firewall-rt** named ++outbound-firewall++ with address prefix ++0.0.0.0/0++ and **Next hop type**  ++Virtual Appliance++. Use the private IP address of the firewall ++@lab.Variable(PrivateIP)++ for the **Next hop address**.

[Learn more on creating route tables](/azure/virtual-network/manage-route-table) and [associating a route table to a subnet](/azure/virtual-network/tutorial-create-route-table-portal#associate-a-route-table-to-a-subnet).



