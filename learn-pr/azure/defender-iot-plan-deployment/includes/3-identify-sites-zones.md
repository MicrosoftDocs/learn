Your car manufacturing organization has a network including offices and production sites across the globe. The Zero Trust access strategy requires segmenting your OT network to enhance network security. Defender for IoT for OT uses sites and zones for segmentation.

## Zero Trust Access

Zero Trust is a security strategy, which assumes a breach as a given, and therefore always requires verifications and the least needed privileges. Some applications of Zero Trust in an OT network can include:

1. Ensuring that all connections between networks and devices are identified and managed.
1. Limiting and securing your network jump hosts.
1. Segmenting your network to limit data access. Encrypting and securing all communication between devices and segments and preventing lateral movement between systems.
1. Evaluating signals like device location, health, and behavior using health data to gate access or flag for remediation.
1. Monitoring security metrics to ensure security perimeter integrity.
<!-- What are the most important zero trust examples for OT to use? -->

## Zero Trust with Defender for IoT

Defender for IoT supports Zero Trust access segmentation with sites and zones. You can group data ingested from sensors in the same site or zone together and monitor for unauthorized traffic crossing segments. Segmenting allows you to create policies for least-privileged access to Defender for IoT.

Sites and zones are defined as follows:

- **Sites** group devices by a specific geographical location, like an office at a specific address.
- **Zones** define a segment within a site that is a functional area, such as a specific production line.

> [!NOTE]
> You can further divide zones into *business units* and *regions* from the on-premises management console.

### Example

In your car manufacturer, you might segment factories and office areas in Paris and Lagos into the following sites and zones:

|Sites  |Zones  |
|---------|---------|
|**Paris office**     | - Ground floor (Guests)</br>- Floor 1 (Sales)</br>- Floor 2 (Executive) </br>    |
|**Lagos office**     | - Ground floor (Offices)</br>- Floors 1-2 (Factory)     |

### Separating Zones

It's recommended to separate sensors with similar characteristics, like recurring IP address ranges, into separate zones when working with multiple networks. This is to ensure that Defender for IoT differentiates between the devices and identifies each device uniquely.

<!--In the next unit, you'll check your understanding of  organize your car manufacturer's locations into sites and zones based on a network diagram.-->

## Knowledge Check

:::image type="content" source="../media/3-recurring-segments-option-no.png" alt-text="Diagram of a sample network":::
<!--Optional "exercise-solution" video -->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
