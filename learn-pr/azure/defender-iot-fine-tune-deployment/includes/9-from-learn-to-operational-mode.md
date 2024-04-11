Your sensor is now fine-tuned so that the devices are correctly identified, configured, and located within the device map and system hierarchy. The final action for setting up the sensor is to triage the alerts that are listed in Microsoft Defender for IoT during the *Learning* mode.
unit 5:
Once the learning phase is complete, Defender for IoT moves to the operational stage with an accurate baseline of alerts to work from and protect your devices. New alerts still appear, but occur less regularly, and you apply the triage process to them. <!-- is this all out of the scope of the LM? Probably-->  

### End learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise should it be added to this unit?-->
The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. Alternatively, you can also turn off the learning mode manually when you see that the alerts accurately reflect your network activity. Going forward, anything that is new traffic creates an alert to be followed up with.

Even in *operational* mode, you could still receive new alerts, and must check and triage them as well. Some of these new alerts are for regular network traffic. Even though the sensor isn't in the Learning mode you can assign these inaccurate alerts a learning status so that the sensor adds them to the existing baseline alerts. This ensures that your alerts baseline is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.
<!-- possibly add short unit before summary just for ending learning and operational mode-->

## End Learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise it should be added to this unit. LW -->
After a week or two, Defender for IoT learns to identify suspicious traffic and not send false alerts and then you can turn off the *Learn* mode.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or traffic trigger an alert, which is assessed like other alerts.

## Check your work

When you complete the triage process, the **Alerts** page shows the updated status of the alerts.

from 5:
When you complete the triage process and the operational mode is enabled, your deployment of the OT sensor to Defender for IoT is complete. The sensor now has a verified baseline of alerts and understands the types of traffic that are considered safe and secure. 

In the early stages, you need to spend more time checking the alerts. Depending on the size and complexity of the system the learning mode could last from 2-6 weeks, and automatically turn offs when the sensor detects a decrease in newly detected alerts. However, you can also manually turn off the learning mode if you think that alerts produced accurately represent the network activity.

from unit 3
## Operational mode

When the sensor first receives network traffic, it enters a state called *Learning* mode. While in *learning* mode, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as a recognized part of your system. Once the learning mode is complete, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

Even after *Learning* mode is turned off, and *operational* mode starts traffic can be tracked. Activating the *Smart IT Learning* makes Defender for IoT send alerts when new suspicious traffic is tracked.

In a real life scenario this triage process must be done daily until the level of alerts reduces to a 'reasonable' daily level<!-- ask ariel or meir what is a possible percentage, or at what stage the system automatically moves on? -->.

Once the operational mode is enabled your deployment of the OT sensor to Defender for IoT is complete.
