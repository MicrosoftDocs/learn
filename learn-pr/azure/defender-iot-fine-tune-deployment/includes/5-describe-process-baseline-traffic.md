Your sensor is now fine tuned and almost fully operational. The final stage is to create a baseline of alerts so that Microsoft Defender for IoT understands the normal type of traffic flow through your system. Then, Defender for IoT is able to identify which traffic is most dangerous or suspicious and produces accurate alerts. Creating the baseline is called the learning stage, as based on your triaging of the alerts, Defender for IoT learns which alerts are regular, safe network traffic. This learning stage can take a week or two, depending on the size of your system, as you define which alerts Defender for IoT should flag.

## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/5-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::
This learn module is divided into two sections.

- Section 1 describe the fifth phase in the deployment, *Calibrate and fine-tune*, and deals with calibrating and fine-tuning your sensor. It includes these units:
    - Unit 2 describes the general overview of the calibration and fine tuning phase of the sensor deployment.
    - Unit 3 describes the information and preparations you need to complete the exercise unit.
    - Unit 4 is the exercise unit to practice the calibration and fine tuning activities.
<!-- I think it is better to only have section 2 written about here?? What do you think? LW -->
- Section 2 describe the sixth phase in the deployment, *Baseline learning*, and deals with triaging the alerts. It includes these units:
    - Unit 5 describes the general overview of the baseline learning phase of the sensor deployment.
    - Unit 6 describes the information and preparations you need to complete the exercise unit.
    - Unit 7 is the exercise unit to practive the alert triaging activities to create the baseline.

## Learning mode

When the sensor first connects to Defender for IoT it enters the learning phase where the sensor learns to identify the difference between suspicious, harmful network traffic and safe traffic. creates alerts for them. When this traffic is identified in the future, alerts are sent to Defender for IoT, and you're able to contain and protect your devices. You must monitor these alerts and in some cases adjust them to be more accurate. These alerts form the baseline of OT alerts for tracking activity when the system moves to the *operational* mode. This process can take anywhere from a few days to several weeks, depending on the complexity and size of your network.
<!--Over a period of weeks Defender for IoT reaches a mature stage and doesn't need regular assessment, and then ends the *Learning* mode and moves to the *operational* mode. -->check and adjust this....
Once the sensor is set up and sending data, Defender for IoT starts to identify normal and irregular traffic flow within the network. This state is called the learning mode, where Defender for IoT identifies regular file transfers or data flows between devices. This regular activity is logged and won't trigger an alert in the future. Any network traffic that doesn't match these, triggers an alert.

## In this phase

### Triage alerts
check and go over this 
The new alerts, listed in Defender for IoT, are checked and in some cases you need to adjust their status. This way Defender for IoT learns which alerts are real cases of harmful traffic and which are normal, unrecognized traffic that can be added to the baseline. The learning process can take several weeks to complete.

As alerts arrive, you check that they're correctly assigned. In some cases during this phase, the alerts will be incorrect and you'll need to change the automatic settings so that the sensor learns that future traffic like this is safe. You might want to assign supression alerts to exclude minor alerts so that the alert page isnt filled with unwanted alerts.

In the early stages, you need to spend more time checking the alerts. Depending on the size and complexity of the system the learning mode could last from 2-6 weeks, and automatically turn offs when the sensor detects a decrease in newly detected alerts. However, you can also manually turn off the learning mode if you think that alerts produced accurately represent the network activity.

### End learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise should it be added to this unit?-->
The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. Alternatively, you can also turn off the learning mode manually when you see that the alerts accurately reflect your network activity. Going forward, anything that is new traffic creates an alert to be followed up with.

Even in *operational* mode, you could still receive new alerts, and must check and triage them as well. Some of these new alerts are for regular network traffic. Even though the sensor isn't in the Learning mode you can assign these inaccurate alerts a learning status so that the sensor adds them to the existing baseline alerts. This ensures that your alerts baseline is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.
<!-- possibly add short unit before summary just for ending learning and operational mode-->
## Outcome

When you complete the triage process, the **Alerts** page shows the updated status of the alerts.
In a real life scenario this triage process must be done each day until the level of alerts reduces to a 'reasonable' daily level<!-- ask ariel or meir what is a possible percentage, or at what stage the system automatically moves on? -->. The sensor now has a verified baseline of alerts that are considered safe and secure and won't trigger them.

Once the operational mode is enabled your deployment of the OT sensor to Defender for IoT is complete.
