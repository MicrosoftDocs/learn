First section will be the plan unit - what you need to know and get ready, 2nd will be the proper exercise. I think the unit title needs to change.
# Fine tuning
Your sensor is now sending data to Microsoft Defender for IoT, but we need to check that the sensors are set up and configured as planned.

## View the subnets detected by your sensor

First you analyze the traffic being monitored. Run the **Analyze** feature in the deployment section. This tracks each interface that is monitored by the sensor and lists the subnets associated with each interface.
When the analysis has completed, you need to check that each interface is monitoring the correct traffic, or whether you need to adjust the settings at all.

<!--What does it mean to change the sensors location in the network? Is that a purdew heirachy connection? done in the device map/ inventory sections -->
Once any changes are made, the analysis should be run again to ensure the set up is now correct.  
<!--<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored>-->

## Modify subnet data to match your network

Similarly, the subnets are analyzed by the OT sensor which also tries to learn the set up of your system. It assigns settings and attemps to understand and build a map of the perduw set up.

<!-- In this section https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#fine-tune-your-subnet-list  why is one an Azure device, but the map isnt? Also what is the meaning of the tip in this section? how is this different from the stuff above the tip? What is the difference between the (Jenkins) sensor screen device mapa nd inventory and the Azure D4IoT Device Inventory??-->
updating the subnets listed, where do they find this data?

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
<!-- do we want to show changing a device?? or is that beyond the scope? -->
## View detected devices

## Update selected details

Note: For exercise - Prepare your environment â€“ Create a sensor with sample data. Speak to Vishakha about how we can use the hands on lab. We might still have to instruct them on how to set up a VM to deploy this. (this basically skips the install/activate steps)

-Microsoft-Defender-for-IoT/Hands on Lab Documents at main Â· Azure/-Microsoft-Defender-for-IoT Â· GitHub
<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#define-ot-and-iot-subnets>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory#merge-duplicate-devices>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#understand-learning-mode>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/alerts#managing-ot-alerts-in-a-hybrid-environment>
<https://learn.microsoft.com/azure/defender-for-iot/organizations/alerts#alert-statuses-and-triaging-options>

Exercises
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts>