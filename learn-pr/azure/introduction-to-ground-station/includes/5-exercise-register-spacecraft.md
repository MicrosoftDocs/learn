Let’s look at how to complete the first step: operate a satellite via Azure Orbital Ground Station by registering it in the Azure portal.

## Getting started

Registering a spacecraft allows you to downlink data from that spacecraft via Azure Orbital Ground Station. Azure Orbital makes this process simple: it’s a matter of gathering the right information to input into the fields in the portal.

We’ll use [NASA’s AQUA satellite](/azure/orbital/downlink-aqua) as an example. A satellite operator like Contoso would have all this information for their satellites readily available. If you’re unfamiliar with a term, look at the descriptions to help build your understanding.

Because this satellite is publicly available, you can follow along in your Azure account to practice registering NASA’s AQUA satellite. If you don’t have one yet, [you can create an account for free](https://azure.microsoft.com/free/).

## Register spacecraft

Now that you have the preceding information on hand, we’ll walk through how to register a spacecraft in the Azure portal. Follow along in your own account.

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Search for and select **Azure Orbital** in the search bar.

    :::image type="content" source="../media/AO-homepage.png" alt-text="Screenshot of the main Azure Orbital dashboard, showing icons for Register a Spacecraft, Create a Contact Profile, and Schedule a Contact.":::

3. Select **Register a Spacecraft** to get started.

    :::image type="content" source="../media/orbital-eos-register-bird.png" alt-text="Screenshot of the Create a Spacecraft resource page on the Basics tab. There are blank fields that need to be filled out for the project details and instance details.":::

4. Start by filling out the information on the Basics tab using the following AQUA satellite information:

| **Field** | **Information needed** | **Description** |
|---|---|---|
| **Satellite name** | AQUA | The name of your satellite. |
| **Region** | West US 2 | The Azure region you want to use. Each Azure region features datacenters within a latency-defined perimeter connected through a dedicated regional low-latency network. This design provides the best possible performance and security within each region. [Get more information on Azure regions](/azure/availability-zones/az-overview).  |
| **NORAD ID** | 27424 | A 5-digit satellite identification number. NORAD (North American Aerospace Defense Catalog Number) IDs have been used since the first satellite was launched in 1957. |
| **TLE title line** | AQUA | The standard format used to describe the trajectory of earth-orbiting objects. TLEs change, so they [need to be kept up to date](https://celestrak.org/NORAD/elements/active.txt). [Get more instructions on updating TLEs.](/azure/orbital/update-tle) |
| **TLE line 1** | [Enter the TLE line 1 from Celestrak](https://celestrak.org/NORAD/elements/active.txt) | The first line of the TLE.  Example 1: 27424U 02022A   22250.53879010  .00000478  00000+0  11551-3 0  9993 |
| **TLE line 2** | [Enter the TLE line 2 from Celestrak](https://celestrak.org/NORAD/elements/active.txt) | The second line of the TLE. Example 2: 27424  98.2510 191.6693 0001463  54.4662 357.4337 14.57372758 82148 |

5. Select **Next: Links** or go to the **Links** tab and select **Add new Link**.

    :::image type="content" source="../media/orbital-eos-register-links.png" alt-text="Screenshot of the Create a Spacecraft resource page on the links tab with a red box around Add a new Link. On the right side of the screen, there are blank fields that need to be filled out for the link details.":::

6. Fill out the fields using the following AQUA satellite information provided, then select **Submit**.

| **Field** | **Information needed** | **Description** |
|---|---|---|
| **Link Direction** | Downlink | The direction you want information to flow. You can uplink (from the ground station to the satellite) or downlink (from the satellite to the ground station) information. |
| **Center Frequency** | 8160 | The measure of central frequency between lower and upper cutoff frequencies. Frequency is the number of times that an alternating current goes through its complete cycle in one second. Higher-frequency bands typically result in wider bandwidths, but are more susceptible to signal degradation. |
| **Bandwidth** | 15 | The amount of data that a satellite can receive, process, and transmit. |
| **Polarization** | Select RHCP | The geometrical orientation of the oscillations of a transverse wave. Satellite frequencies are polarized so that satellite transponder frequencies can be reused without interfering with one another. For example: if half of a transponder’s signals are beamed to earth in a vertically polarized mode and the other half are beamed to earth in a horizontally polarized mode, then they're 90 degrees out of sync and won't interfere with each other. For visuals and additional information, [see this information on polarization.](https://en.wikipedia.org/wiki/Polarization_(waves)) |

7. Skip the information on the **Tags** page. Tags aren't required to register a spacecraft, but they can be [helpful for managing spend and use across all products in a company’s Azure account](/azure/azure-resource-manager/management/tag-resources?tabs=json).

8. Finally, select to **Review + create** to review the information you entered and create the spacecraft resource.

    > [!NOTE]
    > You can't use this spacecraft to schedule a contact until it has been authorized, which takes about 24 hours. To request authorization for your spacecraft, use the [Azure Orbital Spacecraft Authorization Form](https://forms.office.com/r/QbUef0Cmjr). However, you can proceed to the next step while you wait for authorization.
