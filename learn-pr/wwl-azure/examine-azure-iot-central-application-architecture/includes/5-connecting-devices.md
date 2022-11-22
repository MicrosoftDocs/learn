Before a device can exchange data with IoT Central, it must:

 -  Authenticate. Authentication with the IoT Central application uses either a shared access signature (SAS) token or an X.509 certificate. X.509 certificates are recommended in production environments.
 -  Register. Devices must be registered with the IoT Central application. You can view registered devices on the Devices page in the application.
 -  Associate with a device template. In an IoT Central application, device templates define the UI that operators use to view and manage connected devices.

## Device authentication

IoT Central uses the Azure IoT Hub Device Provisioning service (DPS) to manage the connection process. A device first connects to a DPS endpoint to retrieve the information it needs to connect to your application. Internally, your IoT Central application uses an IoT hub to handle device connectivity. Using DPS enables:

 -  IoT Central to support onboarding and connecting devices at scale.
 -  You to generate device credentials and configure the devices offline without registering the devices through IoT Central UI.
 -  You to use your own device IDs to register devices in IoT Central. Using your own device IDs simplifies integration with existing back-office systems.
 -  A single, consistent way to connect devices to IoT Central.

### X.509 group enrollment

In a production environment, using X.509 certificates is the recommended device authentication mechanism for IoT Central.

IoT devices can be connected to IoT Central using X.509 certificates as follows:

1.  Create an enrollment group that uses the Certificates (X.509) attestation type.
2.  Add and verify an intermediate or root X.509 certificate in the enrollment group.
3.  Generate a leaf certificate from the root or intermediate certificate in the enrollment group. Send the leaf certificate from the device when it connects to your application.

For more detailed information, see: [How to connect devices with X.509 certificates to IoT Central Application](/azure/iot-central/core/how-to-connect-devices-x509)

### SAS group enrollment

To connect a device with device SAS key to your application:

 -  Create an enrollment group that uses the Shared Access Signature (SAS) attestation type.
 -  Copy the group primary or secondary key from the enrollment group.
 -  Generate a device key from the group key. This can be accomplished using the following Azure CLI command:
    
    ```azurecli
    az iot central device compute-device-key --primary-key <enrollment group primary key> --device-id <device ID>
    ```

 -  Use the generated device key when the device connects to your IoT Central application.

### Individual enrollment

This approach is useful when you're experimenting with IoT Central or testing devices. You can use the device connection information from your IoT Central application to connect a device to your IoT Central application using the Device Provisioning Service (DPS).

IoT Central supports the following attestation mechanisms for individual enrollments:

 -  Shared Access Signature (SAS) : Shared Access Signature attestation is a simple approach to authenticating a device with the DPS instance. To create an individual enrollment that uses symmetric keys, open the Device connection page for the device, select Individual enrollment as the connection method, and Shared access signature (SAS) as the mechanism. Enter base64 encoded primary and secondary keys, and save your changes. Use the ID scope, Device ID, and either the primary or secondary key to connect your device.
 -  X.509 certificates: To create an individual enrollment with X.509 certificates, open the Device Connection page, select Individual enrollment as the connection method, and Certificates (X.509) as the mechanism. Device certificates used with an individual enrollment entry have a requirement that the issuer and subject CN are set to the device ID.
 -  Trusted Platform Module (TPM) attestation: A TPM is a type of hardware security module. Using a TPM is one of the most secure ways to connect a device. This article assumes you're using a discrete, firmware, or integrated TPM. Software emulated TPMs are well suited for prototyping or testing, but they don't provide the same level of security as discrete, firmware, or integrated TPMs. Don't use software TPMs in production. To create an individual enrollment that uses a TPM, open the Device Connection page, select Individual enrollment as the connection method, and TPM as the mechanism. Enter the TPM endorsement key and save the device connection information.

## Device registration

Before a device can connect to an IoT Central application, it must be registered in the application:

 -  Devices can automatically register themselves when they first connect. To use this option, you must use either X.509 group enrollment or SAS group enrollment.
 -  An operator can import a CSV file to bulk register a list of devices in the application.
 -  An operator can manually register an individual device on the Devices page in the application.

IoT Central enables OEMs to mass manufacture devices that can register themselves automatically. An OEM generates suitable device credentials, and configures the devices in the factory. When a customer turns on a device for the first time, it connects to DPS, which then automatically connects the device to the correct IoT Central application. Optionally, you can require an operator to approve the device before it starts sending data to the application.

IoT Central supports the following two device registration scenarios:

 -  Automatic registration. The device is registered automatically when it first connects. This scenario enables OEMs to mass manufacture devices that can connect without first being registered. An OEM generates suitable device credentials, and configures the devices in the factory. Optionally, you can require an operator to approve the device before it starts sending data. This scenario requires you to configure an X.509 or SAS group enrollment in your application.
 -  Manual registration. Operators either register individual devices on the Devices page, or import a CSV file to bulk register devices. In this scenario you can use X.509 or SAS group enrollment, or X.509 or SAS individual enrollment.

### Automatically register devices that use X.509 certificates

1.  Generate the leaf-certificates for your devices using the root or intermediate certificate you added to your X.509 enrollment group. Use the device IDs as the CNAME in the leaf certificates. A device ID can contain letters, numbers, and the - character.
2.  As an OEM, flash each device with a device ID, a generated X.509 leaf-certificate, and the application ID scope value. The device code should also send the model ID of the device model it implements.
3.  When you switch on a device, it first connects to DPS to retrieve its IoT Central connection information.
4.  The device uses the information from DPS to connect to, and register with, your IoT Central application.

The IoT Central application uses the model ID sent by the device to associate the registered device with a device template.

### Automatically register devices that use SAS tokens

1.  Copy the group primary key from the SAS-IoT-Devices enrollment group.
2.  Use the az iot central device compute-device-key command to generate the device SAS keys.
3.  As an OEM, flash each device with the device ID, the generated device SAS key, and the application ID scope value. The device code should also send the model ID of the device model it implements.
4.  When you switch on a device, it first connects to DPS to retrieve its IoT Central registration information.
5.  The device uses the information from DPS to connect to, and register with, your IoT Central application.

The IoT Central application uses the model ID sent by the device to associate the registered device with a device template.

### Bulk register devices in advance

To register a large number of devices with your IoT Central application, use a CSV file to import device IDs and device names.

If your devices use SAS tokens to authenticate, export a CSV file from your IoT Central application. The exported CSV file includes the device IDs and the SAS keys.

If your devices use X.509 certificates to authenticate, generate X.509 leaf certificates for your devices using the root or intermediate certificate in you uploaded to your X.509 enrollment group. Use the device IDs you imported as the CNAME value in the leaf certificates.

Devices must use the ID Scope value for your application and send a model ID when they connect.

### Register a single device in advance

This approach is useful when you're experimenting with IoT Central or testing devices. Select + New on the Devices page to register an individual device. You can use the device connection SAS keys to connect the device to your IoT Central application. Copy the device SAS key from the connection information for a registered device.

## Associate a device with a device template

IoT Central automatically associates a device with a device template when the device connects. A device sends a model ID when it connects. IoT Central uses the model ID to identify the device template for that specific device model. The discovery process works as follows:

1.  If the device template is already published in the IoT Central application, the device is associated with the device template.
2.  If the device template isn't already published in the IoT Central application, IoT Central looks for the device model in the public model repository. If IoT Central finds the model, it uses it to generate a basic device template.
3.  If IoT Central doesn't find the model in the public model repository, the device is marked as Unassociated. An operator can either create a device template for the device and then migrate the unassociated device to the new device template, or autogenerate a device template based on the data the device sends.
