Microsoft Defender for Endpoint is an enterprise endpoint security platform to help businesses prevent, investigate, detect, and respond to threats. Microsoft Defender for Endpoint increases endpoint security for Azure Virtual Desktop and Windows 10 physical endpoints.

Defender for Endpoint allows up to 50 concurrent user connections for Windows 10 Enterprise multi-session running on Azure Virtual Desktop.

Single session scenarios on Windows 10 Enterprise are fully supported for onboarding your Azure Virtual Desktop machines into Defender for Endpoint.

There are several new items in the Microsoft Defender Security Center that support Azure Virtual Desktop detailed in this unit.

## Device Inventory Page

On the device inventory page, select **filters** to see the **Windows 10 AVD** filter for viewing only Azure Virtual Desktop machines. You can identify Azure Virtual Desktop machines by looking for **Windows 10 AVD** in the OS platform column.

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-2-9ae8ea33.jpg" alt-text="Image of Azure Virtual Desktop device inventory.":::


## Device Page

‎On the device page, **Azure Virtual Desktop** is seen under the device details section. Under OS, you’ll see **Windows 10 AVD x64** indicating an Azure Virtual Desktop machine.

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-3-37b3b054.png" alt-text="Image of Azure Virtual Desktop devices.":::


The device page also shows the number of logged on users in the past 30 days on the overview tab.

Selecting the **See all users** link allows you to view the complete list of users. You’ll see many columns that include: **Logon Type**, **log on type 10**, and **RemoteInteractive**.

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-5-7b9941e6.png" alt-text="Image of Azure Virtual Desktop logged on users.":::


## Machine Timeline

‎The machine timeline is populated with information for all active user sessions on an Azure Virtual Desktop machine. The timeline allows you to see all events happening on the machine and the ability to investigate timeline events that are specific to a particular user session. In the example below, there are events in the machine timeline for five users who are logged on concurrently to an Azure Virtual Desktop machine:

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-6-801d9748.png" alt-text="Image of Azure Virtual Desktop machine timeline.":::


To see all activity related to a specific user, search for the username.

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-17-e490dd66.png" alt-text="Image of Azure Virtual Desktop and Security Center.":::


## Incidents and Alerts

‎Below is a sample alert triggered for a user on an Azure Virtual Desktop machine:

:::image type="content" source="../media/virtual-desktop-defender-endpoint-image-8-5dc0ecb1.png" alt-text="Image of Azure Virtual Desktop alerts.":::
