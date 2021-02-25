## Summarized Notes

![Access Control domain](../media/policies/AccessControl-small.svg)</br>Access control
<ul><li>Users: employees, admins, vendors.</li><li>Corporate network access with generic VPN.</li><li>NAS - sensitive files (code, system config, backups), READ - all, READ/WRITE - admins.</li><li>Build servers - READ - all, WRITE - admins.</li><li>File share server - READ - all, WRITE - admins.</li><li>Access given according to need for individual users.</li><li>O365 - single factor authentication, no password expiration.</li><li>GitHub - single factor authentication, no password expiration.</li><li>Domain Controller - used for local machine access only, no group policy.</li><li>No password requirements.</li><li>Local credentials for Linux machine access.</li><li>Shared accounts - for conference rooms, shared passwords, same permissions as users.</li><li>AAD used for O365 access.</li><li>Decentralized identities - each system uses a different credential.</li><li>No enforced 2FA/MFA.</li><li>No separate accounts used to make sensitive system changes.</li></ul>

</br>

---

</br>

![Secure Development domain](../media/policies/SecureDevelopment-small.svg)<br>Secure development
<ul><li>SDL not implemented formally.</li><li>Potentially unsafe open-source bug management solution.</li><li>Weak authentication for GitHub.</li></ul>

</br>

---

</br>

![Business Continuity domain](../media/policies/BusinessContinuity-small.svg)<br>Business continuity
<ul><li>Critical systems backup - NAS (weekly, not encrypted), removable drive (monthly, not encrypted).</li><li>No formalized business continuity and disaster recovery plan.</li><li>No audits or recovery tests on backups.</li></ul>

</br>

---

</br>

![Cryptography domain](../media/policies/Cryptography-small.svg)<br>Cryptography
<ul><li>Self-signed certificates on dev environment.</li><li>Verisign certificates for public facing websites.</li><li>No key rotation.</li></ul>

</br>

---

</br>

![Asset Management domain](../media/policies/Asset-small.svg)<br>Asset management
<ul><li>No data retention.</li><li>No classification or labeling.</li><li>Folders treated as labeling mechanism.</li><li>Folder access is unrestricted.</li><li>No asset disposal or deprecation plan.</li><li>Unencrypted data on shared drives and servers.</li><li>No Data Leakage Prevention (DLP) mechanisms.</li><li>NAS - stores code artifacts, configuration files, and short-term backups (SQL server, domain controller, and build servers).</li><li>OneDrive currently being implemented to replace shared storage.</li><li>Unencrypted enterprise machine disks.</li><li>Stations not locked when employees leave their stations.</li></ul>

</br>

---

</br>

![Legal domain](../media/policies/Legal-small.svg)<br>Legal
<ul><li>Non-Disclosure Agreements (NDA) and asset use agreements signed.</li><li>Background checks conducted.</li><li>Specialized team handles financial regulatory compliance.</li></ul>

</br>

---

</br>

![Incident Response domain](../media/policies/IncidentResponse-small.svg)<br>Incident response
<ul><li>No incident response program for enterprise.</li><li>No incident response program for product.</li></ul>

</br>

---

</br>

![Network domain](../media/policies/Network-small.svg)<br>Network
<ul><li>Network is unsegmented.</li><li>Firewall has a basic set of inbound and outbound rules.</li><li>VPN takes credentials and a pre-generated token to create a secure connection to the corporate network.</li></ul>

</br>

---

</br>

![Operations domain](../media/policies/Operations-small.svg)<br>Operations
<ul><li>Manual, unplanned patches, and updates done on assets by the IT administrators.</li><li>Basic Antivirus (AV) solution installed on every machine, but no way to enforce or verify.</li><li>No group policy exists to enforce timeout sessions on machines.</li><li>No Mobile Device Management (MDM) solution.</li><li>Logging and monitoring is minimal, made up of only of basic VPN and firewall actions.</li><li>No intelligence platform or analytics service.</li><li>Only default rules are used for the firewall.</li><li>Firewall logs are kept locally for seven days, and then erased to make space for the more recent logs.</li><li>Changes to the production environment require management approval.</li></ul>

</br>

---

</br>

![Physical and environmental domain](../media/policies/Physical-small.svg)<br>Physical and environmental
<ul><li>Five build servers, one domain controller, one NAS in an unlocked IT room.</li><li>No cameras or access records for the IT room.</li><li>RFID for building access.</li><li>Building owner has access to all rooms and floors.</li><li>No building cameras or guards.</li><li>No official visitor check-in process.</li></ul>

</br>

---

</br>

![Governance domain](../media/policies/Governance-small.svg)<br>Governance
<ul><li>No information security policy or risk management program.</li><li>No security training offerings.</li></ul>

</br>

---

</br>

![Security architecture domain](../media/policies/SecurityArchitecture-small.svg)<br>Security architecture
<ul><li>A Virtual Machine (VM) is created using default images.</li><li>Security baselines not configured.</li><li>Hybrid infrastructure can lead to holes in the firewall and access control issues if implemented incorrectly.</li><li>No IoT or container used in the enterprise.</li></ul>

</br>

---

</br>

![Supplier risk domain](../media/policies/Supplier-small.svg)<br>Supplier
<ul><li>No supplier management exists.</li></ul>