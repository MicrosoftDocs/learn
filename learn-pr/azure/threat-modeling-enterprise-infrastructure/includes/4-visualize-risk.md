---
title: Introduction to infrastructure threat modeling
description: Visualize the state of security for your infrastructure by creating a data-flow diagram.
author: rodrigosantos
ms.author: rodsan
ms.date: 03/01/2021
ms.prod: non-product-specific
ms.topic: how-to
ms.custom: infrastructure-threat-modeling-security-guide
ms.customer.intent: As an IT professional, I understand how to visualize risk in the infrastructure by using threat modeling.
---

The next step in the infrastructure threat modeling process is to create a data-flow diagram.

## General assumptions

To build this diagram, we make the following assumptions:

- **Zero trust** - data-flow initiates from outside of the corporate network and cannot be trusted.
- **Context level** - data-flow diagram begins with a high-level context diagram, followed by more in-depth diagrams as needed. Refer to the [Provide context with the right depth layer](https://docs.microsoft.com/en-us/learn/modules/tm-provide-context-with-the-right-depth-layer/) module from the [Threat Modeling Security Fundamentals](https://docs.microsoft.com/en-us/learn/paths/tm-threat-modeling-fundamentals/) learning path for more information.

> [!NOTE]
> To get started, select an element from the options above.

## Elements

::: zone pivot="process-pivot-selection"

[!INCLUDE [Process](../includes/4-visualize-risk-process.md)]

::: zone-end

::: zone pivot="data-store-pivot-selection"

[!INCLUDE [Data store](../includes/4-visualize-risk-data-store.md)]

::: zone-end

::: zone pivot="external-entity-pivot-selection"

[!INCLUDE [External entity](../includes/4-visualize-risk-external-entity.md)]

::: zone-end

::: zone pivot="data-flow-pivot-selection"

[!INCLUDE [Data-flow](../includes/4-visualize-risk-data-flow.md)]

::: zone-end

::: zone pivot="trust-boundary-pivot-selection"

[!INCLUDE [Trust boundary](../includes/4-visualize-risk-trust-boundary.md)]

::: zone-end

> [!NOTE]
> Check out the [Create a threat model using data-flow diagram elements](https://docs.microsoft.com/en-us/learn/modules/tm-create-a-threat-model-using-foundational-data-flow-diagram-elements/) module from our [Threat Modeling Security Fundamentals](https://docs.microsoft.com/en-us/learn/paths/tm-threat-modeling-fundamentals/) learning path for an in-depth review of each element.

## Interactions

The next step is to capture the data-flow between each interaction:

### User

:::image type="content" source="../media/screenshots/user-tm-screenshot.PNG" alt-text="User interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![External Entity](../media/elements/external-entity25.png)</br>User|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>O365|![Checkmark](../media/check25.png)</br>Yes|<ul><li>HTTPS</li><li>AAD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![External Entity](../media/elements/external-entity25.png)</br>User|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Bug management service|![Checkmark](../media/check25.png)</br>Yes|<ul><li>HTTPS</li><li>Service authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![External Entity](../media/elements/external-entity25.png)</br>User|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>SaaS offerings (grouped)|![Checkmark](../media/check25.png)</br>Yes|<ul><li>HTTPS</li><li>SaaS authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![External Entity](../media/elements/external-entity25.png)</br>User|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>GitHub|![Checkmark](../media/check25.png)</br>Yes|<ul><li>HTTPS</li><li>GitHub authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![External Entity](../media/elements/external-entity25.png)</br>User|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Machine|![None](../media/x25.png)</br>No|<ul><li>AD authentication</li><li>User credentials</li></ul>|

### Initial services

:::image type="content" source="../media/screenshots/machine-github-tm-screenshot.PNG" alt-text="Machine and GitHub interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>GitHub|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)</br>Yes|<ul><li>HTTPS</li><li>IP allow list</li><li>IPSec tunnel</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Machine|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)</br>Yes|<ul><li>IP allow list</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Machine|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Active Directory service|![Checkmark](../media/check25.png)</br>Yes|<ul><li>User credentials</li><li>Session tokens</li></ul>|
|![Process](../media/elements/process25.png)</br>Machine|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![External entity](../media/elements/external-entity25.png)</br>User|![Checkmark](../media/check25.png)</br>Yes|*See **User** for details*|
|![Process](../media/elements/process25.png)</br>GitHub|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![External entity](../media/elements/external-entity25.png)</br>User|![Checkmark](../media/check25.png)</br>Yes|*See **User** for details*|
|![Process](../media/elements/process25.png)</br>O365|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![External entity](../media/elements/external-entity25.png)</br>User|![Checkmark](../media/check25.png)</br>Yes|*See **User** for details*|
|![Process](../media/elements/process25.png)</br>Bug management service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![External entity](../media/elements/external-entity25.png)</br>User|![Checkmark](../media/check25.png)</br>Yes|*See **User** for details*|
|![Process](../media/elements/process25.png)</br>SaaS Offerings (grouped)|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![External entity](../media/elements/external-entity25.png)</br>User|![Checkmark](../media/check25.png)</br>Yes|*See **User** for details*|

### Firewall

:::image type="content" source="../media/screenshots/firewall-tm-screenshot.PNG" alt-text="Firewall interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>VPN service|![None](../media/x25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li><li>GitHub IPSec tunnel</li></ul>|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Logging and monitoring service|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Azure IaaS|![Checkmark](../media/check25.png)</br>Yes|<ul><li>IPSec tunnel</li><li>IP allow list</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Machine|![Checkmark](../media/check25.png)</br>Yes|*See **Initial services** for details*|
|![Process](../media/elements/process25.png)</br>Firewall service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>GitHub|![Checkmark](../media/check25.png)</br>Yes|*See **Initial services** for details*|

### VPN

:::image type="content" source="../media/screenshots/vpn-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>VPN service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![None](../media/x25.png)</br>No|<ul><li>IP allow list</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>VPN service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Credentials and tokens VPN store|![None](../media/x25.png)</br>No|<ul><li>VPN tunnel</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>VPN service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS file share service|![None](../media/x25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>VPN service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>SQL server|![None](../media/x25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![Data store](../media/elements/data-store25.png)</br>Credentials and tokens VPN store|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS backup service|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|

### Network attached storage (NAS)

:::image type="content" source="../media/screenshots/nas-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>NAS file share service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>NAS store|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>NAS store|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Active Directory store|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Logging and monitoring store|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>SQL server|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>NAS file share service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/data-store25.png)</br>VPN service|![None](../media/x25.png)</br>No|*See **VPN** for details*|
|![Process](../media/elements/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Credentials and tokens VPN store|![None](../media/x25.png)</br>No|*See **VPN** for details*|

### Servers

:::image type="content" source="../media/screenshots/servers-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>SQL server|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Removable drive backup service|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Removable drive backup service|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>SQL server|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>VPN service|![None](../media/x25.png)</br>No|*See **VPN** for details*|
|![Process](../media/elements/process25.png)</br>SQL server|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS backup service|![None](../media/x25.png)</br>No|*See **NAS** for details*|
|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS backup service|![None](../media/x25.png)</br>No|*See **NAS** for details*|
|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![None](../media/x25.png)</br>No|*See **Firewall** for details*|

### Logging and monitoring

:::image type="content" source="../media/screenshots/logging-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>Logging and monitoring service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Logging and monitoring store|![None](../media/x25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Data store](../media/elements/data-store25.png)</br>Logging and monitoring store|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS backup service|![None](../media/x25.png)</br>No|*See **NAS** for details*|
|![Process](../media/elements/process25.png)</br>Logging and monitoring service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![None](../media/x25.png)</br>No|*See **Firewall** for details*|

### Active directory

:::image type="content" source="../media/screenshots/ad-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Data store](../media/elements/data-store25.png)</br>Active directory store|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Active directory service|![None](../media/x25.png)</br>No|<ul><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Active directory service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Removable drive backup service|![None](../media/x25.png)</br>No|<ul><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Active directory service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Machine|![Checkmark](../media/check25.png)</br>Yes|*See **Initial services** for details*|
|![Data store](../media/elements/data-store25.png)</br>Active directory store|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>NAS backup service|![None](../media/x25.png)</br>No|*See **NAS** for details*|

### Removable drive

:::image type="content" source="../media/screenshots/removable-drive-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Data store](../media/elements/data-store25.png)</br>Removable drive store|![Checkmark](../media/check25.png)</br>Yes|<ul><li>Requests and responses</li></ul>|
|![Process](../media/elements/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>SQL server|![None](../media/x25.png)</br>No|*See **Servers** for details*|
|![Process](../media/elements/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Build servers (grouped)|![None](../media/x25.png)</br>No|*See **Servers** for details*|
|![Process](../media/elements/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Active directory service|![None](../media/x25.png)</br>No|*See **Active directory** for details*|

### Azure

:::image type="content" source="../media/screenshots/azure-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Process](../media/elements/process25.png)</br>Azure IaaS|![Bi-directional Flow](../media/elements/biflow25.png)</br>Bi-directional|![Process](../media/elements/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)</br>Yes|<ul><li>IPSec tunnel</li><li>AAD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|

## Finished diagram

:::image type="content" source="../media/screenshots/infra-tm.PNG" alt-text="VPN interactions in data-flow diagram":::
