Your sensor is now fine-tuned, calibrated and a baseline of safe network traffic was made so that only suspicious, harmful network traffic produces alerts. All of this happens with the sensor in *learning* mode. Once *learning* mode is complete, Defender for IoT moves to the operational stage where it monitors your network traffic using the alerts baseline to filter the traffic. New alerts still appear, but occur less regularly, and you apply the triage process to them.

## End learning mode

In the early stages of *learning* mode, you need to spend more time checking the alerts. *Learning* mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. However, you can also manually turn off *learning* mode if you think that alerts produced accurately represent the network activity. Moving forward, anything that is new traffic creates an alert to be followed up with.

Even in *operational* mode, you could still receive new alerts, and must check and triage them as well. Some of these new alerts are for regular network traffic. Even though the sensor isn't in *learning* mode you can assign these inaccurate alerts a *learn* status so that the sensor adds them to the existing baseline alerts. This ensures that your alerts baseline is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.

## Manually end learning mode

Over time, Defender for IoT learns to identify suspicious traffic, so that most of the alerts are accurate and don't need triaging. Defender for IoT then automatically switches from *learning* mode to *operational* mode. However, you can turn off *learning* mode manually at any time, if you think the level of alerts drops to an acceptable level.

After this change, any new devices or unrecognized network traffic trigger an alert, which is assessed like other alerts.

## Operational mode

When the sensor is in *learning* mode, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as a recognized part of your system. Once *learning* mode is complete, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

Even after *learning* mode is turned off, and *operational* mode starts traffic can be tracked. Activating the *Smart IT Learning*, found under **Network modeling**, makes Defender for IoT send alerts when new suspicious traffic is tracked.
 