Downtime-optimized DMO is a migration option where large tables are migrated as part of the uptime phase. Triggers will capture the changes that can be replayed back as part of the downtime process. As of June 2019, this scenario is on a service-based, project-only basis and SAP Support must be involved in the migration execution. Refer to [SAP Note \#2442926](https://launchpad.support.sap.com/#/notes/2442926).

In the table below, see the comparison between Classic DMO and Downtime-optimized DMO.

:::row:::
  :::column:::
    **Classic DMO**
  :::column-end:::
  :::column:::
    **Downtime-optimized DMO**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DMO can be performed by any resource
  :::column-end:::
  :::column:::
    A SAP employee needs to execute the project and is an SAP Services-based project only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    All tables are replicated as part of the downtime
  :::column-end:::
  :::column:::
    Large tables are replicated as part of the uptime using SLT
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Longer downtime duration
  :::column-end:::
  :::column:::
    Reduced downtime duration
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    All scenarios are supported
  :::column-end:::
  :::column:::
    Scenario "DMO without software update" can be combined with "downtime-optimized DMO". Scenario "DMO with system move" does not support "downtime-optimized DMO"
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    No need to add the DMIS in stack.xml generation
  :::column-end:::
  :::column:::
    Manually add DMIS in Maintenance Optimizer (MOPZ) to create the stack configuration file (stack.xml)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    No Restrictions
  :::column-end:::
  :::column:::
    Products supported: SAP ECC 6.0 and higher SAP CRM 7.0 and higher
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    No Restrictions
  :::column-end:::
  :::column:::
    Restrictions on Tables that cannot be replicated in uptime:

 -  Basis tables containing deep components (e.g. STRG)
 -  Pool tables
 -  Application exchange tables (transferred in uptime anyhow)
 -  Tables to be converted
 -  Tables without primary key
 -  Tables that start with /BI in the name
 -  Tables from Transport Management System (TMS) starting with E07\*


  :::column-end:::
:::row-end:::


## Near-zero downtime (NZDT)

NZDT uses clone-based methodology and following the cloning of the production system, DMO executes on the clone. Transaction activities are captured from the production system and replayed back to the clone system. For details, refer to [SAP Note \#693168](https://launchpad.support.sap.com/#/notes/693168).

> [!NOTE]
> NZDT and downtime-optimized DMO are not yet supported for cloud migrations.
