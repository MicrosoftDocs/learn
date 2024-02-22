Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. Zero Trust access principles require segmenting your network to enhance security and limit access for each segment to relevant personnel only.

Defender for IoT uses *sites* and *zones* for this segmentation, and you need the details about your sensors' sites and zones when onboarding your sensor.

## Sites and zones

In Defender for IoT, in our example, each international office location is designated as a separate *site*. Each of these sites contains areas with different uses, such as executive offices, production floors, and sales. In Defender for IoT, each of these logical areas are called *zones*.

Each of your sensors is assigned to a site and zone, with its own unique name. The sensor is either connected to the cloud, where data is streamed to the Azure portal, or managed locally, where data is accessed only on-premises. You define sites and zones for your sensors as you onboard them to Defender for IoT.

### Your organization's deployment plan

Your car manufacturer has four offices worldwide. The following table shows the part of your deployment plan that details the sites, zones, and sensor required for each office.

|Site | Zones | Sensor name | Cloud connected |
|--- | ---|---|--- |
|**Paris office** |- Ground floor (Guests)<br> - Floor 1 (Sales) <br> - Floor 2 (Executive)|paris-guests<br>paris-sales<br>paris-exec | Yes<br>Yes<br>Yes |
|**Lagos office** |- Ground floor (Guests)<br> - Floor 1 (Sales)  |lagos-offices<br>lagos-factory |Yes <br> No |
|**Dubai office** |- Ground floor (Convention center)<br> - Floor 1 (Sales) <br> - Floor 2 (Offices)|dubai-guests<br>dubai-sales<br>dubai-exec| Yes<br>Yes<br>Yes|
|**Tianjin office** |- Ground floor (Offices)<br> - Floors 1-2 (Factory)| tianjin-office <br>tianjin-factory | Yes <br> No |

To onboard the **Sales floor** sensor for the **Paris office**, you need the following information ready:

- **Site name**: Paris office
- **Zone**: Floor 1 (Sales)
- **Sensor name**: paris-sales
- **Cloud connected**: Yes
