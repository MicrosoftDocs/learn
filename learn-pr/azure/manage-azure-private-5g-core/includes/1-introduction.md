Enterprises use private mobile networks for their mission-critical applications. To ensure the smooth operation of the private mobile network and to satisfy the needs of your current and future applications, you'll need to occasionally manage the network after its initial setup. For example, you may need to provision SIMs for newly added user equipment (UE) or configure SIM policies for a new application.

In this module, we'll introduce you to Azure Private 5G Core routine management tasks, including tasks for network and site management, SIM and SIM policy management, and system upgrade. For each task, we'll explain the reasons for performing it. We'll also provide high-level instructions for completing the task, with links to the detailed steps described in relevant documentation.

At the end of this module, you'll take the Knowledge Check to ensure that you've successfully understood the material. With the knowledge taught in this module, you should be able to manage an Azure Private 5G Core powered private mobile network on a routine basis.

## Methods for completing management tasks

You can complete many management tasks by using either the Azure portal or an [Azure Resource Manager template](/azure/azure-resource-manager/templates/overview) (ARM template). An ARM template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for a project.

While the Azure portal provides intuitive graphical user interface (GUI), an ARM template can help you quickly complete repetitive steps. For example, with an ARM template, you can deploy multiple sites or provision multiple SIMs in a single step. Where applicable, this module provides instructions for using both the Azure portal and an ARM template to complete a task.

> [!NOTE]
>
> - As one or more sites need to be created before a private mobile network can be put into operation, the mobile network and site deployment tasks are introduced in the *Deploy an Azure Private 5G Core service* module.
> - Monitoring the health of a private mobile network and troubleshooting network issues are important management tasks. These tasks are introduced separately in the *Monitor the Azure Private 5G Core service* module.

## Azure resources used by management tasks

With either the Azure portal GUI or the ARM templates, you'll need to use different resources to manage the components in a private mobile network. For example, to provision SIMs, you'll need to use the **Mobile Network** resource.

The following table describes the major resource types that you'll need for managing a private mobile network:

|Resource type  |Network component managed |Usage note  |
|---------|---------|---------|
|Mobile Network |A private mobile network |Use this resource to manage a private mobile network. |
|Mobile Network Site |A site in a private mobile network |Use this resource to manage a site in a private mobile network. You can open this resource from a **Mobile Network**. |
|Packet Core Control Plane |The control plane of a packet core instance |Use this resource to manage a packet core instance. You can open it from a **Mobile Network Site**. |
|SIM Group |A SIM group |Use this resource to categorize SIMs. You can open it from a **Mobile Network**. |
|SIM |A SIM for an attached UE |Use this resource to configure a SIM. You can open it from a **Mobile Network**. |
|SIM Policy |A SIM policy |Use this resource to manage a SIM policy. You can open it from a **Mobile Network**.  |
|Service |A service |Use this resource in SIM policy configuration. You can open it from a **Mobile Network**. |

These resources are interrelated. Take SIM related resources as an example. You can categorize SIMs into SIM groups and assign SIM policies to the SIMs. Each SIM policy can have multiple network scopes, and in each scope, one or more services can be used.

The following diagram shows an example of two SIM policies assigned to SIMs in two different SIM groups:

:::image type="content" source="../media/sim-policy-relationship.png" alt-text="A diagram that shows two SIM policies and their related SIMs, SIM groups, and services." border="true":::

As shown in the diagram, SIM group 1 contains three SIMs, while SIM group 2 contains two SIMs. SIM policy 1 and SIM policy 2 are respectively assigned to the SIMs in SIM group 1 and SIM group 2.

The private mobile network has two DNs and four slices. SIM policy 1 has two network scopes, through which service 1 and service 2 are respectively used. SIM policy 2 also has two network scopes, through which service 2 is used. Each network scope is restricted by the combination of a slice and a DN.

You'll learn more about these resources and their usage in later units.
