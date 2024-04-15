Your sensor can now send data to Microsoft Defender for IoT, but you need to make some final checks to ensure that the system runs as it was originally planned. You need to check that all the planned devices are correctly listed and that they're configured properly in the system. 

Once these checks are complete, you have a full and accurate list of devices that are set up correctly and can now securely process data.

## OT sensor deployment path

The following diagram shows the complete Operational Technology (OT) deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This learn module is divided into two sections.

Section 1 describes the fifth phase in the deployment, *Calibrate and fine-tune*, and deals with calibrating and fine-tuning your sensor. It includes these units:

 - Unit 2 describes the general overview of the calibration and fine tuning phase of the sensor deployment.
 - Unit 3 describes the information and preparations you need to complete the exercise unit.
 - Unit 4 is the exercise unit to practice the calibration and fine tuning activities.

Section 2 describes the sixth phase in the deployment, *Baseline learning*, and deals with triaging the alerts.

## In this phase

In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, activated, and sending data to Defender for IoT.

The OT calibration and fine-tuning is the phase where you check that all of the devices listed in the network plan appear correctly in Defender for IoT. You also check that the settings that Defender for IoT automatically assigns to each device are correct. You might have to adjust some of these device settings.

### Calibrate the list of devices

Using Defender for IoT, compare the list of devices displayed by your sensor with the list in the network diagram. The number and type of devices must match exactly to ensure that the correct data is sent to Defender for IoT and that all of the devices are protected. If there are differences between the two lists, you must check and identify the reasons for the differences. Check that all of the devices are properly connected to the sensor, and that the monitoring settings are set correctly.

### Fine-tune your sensor subnets

Now that all of the devices are properly connected to Defender for IoT, you must check that the settings for each device are assigned correctly. Defender for IoT automatically assigns settings for each device as it detects them. Most of the time these settings are correct, however, they must all be checked and in some cases you might need to update and change them. These checks ensure that the sensor processes the data correctly.

If the settings aren't corrected, false alerts are sent that could leave other vulnerabilities on your devices, compromising your most critical assets. Devices are also set to different safety or importance levels, which affect attack vector and risk assessment reports.

## Outcome

Once these steps are completed, Defender for IoT is set up to monitor all of the devices and pass the data to the Azure portal. Defender for IoT now has an accurate list of all the sensors, devices, and their subnets. As well as the correct status for each one so that they're tracked for vulnerabilities and compromises. The device list now matches the original network diagram produced in the deployment planning phase.
