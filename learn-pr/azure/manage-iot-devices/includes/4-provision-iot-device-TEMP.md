Now that you have an understanding of how Azure IoT Hub collects data from IoT devices such as the Raspberry Pi you can now move forward to provision other IoT devices to send their data as well. Completing setup of IoT devices in a small project (1-5 devices) can be done 1 to 1. Larger deployments would require a better method for provisioning.

Azure IoT Hub Device Provisioning Service enables customers to configure zero-touch device provisioning to Azure IoT Hub, and it brings the scalability of the cloud to what was once a lengthy one-at-a-time process. The process was designed with the challenges of the supply chain in mind, providing the infrastructure needed to provision millions of devices in a secure and scalable manner.

Automatic device provisioning with the Device Provisioning Service now supports all protocols that IoT Hub supports including HTTP, AMQP, MQTT, AMQP over websockets, and MQTT over websockets. This release also corresponds to expanded
SDK language support for both the device and client side.

## Link the Device Provisioning Service to an IoT hub

The next step is to link the Device Provisioning Service and IoT hub so that the IoT Hub Device Provisioning Service can register devices to that hub. The service can only provision devices to IoT hubs that have been linked to the Device Provisioning Service. Follow these steps.

1.  In the **All resources** page on the Azure portal, click the Device Provisioning Service instance you created previously.

2.  In the Device Provisioning Service page, click **Linked IoT hubs**.

3.  Click **Add**.

4.  In the **Add link to IoT hub** page, provide the following information, and click **Save**:

    - **Subscription:** Make sure the subscription that contains the IoT hub is selected. You can link to IoT hub that resides in a different subscription.

    - **IoT hub:** Choose the name of the IoT hub that you want to link with this Device Provisioning Service instance.

    - **Access Policy:** Select **iothubowner** as the credentials to use for establishing the link to the IoT hub.

![Link the hub name to link to the DPS in the portal](../media/ee6e78754a1d39d86de71fb6872723f3.png)

## Set the allocation policy on the Device Provisioning Service

The allocation policy is a IoT Hub Device Provisioning Service setting that determines how devices are assigned to an IoT hub. There are three supported allocation policies:

1. **Lowest latency**: Devices are provisioned to an IoT hub based on the hub with the lowest latency to the device.

2. **Evenly weighted distribution** (default): Linked IoT hubs are equally likely to have devices provisioned to them. This setting is the default. If you are provisioning devices to only one IoT hub, you can keep this setting.

3. **Static configuration via the enrollment list**: Specification of the desired IoT hub in the enrollment list takes priority over the Device Provisioning Service-level allocation policy.

To set the allocation policy, in the Device Provisioning Service page click **Manage allocation policy**. Make sure the allocation policy is set to **Evenly weighted distribution** (the default). If you make any changes, click **Save** when you are done.

![Manage allocation policy](../media/0c5fa5193156f17b4f5d64aab65a414d.png)

## Enroll the device

This step involves adding the device's unique security artifacts to the Device Provisioning Service. These security artifacts are based on the device's [Attestation mechanism](https://docs.microsoft.com/azure/iot-dps/concepts-device#attestation-mechanism)
as follows:

For TPM-based devices you need:

- The *Endorsement Key* that is unique to each TPM chip or simulation, which is obtained from the TPM chip manufacturer. Read the [Understand TPM Endorsement Key](https://docs.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/tpm-key-attestation#terminology) for more information.

- The *Registration ID* that is used to uniquely identify a device in the namespace/scope. This ID may or may not be the same as the device ID. The ID is mandatory for every device. For TPM-based devices, the registration ID may be derived from the TPM itself, for example, an SHA-256 hash of the TPM Endorsement Key.

![Enrollment information for TPM in the portal](../media/11db90b7128e1cf222a4da45de7cbac8.png)

For X.509 based devices you need:

- The [certificate issued to the X.509](https://docs.microsoft.com/windows/desktop/SecCertEnroll/about-x-509-public-key-certificates) chip or simulation, in the form of either a *.pem* or a *.cer* file. For individual enrollment, you need to use the per-device *signer         certificate* for your X.509 system, while for enrollment groups, you need to use the *root certificate*.

   ![Add individual enrollment for X.509 attestation in the portal](../media/8d56752f453f27e55dd15b7c894ae406.png)

There are two ways to enroll the device to the Device Provisioning Service:

- **Enrollment Groups** This represents a group of devices that share a specific attestation mechanism. We recommend using an enrollment group for a large number of devices, which share a desired initial configuration, or for devices all going to the same tenant. For more information on Identity attestation for enrollment groups, see [Security](https://docs.microsoft.com/azure/iot-dps/concepts-security#controlling-device-access-to-the-provisioning-service-with-x509-certificates).

   ![Add group enrollment for X.509 attestation in the portal](../media/4a9d9ea822887c70f1ff1e4b64b138f1.png)

- **Individual Enrollments** This represents an entry for a single device that may register with the Device Provisioning Service. Individual enrollments may use either x509 certificates or SAS tokens (in a real or virtual TPM) as attestation mechanisms. We recommend using individual enrollments for devices that require unique initial configurations, and devices that can only use SAS tokens via TPM or virtual TPM as the attestation mechanism. Individual enrollments may have the desired IoT hub device ID specified.

Now you enroll the device with your Device Provisioning Service instance, using the required security artifacts based on the device's attestation mechanism:

1. Sign in to the Azure portal, click on the **All resources** button on the left-hand menu and open your Device Provisioning service.

2. On the Device Provisioning Service summary blade, select **Manage enrollments**. Select either **Individual Enrollments** tab or the **Enrollment Groups** tab as per your device setup. Click the **Add** button at the top. Select **TPM** or **X.509** as the identity attestation *Mechanism*, and enter the appropriate security artifacts as discussed     previously. You may enter a new **IoT Hub device ID**. Once complete, click the **Save** button.

3. When the device is successfully enrolled, you should see it displayed in the portal as follows:

![Successful TPM enrollment in the portal](../media/cb277b2e5bc21cd02669775d536e89c0.png)

After enrollment, the provisioning service then waits for the device to boot and connect with it at any later point in time. When your device boots for the first time, the client SDK library interacts with your chip to extract the security
artifacts from the device, and verifies registration with your Device Provisioning service.

## Start the IoT device

Your IoT device can be a real device, or a simulated device. Since the IoT device has now been enrolled with a Device Provisioning Service instance, the device can now boot up, and call the provisioning service to be recognized using
the attestation mechanism. Once the provisioning service has recognized the device, it will be assigned to an IoT hub.

Simulated device examples, using both TPM and X.509 attestation, are included for C, Java, C\#, Node.js, and Python. For example, a simulated device using TPM and the [Azure IoT C SDK](https://github.com/Azure/azure-iot-sdk-c) would follow
the process covered in the [Simulate first boot sequence for a device](https://docs.microsoft.com/azure/iot-dps/quick-create-simulated-device#simulate-first-boot-sequence-for-the-device)
section. The same device using X.509 certificate attestation would refer to this [boot sequence](https://docs.microsoft.com/azure/iot-dps/quick-create-simulated-device-x509#simulate-first-boot-sequence-for-the-device)
section.

Refer to the [How-to guide for the MXChip Iot DevKit](https://docs.microsoft.com/azure/iot-dps/how-to-connect-mxchip-iot-devkit) as an example for a real device.

Start the device to allow your device's client application to start the registration with your Device Provisioning service.

## Verify the device is registered

Once your device boots, the following actions should take place:

1. The device sends a registration request to your Device Provisioning service.

2. For TPM devices, the Device Provisioning Service sends back a registration challenge to which your device responds.

3. On successful registration, the Device Provisioning Service sends the IoT hub URI, device ID, and the encrypted key back to the device.

4. The IoT Hub client application on the device then connects to your hub.

5. On successful connection to the hub, you should see the device appear in the IoT hub's **IoT Devices** explorer.

![Successful connection to hub in the portal](../media/12ea6da6eef9bf96be6bd80aa1721173.png)

<!--Reference links

-   <https://docs.microsoft.com/azure/iot-dps/tutorial-set-up-cloud>

-   <https://docs.microsoft.com/azure/iot-dps/tutorial-provision-device-to-hub>-->