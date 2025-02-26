During the Go Live phase, ensure to follow the playbooks you developed in earlier phases. Execute the steps that you tested and trained. Don't accept last-minute changes in configurations and process. In addition, apply the following measures:

1. Verify that monitoring is operational. Recommended monitoring approach includes Azure portal, Azure Monitor as well as Perfmon for Windows and SAR for Linux. Monitor the following counters:

     - **CPU counters**

         - Average CPU time – total (all CPU)
         - Average CPU time – each individual processor (so 128 processors on m128 virtual machine)
         - CPU time kernel – each individual processor
         - CPU time user – each individual processor
     - **Memory**

         - Free memory
         - Memory Page in/sec
         - Memory Page out/sec
     - **Disk**

         - Disk read kb/sec – per individual disk
         - Disk reads/sec – per individual disk
         - Disk read ms/read – per individual disk
         - Disk write kb/sec – per individual disk
         - Disk write/sec – per individual disk
         - Disk write ms/read – per individual disk
     - **Network**

         - Network packets in/sec
         - Network packets out/sec
         - Network kb in/sec
         - Network kb out/sec
2. After the migration of the data, perform all the validation tests you agreed upon with the business owners. Accept validation test results only if you have results for the original source systems.
3. Verify that all interfaces are functioning and that applications can communicate with the newly deployed production systems.
4. Validate the transport and correction system through SAP transaction STMS.
5. Perform database backups once the system is released for production.
6. Perform virtual machine backups for the SAP application layer virtual machines once the system is released for production.
7. For SAP systems that were not part of the current Go Live phase, but communicate with the SAP systems that you moved into Azure in the current Go Live phase, you need to reset the host name buffer in SM51. This step will purge the cached IP addresses associated with the names of the application instances you moved into Azure.
