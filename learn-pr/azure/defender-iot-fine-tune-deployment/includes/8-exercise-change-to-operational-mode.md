After the completing the triage process for a week or two you might see that the level of new, daily alerts has dropped to an acceptable level. Instead of waiting for Defender for IoT to automatically switch from *learning* to *operational* mode, you could manually turn off *learning* mode.

## Manually end learning mode

To manually change the sensor from learning mode to operational mode, complete the following steps.

1. In the Sensor, select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Disabled**.
1. Select **Close**.

## Check your work

Review the **System settings**. It should show that *learning* mode is disabled.

:::image type="content" source="../media/8-disable-learning-mode.png" lightbox="../media/8-disable-learning-mode.png" alt-text="Screenshot of the learning option disabled.":::

Once the operational mode is enabled your deployment of the OT sensor to Defender for IoT is complete.
