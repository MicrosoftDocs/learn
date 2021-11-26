The Azure Defender for IoT service provides a reference architecture for security agents. Security agents are able to log, process, aggregate, and deliver security data through IoT Hub.

Security agents are designed to work in a resource-constrained IoT environment. Security agents are also highly customizable in terms of the value they provide when compared to the resources they consume.

Security agents support the following features:

 -  They collect raw security events from the underlying Operating System (Linux, Windows).
 -  They aggregate raw security events to create messages that are delivered through IoT Hub.
 -  They authenticate with either an existing device identity or a dedicated module identity.
 -  They configure remotely through the use of the **azureiotsecurity** module twin.

A security module is required for each device onboarded to Azure Defender for IoT in the IoT Hub. To authenticate the device, Azure Defender for IoT can use one of two methods:

 -  SecurityModule option.
 -  Device option.

## Authentication methods

You can use the following information to help you choose between the two methods for authentication:

 -  SecurityModule authentication mode.

The agent is authenticated using the security module identity independently of the device identity. Use this authentication type if you would like the security agent to use a dedicated authentication method through security module (symmetric key only).

 -  Device authentication mode.

In this method, the security agent first authenticates with the device identity. After the initial authentication, the Azure Defender for IoT agent performs a REST call to the IoT Hub using the REST API with the authentication data of the device. The Azure Defender for IoT agent then requests the security module authentication method and data from the IoT Hub. In the final step, the Azure Defender for IoT agent performs an authentication against the Azure Defender for IoT module.

Use this authentication type if you would like the security agent to reuse an existing device authentication method (self-signed certificate or symmetric key).

## Authentication methods known limitations

SecurityModule authentication mode only supports symmetric key authentication.

CA-Signed certificate is not supported by Device authentication mode.

## Security agent installation parameters

When deploying a security agent, authentication details must be provided as arguments. These arguments are documented in the following table.

:::row:::
  :::column:::
    **Linux Parameter Name**
  :::column-end:::
  :::column:::
    **Windows Parameter Name**
  :::column-end:::
  :::column:::
    **Shorthand Parameter**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Options**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    authentication-identity
  :::column-end:::
  :::column:::
    AuthenticationIdentity
  :::column-end:::
  :::column:::
    aui
  :::column-end:::
  :::column:::
    Authentication identity.
  :::column-end:::
  :::column:::
    **SecurityModule** or **Device**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    authentication-method
  :::column-end:::
  :::column:::
    AuthenticationMethod
  :::column-end:::
  :::column:::
    aum
  :::column-end:::
  :::column:::
    Authentication method.
  :::column-end:::
  :::column:::
    **SymmetricKey** or **SelfSignedCertificate**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    file-path
  :::column-end:::
  :::column:::
    FilePath
  :::column-end:::
  :::column:::
    f
  :::column-end:::
  :::column:::
    Absolute full path for the file containing the certificate or the symmetric key.
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    host-name
  :::column-end:::
  :::column:::
    HostName
  :::column-end:::
  :::column:::
    hn
  :::column-end:::
  :::column:::
    FQDN of the IoT Hub.
  :::column-end:::
  :::column:::
    Example: ContosoIotHub.azure-devices.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    device-id
  :::column-end:::
  :::column:::
    DeviceId
  :::column-end:::
  :::column:::
    di
  :::column-end:::
  :::column:::
    Device ID.
  :::column-end:::
  :::column:::
    Example: MyDevice1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    certificate-location-kind
  :::column-end:::
  :::column:::
    CertificateLocationKind
  :::column-end:::
  :::column:::
    cl
  :::column-end:::
  :::column:::
    Certificate storage location.
  :::column-end:::
  :::column:::
    **LocalFile** or **Store**
  :::column-end:::
:::row-end:::


When using the install security agent script, the following configuration is performed automatically. To edit the security agent authentication manually, edit the config file.

## Change authentication method after deployment

When deploying a security agent with an installation script, a configuration file is automatically created.

To change authentication methods after deployment, manual editing of the configuration file is required.

### C\#-based security agent

Edit *Authentication.config* with the following parameters:

```xml
<Authentication>
  <add key="deviceId" value=""/>
  <add key="gatewayHostname" value=""/>
  <add key="filePath" value=""/>
  <add key="type" value=""/>
  <add key="identity" value=""/>
  <add key="certificateLocationKind" value="" />
</Authentication>

```

### C-based security agent

Edit *LocalConfiguration.json* with the following parameters:

```json
"Authentication" : {
"Identity" : "",
"AuthenticationMethod" : "",
"FilePath" : "",
"DeviceId" : "",
"HostName" : ""
}

```
