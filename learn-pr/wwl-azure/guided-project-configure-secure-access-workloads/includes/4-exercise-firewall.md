## Scenario

Your organization requires centralized network security for the application virtual network. As the application usage increases, more granular application-level filtering and advanced threat protection are needed. All subnet traffic is routed through the firewall. You identify these requirements.

+ Azure Firewall is required for security in the app-vnet. 
+ A firewall policy should be configured to help manage access to the application. 
+ A firewall policy **application rule** is required. This rule allows the application access to Azure DevOps so the application code can be updated. 
+ A firewall policy **network rule** is required. This rule allows DNS resolution. 

This lab uses the Standard SKU, which supports both network and application rule collections. Azure Firewall has three SKUs: Basic (for SMB environments, alert-mode threat intelligence only), Standard (enterprise-grade with application rules), and Premium (advanced threat protection). Azure Firewall inspects both north-south (external) and east-west (internal lateral) traffic between workloads.  

## Skilling Tasks

+ Create an Azure Firewall.
+ Create and configure a firewall policy.
+ Create an application rule collection.
+ Create a network rule collection.


## Architecture Diagram

:::image type="content" source="../media/task-3.png" alt-text="Diagram that shows one virtual network with a firewall and route table." border="true":::

Launch the exercise and follow the instructions. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
> To complete this lab, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2261961)

