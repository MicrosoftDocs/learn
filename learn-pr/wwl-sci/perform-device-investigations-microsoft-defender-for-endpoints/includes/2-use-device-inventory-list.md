The Device inventory page shows a list of the devices in your network where alerts were generated. By default, the queue displays devices with alerts seen in the last 30 days.  Select a device to open the Device page.  The Device page is also accessed from various investigation pages like Incidents and Alerts.

:::image type="content" source="../media/device-list.png" alt-text="Device Inventory List":::

At a glance, you'll see information such as domain, risk level, OS platform, and other details for easy identification of devices most at risk.

During the onboarding process, the Devices list is gradually populated with devices as they begin to report sensor data. Use this view to track your onboarded endpoints as they come online, or download the complete endpoint list as a CSV file for offline analysis.

## Risk level

The risk level reflects the overall risk assessment of the device based on a combination of factors, including the types and severity of active alerts on the device. Resolving active alerts, approving remediation activities, and suppressing subsequent alerts can lower the risk level.

## Exposure level

The exposure level reflects the current exposure of the device based on the cumulative impact of its pending security recommendations. The possible levels are low, medium, and high. Low exposure means your devices are less vulnerable to exploitation.

If the exposure level says, "No data available," there are a few reasons why this may be the case:

- The device stopped reporting for more than 30 days – in that case, it is considered inactive, and the exposure isn't computed

- The device OS is not supported - see minimum requirements for Microsoft Defender for Endpoint

- The device has a stale agent (very unlikely)

## Health state

The following device health states:

- Active – Devices that are actively reporting sensor data to the service.

- Inactive – Devices that have stopped sending signals for more than seven days.

- Misconfigured – Devices that have impaired communications with service or are unable to send sensor data. Misconfigured devices can further be classified to:

  - No sensor data

  - Impaired communications

## Antivirus status

The antivirus status for Windows 10 devices only:

- Disabled - Virus & threat protection is turned off.

- Not reporting - Virus & threat protection is not reporting.

- Not updated - Virus & threat protection is not up to date.

