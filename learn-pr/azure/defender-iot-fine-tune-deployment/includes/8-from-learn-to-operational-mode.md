Your sensor is now fine-tuned, calibrated and a baseline of safe network traffic was made so that only suspicious, harmful network traffic produces alerts. Once the learning stage/phase is complete, Defender for IoT moves to the operational stage where it monitors your network traffic using the alerts baseline to filter the traffic. New alerts still appear, but occur less regularly, and you apply the triage process to them.

## End learning mode

In the early stages of the learning mode, you need to spend more time checking the alerts. The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. However, you can also manually turn off the learning mode if you think that alerts produced accurately represent the network activity. Moving forward, anything that is new traffic creates an alert to be followed up with.

Even in *operational* mode, you could still receive new alerts, and must check and triage them as well. Some of these new alerts are for regular network traffic. Even though the sensor isn't in the Learning mode you can assign these inaccurate alerts a learning status so that the sensor adds them to the existing baseline alerts. This ensures that your alerts baseline is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.
<!-- check the learning mode, phrase, check in other docs. -->
## Manually end Learning mode

In a real life scenario, this triage process must be done daily until the level of alerts reduces to a 'reasonable' daily level.<!-- ask ariel or meir what is a possible percentage, or at what stage the system automatically moves on? -->
Over time, Defender for IoT learns to identify suspicious traffic and stops sending false alerts and automatically switches to operational mode. However, you can turn off the *Learn* mode manually, if you think the level of alerts drops to an acceptable level.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or unrecognized network traffic trigger an alert, which is assessed like other alerts.

## Operational mode

When the sensor is in learning mode, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as a recognized part of your system. Once the learning mode is complete, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

Even after *Learning* mode is turned off, and *operational* mode starts traffic can be tracked. Activating the *Smart IT Learning*, found under **Network modeling**, makes Defender for IoT send alerts when new suspicious traffic is tracked.

## Check your work

The **System settings** shows that the learning phase is enabled.

Once the operational mode is enabled your deployment of the OT sensor to Defender for IoT is complete.
