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
|Packet Core Control/Data Plane |The control/data plane of a packet core instance |Use these resources to manage a packet core instance. You can open it from a **Mobile Network Site**. |
|SIM Group |A SIM group |Use this resource to categorize SIMs. You can open it from a **Mobile Network**. |
|SIM |A SIM for an attached UE |Use this resource to configure a SIM. You can open it from a **Mobile Network**. |
|SIM Policy |A SIM policy |Use this resource to manage a SIM policy. You can open it from a **Mobile Network**.  |
|Service |A service |Use this resource in SIM policy configuration. You can open it from a **Mobile Network**. |
