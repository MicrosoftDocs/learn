Your sensor can now send data to Microsoft Defender for IoT, but you need to make some final checks to ensure that the system runs as it was originally planned. You need to check that all the planned devices are correctly listed and that they're configured properly in the system. 

Once these checks are complete, you have a full and accurate list of devices that are set up correctly and can now securely process data.

## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This Learn Module is divided into two sections.

Section 1: units 3 and 4 dealing with calibrating and fine-tuning your sensor.
Section 2: units 6 and 7 dealing with triaging the alerts.

Units 3 and 4 describes the fifth phase in the deployment: *Calibrate and fine-tune*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, activated and sending data to Defender for IoT.

The OT calibration and fine-tuning is the phase where you check that all of the devices listed in the network plan appear correctly in Defender for IoT. You also check that the settings that Defender for IoT automatically assigns to each device are correct. You might have to adjust some of these device settings.

## In this phase

### Validate the list of devices in Defender for IoT

Using Defender for IoT, compare the list of devices displayed for each sensor with the list in the network diagram. The number and type of devices must match exactly to ensure that the correct data is sent to Defender for IoT and that all of the devices are protected. If there are differences between the two lists, you must check and identify the reasons for the differences. Check that all of the devices are properly connected to the sensor, and that the monitoring settings are set correctly.

### Fine-tune your sensor subnets

Once you know that all of the devices are properly connected to Defender for IoT, you must check that the settings for each device are assigned correctly. Defender for IoT automatically assigns settings for each device. Most of the time these settings are correct, however, they must all be checked and in some cases you need to update and change them. These checks ensure that data is processed correctly, and the proper alerts are created. If the settings are left incorrect, this results in false alerts being sent, and could leave other vulnerabilities on your devices unsecured, which could compromise your most critical assets. Devices are also set to different safety or importance levels, which affect attack vector and risk assessment reports.

<!-- What are managed and unmanaged devices?  check that all the assigned settings are correct. -->
<!-- When does this categorization of devices occur, who does it? <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#supported-devices>-->

## Outcome

Once these steps are properly completed, Defender for IoT is set up to monitor all of the devices passing data to the Azure portal. Defender for IoT now has an accurate list of all the sensors, devices, and their subnets, and the correct status for each one so that they're tracked for vulnerabilities and compromises. This device list should match the original network diagram produced at the beginning of the process.
