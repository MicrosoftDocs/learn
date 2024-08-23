Cloud attach allows you to use both Microsoft Intune and Microsoft Endpoint Configuration Manager from within Intune.

There are two steps to cloud attach your on-premises devices.

1. The first step of attachment is called *tenant attach*, which is registering your Configuration Manager deployment with your Intune tenant.
2. The second step is called *co-management*, which is concurrently managing Windows 10/11 devices with both Configuration Manager and Intune.

These steps let you incrementally reach full cloud attachment. You get immediate value through tenant attach, and you get extra value through co-management.

## Tenant attach

Tenant attach allows the Intune cloud service to recognize and act on Configuration Manager devices and infrastructure from within Intune. Once you connect Configuration Manager, you gain instant cloud value. Configuration Manager uses the Configuration Manager connector to enable data flow to Intune. The connector requires a connection to an Intune tenant, and doesn't require turning on co-management.

## Co-management

Co-management lets you concurrently manage Windows 10/11 devices with both Configuration Manager and Intune. Co-management combines your existing on-premises Configuration Manager and Active Directory investment with the cloud, by using Intune, Microsoft Entra ID, and other Microsoft 365 cloud services. You choose whether to make Configuration Manager or Intune the management authority. You can keep some tasks on-premises while running other tasks in the cloud.

There are two main paths to co-management:

- For existing Windows 10/11 Configuration Manager clients, you set up hybrid Microsoft Entra ID and enroll the devices into Intune.
- For new cloud-based Windows 10/11 devices, you join Microsoft Entra ID and automatically enroll to Intune. You install the Configuration Manager client to enable co-management.

When you enroll existing Configuration Manager clients in co-management, you immediately gain the following capabilities:

- Conditional access with device compliance
- Intune-based remote actions, such as restart, remote control, or factory reset
- Centralized device health visibility
- Microsoft Entra ID to link users, devices, and apps
- Modern provisioning with Windows Autopilot

The following diagram shows how you can manage Windows 10/11 devices with both Configuration Manager and Microsoft Intune.

[ ![Diagram of cloud and on-premises infrastructure.](../media/intro-to-endpoint-manager-09.png) ](../media/intro-to-endpoint-manager-09.png#lightbox)
