

Follow this guidance for the source export of VLDB systems:

- Purge technical tables and unnecessary data. For details, review [SAP Note \#2388483](https://launchpad.support.sap.com/#/notes/2388483).
- Separate the R3load processes from the DBMS server, an essential step to maximize export performance.
- R3load should run on a fast new Intel CPU. Don't run R3load on UNIX servers as the performance is poor. Two-socket commodity Intel servers with 128-GB RAM cost little and saves days or weeks of tuning/optimization or consulting time.
- Ensure there's a high-speed network, ideally 10 GB with minimal network hops between the source DB server and the Intel R3load servers.
- It's recommended to use physical servers for the R3load export servers – virtualized R3load servers at some customer sites didn't demonstrate good performance or reliability for extreme network throughput.
- Sequence larger tables to the start of the Orderby.txt.
- Configure semi-parallel export/import using signal files.
- Large exports benefit from unsorted export on larger tables. It's important to review the net effect of unsorted exports, as importing unsorted exports to databases that have a clustered index on the primary key is slower.
- Configure Jumbo Frames between source DB server and Intel R3load servers.
- Adjust memory settings on the source database server to optimize for sequential read/export tasks. For details, review [SAP Note \#936441](https://launchpad.support.sap.com/#/notes/936441).
