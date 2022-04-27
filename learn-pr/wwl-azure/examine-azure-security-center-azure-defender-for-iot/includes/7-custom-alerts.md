Using custom security groups and alerts, takes full advantage of the end-to-end security information and categorical device knowledge to ensure better security across your IoT solution.

## Why use custom alerts?

You know your IoT devices best.

For customers who fully understand their expected device behavior, Azure Defender for IoT allows you to translate this understanding into a device behavior policy and alert on any deviation from expected, normal behavior.

## Device security groups

Security groups enable you to define logical groups of devices, and manage their security state in a centralized way.

These groups can represent devices with specific hardware, devices deployed in a certain location, or any other group suitable to your specific needs.

Device security groups are specified by using a device twin tag property named **SecurityGroup**. By default, each IoT solution on IoT Hub has one security group named **default**. Change the value assigned to the **SecurityGroup** property to change the security group of a device. You can create device security groups using **Settings** in the **Security** section of your IoT Hub menu.

Here is an example using a security group tag:

```
{
  "deviceId": "VM-Contoso12",
  "etag": "AAAAAAAAAAM=",
  "deviceEtag": "ODA1BzA5QjM2",
  "status": "enabled",
  "statusUpdateTime": "0001-01-01T00:00:00",
  "connectionState": "Disconnected",
  "lastActivityTime": "0001-01-01T00:00:00",
  "cloudToDeviceMessageCount": 0,
  "authenticationType": "sas",
  "x509Thumbprint": {
    "primaryThumbprint": null,
    "secondaryThumbprint": null
  },
  "version": 4,
  "tags": {
    "SecurityGroup": "default"
  },

```

Use security groups to group your devices into logical categories. After creating the groups, assign them to the custom alerts of your choice, for the most effective end-to-end IoT security solution.

## Customize an alert

1.  Open your IoT Hub.
2.  In the **Security** section, select **Settings**, and then select **Custom Alerts**.
3.  Choose a security group you wish to apply the customization to.
4.  Select **Create custom alert rule**.
5.  Select a custom alert from the dropdown list.
6.  Edit the required properties, select **OK**.
7.  Make sure to select **SAVE**. Without saving the new alert, the alert is deleted the next time you close IoT Hub.
