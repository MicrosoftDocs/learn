Before you can downlink data from AQUA, you need to create a contact profile. 

## Getting started

A contact profile defines how the satellite and ground station will make contact. When you set up the contact profile, you’ll determine the minimum duration of the contact, type of contact, where the data should go once contact has been made, and other specifications.

Just like registering the spacecraft, creating a contact profile is a matter of inputting the right information into the Azure Orbital portal. Satellite operators using their own fleet will have this information on hand.

We’ll continue to use [NASA’s AQUA satellite](/azure/orbital/downlink-aqua) to show you how to create a contact profile. If you’re following along in your own account, you’ll need to have an Azure event hub and virtual network established as the endpoint for the data. You can learn how to create an [event hub here](/azure/event-hubs/event-hubs-create) and a [virtual network](/azure/virtual-network/quick-create-portal) here.

## Create a Contact Profile

Now that you have the needed information on hand, we’ll walk through how to create a contact profile in the Azure portal.

1. Navigate back to the Azure Orbital home page.

    :::image type="content" source="../media/AO-homepage.png" alt-text="Screenshot of the main Azure Orbital window, showing icons for Register a Spacecraft, Create a Contact Profile, and Schedule a Contact.":::

2. Select **Create a Contact Profile**.

    :::image type="content" source="../media/orbital-eos-contact-profile.png" alt-text="Screenshot of the Create a Contact Profile resource page on the basics tab. There are blank fields you need to fill out for the project details and instance details.":::

3. Fill out the **Basics** tab using the following information. Here, you'll designate where the data should go once the satellite and ground station have made contact.

| **Field** | **Information needed** | **Description** |
|---|---|---|
| **Name** | AQUA Downlink | The name of your satellite contact profile |
| **Region** | West US 2 | The Azure region you want to use. Each Azure region features datacenters within a latency-defined perimeter connected through a dedicated regional low-latency network. This design provides the best possible performance and security within each region. You can find more information on [Azure regions in Microsoft Docs](/azure/availability-zones/az-overview).  |
| **Minimum viable Contact duration** | PT1M | The minimum amount of time that the ground station and spacecraft can be in contact. A contact is the period of time that the ground station antenna and satellite are linked. |
| **Minimum elevation in degrees** | 5.0 | The minimum elevation required for the contact. Elevation is the upward tilt to a satellite antenna measured in degrees. A higher value elevation can decrease the duration of the contact. |
| **Auto track configuration** | Disabled | The frequency of the band that should be used for auto tracking during the contact. In Azure Orbital, you'll select **X band**, **S band**, or **Disabled**. |
| **Azure Event Hubs Namespace** | Unique to each user | The namespace of your Azure Event Hubs. Azure Event Hubs is a data streaming platform and event ingestion service that can receive and process millions of events per second. You can determine whether you want the telemetry sent to an event hub. |
| **Azure Event Hubs Instance** | Unique to each user | The instance of your Azure Event Hubs. |
| **Virtual Network** | Unique to each user | The name of the virtual network you want to use for your endpoint. When selected, a box will show up where you can select the subnet for your virtual network. |

4. Go to the Links tab and select **Add new Link**.

    :::image type="content" source="../media/orbital-eos-contact-link.png" alt-text="Screenshot of the Create Contact Profile resource page on the links tab with a red box around Add a new Link button." border="true":::

5. Use the following information needed to set up the link:

    :::image type="content" source="../media/Orbital-eos-contact-channel.png" alt-text="Screenshot of the page that comes up when Add a new Link is selected. There's a red box around Add Channel." border="true":::

| **Field** | **Information needed** | **Description** |
|---|---|---|
| **Link Direction** | Downlink | The direction you want information to flow. You can uplink (from the ground station to the satellite) or downlink (from the satellite to the ground station) information. |
| **EIRP (Equivalent Isotropic Radiated Power)** | NA for downlink | If you select **Uplink**, you need to input the EIRP in dBW. EIRP is used to determine the transmitter power and beam verification. |
| **G/T(Gain/Temperature)** | 0 | If you select **Downlink**, you'll need to input the G/T in db/K, which measures the quality of an antenna. The higher the G/T number, the better the system. |
| **Polarization** | RHCP | The geometrical orientation of the oscillations of a transverse wave. Satellite frequencies are polarized so that satellite transponder frequencies can be reused without interfering with one another. For example: if half of a transponder’s signals are beamed to earth in a vertically polarized mode and the other half are beamed to earth in a horizontally polarized mode, then they're 90 degrees out of sync and won't interfere with each other. For visuals and additional information, [see this Wikipedia entry on polarization.](https://en.wikipedia.org/wiki/Polarization_(waves)) |  

6. After you’ve filled out the link information, select **Add Channel**, then input the following information on the AQUA satellite and the relevant information for your endpoint.

| **Field** | **Information needed** | **Description** |
|---|---|---|
| **Center Frequency** | 8160 | The measure of central frequency between lower and upper cutoff frequencies. Frequency is the number of times that an alternating current goes through its complete cycle in one second. Higher frequency bands typically result in wider bandwidths but are more susceptible to signal degradation. |
| **Bandwidth** | 15.0 | The amount of data that can be received, processed, and transmitted by a satellite. |
| **Endpoint Name** | Unique to each user | Where you want the data from the satellite to go; it could be a Virtual Machine, Azure Storage, or an Azure data lake. |
| **IP Address** | Unique to each user | A unique string of characters that identifies each computer using the internet protocol to communicate over a network |
| **Port** | Unique to each user | A virtual point where network connections start and end. Ports are software based and each port is associated with a specific process or service. For example, emails go to a different port than webpages even though they reach a computer over the same internet connection. |
| **Protocol** | TCP or UDP (unique to each user) | An established set of rules that determine how data is transmitted between devices in the same network |
| **Demodulation Configuration Type** | Select the Preset Named Modem Configuration option and choose Aqua Direct Broadcast. Leave the **Decoding configuration** blank. | Configuration required to demodulate the data. Demodulation is the process in which a satellite receiver circuit extracts the wanted signals from a satellite. In Azure Orbital, this line can be left blank, or you can request a demodulation configuration from the [Azure Orbital Team](mailto:msazureorbital@microsoft.com) to use a software modem. |

7. For this exercise, skip the information on the **Tags** page. Tags aren't required to register a spacecraft, but they can be [helpful for managing spend and use across all products in a company’s Azure account](/azure/azure-resource-manager/management/tag-resources?tabs=json).  

8. Finally, select **Review + create** to review the information you entered and create the contact profile.

Once you have set up your contact profile, you’re ready to schedule a contact and downlink the data.
