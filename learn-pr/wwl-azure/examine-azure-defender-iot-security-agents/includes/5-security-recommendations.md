Azure Defender for IoT scans your Azure resources and IoT devices and provides security recommendations to reduce your attack surface. Security recommendations are actionable and aim to aid customers in complying with security best practices.

## Recommendations for IoT Hub

Recommendation alerts provide insight and suggestions for actions to improve the security posture of your environment.

:::row:::
  :::column:::
    **Severity**
  :::column-end:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Data Source**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Identical authentication credentials used by multiple devices.
  :::column-end:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    IoT Hub authentication credentials are used by multiple devices. This may indicate an illegitimate device impersonating a legitimate device. Duplicate credential use increases the risk of device impersonation by a malicious actor.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Default IP filter policy should be deny.
  :::column-end:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    IP filter configuration should have rules defined for allowed traffic, and should by default, deny all other traffic by default.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    IP filter rule includes large IP range.
  :::column-end:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    An allow IP filter rule source IP range is too large. Overly permissive rules can expose your IoT hub to malicious actors.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Enable diagnostics logs in IoT Hub.
  :::column-end:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    Enable logs and retain them for up to a year. Retaining logs enables you to recreate activity trails for investigation purposes when a security incident occurs or your network is compromised.
  :::column-end:::
:::row-end:::


## Agent-based recommendations for IoT devices<br>

Device recommendations provide insights and suggestions to improve device security posture.

:::row:::
  :::column:::
    **Severity**
  :::column-end:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Data Source**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Open Ports on device.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A listening endpoint was found on the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Permissive firewall policy found in one of the chains.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Allowed firewall policy found (INPUT/OUTPUT). Firewall policy should deny all traffic by default, and define rules to allow necessary communication to/from the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Permissive firewall rule in the input chain was found.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or ports.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Permissive firewall rule in the output chain was found.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or ports.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Operation system baseline validation has failed.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Device doesn't comply with CIS Linux benchmarks.
  :::column-end:::
:::row-end:::


## Agent-based operational recommendations

Operational recommendations provide insights and suggestions to improve security agent configuration.

:::row:::
  :::column:::
    **Severity**
  :::column-end:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Data Source**
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
    Agent sends unutilized messages.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    10% or more of security messages were smaller than 4 KB during the last 24 hours.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Security twin configuration not optimal.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Security twin configuration is not optimal.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Security twin configuration conflict.
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Conflicts were identified in the security twin configuration.
  :::column-end:::
:::row-end:::
