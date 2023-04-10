## Lab scenario

In this lab, you will configure connectivity between the CoreServicesVnet and the ManufacturingVnet by adding peerings to allow traffic flow.

## Architecture diagram

:::image type="content" source="../media/8-exercise-connect-two-azure-virtual-networks-global.png" alt-text="Diagram of virtual network peering.":::

## Objectives


 -  **Task 1**: Create a Virtual Machine to test the configuration
    - Use a template to create the virtual machines. You can review the [lab template](https://github.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/blob/master/Allfiles/Exercises/M01/ManufacturingVMazuredeploy.json).
    - Use Azure PowerShell to deploy the template. 
 -  **Task 2**: Connect to the **Test VMs** using RDP
 -  **Task 3**: Test the connection between the VMs
 -  **Task 4**: Create VNet peerings between **CoreServicesVnet** and **ManufacturingVnet**
 -  **Task 5**: Test the connection between the VMs

> [!NOTE]
> Click on the thumbnail image to start the lab simulation. When you're done, be sure to return to this page so you can continue learning. 

> [!NOTE]
> You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.

[![Screenshot of the simulation page.](../media/simulation-peer-thumbnail.jpg)](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Connect%20two%20Azure%20virtual%20networks%20using%20global%20virtual%20network%20peering)


