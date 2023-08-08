The next step in the infrastructure threat modeling process is to create a data-flow diagram.

## General assumptions

To build this diagram, we make the following assumptions:

- **Zero trust** - The data-flow starts from outside of the corporate network and can't be trusted.
- **Context level** - The data-flow diagram begins with a high-level context diagram, followed by more in-depth diagrams as needed. For more information, see [Provide context with the right depth layer](/training/modules/tm-provide-context-with-the-right-depth-layer/) module from the [Threat Modeling Security Fundamentals](/training/paths/tm-threat-modeling-fundamentals/) learning path.

## Elements

[!INCLUDE [Process](../includes/4-visualize-risk-process.md)]

</br>

---

[!INCLUDE [Data store](../includes/4-visualize-risk-data-store.md)]

</br>

---

[!INCLUDE [External entity](../includes/4-visualize-risk-external-entity.md)]

</br>

---

[!INCLUDE [Data-flow](../includes/4-visualize-risk-data-flow.md)]

</br>

---

[!INCLUDE [Trust boundary](../includes/4-visualize-risk-trust-boundary.md)]

> [!NOTE]
> Check out the [Create a threat model using data-flow diagram elements](/training/modules/tm-create-a-threat-model-using-foundational-data-flow-diagram-elements/) module from our [Threat Modeling Security Fundamentals](/training/paths/tm-threat-modeling-fundamentals/) learning path for an in-depth review of each element.

## Interactions

The next step is to capture the data-flow between each interaction:

### User

[![User threat model.](../media/screenshots/user-threat-model.png)](../media/screenshots/user-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![User external entity.](../media/elements/external-entity-25.png)</br>User|![Bi-directional flow between user external entity and Microsoft 365 process](../media/elements/data-flow-25.png)</br>Bi-directional|![Microsoft 365 process](../media/elements/process-25.png)</br>Microsoft 365|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>HTTPS</li><li>Azure AD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![User external entity.](../media/elements/external-entity-25.png)</br>User|![Bi-directional flow between user external entity and bug management service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Bug management service process](../media/elements/process-25.png)</br>Bug management service|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>HTTPS</li><li>Service authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![User external entity.](../media/elements/external-entity-25.png)</br>User|![Bi-directional flow between user external entity and SaaS offerings (grouped) process](../media/elements/data-flow-25.png)</br>Bi-directional|![SaaS offerings (grouped) process](../media/elements/process-25.png)</br>SaaS offerings (grouped)|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>HTTPS</li><li>SaaS authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![User external entity.](../media/elements/external-entity-25.png)</br>User|![Bi-directional flow between user external entity and GitHub process](../media/elements/data-flow-25.png)</br>Bi-directional|![GitHub process](../media/elements/process-25.png)</br>GitHub|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>HTTPS</li><li>GitHub authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![User external entity.](../media/elements/external-entity-25.png)</br>User|![Bi-directional flow between user external entity and machine process](../media/elements/data-flow-25.png)</br>Bi-directional|![Machine process](../media/elements/process-25.png)</br>Machine|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>AD authentication</li><li>User credentials</li></ul>|

### Initial services

[![Initial services threat model.](../media/screenshots/initial-services-threat-model.png)](../media/screenshots/initial-services-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![GitHub process.](../media/elements/process-25.png)</br>GitHub|![Bi-directional flow between GitHub process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>HTTPS</li><li>IP allowlist</li><li>IPSec tunnel</li><li>Requests and responses</li></ul>|
|![Machine process.](../media/elements/process-25.png)</br>Machine|![Bi-directional flow between machine process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>IP allowlist</li><li>Requests and responses</li></ul>|
|![Machine process.](../media/elements/process-25.png)</br>Machine|![Bi-directional flow between machine process and active directory service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Active Directory service process](../media/elements/process-25.png)</br>Active Directory service|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>User credentials</li><li>Session tokens</li></ul>|
|![Machine process.](../media/elements/process-25.png)</br>Machine|![Bi-directional flow between machine process and user external entity](../media/elements/data-flow-25.png)</br>Bi-directional|![User external entity](../media/elements/external-entity-25.png)</br>User|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|
|![Github process.](../media/elements/process-25.png)</br>GitHub|![Bi-directional flow between GitHub process and user external entity](../media/elements/data-flow-25.png)</br>Bi-directional|![User external entity](../media/elements/external-entity-25.png)</br>User|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|
|![Microsoft 365 process.](../media/elements/process-25.png)</br>Microsoft 365|![Bi-directional flow between Microsoft 365 process and user external entity](../media/elements/data-flow-25.png)</br>Bi-directional|![User external entity](../media/elements/external-entity-25.png)</br>User|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|
|![Bug management service process.](../media/elements/process-25.png)</br>Bug management service|![Bi-directional flow between bug management service process and user external entity](../media/elements/data-flow-25.png)</br>Bi-directional|![User external entity](../media/elements/external-entity-25.png)</br>User|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|
|![SaaS offerings (grouped) process.](../media/elements/process-25.png)</br>SaaS offerings (grouped)|![Bi-directional flow between SaaS offerings (grouped process and user external entity)](../media/elements/data-flow-25.png)</br>Bi-directional|![User external entity](../media/elements/external-entity-25.png)</br>User|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|

### Firewall

[![Firewall threat model.](../media/screenshots/firewall-threat-model.png)](../media/screenshots/firewall-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and VPN service process](../media/elements/data-flow-25.png)</br>Bi-directional|![VPN service process](../media/elements/process-25.png)</br>VPN service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and build servers (grouped) process](../media/elements/data-flow-25.png)</br>Bi-directional|![Build servers (grouped) process](../media/elements/process-25.png)</br>Build servers (grouped)|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li><li>GitHub IPSec tunnel</li></ul>|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and logging and monitoring service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Logging and monitoring service process](../media/elements/process-25.png)</br>Logging and monitoring service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and Azure IaaS process](../media/elements/data-flow-25.png)</br>Bi-directional|![Azure IaaS process](../media/elements/process-25.png)</br>Azure IaaS|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>IPSec tunnel</li><li>IP allowlist</li><li>Requests and responses</li></ul>|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and machine process](../media/elements/data-flow-25.png)</br>Bi-directional|![Machine process](../media/elements/process-25.png)</br>Machine|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **Initial services** for details*|
|![Firewall service process.](../media/elements/process-25.png)</br>Firewall service|![Bi-directional flow between firewall service process and GitHub process](../media/elements/data-flow-25.png)</br>Bi-directional|![GitHub process](../media/elements/process-25.png)</br>GitHub|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **Initial services** for details*|

### VPN

[![VPN threat model.](../media/screenshots/vpn-threat-model.png)](../media/screenshots/vpn-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![VPN service process.](../media/elements/process-25.png)</br>VPN service|![Bi-directional flow between VPN service process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>IP allowlist</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![VPN service process.](../media/elements/process-25.png)</br>VPN service|![Bi-directional flow between VPN service process and credentials and tokens VPN store](../media/elements/data-flow-25.png)</br>Bi-directional|![Credentials and tokens VPN data store](../media/elements/data-store-25.png)</br>Credentials and tokens VPN store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>VPN tunnel</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![VPN service process.](../media/elements/process-25.png)</br>VPN service|![Bi-directional flow between VPN service process and NAS file share service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS file share service process](../media/elements/process-25.png)</br>NAS file share service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![VPN service process.](../media/elements/process-25.png)</br>VPN service|![Bi-directional flow between VPN service process and SQL server process](../media/elements/data-flow-25.png)</br>Bi-directional|![SQL server process](../media/elements/process-25.png)</br>SQL server|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>VPN tunnel</li><li>Requests and responses</li></ul>|
|![Credentials and tokens VPN data store.](../media/elements/data-store-25.png)</br>Credentials and tokens VPN store|![Bi-directional flow between credentials and tokens VPN data store and NAS backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS backup service process](../media/elements/process-25.png)</br>NAS backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|

### Network attached storage (NAS)

[![NAS threat model.](../media/screenshots/nas-threat-model.png)](../media/screenshots/nas-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![NAS file share service process.](../media/elements/process-25.png)</br>NAS file share service|![Bi-directional flow between NAS file share service process and NAS store](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS data store](../media/elements/data-store-25.png)</br>NAS store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and NAS data store](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS data store](../media/elements/data-store-25.png)</br>NAS store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and Active Directory data store](../media/elements/data-flow-25.png)</br>Bi-directional|![Active Directory data store](../media/elements/data-store-25.png)</br>Active Directory store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and logging and monitoring data store](../media/elements/data-flow-25.png)</br>Bi-directional|![Logging and monitoring data store](../media/elements/data-store-25.png)</br>Logging and monitoring store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and SQL server process](../media/elements/data-flow-25.png)</br>Bi-directional|![SQL server process](../media/elements/process-25.png)</br>SQL server|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and build servers (grouped) process](../media/elements/data-flow-25.png)</br>Bi-directional|![Build servers (grouped) process](../media/elements/process-25.png)</br>Build servers (grouped)|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![NAS file share service process.](../media/elements/process-25.png)</br>NAS file share service|![Bi-directional flow between NAS file share service process and VPN service process](../media/elements/data-flow-25.png)</br>Bi-directional|![VPN service process](../media/elements/process-25.png)</br>VPN service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **VPN** for details*|
|![NAS backup service process.](../media/elements/process-25.png)</br>NAS backup service|![Bi-directional flow between NAS backup service process and credentials and tokens VPN data store](../media/elements/data-flow-25.png)</br>Bi-directional|![Credentials and tokens VPN data store](../media/elements/data-store-25.png)</br>Credentials and tokens VPN store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **VPN** for details*|

### Servers

[![Servers threat model.](../media/screenshots/servers-threat-model.png)](../media/screenshots/servers-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![SQL server process.](../media/elements/process-25.png)</br>SQL server|![Bi-directional flow between SQL server process and removable drive backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Removable drive backup service process](../media/elements/process-25.png)</br>Removable drive backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Build servers (grouped) process.](../media/elements/process-25.png)</br>Build servers (grouped)|![Bi-directional flow between build servers (grouped) process and removable drive backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Removable drive backup service process](../media/elements/process-25.png)</br>Removable drive backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![SQL server process.](../media/elements/process-25.png)</br>SQL server|![Bi-directional flow between SQL server process and VPN service process](../media/elements/data-flow-25.png)</br>Bi-directional|![VPN service process](../media/elements/process-25.png)</br>VPN service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **VPN** for details*|
|![SQL server process.](../media/elements/process-25.png)</br>SQL server|![Bi-directional flow between SQL server process and NAS backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS backup service process](../media/elements/process-25.png)</br>NAS backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **NAS** for details*|
|![Build servers (grouped) process.](../media/elements/process-25.png)</br>Build servers (grouped)|![Bi-directional flow between build servers (grouped) process and NAS backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS backup service process](../media/elements/process-25.png)</br>NAS backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **NAS** for details*|
|![Build servers (grouped) process.](../media/elements/process-25.png)</br>Build servers (grouped)|![Bi-directional flow between build servers (grouped) process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **Firewall** for details*|

### Logging and monitoring

[![Logging and monitoring threat model.](../media/screenshots/logging-threat-model.png)](../media/screenshots/logging-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Logging and monitoring service process.](../media/elements/process-25.png)</br>Logging and monitoring service|![Bi-directional flow between logging and monitoring service process and logging and monitoring data store](../media/elements/data-flow-25.png)</br>Bi-directional|![Logging and monitoring data store](../media/elements/data-store-25.png)</br>Logging and monitoring store|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|
|![Logging and monitoring data store.](../media/elements/data-store-25.png)</br>Logging and monitoring store|![Bi-directional flow between logging and monitoring data store and NAS backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS backup service process](../media/elements/process-25.png)</br>NAS backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **NAS** for details*|
|![Logging and monitoring service process.](../media/elements/process-25.png)</br>Logging and monitoring service|![Bi-directional flow between logging and monitoring service process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **Firewall** for details*|

### Active Directory

[![Active Directory threat model.](../media/screenshots/active-directory-threat-model.png)](../media/screenshots/active-directory-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Active Directory data store.](../media/elements/data-store-25.png)</br>Active directory store|![Bi-directional flow between Active Directory data store and Active Directory service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Active Directory service process](../media/elements/process-25.png)</br>Active directory service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Active Directory service process.](../media/elements/process-25.png)</br>Active directory service|![Bi-directional flow between Active Directory service process and removable drive backup service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Removable drive backup service process](../media/elements/process-25.png)</br>Removable drive backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|<ul><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Active Directory service process.](../media/elements/process-25.png)</br>Active directory service|![Bi-directional flow between Active Directory service process and machine process](../media/elements/data-flow-25.png)</br>Bi-directional|![Machine process](../media/elements/process-25.png)</br>Machine|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|*See **Initial services** for details*|
|![Active Directory data store.](../media/elements/data-store-25.png)</br>Active directory store|![Bi-directional flow between Active Directory data store and NAS backup file service process](../media/elements/data-flow-25.png)</br>Bi-directional|![NAS backup service process](../media/elements/process-25.png)</br>NAS backup service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **NAS** for details*|

### Removable drive

[![Removable drive threat model.](../media/screenshots/removable-drive-threat-model.png)](../media/screenshots/removable-drive-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Removable drive backup service process.](../media/elements/process-25.png)</br>Removable drive backup service|![Bi-directional flow between removable drive backup service process and removable drive data store](../media/elements/data-flow-25.png)</br>Bi-directional|![Removable drive data store](../media/elements/data-store-25.png)</br>Removable drive store|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>Requests and responses</li></ul>|
|![Removable drive backup service process.](../media/elements/process-25.png)</br>Removable drive backup service|![Bi-directional flow between removable drive backup service process and SQL server process](../media/elements/data-flow-25.png)</br>Bi-directional|![SQL server process](../media/elements/process-25.png)</br>SQL server|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **Servers** for details*|
|![Removable drive backup service process.](../media/elements/process-25.png)</br>Removable drive backup service|![Bi-directional flow between removable drive backup service process and build servers (grouped) process](../media/elements/data-flow-25.png)</br>Bi-directional|![Build servers (grouped) process](../media/elements/process-25.png)</br>Build servers (grouped)|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **Servers** for details*|
|![Removable drive backup service process.](../media/elements/process-25.png)</br>Removable drive backup service|![Bi-directional flow between removable drive backup service process and Active Directory service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Active Directory service process](../media/elements/process-25.png)</br>Active directory service|![Does not cross trust boundary](../media/supporting-icons/none-25.png)</br>No|*See **Active directory** for details*|

### Azure

[![Azure threat model.](../media/screenshots/azure-threat-model.png)](../media/screenshots/azure-threat-model-large.png#lightbox)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Azure IaaS process.](../media/elements/process-25.png)</br>Azure IaaS|![Bi-directional flow between Azure IaaS process and firewall service process](../media/elements/data-flow-25.png)</br>Bi-directional|![Firewall service process](../media/elements/process-25.png)</br>Firewall service|![Crosses trust boundary](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>IPSec tunnel</li><li>Azure AD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|

## Finished diagram

[![Infrastructure threat model.](../media/screenshots/infrastructure-threat-model.png)](../media/screenshots/infrastructure-threat-model-large.png#lightbox)
