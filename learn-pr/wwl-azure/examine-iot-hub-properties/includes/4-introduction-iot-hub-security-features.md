IoT Hub uses a combination of authentication and access control permissions to help protect your IoT solution.

There are three different ways for controlling access to IoT Hub:

 -  Azure Active Directory (Azure AD) integration for service APIs. Azure provides identity-based authentication with Azure AD and fine-grained authorization with Azure role-based access control (Azure RBAC). Azure AD and RBAC integration is supported for IoT hub service APIs only.
 -  Shared access signatures let you group permissions and grant them to applications using access keys and signed security tokens.
 -  Per-device security credentials. Each IoT Hub contains an identity registry. For each device in this identity registry, you can configure security credentials that grant DeviceConnect permissions scoped to the device's endpoints.

## Access control and permissions

Use shared access policies for IoT hub-level access, and use the individual device credentials to scope access to that device only.

IoT hub-level shared access policies can grant any combination of permissions. You can define policies in the Azure portal, programmatically by using the IoT Hub Resource REST APIs, or using the az iot hub policy CLI. A newly created IoT hub has the following default policies:

:::row:::
  :::column:::
    **Shared Access Policy**
  :::column-end:::
  :::column:::
    **Permissions**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothubowner
  :::column-end:::
  :::column:::
    All permission
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    service
  :::column-end:::
  :::column:::
    ServiceConnect permissions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    device
  :::column-end:::
  :::column:::
    DeviceConnect permissions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    registryRead
  :::column-end:::
  :::column:::
    RegistryRead permissions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    registryReadWrite
  :::column-end:::
  :::column:::
    RegistryRead and RegistryWrite permissions
  :::column-end:::
:::row-end:::


For example, in a typical IoT solution:

 -  The device management component uses the registryReadWrite policy.
 -  The event processor component uses the service policy.
 -  The run-time device business logic component uses the service policy.
 -  Individual devices connect using credentials stored in the IoT hub's identity registry.

## Authentication

Azure IoT Hub grants access to endpoints by verifying a token against the shared access policies and identity registry security credentials. Keep in mind that security credentials, such as symmetric keys, should never be sent over the wire.

## Scope IoT hub-level credentials

You can scope IoT hub-level security policies by creating tokens with a restricted resource URI. For example, the endpoint to send device-to-cloud messages from a device is `/devices/{deviceId}/messages/events`. You can also use an IoT hub-level shared access policy with DeviceConnect permissions to sign a token whose resourceURI is `/devices/{deviceId}`. This approach creates a token that is only usable to send messages on behalf of device deviceId.

## Security tokens

IoT Hub uses security tokens to authenticate devices and services to avoid sending keys on the wire. Additionally, security tokens are limited in time validity and scope. Azure IoT SDKs automatically generate tokens without requiring any special configuration. Some scenarios do require you to generate and use security tokens directly. Such scenarios include:

 -  The direct use of the MQTT, AMQP, or HTTPS surfaces.
 -  The implementation of the token service pattern, as explained in Custom device authentication.

IoT Hub also allows devices to authenticate with IoT Hub using X.509 certificates.

## Supported X.509 certificates

You can use any X.509 certificate to authenticate a device with IoT Hub by uploading either a certificate thumbprint or a certificate authority (CA) to Azure IoT Hub. Authentication using certificate thumbprints only verifies that the presented thumbprint matches the configured thumbprint. Authentication using certificate authority validates the certificate chain.

Supported certificates include:

 -  An existing X.509 certificate. A device may already have an X.509 certificate associated with it. The device can use this certificate to authenticate with IoT Hub. Works with either thumbprint or CA authentication.
 -  CA-signed X.509 certificate. To identify a device and authenticate it with IoT Hub, you can use an X.509 certificate generated and signed by a Certification Authority (CA). Works with either thumbprint or CA authentication.
 -  A self-generated and self-signed X-509 certificate. A device manufacturer or in-house deployer can generate these certificates and store the corresponding private key (and certificate) on the device. You can use tools such as OpenSSL and Windows SelfSignedCertificate utility for this purpose. Only works with thumbprint authentication.

A device may either use an X.509 certificate or a security token for authentication, but not both.
