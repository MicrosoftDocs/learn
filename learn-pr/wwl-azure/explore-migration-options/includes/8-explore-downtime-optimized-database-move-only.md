Downtime-optimized DMO is a migration option where large tables are migrated as part of the uptime phase. Triggers capture the changes that can be replayed back as part of the downtime process. As of June 2019, this scenario is on a service-based, project-only basis and SAP Support must be involved in the migration execution. Refer to [SAP Note \#2442926](https://me.sap.com/notes/2442926).

The following table displays a comparison between Classic DMO and Downtime-optimized DMO:

| Feature | Classic DMO | Downtime-optimized DMO |
|--|--|--|
| Resources | DMO can be performed by any resource | A SAP employee needs to execute the project and is an SAP Services-based project only |
| Downtime table replication | All tables are replicated as part of the downtime | Large tables are replicated as part of the uptime using SLT |
| Downtime | Longer downtime duration | Reduced downtime duration |
| Scenario compatibility | All scenarios are supported | - Scenario "DMO without software update" can be combined with "downtime-optimized DMO".<br>- Scenario "DMO with system move" doesn't support "downtime-optimized DMO" |
| DMIS | No need to add the DMIS in stack.xml generation | Manually add DMIS in Maintenance Optimizer (MOPZ) to create the stack configuration file (stack.xml) |
| Products | No restrictions | Products supported: SAP ECC 6.0 and higher SAP CRM 7.0 and higher |
| Uptime table replication | No restrictions | Restrictions on tables that cannot be replicated in uptime:<br><br>- Basis tables containing deep components (e.g. STRG)<br>- Pool tables<br>- Application exchange tables (still transferred in uptime)<br>- Tables to be converted<br>- Tables without primary key<br>- Tables that start with /BI in the name<br>- Tables from Transport Management System (TMS) starting with E07\* |

## Near-zero downtime (NZDT)

NZDT uses clone-based methodology and following the cloning of the production system, DMO executes on the clone. Transaction activities are captured from the production system and replayed back to the clone system. For details, refer to [SAP Note \#693168](https://me.sap.com/notes/693168).

> [!NOTE]
> NZDT and downtime-optimized DMO aren't yet supported for cloud migrations.
