You typically need to be able to fail back from a DR to a production site. Let's look at a scenario in which the failover into the disaster recovery site was caused by problems in the production Azure region, and not by your need to recover lost data.

You've been running your SAP production workload for a while on the disaster recovery site. As the problems in the production site are resolved, you want to fail back to your production site. Because you can't lose data, the failback to the production site involves several steps and close cooperation with the SAP HANA on Azure operations team. It's up to you to trigger the operations team to start synchronizing back to the production site after the problems are resolved.

Follow these steps:

1.  The SAP HANA on Azure operations team gets the trigger to synchronize the production storage volumes from the disaster recovery storage volumes, which now represent the production state. In this state, the HANA Large Instance unit in the production site is shut down.
2.  The SAP HANA on Azure operations team monitors the replication and makes sure that it's caught up before they inform you.
3.  You shut down the applications that use the production HANA Instance in the disaster recovery site. You then perform a HANA transaction log backup. Next, you stop the HANA instance that's running on the HANA Large Instance units in the disaster recovery site.
4.  After the HANA instance that's running in the HANA Large Instance unit in the disaster recovery site is shut down, the operations team manually synchronizes the disk volumes again.
5.  The SAP HANA on Azure operations team starts the HANA Large Instance unit in the production site again. They hand it over to you. You make sure that the SAP HANA instance is in a shutdown state at the startup time of the HANA Large Instance unit.
6.  You perform the same database restore steps that you did when you previously failed over to the disaster recovery site.
