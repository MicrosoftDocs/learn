## Lab scenario

In this lab, you configure DNS name resolution for Contoso Ltd. You create a private DNS zone named contoso.com, link the VNets for registration and resolution, and then create two virtual machines and test the configuration.

## Architecture diagram

:::image type="content" source="../media/6-exercise-configure-domain-name-servers-configuration-azure.png" alt-text="Diagram of the lab DNS architecture.":::

## Objectives

- **Task 1**: Create a private DNS Zone.
- **Task 2**: Link the subnet for auto registration.
- **Task 3**: Test the environment. 
  - Use a template to create the virtual machines. You can review the [lab template](https://github.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/blob/master/Allfiles/Exercises/M01/azuredeploy.json).
  - Use Azure PowerShell to deploy the template.
- **Task 4**: Verify records are present in the DNS zone.

> [!NOTE]
> Select the thumbnail image to start the lab simulation. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
>You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.

> [!NOTE]
> You can view the [Configure DNS settings in Azure](https://microsoftlearning.github.io/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/Instructions/Exercises/M01-Unit%206%20Configure%20DNS%20settings%20in%20Azure.html) instructions directly. 

[![Screenshot of the simulation page.](../media/simulation-dns-thumbnail.jpg)](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Configure%20DNS%20settings%20in%20Azure)
