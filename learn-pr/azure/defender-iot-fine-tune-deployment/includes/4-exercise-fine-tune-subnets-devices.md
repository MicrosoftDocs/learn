First section will be the plan unit - what you need to know and get ready, 2nd will be the proper exercise. I think the unit title needs to change.

# Fine tuning

<https://youtu.be/iwEAHiN6BOI?si=xUeeL_LF2T-9zjc5&t=1544>
Your sensor is now sending data to Microsoft Defender for IoT, but we need to check that the sensors are set up and configured as planned.

## View the subnets detected by your sensor
<!-- Qus: what exactly is a subnet? 
What is the difference between the Jenkins sensor page and the D4IoT sensor page? do they control different things? They both show interfaces and subnets and a device inventory, how are they different if at all?
what defines a device as authorised? or not? 
device properties - how does that relate to making changes?-->

First you analyze the traffic being monitored. Run the **Analyze** feature in the deployment section. This tracks each interface that is monitored by the sensor and lists the subnets associated with each interface.
When the analysis has completed, you need to check that each interface is monitoring the correct traffic, or whether you need to adjust the settings at all.

<!--What does it mean to change the sensors location in the network? Is that a purdue heirachy connection? done in the device map/ inventory sections -->
Once any changes are made, the analysis should be run again to ensure the set up is now correct.  
<!--<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored>-->

## Modify subnet data to match your network

Similarly, the subnets are analyzed by the OT sensor which tries to learn the set up of your system. It assigns settings and attemps to understand and build a map of the purdue set up.

<!-- In this section https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#fine-tune-your-subnet-list  why is one an Azure device, but the map isnt? Also what is the meaning of the tip in this section? how is this different from the stuff above the tip? What is the difference between the (Jenkins) sensor screen device mapa nd inventory and the Azure D4IoT Device Inventory??-->
updating the subnets listed, where do they find this data? There are several ways to update the subnet data. If you have a .CSV file with the data correctly organized, this can be uploaded. Any data will be overwritten. You could update an IP address or the subnet Mask. Redefining the ICS subnet can only be done manually, but is not discussed in this module!!(How to write this better?)

|Name  |Description  |
|---------|---------|
|**Import subnets**     | Import a .CSV file of subnet definitions. The subnet information is updated with the information that you imported. If you import an empty field, you lose the data in that field.       |
|**Export subnets**     |  Export the currently listed subnets to a .CSV file.       |
|**Clear all**     |  Clear all currently defined subnets.      |
|**Auto subnet learning**     |  Selected by default. Clear this option to prevent the sensor from detecting your subnets automatically. |
|**Resolve all Internet traffic as internal/private**     | Select to consider all public IP addresses as private, local addresses. If selected, public IP addresses are treated as local addresses, and alerts aren't sent about unauthorized internet activity.  <br><br>This option reduces notifications and alerts received about external addresses.      |
| **IP address** | Define the subnet's IP address. |
| **Mask**| Define the subnet's IP mask. |
| **Name**| We recommend that you enter a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.|
|**Segregated**     |   Select to show this subnet separately when displaying the device map according to Purdue level.  |
| **Remove subnet** | Select to remove any subnets that aren't related to your IoT/OT network scope.|

<!--What is ICS subnet?? -->
<!-- do we want to show changing a device?? or is that beyond the scope? must talk about this, but how much details??? change one ip setting? -->

## View detected devices
<!-- carry on watching this https://youtu.be/FbLhJZN1LdQ?si=xMBscEGQxGspzMSR&t=4635-->

All of the devices detected by Defender for IoT will appear in teh Device inventory. You can made changes to the device details and it is important to review the data for the Name, Class, Type, and Subtype, Authorization, Scanner device, and Programming device columns.

## Update selected details

You can also customize other parts of the data , such as the names assigned to the detected ports, the VLAN names and the DHCP addresses. (is this important enough to mention here? )

In some cases a device might be listed more than once, this can happen when a device has two or more similar connectors, for example a laptop with both Wifi and a physical network card. In this case you will need to merge them together, using the **Merge** option. This will make a new device listing, that will contain all of the data from the merged devices.

Needs more review and help from a PM or someone.

Note: For exercise - Prepare your environment â€“ Create a sensor with sample data. Speak to Vishakha about how we can use the hands on lab. We might still have to instruct them on how to set up a VM to deploy this. (this basically skips the install/activate steps)
fine tune
-Microsoft-Defender-for-IoT/Hands on Lab Documents at main Â· Azure/-Microsoft-Defender-for-IoT Â· GitHub
<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#define-ot-and-iot-subnets>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory#merge-duplicate-devices>

alerts
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#understand-learning-mode>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/alerts#managing-ot-alerts-in-a-hybrid-environment>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/alerts#alert-statuses-and-triaging-options>

Exercises
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts>