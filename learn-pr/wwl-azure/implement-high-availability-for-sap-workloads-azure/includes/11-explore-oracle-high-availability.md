Windows and Oracle Linux are the only operating systems supported by Oracle and Azure for SAP workloads. The widely used SLES and RHEL Linux distributions aren't supported for deploying Oracle components in Azure. Oracle components include the Oracle Database client, which is used by SAP applications to connect against the Oracle DBMS.

Exceptions, according to [SAP Note \#2039619](https://launchpad.support.sap.com/#/notes/2039619), are SAP components that don't use the Oracle Database client. Such SAP components are SAP's stand-alone enqueue, message server, Enqueue replication services, WebDispatcher, and SAP Gateway.

Even if you're running your Oracle DBMS and SAP application instances on Oracle Linux, you can run your SAP Central Services on SLES or RHEL and protect it with a Pacemaker-based cluster. Pacemaker as a high-availability framework isn't supported on Oracle Linux.

## Oracle Data Guard

[Oracle Data Guard](https://docs.oracle.com/en/database/oracle/oracle-database/19/sbydb/preface.html#GUID-B6209E95-9DA8-4D37-9BAD-3F000C7E3590) is supported for high availability purposes. To achieve automatic failover in Data Guard, you need to use Fast-Start Failover (FSFA). The Observer (FSFA) triggers the failover. If you don't use FSFA, you can only use a manual failover configuration.

With Data Guard, you can maintain an identical copy of a database on separate physical hardware. Ideally, that hardware should be geographically removed from the primary database. Data Guard places no limit on the distance, although distance has a bearing on modes of protection. Increased distance adds latency between sites, which can cause some options (such as synchronous replication) to no longer be viable.

Data Guard offers advantages over storage-level replication:

- As the replication is database-aware, only relevant traffic is replicated.
- Certain workloads can generate high input/output on temporary tablespaces, which aren't required on standby and so aren't replicated.
- Validation on the replicated blocks occurs at the standby database, so physical corruptions on the primary database aren't replicated to the standby database.
- Prevents logical intra-block corruptions and lost-write corruptions. It also eliminates the risk of mistakes made by storage administrators from replicating to the standby. Redo can be delayed for a predetermined period, so user errors aren't immediately replicated to the standby.
