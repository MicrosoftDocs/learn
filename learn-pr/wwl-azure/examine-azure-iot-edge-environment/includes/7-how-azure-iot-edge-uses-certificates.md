IoT Edge certificates are used for the modules and downstream IoT devices to verify the identity and legitimacy of the IoT Edge hub runtime module that they connect to. These verifications enable a TLS (transport layer security) secure connection between the runtime, the modules, and the IoT devices. Like IoT Hub itself, IoT Edge requires a secure and encrypted connection from IoT downstream (or leaf) devices and IoT Edge modules.

To establish a secure TLS connection, the IoT Edge hub module presents a server certificate chain to connecting clients in order for them to verify its identity.

> [!IMPORTANT]
> The IoT Edge certificates discussed in this topic and the Azure IoT Hub certificates that the hub uses to authenticate devices are two different things. This topic discusses the certificates that are used to secure connections between the different components on an IoT Edge device or between an IoT Edge device and any leaf devices. You may also use certificates to authenticate your IoT Edge device to IoT Hub. Those authentication certificates are different, and are not discussed here.

## IoT Edge certificates

There are two common scenarios for setting up certificates on an IoT Edge device. Sometimes the end user, or operator, of a device purchases a generic device made by a manufacturer then manages the certificates themselves. Other times, the manufacturer works under contract to build a custom device for the operator and does some initial certificate signing before handing off the device. The IoT Edge certificate design attempts to take both scenarios into account.

The following figure illustrates IoT Edge's usage of certificates. There may be zero, one, or many intermediate signing certificates between the root CA certificate and the device CA certificate, depending on the number of entities involved. Here we show one case.

:::image type="content" source="../media/m06-l01-iot-edge-edge-certs-general-july2022-a0d39603.png" alt-text="Diagram that illustrates how the IoT Edge uses certificates.":::


### Certificate authority

The certificate authority, or 'CA' for short, is an entity that issues digital certificates. A certificate authority acts as a trusted third party between the owner, and the receiver of the certificate. A digital certificate certifies the ownership of a public key by the receiver of the certificate. The certificate chain of trust works by initially issuing a root certificate, which is the basis for trust in all certificates issued by the authority. Afterwards, the owner can use the root certificate to issue more intermediate certificates ('leaf' certificates).

### Root CA certificate

A root CA certificate is the root of trust of the entire process. In production scenarios, this CA certificate can be purchased from a trusted commercial certificate authority like Baltimore, Verisign, or DigiCert. Should you have complete control over the devices connecting to your IoT Edge devices, it's possible to use a corporate level certificate authority. In either event, the entire certificate chain from the IoT Edge hub up rolls up to it, so the leaf IoT devices must trust the root certificate. You can store the root CA certificate either in the trusted root certificate authority store, or provide the certificate details in your application code.

### Intermediate certificates

In a typical manufacturing process for creating secure devices, root CA certificates are rarely used directly, primarily because of the risk of leakage or exposure. The root CA certificate creates and digitally signs one or more intermediate CA certificates. There may only be one, or there may be a chain of these intermediate certificates. Scenarios that would require a chain of intermediate certificates include:

 -  A hierarchy of departments within a manufacturer.
 -  Multiple companies involved serially in the production of a device.
 -  A customer buying a root CA and deriving a signing certificate for the manufacturer to sign the devices they make on that customer's behalf.

In any case, the manufacturer uses an intermediate CA certificate at the end of this chain to sign the device CA certificate placed on the end device. Generally, these intermediate certificates are closely guarded at the manufacturing plant. They undergo strict processes, both physical and electronic for their usage.

### Edge CA certificate

The edge (device) CA certificate is generated from and signed by the final intermediate CA certificate in the process. This certificate is installed on the IoT Edge device itself, preferably in secure storage such as a hardware security module (HSM). In addition, an edge CA certificate uniquely identifies an IoT Edge device. The edge CA certificate can sign other certificates.

### IoT Edge hub server certificate

The IoT Edge hub server certificate is the actual certificate presented to leaf devices and modules for identity verification during establishment of the TLS connection required by IoT Edge. This certificate presents the full chain of signing certificates used to generate it up to the root CA certificate, which the leaf IoT device must trust. When generated by IoT Edge, the common name (CN), of this IoT Edge hub certificate is set to the 'hostname' property in the config file after conversion to lower case.

## Production implications

A reasonable question might be "why does IoT Edge need the 'workload CA' extra certificate? Couldn't it use the device CA certificate to directly generate the IoT Edge hub server certificate?". Technically, it could. However, the purpose of this "workload" intermediate certificate is to separate concerns between the device manufacturer and the device operator. Imagine a scenario where an IoT Edge device is sold or transferred from one customer to another. You would likely want the device CA certificate provided by the manufacturer to be immutable. However, the "workload" certificates specific to operation of the device should be wiped and recreated for the new deployment.

Because manufacturing and operation processes are separated, consider the following implications when preparing production devices:

 -  With any certificate-based process, the root CA certificate and all intermediate CA certificates should be secured and monitored during the entire process of rolling out an IoT Edge device. The IoT Edge device manufacturer should have strong processes in place for proper storage and usage of their intermediate certificates. In addition, the device CA certificate should be kept in as secure storage as possible on the device itself, preferably a hardware security module.
 -  The IoT Edge hub server certificate is presented by IoT Edge hub to the connecting client devices and modules. The common name (CN) of the device CA certificate must not be the same as the "hostname" that will be used in the config file on the IoT Edge device. The name used by clients to connect to IoT Edge (for example, via the GatewayHostName parameter of the connection string or the CONNECT command in MQTT) can't be the same as the common name used in the device CA certificate. This restriction is because the IoT Edge hub presents its entire certificate chain for verification by clients. If the IoT Edge hub server certificate and the device CA certificate both have the same CN, you get in a verification loop and the certificate invalidates.
 -  Because the device CA certificate is used by the IoT Edge security daemon to generate the final IoT Edge certificates, it must itself be a signing certificate, meaning it has certificate signing capabilities. Applying "V3 Basic constraints CA:True" to the device CA certificate automatically sets up the required key usage properties.

## Dev/Test implications

To ease development and test scenarios, Microsoft provides a set of convenience scripts for generating non-production certificates suitable for IoT Edge in the transparent gateway scenario.

These scripts generate certificates that follow the certificate chain structure explained in this article. The following commands generate the "root CA certificate" and a single "intermediate CA certificate".

Bash

```bash
./certGen.sh create_root_and_intermediate

```

PowerShell

```Powershell
New-CACertsCertChain rsa

```

Likewise, these commands generate the "Device CA Certificate".

Bash

```bash
./certGen.sh create_edge_device_ca_certificate "<gateway device name>"

```

PowerShell

```Powershell
New-CACertsEdgeDeviceCA "<gateway device name>"

```

> [!NOTE]
> The "gateway" parameter passed into those scripts should not be the same as the "hostname" parameter in config.yaml. The scripts help you avoid any issues by appending a ".ca" string to the "gateway" to prevent the name collision in case a user sets up IoT Edge using the same name in both places. However, it's good practice to avoid using the same name.

> [!TIP]
> To connect your IoT "leaf" devices and applications that use our IoT device SDK through IoT Edge, you must add the optional GatewayHostName parameter on to the end of the device's connection string. When the Edge Hub Server Certificate is generated, it is based on a lowercase version of the hostname from config file, therefore, for the names to match and the TLS certificate verification to succeed, you should enter the GatewayHostName parameter in lower case.

## Example of IoT Edge certificate hierarchy

To illustrate an example of this certificate path, the following screenshot is from a working IoT Edge device set up as a transparent gateway. OpenSSL is used to connect to the IoT Edge hub, validate, and dump out the certificates.

:::image type="content" source="../media/m06-l01-iot-edge-iot-edge-cert-chain-july2022-854acc7a.png" alt-text="Screenshot that shows an example of the certificate path for an IoT Edge device.":::


You can see the hierarchy of certificate depth represented in the screenshot:

:::row:::
  :::column:::
    Root CA Certificate
  :::column-end:::
  :::column:::
    Azure IoT Hub CA Cert Test Only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Intermediate CA Certificate
  :::column-end:::
  :::column:::
    Azure IoT Hub intermediate certification test only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Edge CA Certificate
  :::column-end:::
  :::column:::
    `iotgateway.ca` ("iotgateway" was passed in as the &lt; gateway host name &gt; to the convenience scripts).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge Hub Server Certificate
  :::column-end:::
  :::column:::
    `iotedgegw.local` (matches the 'hostname' from config.yaml).
  :::column-end:::
:::row-end:::
