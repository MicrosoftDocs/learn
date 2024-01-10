Your sensor can send data to Microsoft Defender for IoT, but before this can be used to secure your organization's network, you need to check that the devices listed match the ones listed in your network plan. Once this check is made, you also need to check the settings of each device and ensure that they're configured properly. When Defender for IoT first receives data from each device it automatically defines the settings, sometimes these settings might be incorrect, and so you must check each one. Once these two checks are complete, you have a complete and accurate list of devices that are correctly set up to process data.

## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This module describes the fifth phase in the deployment: *Calibrate and fine-tune*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, activated and sending data to Defender for IoT.

The OT calibration and fine-tuning is the phase where you check that all of the devices appear listed correctly in Defender for IoT. You also check the settings that Defender for IoT has automatically assigned to each device and might have to adjust some of these.

## In this phase

Not sure to keep this or keep format from previous modules. How to organize this unit?

## Validate the list of devices in Defender for IoT

Using Defender for IoT, compare the list of devices listed for your sensor with the list made for the network diagram. The number and type of devices must match properly so that all of the correct data is sent to Defender for IoT and to ensure that all of the devices will be securely protected. If there are differences between the two lists, you must check and identify the reasons for the differences. Check that all of the devices are properly connected to the sensor, or that the monitoring settings are set correctly.

## Fine-tune your sensor subnets

Once you know that all of the devices are properly connected to Defender for IoT, you must check that the settings for each device are assigned correctly. Defender for IoT initially, automatically, assigns settings for each device. Most of the time these are correct, however, they must all be checked and in some cases you'll need to update and change these settings. This is important so that data is processed correctly, and the proper alerts can be created. If the settings are left incorrect, this results in false alerts being sent, and can leave other vulnerabilities on your devices unsecured that can compromise your most critical assets. Devices are also set to different safety or importance levels, which affect attack vector and risk assessment reports.

<!-- What are managed and unmanaged devices?  check that all the assigned settings are correct. -->

## Outcome

Once these steps are properly completed, Defender for IoT is set up to monitor all of the devices passing data to the Azure portal. Defender for IoT now has an accurate list of all the sensors, devices, and their subnets, and the correct status for each one so that they're tracked for vulnerabilities and compromises. This device list should match the original network diagram produced at the beginning of the process.
