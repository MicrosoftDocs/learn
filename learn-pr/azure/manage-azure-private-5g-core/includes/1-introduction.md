Enterprises often use private mobile networks that Azure Private 5G Core powers for mission critical IoT applications. To ensure the smooth operation of the network and to satisfy the needs of your applications, you'll need to manage the network on a routine basis after the initial setup of the network. For example, you may need to provision SIMs for newly added user equipment (UE) or configure SIM policies for a new application.

In this module, we'll introduce you to Azure Private 5G Core routine management tasks, including tasks for network and site management, SIM and SIM policy management, and system upgrade. For each task, we'll explain the reasons for performing the operation. We'll also provide high-level instructions for completing the task, with links to the detailed steps described in relevant documentation.

After the learning, you'll need to do some exercises in the Knowledge Check unit to make sure that you've learned the tasks successfully. With the knowledge taught in this module, you should be able to manage an Azure Private 5G Core powered private mobile network on a routine basis.

## Methods for completing management tasks

You can complete many management tasks by using either the Azure portal or an Azure Resource Manage template (ARM template). While the Azure portal provides intuitive graphical user interface (GUI), an ARM template can help you quickly complete repetitive steps. For example, with an ARM template, you can deploy multiple sites or provision multiple SIMs in one go. Where applicable, this module provides instructions for using both the Azure portal and an ARM template to complete a task.

> [!NOTE]
>
> - As one or more sites need to be created before a private mobile network can be put into operation, the mobile network and site deployment tasks are introduced in the *Deploy an Azure Private 5G Core service* module.
> - Monitoring the health of a private mobile network and troubleshooting network issues are important management tasks. These tasks are introduced separately in the *Monitor the Azure Private 5G Core service* module.

## Azure resources used by management tasks

With either the Azure portal GUI or the ARM templates, you'll' need to use different resources to manage different components in a private mobile network. For example, to provision SIMs, you'll need to use the *Mobile Network* resource.

The following table describes the major resource types that you'll need to manage a private mobile network:

|Resource type  |Network component managed |Usage note  |
|---------|---------|---------|
|Mobile Network |A private mobile network |Use this resource to manage a private mobile network. |
|Mobile Network Site |A site in a private mobile network |Use this resource to manage a site in a private mobile network. You can open this resource from a *Mobile Network*. |
|Packet Core Control Plane |The control plane of a packet core instance |Use this resource to manage a packet core instance. You can open it from a *Mobile Network Site*. |
|Packet Core Data Plane |The data plane of a packet core instance |Use this resource to manage a packet core instance. You can open it from a *Mobile Network Site*. |
|Sim Group |A SIM group |Use this resource to categorize SIMs. You can open it from a *Mobile Network*. |
|Sim |A SIM for an attached UE |Use this resource to configure a SIM. You can open it from a *Mobile Network*. |
|Sim Policy |A SIM policy |Use this resource to manage a SIM policy. You can open it from a *Mobile Network*.  |
|Service |A service |Use this resource in SIM policy configuration. You can open it from a *Mobile Network*. |
