Your sensor now sends data to Microsoft Defender for IoT, but you need to make final checks to ensure that the system runs as originally planned. You need to check that all the planned devices are correctly listed and that they're configured properly in the system. This is called calibration and fine tuning.

Once these checks are complete, you have a full and accurate list of devices set up correctly that can now securely process data.

After fine tuning your sensor, the final stage is to create a baseline of alerts so that Microsoft Defender for IoT recognizes normal traffic flow through your system. Defender for IoT is then able to identify dangerous or suspicious traffic and produce accurate alerts. Creating the baseline occurs in the *learning* mode, where you triage alerts, and Defender for IoT learns which alerts are actually regular, safe network traffic. The *learning* mode can take a week or two, depending on the size of your system.

## OT sensor deployment path

The following diagram shows the complete operational technology (OT) deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process." border="false":::

This learn module covers the last two phases of the OT sensor deployment path.

- *Calibrate and fine-tune* deals with calibrating and fine-tuning your sensor.

- *Baseline learning* covers triaging the alerts and how the sensor changes from *learning* to *operational* mode.

## In this phase: Calibrate and fine tune

In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, activated, and sending data to Defender for IoT.

### Calibrate the list of devices

Using Defender for IoT, compare the list of devices displayed by your sensor with the list in the network diagram. The number and type of devices must match exactly to ensure that the correct data is sent to Defender for IoT and that all of the devices are protected. If there are differences between the two lists, you must check and identify the reasons for the differences. For example, a device may not be listed because it isn't correctly connected to the sensor. Check that all of the devices are properly connected to the sensor, and that the monitoring settings are set correctly. The **Analyze** feature is used to calibrate the system.

### Fine-tune your sensor subnets

Now that all of the devices are properly connected to Defender for IoT, you must check that the settings for each device are assigned correctly. Defender for IoT automatically assigns settings for each device as it detects them. Most of the time these settings are correct, however, they must be checked and in some cases you might need to update and change them. These checks ensure that the sensor processes the data correctly.

If the settings aren't corrected, false alerts are sent that could leave other vulnerabilities on your devices, compromising your most critical assets. Devices are also set to different safety or importance levels, which affect attack vector and risk assessment reports.

### Outcome

Once these steps are completed, Defender for IoT is set up to monitor all of the devices and pass the data to the Azure portal. Defender for IoT now has an accurate list of all the sensors, devices, and their subnets. As well as the correct status for each one so that they're tracked for vulnerabilities and compromises. The device list now matches the original network diagram produced in the deployment planning phase.

## In this phase: Baseline learning

When the sensor first connects to Defender for IoT it enters *learning* mode. In *learning* mode the sensor learns the difference between suspicious, harmful network traffic and safe traffic, including regular file transfers or data flows between devices.

Alerts are based on categories of activity, and are also given a severity rating based on the possible threat it could lead to. You need to check the alerts and confirm if they're correct or not, this is called the triage process.

When suspicious network traffic is identified in the future, accurate alerts are sent to Defender for IoT, so that you're able to protect your devices.

In a real life scenario, *learning* mode can continue for up to two weeks, and requires regularly, daily triage of the alerts.

### Triage alerts

Check each of the details of the new alerts listed in Defender for IoT. When you find an alert that is incorrect select the *learn* setting so that the sensor understands that this type of network traffic is safe. This specific alert configuration will be added to the baseline of normal network traffic and won't produce an alert in the future.

Other options and solutions for dealing with an alert exist, especially in a situation where harmful traffic generates the alert. You might also want to assign a suppression alert to exclude minor level alerts so that only important and severe level alerts appear on the **Alerts** page.

### Outcome

When you complete the triage process, the **Alerts** page shows the updated status of the alerts. The sensor now has a verified baseline of alerts that are considered safe and secure. This process is repeated until you see that most of the alerts are important ones, and not generated by normal system traffic.

### Learning to operational mode

*Learning* mode automatically changes to the *operational* mode once the system detects a low level of new daily alerts. However, if you think that you have already reached a low level and have set most regular traffic alerts to the learn status, you can also manually change for *operational* mode.

### Outcome

Once *operational* mode is active changes appear in the settings page.
