

VLDB OS/DB migrations require additional levels of technical skill and also additional documentation and procedures. The purpose of this documentation is to reduce downtime and eliminate the possibility of data loss. The minimum acceptable documentation would include the following topics:

- Current SAP Application Name, version, patches, DB size, Top 100 tables by size, DB compression usage, current server hardware CPU, RAM, and disk.
- Data Archiving/Purging activities completed and the space savings achieved.
- Details on any upgrade, Unicode conversion, or support packs to be applied during the migration.
- Target SAP Application version, Support Pack Level, estimated target DB size (after compression), Top 100 tables by size, DB version and patch, OS version and patch, VM sku, VM configuration options such as disk cache, Write Accelerator, accelerated networking, type and quantity of disks, database file sizes and layout, DBMS configuration options such as memory, traceflags, resource governor.
- Security-related configuration, including network security groups, firewall settings, Group Policy, DBMS encryption settings.
- HA/DR approach and technologies, in addition to special steps to establish HA/DR after the initial import is finished.
- OS/DB migration design approach:

  - How many Intel R3load export servers
  - How many R3load import VMs
  - How many R3load processes per VM
  - Table splitting settings
  - Package splitting settings
  - Export and import monitor settings
  - List of secondary indexes to be removed from STR files and created manually
  - List of pre-export tasks such as clearing updates
- Analysis of last export/import cycle:

  - Which settings were changed?
  - What was the impact on the “flight plan”?
  - Is the configuration change accepted or rejected?
  - What tuning and configuration is planned for next test cycle?
- Recovery procedures and exception handling – procedures for rollback, how to handle exceptions/issues that have occurred during previous test cycles.
