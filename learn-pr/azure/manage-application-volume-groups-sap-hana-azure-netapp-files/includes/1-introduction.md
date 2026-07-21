Application volume groups (AVG) enable you to deploy all volumes for a single HANA host in one atomic step. The Azure portal and the Azure Resource Manager template have implemented prechecks and recommendations for deployment in areas including throughputs and volume naming conventions. As a REST API user, those checks and recommendations aren't available.

Without these checks, it's important to understand the requirements for running HANA on Azure NetApp Files and the basic architecture and workflows on which application volume groups are built.

SAP HANA can be installed in a single-host (scale-up) or in a multiple-host (scale-out) configuration. The volumes required for each of the HANA nodes differ for the first HANA node (single-host) and for subsequent HANA hosts (multiple-host). Since an application volume group creates the volumes for a single HANA host, the number and type of volumes created differ for the first HANA host and all subsequent HANA hosts in a multiple-host setup.

### Rules and restrictions

Using application volume groups requires understanding the rules and restrictions:

- A single volume group is used to create the volumes for a single HANA host only.
- In a HANA multiple-host setup (scale-out), you should start with the volume group for the first HANA host and continue host by host.
- HANA requires different volume types for the first HANA host and all additional multiple-host hosts you add.
- Available volume types are: data, log, shared, log-backup, and data-backup.
- The first node can have all five different volumes (one for each type).
    - data, log, and shared volumes must be provided.
    - log-backup and data-backup are optional, as you may choose to use a central share to store the backups or even use Backint for the log-backup.
- All additional hosts in a multiple-host setup may only add one data and one log volume each.
- For data, log and shared volumes, SAP HANA certification requires NFSv4.1 protocol.
- Log-backup and file-backup volumes, if created optionally with the volume group of the first HANA host, may use NFSv4.1 or NFSv3 protocol.
- Each volume must have at least one export policy defined. To install SAP, root access must be enabled.
- Kerberos and LDAP enablement aren't supported.

### Volume types for application volume groups

The following table describes all the possible volume types for application volume groups for SAP HANA.

| Volume type | Creation limits | Supported protocol | Recommended naming | Data protection recommendation |
| --- | --- | --- | --- | --- |
| **SAP HANA data volume** | One data volume must be created for every HANA host. | NFSv4.1 (LDAP and Kerberos aren't supported) | `<SID>-data-mnt<00001>` where `<SID>` is the SAP system ID and `<00001>` refers to the host number. | No initial data protection recommendation |
| **SAP HANA log volume** | One log volume must be created for every HANA host. | NFSv4.1 (LDAP and Kerberos aren't supported) | `<SID>-log-mnt<00001>` where `<SID>` is the SAP system ID and `<00001>` refers to the host number. | No initial data protection recommendation |
| **SAP HANA shared volume** | One shared volume must be created for the first host of a multiple-host setup, or for a single-host HANA installation. | NFSv4.1 (LDAP and Kerberos aren't supported) | `<SID>-shared` where `<SID>` is the SAP system ID. | No initial data protection recommended |
| **SAP HANA data backup volume** | An optional volume created only for the first HANA node. | NFSv4.1 (LDAP and Kerberos aren't supported) | `<SID>-data-backup` where `<SID>` is the SAP system ID. | No initial data protection recommended |
| **SAP HANA log backup volume** | An optional volume created only for the first HANA node. | NFSv4.1 (LDAP and Kerberos aren't supported) | `<SID>-log-backup` where `<SID>` is the SAP system ID. | No initial data protection recommended |
