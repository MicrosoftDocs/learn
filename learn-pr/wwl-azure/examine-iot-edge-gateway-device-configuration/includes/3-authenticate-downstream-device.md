In a transparent gateway scenario, downstream devices (sometimes called leaf devices or child devices) need identities in IoT Hub like any other device.

There are three general steps to set up a successful transparent gateway connection.

 -  The gateway device needs to be able to securely connect to downstream devices, receive communications from downstream devices, and route messages to the proper destination. For more information, see Configure an IoT Edge device to act as a transparent gateway.
 -  The downstream device needs to have a device identity to be able to authenticate with IoT Hub, and know to communicate through its gateway device.
 -  The downstream device needs to be able to securely connect to its gateway device. For more information, see Connect a downstream device to an Azure IoT Edge gateway.

Downstream devices can authenticate with IoT Hub using one of three methods: symmetric keys (sometimes referred to as shared access keys), X.509 self-signed certificates, or X.509 certificate authority (CA) signed certificates. The authentication steps are similar to the steps used to set up any non-IoT-Edge device with IoT Hub, with small differences to declare the gateway relationship.

## Prerequisites

An IoT Edge device configured to act as a transparent gateway.

If you're using X.509 authentication for your downstream device, you need to use the same certificate generating script that you used to configure the transparent gateway.

> [!NOTE]
> In the instructional materials that follow, we use a gateway hostname to create the certificates, and then refer to the gateway hostname in the connection string of the downstream devices. The gateway hostname is declared in the "hostname" parameter of the config.yaml file on the IoT Edge gateway device. The gateway hostname needs to be resolvable to an IP Address, either using DNS or a host file entry.

## Symmetric key authentication

Symmetric key authentication, or shared access key authentication, is the simplest way to authenticate with IoT Hub. With symmetric key authentication, a base64 key is associated with your IoT device ID in IoT Hub. You include that key in your IoT applications so that your device can present it when it connects to IoT Hub.

### Create the device identity

Add a new IoT device in your IoT hub, using either the Azure portal, Azure CLI, or the IoT extension for Visual Studio Code. Remember that downstream devices need to be identified in IoT Hub as regular IoT device, not IoT Edge devices.

When you create the new device identity, provide the following information:

 -  Create an ID for your device.
 -  Select **Symmetric key** as the authentication type.
 -  Optionally, choose to **Set a parent device** and select the IoT Edge gateway device that this downstream device will connect through. This step is optional for symmetric key authentication, but it's recommended because setting a parent device enables offline capabilities for your downstream device. You can always update the device details to add or change the parent later.

:::image type="content" source="../media/m06-l03-edge-gateway-symmetric-key-portal-93d92342.png" alt-text="Screenshot that shows how to create a device identity that uses symmetric key authentication.":::


You can use the IoT extension for Azure CLI to complete the same operation. The following example creates a new IoT device with symmetric key authentication and assigns a parent device:

```cli
az iot hub device-identity create -n {iothub name} -d {device ID} --pd {gateway device ID}

```

### Connect to IoT Hub through a gateway

The same process is used to authenticate regular IoT devices to IoT Hub with symmetric keys also applies to downstream devices. The only difference is that you need to add a pointer to the gateway device to route the connection or, in offline scenarios, to handle the authentication on behalf of IoT Hub.

For symmetric key authentication, there's no more steps that you need to take on your device for it to authenticate with IoT Hub. You still need the certificates in place so that your downstream device can connect to its gateway device, as described in Connect a downstream device to an Azure IoT Edge gateway.

After creating an IoT device identity in the portal, you can retrieve its primary or secondary keys. One of these keys needs to be included in the connection string that you include in any application that communicates with IoT Hub. For symmetric key authentication, IoT Hub provides the fully formed connection string in the device details for your convenience. You need to add extra information about the gateway device to the connection string.

Symmetric key connection strings for downstream devices need the following components:

 -  The IoT hub that the device connects to: `Hostname={iothub name}.azure-devices.net`
 -  The device ID registered with the hub: `DeviceID={device ID}`
 -  Either the primary or secondary key: `SharedAccessKey={key}`
 -  The gateway device that the device connects through. Provide the hostname value from the IoT Edge gateway device's config.yaml file: `GatewayHostName={gateway hostname}`

All together, a complete connection string looks like:

`HostName=myiothub.azure-devices.net;DeviceId=myDownstreamDevice;SharedAccessKey=xxxyyyzzz;GatewayHostName=myGatewayDevice`

If you established a parent/child relationship for this downstream device, then you can simplify the connection string by calling the gateway directly as the connection host. For example:

`HostName=myGatewayDevice;DeviceId=myDownstreamDevice;SharedAccessKey=xxxyyyzzz`

## X.509 authentication

There are two ways to authenticate an IoT device using X.509 certificates. Whichever way you choose to authenticate, the steps to connect your device to IoT Hub are the same. Choose either self-signed or CA-signed certs for authentication, then continue to learn how to connect to IoT Hub.

### Create the device identity with X.509 self-signed certificates

For X.509 self-signed authentication, sometimes referred to as thumbprint authentication, you need to create new certificates to place on your IoT device. These certificates have a thumbprint in them that you share with IoT Hub for authentication.

The easiest way to test this scenario is to use the same machine that you used to create certificates for the transparent gateway.

That machine should already be set up with the right tool, root CA certificate, and intermediate CA certificate to create the IoT device certificates. You can copy the final certificates and their private keys over to your downstream device afterwards. Complete the following steps:

 -  Set up openssl on your machine.
 -  Clone the IoT Edge repo to access certificate creation scripts.
 -  Make a working directory called &lt;WRKDIR&gt; to hold the certificates.

The default certificates are meant for developing and testing, so only last 30 days.

You should have created a root CA certificate and an intermediate certificate.

1.  Navigate to your working directory in either a bash or PowerShell window.
2.  Create two certificates (primary and secondary) for the downstream device. Provide your device name and then the primary or secondary label. This information is used to name the files so that you can keep track of certificates for multiple devices. PowerShell
    
    ```PowerShell
    New-CACertsDevice "<device name>-primary"
    New-CACertsDevice "<device name>-secondary"
    
    ```
    
    Bash
    
    ```bash
    ./certGen.sh create_device_certificate "<device name>-primary"
    ./certGen.sh create_device_certificate "<device name>-secondary"
    
    ```
3.  Retrieve the SHA1 fingerprint (called a thumbprint in the IoT Hub interface) from each certificate, which is a 40 hexadecimal character string. Use the following openssl command to view the certificate and find the fingerprint: PowerShell / bash
    
    ```PowerShell
    openssl x509 -in <WORKDIR>/certs/iot-device-<device name>-primary.cert.pem -text -fingerprint | sed 's/[:]//g'
    
    ```
4.  Navigate to your IoT hub in the Azure portal and create a new IoT device identity with the following values:
     -  Select X.509 Self-Signed as the authentication type.
     -  Paste the hexadecimal strings that you copied from your device's primary and secondary certificates.
     -  Select Set a parent device and choose the IoT Edge gateway device that this downstream device will connect through. A parent device is required for X.509 authentication of a downstream device.:::image type="content" source="../media/m06-l03-edge-gateway-x509-self-signed-portal-5ce563d0.png" alt-text="Screenshot that shows how to create a device identity that uses X.509 self-signed certificate authentication.":::
    
5.  Copy the following files to any directory on your downstream device:
    
    ```
    <WRKDIR>\certs\azure-iot-test-only.root.ca.cert.pem
    <WRKDIR>\certs\iot-device-<device name>*.cert.pem
    <WRKDIR>\certs\iot-device-<device id>*.cert.pfx
    <WRKDIR>\certs\iot-device-<device name>*-full-chain.cert.pem
    <WRKDIR>\private\iot-device-<device name>*.key.pem
    
    ```
    
    You'll reference these files in the leaf device applications that connect to IoT Hub. You can use a service like Azure Key Vault or a function like Secure copy protocol to move the certificate files.

You can use the IoT extension for Azure CLI to complete the same device creation operation. The following example creates a new IoT device with X.509 self-signed authentication and assigns a parent device:

```cli
az iot hub device-identity create -n {iothub name} -d {device ID} --pd {gateway device ID} --am x509_thumbprint --ptp {primary thumbprint} --stp {secondary thumbprint}

```

### Create the device identity with X.509 CA signed certificates

For X.509 certificate authority (CA) signed authentication, you need a root CA certificate registered in IoT Hub that you use to sign certificates for your IoT device. Any device using a certificate that was issues by the root CA certificate or any of its intermediate certificates will be permitted to authenticate.

1.  Follow the instructions in the Register X.509 CA certificates to your IoT hub section of Set up X.509 security in your Azure IoT hub [Tutorial: Using Microsoft-supplied scripts to create test certificates](/azure/iot-hub/iot-hub-security-x509-get-started). In that section, you perform the following steps:
     -  Upload a root CA certificate. If you're using the certificates that you created in the transparent gateway article, upload &lt;WRKDIR&gt;/certs/azure-iot-test-only.root.ca.cert.pem as the root certificate file.
     -  Verify that you own that root CA certificate. You can verify possession with the cert tools in &lt;WRKDIR&gt;.PowerShell
    
    ```PowerShell
    New-CACertsVerificationCert "<verification code from Azure portal>"
    
    ```
    
    Bash
    
    ```bash
    ./certGen.sh create_verification_certificate <verification code from Azure portal>"
    
    ```
2.  Follow the instructions in the Create an X.509 device for your IoT hub section of Set up X.509 security in your Azure IoT hub. In that section, you perform the following steps:
     -  Add a new device. Provide a lowercase name for device ID, and choose the authentication type X.509 CA Signed.
     -  Set a parent device. For downstream devices, select Set a parent device and choose the IoT Edge gateway device that will provide the connection to IoT Hub.
3.  Create a certificate chain for your downstream device. Use the same root CA certificate that you uploaded to IoT Hub to make this chain. Use the same lowercase device ID that you gave to your device identity in the portal. PowerShell
    
    ```PowerShell
    New-CACertsDevice "<device id>"
    
    ```
    
    Bash
    
    ```bash
    ./certGen.sh create_device_certificate "<device id>"
    
    ```
4.  Copy the following files to any directory on your downstream device:
    
    ```
    <WRKDIR>\certs\azure-iot-test-only.root.ca.cert.pem
    <WRKDIR>\certs\iot-device-<device id>*.cert.pem
    <WRKDIR>\certs\iot-device-<device id>*.cert.pfx
    <WRKDIR>\certs\iot-device-<device id>*-full-chain.cert.pem
    <WRKDIR>\private\iot-device-<device id>*.key.pem
    
    ```
    
    You'll reference these files in the leaf device applications that connect to IoT Hub. You can use a service like Azure Key Vault or a function like Secure copy protocol to move the certificate files.

You can use the IoT extension for Azure CLI to complete the same device creation operation. The following example creates a new IoT device with X.509 CA signed authentication and assigns a parent device:

```cli
az iot hub device-identity create -n {iothub name} -d {device ID} --pd {gateway device ID} --am x509_ca

```

### Connect to IoT Hub through a gateway

Each Azure IoT SDK handles X.509 authentication a little differently. However, the same process is used to authenticate regular IoT devices to IoT Hub with X.509 certificates also applies to downstream devices. The only difference is that you need to add a pointer to the gateway device to route the connection or, in offline scenarios, to handle the authentication on behalf of IoT Hub. In general, you can follow the same X.509 authentication steps for all IoT Hub devices, then simply replace the value of Hostname in the connection string to be the hostname of your gateway device.

> [!IMPORTANT]
> The following code sample demonstrates how the IoT Hub SDKs use certificates to authenticate devices. In a production deployment, you should store all secrets like private or SAS keys in a hardware secure module (HSM).

For an example of a C\# program authenticating to IoT Hub with X.509 certificates, see Set up X.509 security in your Azure IoT hub [https://learn.microsoft.com/azure/iot-hub/iot-hub-security-x509-get-started](/azure/iot-hub/iot-hub-security-x509-get-started). Some of the key lines of that sample are included here to demonstrate the authentication process.

When declaring the hostname for your DeviceClient instance, use the IoT Edge gateway device's hostname. The hostname can be found in the gateway device's config.yaml file.

If you're using the test certificates provided by the IoT Edge git repository, the key to the certificates is **1234**.

```
try
{
    var cert = new X509Certificate2(@"<absolute-path-to-your-device-pfx-file>", "1234");
    var auth = new DeviceAuthenticationWithX509Certificate("<device-id>", cert);
    var deviceClient = DeviceClient.Create("<gateway hostname>", auth, TransportType.Amqp_Tcp_Only);

    if (deviceClient == null)
    {
        Console.WriteLine("Failed to create DeviceClient!");
    }
    else
    {
        Console.WriteLine("Successfully created DeviceClient!");
        SendEvent(deviceClient).Wait();
    }

    Console.WriteLine("Exiting...\n");
}
catch (Exception ex)
{
    Console.WriteLine("Error in sample: {0}", ex.Message);
}

```

> [!NOTE]
> You may be curious as to why the **X509Certificate2** type is used rather than an **X509Certificate**. The **X509Certificate** is an earlier implementation and is limited in its functionality. The **X509Certificate2** is a subclass of **X509Certificate** with more functionality that supports both V2 and V3 of the X509 standard.

Code samples for other coding languages are available as follows:

:::row:::
  :::column:::
    **Language**
  :::column-end:::
  :::column:::
    **Description / Link**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    iotedge\_downstream\_device\_sample
[https://github.com/Azure/azure-iot-sdk-c/tree/main/iothub\_client/samples/iotedge\_downstream\_device\_sample](https://github.com/Azure/azure-iot-sdk-c/tree/main/iothub_client/samples/iotedge_downstream_device_sample)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Node.js
  :::column-end:::
  :::column:::
    simple\_sample\_device\_x509.js
https://github.com/Azure/azure-iot-sdk-node/blob/main/device/samples/javascript/simple_sample_device_x509.js
  :::column-end:::
:::row-end:::
