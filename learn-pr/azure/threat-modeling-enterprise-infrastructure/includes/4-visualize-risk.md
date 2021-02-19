The next step in the infrastructure threat modeling process is to create a data-flow diagram.

## General assumptions

To build this diagram, we make the following assumptions:

- **Zero trust** - data-flow initiates from outside of the corporate network.
- **Context level** - data-flow diagram begins with a high-level context diagram, followed by additional,
more in-depth diagrams as needed. Refer to the [Provide context with the right depth layer](https://docs.microsoft.com/en-us/learn/modules/tm-provide-context-with-the-right-depth-layer/) module from the [Threat Modeling Security Fundamentals](https://docs.microsoft.com/en-us/learn/paths/tm-threat-modeling-fundamentals/) learning path for more information.

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

The next step is to create the data flows between each element:

### User

:::image type="content" source="../media/user-tm-screenshot.PNG" alt-text="User interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![External Entity](../media/external-entity25.png)</br>User|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>O365||<ul><li>Authentication tokens</li><li>Data requests and responses</li></ul>|
|![External Entity](../media/external-entity25.png)</br>User|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Bug management service|||
|![External Entity](../media/external-entity25.png)</br>User|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>SaaS offerings (grouped)|||
|![External Entity](../media/external-entity25.png)</br>User|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>GitHub|||
|![External Entity](../media/external-entity25.png)</br>User|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Machine|||

### Machine and Github service interactions

:::image type="content" source="../media/machine-github-tm-screenshot.PNG" alt-text="Machine and Github interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>GitHub|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![External entity](../media/external-entity25.png)</br>User|||
|![Process](../media/process25.png)</br>GitHub|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Internet - Corporate</li></ul>|
|![Process](../media/process25.png)</br>Machine|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![External entity](../media/external-entity25.png)</br>User||
|![Process](../media/process25.png)</br>Machine|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Internet - Corporate</li></ul>|
|![Process](../media/process25.png)</br>Machine|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Active Directory service|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Internet - Corporate</li></ul>|

### Firewall Service interactions

:::image type="content" source="../media/firewall-tm-screenshot.PNG" alt-text="Firewall interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Machine|![Checkmark](../media/check25.png)||
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>GitHub|![Checkmark](../media/check25.png)||
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>VPN service|||
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Build servers (grouped)|||
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Logging and monitoring service|||
|![Process](../media/process25.png)</br>Firewall service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Azure IaaS|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Corporate - Azure</li></ul>|

### VPN interactions

:::image type="content" source="../media/vpn-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>VPN service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/data-store25.png)</br>Firewall service|||
|![Process](../media/process25.png)</br>VPN service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Credentials and tokens VPN store|||
|![Process](../media/process25.png)</br>VPN service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS file share service|||
|![Process](../media/process25.png)</br>VPN service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>SQL server|||
|![Data store](../media/data-store25.png)</br>Credentials and tokens VPN store|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS backup service|||

### NAS interactions

:::image type="content" source="../media/nas-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>NAS file share service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/data-store25.png)</br>VPN service|||
|![Process](../media/process25.png)</br>NAS file share service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>NAS store|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>NAS store|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Credentials and tokens VPN store|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Active Directory store|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Logging and monitoring store|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>SQL server|||
|![Process](../media/process25.png)</br>NAS backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Build servers (grouped)|||

### Server interactions

:::image type="content" source="../media/servers-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>SQL server|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Removable drive backup service|||
|![Process](../media/process25.png)</br>SQL server|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS backup service|||
|![Process](../media/process25.png)</br>SQL server|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>VPN service|||
|![Process](../media/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Removable drive backup service|||
|![Process](../media/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS backup service|||
|![Process](../media/process25.png)</br>Build servers (grouped)|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Firewall service|||

### Logging and monitoring interactions

:::image type="content" source="../media/logging-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>Logging and monitoring service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Firewall service|||
|![Process](../media/process25.png)</br>Logging and monitoring service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Logging and monitoring store|||
|![Process](../media/data-store25.png)</br>Logging and monitoring store|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS backup service|||

### Active Directory interactions

:::image type="content" source="../media/ad-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Data store](../media/data-store25.png)</br>Active directory store|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Active directory service|||
|![Data store](../media/data-store25.png)</br>Active directory store|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>NAS backup service|||
|![Process](../media/process25.png)</br>Active directory service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Removable drive backup service|||
|![Process](../media/process25.png)</br>Active directory service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Machine|||

### Removable drive interactions

:::image type="content" source="../media/removable-drive-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Data store](../media/data-store25.png)</br>Removable drive store|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Corporate - Internet</li></ul>|
|![Process](../media/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>SQL server||<ul><li><strong>Boundary:</strong> Corporate - Internet</li></ul>|
|![Process](../media/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Build servers (grouped)||<ul><li><strong>Boundary:</strong> Corporate - Internet</li></ul>|
|![Process](../media/process25.png)</br>Removable drive backup service|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Active directory service||<ul><li><strong>Boundary:</strong> Corporate - Internet</li></ul>|

### Azure interactions

:::image type="content" source="../media/azure-tm-screenshot.PNG" alt-text="VPN interactions in data-flow diagram":::

|Element one|Data-flow direction|Element two|Crosses boundary|Details|
|-----------|-------------------|-----------|----------------|-------|
|![Process](../media/process25.png)</br>Azure IaaS|![Bi-directional Flow](../media/biflow25.png)</br>Bi-directional|![Process](../media/process25.png)</br>Firewall service|![Checkmark](../media/check25.png)|<ul><li><strong>Boundary:</strong> Corporate - Azure</li></ul>|

## Finished diagram

:::image type="content" source="../media/infra-tm.PNG" alt-text="VPN interactions in data-flow diagram":::