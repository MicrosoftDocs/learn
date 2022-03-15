Microsoft suggests the following security recommendations for individuals and companies working on IoT solutions. Implementing these recommendations will help you fulfill your security obligations as described in Microsoft's shared responsibility model.

Some of the recommendations described below can be automatically monitored by Azure Security Center. Azure Security Center is the first line of defense in protecting your resources in Azure. It periodically analyzes the security state of your Azure resources to identify potential security vulnerabilities. It then provides you with recommendations on how to address them.

## General

:::row:::
  :::column:::
    **Recommendation**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
  :::column:::
    **Supported by ASC**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Stay up to date.
  :::column-end:::
  :::column:::
    Use the latest versions of supported platforms, programming languages, protocols, and frameworks.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Keep authentication keys safe.
  :::column-end:::
  :::column:::
    Keep the device IDs and their authentication keys physically safe after deployment. This will avoid a malicious device masquerading as a registered device.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Use device SDKs when possible.
  :::column-end:::
  :::column:::
    Device SDKs implement security features, such as, encryption, authentication, and so on, to assist you in developing a robust and secure device application. Microsoft's continued investment in the SDKs means that you will benefit as support for new security advancements are added.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::


## Identity and access management

:::row:::
  :::column:::
    **Recommendation**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
  :::column:::
    **Supported by ASC**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Define access control for the hub.
  :::column-end:::
  :::column:::
    Understand and define the type of access each component will have in your IoT Hub solution, based on the functionality. The allowed permissions are Registry Read, RegistryReadWrite, ServiceConnect, and DeviceConnect. Default shared access policies in your IoT hub can also help define the permissions for each component based on its role.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Define access control for backend services.
  :::column-end:::
  :::column:::
    Data ingested by your IoT Hub solution can be consumed by other Azure services such as Cosmos DB, Stream Analytics, App Service, Logic Apps, and Blob storage. Make sure to understand and allow appropriate access permissions as documented for these services.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::


## Data protection

:::row:::
  :::column:::
    **Recommendation**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
  :::column:::
    **Supported by ASC**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Secure device authentication.
  :::column-end:::
  :::column:::
    Ensure secure communication between your devices and your IoT hub, by using either a unique identity key or security token, or an on-device X.509 certificate for each device. Use the appropriate method to use security tokens based on the chosen protocol (MQTT, AMQP, or HTTPS).
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Secure device communication.
  :::column-end:::
  :::column:::
    IoT Hub secures the connection to the devices using Transport Layer Security (TLS) standard, supporting versions 1.2 and 1.0. Use TLS 1.2 to ensure maximum security.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Secure service communication.
  :::column-end:::
  :::column:::
    IoT Hub provides endpoints to connect to backend services such as Azure Storage or Event Hubs using only the TLS protocol, and no endpoint is exposed on an unencrypted channel. Once this data reaches these backend services for storage or analysis, make sure to employ appropriate security and encryption methods for that service, and protect sensitive information at the backend.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::


## Networking

:::row:::
  :::column:::
    **Recommendation**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
  :::column:::
    **Supported by ASC**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Protect access to your devices.
  :::column-end:::
  :::column:::
    Keep hardware ports in your devices to a bare minimum to avoid unwanted access. Additionally, build mechanisms to prevent or detect physical tampering of the device. Read IoT security best practices for details.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Build secure hardware.
  :::column-end:::
  :::column:::
    Incorporate security features such as encrypted storage, or Trusted Platform Module (TPM), to keep devices and infrastructure more secure. Keep the device operating system and drivers upgraded to latest versions, and if space permits, install antivirus and antimalware capabilities. Read IoT security architecture to understand how this can help mitigate several security threats.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::


## Monitoring

:::row:::
  :::column:::
    **Recommendation**
  :::column-end:::
  :::column:::
    **Comments**
  :::column-end:::
  :::column:::
    **Supported by ASC**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitor unauthorized access to your devices.
  :::column-end:::
  :::column:::
    Use your device operating system's logging feature to monitor any security breaches or physical tampering of the device or its ports.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitor your IoT solution from the cloud.
  :::column-end:::
  :::column:::
    Monitor the overall health of your IoT Hub solution using the metrics in Azure Monitor.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Set up diagnostics.
  :::column-end:::
  :::column:::
    Closely watch your operations by logging events in your solution, and then sending the diagnostic logs to Azure Monitor to get visibility into the performance. Read Monitor and diagnose problems in your IoT hub for more information.
  :::column-end:::
  :::column:::
    \-
  :::column-end:::
:::row-end:::
