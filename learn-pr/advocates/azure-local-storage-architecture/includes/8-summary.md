In this module, you explored how Azure Local provides storage through Storage Spaces Direct, qualified external arrays, and supported combinations of both. You traced the layers from physical capacity to workload placement and distinguished hyperconverged, disaggregated, and rack-aware configurations. You learned why local-drive protection, array protection, filesystems, and deployment limits must be evaluated within the selected architecture rather than combined across different support models.

You compared mirroring, parity, and nested resiliency, balancing fault protection against capacity efficiency and performance. You calculated a workload budget by separating physical footprint from logical capacity and accounting for overhead, infrastructure, growth, and repair reserve. You also identified why guest free space and expected deduplication savings can't substitute for usable physical headroom.

You examined how failure domains, redundant access paths, cluster quorum, pool quorum, and witnesses contribute to availability. A witness helps arbitrate cluster ownership, but it doesn't supply missing workload data. Even when storage remains accessible, VM placement, surviving compute capacity, and application recovery determine whether service can resume. Hyperconverged rack-aware requirements remain distinct from those of the disaggregated rack-aware SAN preview.

You distinguished hardware availability from data integrity, including the limits of ReFS file-data checksums and redundant copies. You used continuous monitoring and a failure-scenario matrix to identify reduced protection, missing evidence, and recovery milestones. You also separated storage repair, resynchronization, and rebalancing from restoring data to a known-good application state.

Finally, you reviewed volume lifecycle requirements and ReFS deduplication, recognizing that maintenance must preserve supported configurations and resources needed for recovery. For the manufacturing scenario, a successful design must retain authoritative ownership, accessible data, and sufficient resources after the specified rack failure, then demonstrate application recovery. Returning hardware to service isn't sufficient until the required storage protection is restored. Independent recovery points and a usable recovery location remain necessary for failures and unwanted changes that live storage replicas don't protect against.

## More info

- [Azure Local release information](/azure/azure-local/whats-new?view=azloc-2610&preserve-view=true)
- [Find your deployment type](/azure/azure-local/plan/find-your-deployment-type?view=azloc-2610&preserve-view=true)
- [External storage support](/azure/azure-local/concepts/external-storage-support?view=azloc-2610&preserve-view=true)
- [SAN requirements](/azure/azure-local/concepts/san-requirements?view=azloc-2610&preserve-view=true)
- [Azure Local system requirements](/azure/azure-local/concepts/system-requirements-23h2?view=azloc-2610&preserve-view=true)
- [Rack-aware cluster requirements](/azure/azure-local/concepts/rack-aware-cluster-requirements?view=azloc-2610&preserve-view=true)
- [Deploy a rack-aware cluster in the portal](/azure/azure-local/deploy/rack-aware-cluster-deploy-portal?view=azloc-2610&preserve-view=true)
- [Deploy a disaggregated rack-aware cluster with SAN storage (preview)](/azure/azure-local/deploy/deploy-rack-aware-cluster-storage-area-network?view=azloc-2610&preserve-view=true)
- [Storage Spaces fault tolerance](/windows-server/storage/storage-spaces/fault-tolerance)
- [Create volumes in Storage Spaces Direct](/windows-server/storage/storage-spaces/create-volumes)
- [Manage volumes in Azure Local and Windows Server](/windows-server/storage/storage-spaces/manage-volumes)
- [Nested resiliency](/windows-server/storage/storage-spaces/nested-resiliency)
- [Cluster and pool quorum](/windows-server/storage/storage-spaces/quorum)
- [Quorum witnesses](/windows-server/failover-clustering/what-is-quorum-witness)
- [Deploy a witness](/windows-server/failover-clustering/deploy-quorum-witness)
- [ReFS deduplication](/azure/azure-local/manage/refs-deduplication-and-compression?view=azloc-2610&preserve-view=true)
- [ReFS integrity streams](/windows-server/storage/refs/integrity-streams)
- [Health Service in Azure Local](/azure/azure-local/manage/health-service-overview?view=azloc-2610&preserve-view=true)
- [Replace drives in Storage Spaces Direct](/windows-server/storage/storage-spaces/replace-drives)
- [Repair an Azure Local machine](/azure/azure-local/manage/repair-server?view=azloc-2610&preserve-view=true)
- [Suspend and resume Azure Local machines](/azure/azure-local/manage/suspend-resume-cluster-maintenance?view=azloc-2610&preserve-view=true)
- [Understand storage resynchronization](/windows-server/storage/storage-spaces/understand-storage-resync)
- [Monitor Azure Local with Insights](/azure/azure-local/manage/monitor-single-23h2?view=azloc-2610&preserve-view=true)
- [Monitor Azure Local with Azure Monitor metrics](/azure/azure-local/manage/monitor-cluster-with-metrics?view=azloc-2610&preserve-view=true)
