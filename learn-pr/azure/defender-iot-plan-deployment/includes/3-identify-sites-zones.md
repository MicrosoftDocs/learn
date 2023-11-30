Your car manufacturing organization has a network including offices and production sites across the globe. A Zero Trust access strategy requires segmenting your OT network to enhance network security and limit access to each segment only to relevant personnel. Defender for IoT uses *sites* and *zones* for segmentation.

## Zero Trust

Zero Trust is a security strategy that assumes a breach as a given, and therefore always requires verifications and the least needed privileges. Some applications of Zero Trust in an OT network can include:

- Ensuring that all connections between networks and devices are identified and managed.
- Limiting and securing your network jump hosts.
- Segmenting your network to limit data access. Encrypting and securing all communication between devices and segments and preventing lateral movement between systems.
- Evaluating signals like device location, health, and behavior using health data to gate access or flag for remediation.
- Monitoring security metrics to ensure security perimeter integrity.

## Zero Trust with Defender for IoT

Defender for IoT supports Zero Trust access segmentation with sites and zones. You can group data ingested from sensors in the same site or zone together and monitor for unauthorized traffic crossing segments. Segmenting allows you to create policies for least-privileged access to Defender for IoT.

Sites and zones are defined as follows:

- **Sites** group devices by a specific geographical location, like an office at a specific address.
- **Zones** define a segment within a site that is a functional area, such as a specific production line.

### Example

In your car manufacturer, you might segment factories and office areas in Paris and Lagos into the following sites and zones:

|Sites  |Zones  |
|---------|---------|
|**Paris office**     | - Ground floor (Guests)</br>- Floor 1 (Sales)</br>- Floor 2 (Executive) </br>    |
|**Lagos office**     | - Ground floor (Offices)</br>- Floors 1-2 (Factory)     |

### Separate recurring IP address ranges

When you're working with multiple networks, separate sensors with recurring IP address ranges into separate zones. This ensures that Defender for IoT differentiates between the devices and identifies each device uniquely across your networks.

## Knowledge check

Figures A and B will help you answer the knowledge check questions.

:::image type="complex" source="../media/3-figure-a-knowledge-check.png" alt-text="A diagram, labeled Figure A, depicting two global locations, a Paris location and a Bengalaru location, each with different departments on different floors of the location." border="false":::

Figure A shows an example of two global locations. The Paris location has an office of different departments on three floors. The ground floor with a Guests network, floor 1 with Sales, and floor 2 with Executives. The Bengaluru location includes an office with different departments on three floors. The ground floor with an Offices network, floor 1 with Production Line A, and floor 2 with Production Line B.
:::image-end:::

:::image type="complex" source="../media/3-figure-b-knowledge-check.png" alt-text="A diagram of a sample network, labeled Figure B. " border="false":::

Figure B is a diagram of a sample network with two sites, Site 1 and Site 2. Site 1 contains Zone 1 with network segments 10.0.0.0\/24, 10.0.1.0\/24, and 10.0.3.0\/24. Site 2 contains Zone 2 with network segments 10.0.0.0\/24, 10.0.0.0\/24, and 10.0.2.0\/24.
:::image-end:::
