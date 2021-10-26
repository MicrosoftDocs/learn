## Classical migration

With the Classical Migration option, SAP’s Software Provisioning Manager (SWPM) is used as the Software Logistics (SL) tool and is exclusively for database migrations. SWPM exports data from a source system and imports it to a target system where the target can be any DB (SQL server, Oracle, DB2, etc.). This method in particular uses a file-based approach.

## SAP database migration option (DMO)

DMO facilitates both an SAP upgrade and a database migration to the SAP HANA database via one tool. As both steps are handled at once, the DMO process is often referred to as a **one-step migration**. In comparison, Classical Migration uses a heterogenous system copy approach (thus garnering it the title of a **two-step migration** or "lift and shift" migration) with the first step being that of a migration followed by a second step facilitating an SAP upgrade.

## Classical Migration vs DMO

:::row:::
  :::column:::
    **Parameter**
  :::column-end:::
  :::column:::
    **Classical migration**
  :::column-end:::
  :::column:::
    **DMO**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Purpose/Use case
  :::column-end:::
  :::column:::
    Migration only
  :::column-end:::
  :::column:::
    Upgrade + migration new DMO version available for migration-only option
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Downtime optimization flexibility
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Migration
  :::column-end:::
  :::column:::
    Manual
  :::column-end:::
  :::column:::
    Automated
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Migration expertise
  :::column-end:::
  :::column:::
    OS/DB certification is mandatory
  :::column-end:::
  :::column:::
    OS/DB is not mandatory, but highly recommended
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Data consistency
  :::column-end:::
  :::column:::
    Manual
  :::column-end:::
  :::column:::
    Automatic
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Options for data transfer
  :::column-end:::
  :::column:::
    Socket mode option Net exchange mode option FTP mode option to transfer data
  :::column-end:::
  :::column:::
    Memory pipes filesystem dump
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Migration check service
  :::column-end:::
  :::column:::
    Migration check service required for classical approach on productive systems
  :::column-end:::
  :::column:::
    No migration check service required for DMO on productive systems.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitoring progress
  :::column-end:::
  :::column:::
    Distribution monitor and migration monitor tools available
  :::column-end:::
  :::column:::
    Built-in SAPUI application for monitoring progress
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Post-migration consistency check
  :::column-end:::
  :::column:::
    Process is manual and requires MIGCHECK tool and the time analyzer tool to generate reports
  :::column-end:::
  :::column:::
    Built-in feature in DMO
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table splitting
  :::column-end:::
  :::column:::
    Dedicated table splitting and package splitting tools available – R3TA, R3ZCHECK
  :::column-end:::
  :::column:::
    Table splitting is built-in and tuned
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Import and Export Table Splitting
  :::column-end:::
  :::column:::
    Table splitting for export and import can be changed on the fly
  :::column-end:::
  :::column:::
    Table splitting and sorting requires adjustment as part of uptime (not on the fly)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DDL statements
  :::column-end:::
  :::column:::
    Manual process to generate all DDL statements prior to migration
  :::column-end:::
  :::column:::
    Built-in process for DDL statement calculations and deployment
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SWPM, MIGMON, DISMON
  :::column-end:::
  :::column:::
    SWPM, Migration Monitor (MIGMON) and Distribution Monitor (DISTMON) can be started and stopped manually Not recommended to run from remote desktops for MIGMON tools
  :::column-end:::
  :::column:::
    No such option available in DMO No such restrictions in DMO
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Export/import
  :::column-end:::
  :::column:::
    Ability to add multiple application servers to run the export/import
  :::column-end:::
  :::column:::
    Only one application server can be used
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    R3 load process limit
  :::column-end:::
  :::column:::
    No limits
  :::column-end:::
  :::column:::
    Limit of 999 R3 load processes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table splits limit
  :::column-end:::
  :::column:::
    No limit on number of table splits
  :::column-end:::
  :::column:::
    Limit of 200 table splits
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Target DB
  :::column-end:::
  :::column:::
    anyDB (e.g. SAP HANA, SQL server, Oracle, DB2, etc.)
  :::column-end:::
  :::column:::
    Only SAP HANA, AS (other databases are available upon request)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SAP recommendation
  :::column-end:::
  :::column:::
    SAP recommended option if no software change is involved
  :::column-end:::
  :::column:::
    SAP recommended option if SAP upgrade is in scope
  :::column-end:::
:::row-end:::
