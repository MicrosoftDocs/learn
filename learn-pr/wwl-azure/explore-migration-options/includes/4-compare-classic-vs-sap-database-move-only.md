## Classical migration

With the Classical Migration option, SAP’s Software Provisioning Manager (SWPM) is used as the Software Logistics (SL) tool and is exclusively for database migrations. SWPM exports data from a source system and imports it to a target system where the target can be any DB (SQL server, Oracle, DB2, etc.). This method in particular uses a file-based approach.

## SAP database migration option (DMO)

DMO facilitates both an SAP upgrade and a database migration to the SAP HANA database via one tool. As both steps are handled at once, the DMO process is often referred to as a **one-step migration**. In comparison, Classical Migration uses a heterogenous system copy approach (thus garnering it the title of a **two-step migration** or "lift and shift" migration) with the first step being that of a migration followed by a second step facilitating an SAP upgrade.

## Classical Migration vs DMO

| Parameter | Classical migration | DMO |
|--|--|--|
| Purpose/Use case | Migration only | Upgrade + migration new DMO version available for migration-only option |
| Downtime optimization flexibility | High | Medium |
| Migration | Manual | Automated |
| Migration expertise | OS/DB certification is mandatory | OS/DB isn't mandatory, but highly recommended |
| Data consistency | Manual | Automatic |
| Options for data transfer | Socket mode option Net exchange mode option FTP mode option to transfer data | Memory pipes filesystem dump |
| Migration check service | Migration check service required for classical approach on productive systems | No migration check service required for DMO on productive systems |
| Monitoring progress | Distribution monitor and migration monitor tools available | Built-in SAPUI application for monitoring progress |
| Post-migration consistency check | Process is manual and requires MIGCHECK tool and the time analyzer tool to generate reports | Built-in feature in DMO |
| Table splitting | Dedicated table splitting and package splitting tools available – R3TA, R3ZCHECK | Table splitting is built-in and tuned |
| Import and Export Table Splitting | Table splitting for export and import can be changed on the fly | Table splitting and sorting requires adjustment as part of uptime (not on the fly) |
| DDL statements | Manual process to generate all DDL statements prior to migration | Built-in process for DDL statement calculations and deployment |
| SWPM, MIGMON, DISMON | SWPM, Migration Monitor (MIGMON) and Distribution Monitor (DISTMON) can be started and stopped manually Not recommended to run from remote desktops for MIGMON tools | No such option available in DMO No such restrictions in DMO |
| Export/import | Ability to add multiple application servers to run the export/import | Only one application server can be used |
| R3 load process limit | No limits | Limit of 999 R3 load processes |
| Table splits limit | No limit on number of table splits | Limit of 200 table splits |
| Target DB | anyDB (e.g. SAP HANA, SQL server, Oracle, DB2, etc.) | Only SAP HANA, AS (other databases are available upon request) |
| SAP recommendation | SAP recommended option if no software change is involved | SAP recommended option if SAP upgrade is in scope |
