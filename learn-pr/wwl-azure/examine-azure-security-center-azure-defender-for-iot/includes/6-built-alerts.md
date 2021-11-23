Azure Defender for IoT continuously analyzes your IoT solution using advanced analytics and threat intelligence to alert you to malicious activity. In addition built-in alerts, you can create custom alerts based on your knowledge of expected behaviors. An alert acts as an indicator of potential compromise, and should be investigated and remediated.

The following list of built-in alerts can be triggered on your IoT Hub.

## Built-in alerts for IoT Hub

:::row:::
  :::column:::
    Alert types
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Suggested remediation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Medium** severity alerts
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    New certificate added to an IoT Hub.
  :::column-end:::
  :::column:::
    A certificate named '%\{DescCertificateName\}' was added to IoT Hub '%\{DescIoTHubName\}'. If this action was made by an unauthorized party, it may indicate malicious activity.
  :::column-end:::
  :::column:::
    1. Make sure the certificate was added by an authorized party.
2. If it was not added by an authorized party, remove the certificate and escalate the alert to the organizational security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Certificate deleted from an IoT Hub.
  :::column-end:::
  :::column:::
    A certificate named '%\{DescCertificateName\}' was deleted from IoT Hub '%\{DescIoTHubName\}'. If this action was made by an unauthorized party, it may indicate a malicious activity.
  :::column-end:::
  :::column:::
    1. Make sure the certificate was removed by an authorized party.
2. If the certificate was not removed by an authorized party, add the certificate back, and escalate the alert to the organizational security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Unsuccessful attempt detected to add a certificate to an IoT Hub.
  :::column-end:::
  :::column:::
    There was an unsuccessful attempt to add certificate '%\{DescCertificateName\}' to IoT Hub '%\{DescIoTHubName\}'. If this action was made by an unauthorized party, it may indicate malicious activity.
  :::column-end:::
  :::column:::
    Make sure permissions to change certificates are only granted to authorized parties.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Unsuccessful attempt detected to delete a certificate from an IoT Hub.
  :::column-end:::
  :::column:::
    There was an unsuccessful attempt to delete certificate '%\{DescCertificateName\}' from IoT Hub '%\{DescIoTHubName\}'. If this action was made by an unauthorized party, it may indicate malicious activity.
  :::column-end:::
  :::column:::
    Make sure permissions to change certificates are only granted to an authorized party.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    x.509 device certificate thumbprint mismatch.
  :::column-end:::
  :::column:::
    x.509 device certificate thumbprint did not match configuration.
  :::column-end:::
  :::column:::
    Review alerts on the devices. No further action required.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    x.509 certificate expired.
  :::column-end:::
  :::column:::
    X.509 device certificate has expired.
  :::column-end:::
  :::column:::
    This could be a legitimate device with an expired certificate or an attempt to impersonate a legitimate device. If the legitimate device is currently communicating correctly this alert is likely an impersonation attempt.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Low** severity alerts
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attempt to add or edit a diagnostic setting of an IoT Hub detected.
  :::column-end:::
  :::column:::
    Attempt to add or edit the diagnostic settings of an IoT Hub has been detected. Diagnostic settings enable you to recreate activity trails for investigation purposes when a security incident occurs or your network is compromised. If this action was not made by an authorized party, it may indicate malicious activity.
  :::column-end:::
  :::column:::
    1. Make sure the certificate was removed by an authorized party.
2. If the certificate was not removed by an authorized party, add the certificate back and escalate the alert to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attempt to delete a diagnostic setting from an IoT Hub detected.
  :::column-end:::
  :::column:::
    There was %\{DescAttemptStatusMessage\}' attempt to add or edit diagnostic setting '%\{DescDiagnosticSettingName\}' of IoT Hub '%\{DescIoTHubName\}'. Diagnostic setting enables you to recreate activity trails for investigation purposes when a security incident occurs or your network is compromised. If this action was not made by an authorized party, it may indicate a malicious activity.
  :::column-end:::
  :::column:::
    Make sure permissions to change diagnostics settings are granted only to an authorized party.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Expired SAS Token.
  :::column-end:::
  :::column:::
    Expired SAS token used by a device.
  :::column-end:::
  :::column:::
    May be a legitimate device with an expired token, or an attempt to impersonate a legitimate device. If the legitimate device is currently communicating correctly, this alert is likely an impersonation attempt.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Invalid SAS token signature.
  :::column-end:::
  :::column:::
    A SAS token used by a device has an invalid signature. The signature does not match either the primary or secondary key.
  :::column-end:::
  :::column:::
    Review the alerts on the devices. No further action required.
  :::column-end:::
:::row-end:::


## Built-in custom alerts for IoT Hub

Azure Defender for IoT allows you to define custom alerts based on expected IoT Hub and/or device behavior.

:::row:::
  :::column:::
    **Severity**
  :::column-end:::
  :::column:::
    **Custom Alert**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of cloud-to-device messages in AMQP protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (AMQP protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of rejected cloud-to-device messages in AMQP protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (AMQP protocol) rejected by the device, within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of device-to-cloud messages in AMQP protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of device-to-cloud messages (AMQP protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of times that a direct method is invoked is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of times that a direct method is invoked within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of file uploads is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of file uploads within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of cloud-to-device messages in HTTP protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (HTTP protocol) in a time window is not in the configured allowed range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of rejected cloud-to-device messages in HTTP protocol is not in the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (HTTP protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of device-to-cloud messages in HTTP protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of device-to-cloud messages (HTTP protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of cloud-to-device messages in MQTT protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (MQTT protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of rejected cloud-to-device messages in MQTT protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of cloud-to-device messages (MQTT protocol) rejected by the device within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of device-to-cloud messages in MQTT protocol is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of device-to-cloud messages (MQTT protocol) within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of command queue purges that are outside of the allowed range.
  :::column-end:::
  :::column:::
    The number of command queue purges within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of module twin updates is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of module twin updates within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Custom alert - The number of unauthorized operations is outside the allowed range.
  :::column-end:::
  :::column:::
    The number of unauthorized operations within a specific time window is outside the currently configured and allowable range.
  :::column-end:::
:::row-end:::
