Architecture selection joins workload support, connectivity, failure domains, measurable capacity, and accountable operations. Keep execution separate from management, physical cores separate from virtual allocation, and activation separate from entitlement. Approve the design only when its assumptions survive both failure analysis and support review.

You selected a deployment by capability before sizing it, traced both local and cloud dependencies, separated failover from backup and disaster recovery, and calculated usable resources in a stated failure condition. You also identified why catalog qualification, lifecycle management, licensing, and incident ownership are independent requirements.

The worked decision remains conditional: four nodes meet the example's one-unavailable-node memory envelope, but not a two-unavailable-node requirement. Neither that result nor the simplified storage calculation proves the application recovery targets. A defensible architecture preserves those limits instead of hiding them.

## More info

Use these sources to validate the selected architecture and commercial conditions.

- [Azure Local deployment selection and workload matrix](/azure/azure-local/plan/find-your-deployment-type?view=azloc-2610&preserve-view=true)
- [Azure Local Well-Architected guidance](/azure/well-architected/service-guides/azure-local)
- [Azure Local system requirements and hardware support](/azure/azure-local/concepts/system-requirements-23h2?view=azloc-2610&preserve-view=true)
- [Azure Local billing, deployment tiers, and payment](/azure/azure-local/concepts/billing?view=azloc-2610&preserve-view=true)
- [Azure Hybrid Benefit eligibility for Azure Local](/azure/azure-local/concepts/azure-hybrid-benefit?view=azloc-2610&preserve-view=true)
- [Windows Server subscription and virtual-machine activation](/azure/azure-local/manage/vm-activate?view=azloc-2610&preserve-view=true)
- [Extended Security Update eligibility and pricing boundaries](/azure/azure-local/manage/azure-benefits-esu?view=azloc-2610&preserve-view=true)
- [Get-CimInstance reference](/powershell/module/cimcmdlets/get-ciminstance)
- [Small-form-factor preview architecture](/azure/azure-local/small-form-factor/small-form-factor-overview?view=azloc-2610&preserve-view=true)
- [Deployment eligibility and multi-rack preview](/azure/azure-local/faq?view=azloc-2610&preserve-view=true)
- [Azure Local release information and servicing support](/azure/azure-local/release-information-23h2?view=azloc-2610&preserve-view=true)
- [Disaggregated architecture and scale](/azure/azure-local/overview/disaggregated-overview?view=azloc-2610&preserve-view=true)
- [Supported external storage configurations](/azure/azure-local/concepts/external-storage-support?view=azloc-2610&preserve-view=true)
- [Azure Local VM management components](/azure/azure-local/manage/azure-arc-vm-management-overview?view=azloc-2610&preserve-view=true)
- [Disconnected operations eligibility](/azure/azure-local/manage/disconnected-operations-overview?view=azloc-2610&preserve-view=true)
- [Storage Spaces Direct volume planning](/windows-server/storage/storage-spaces/plan-volumes)
- [Azure Local host-network requirements](/azure/azure-local/concepts/host-network-requirements?view=azloc-2610&preserve-view=true)
- [Disaggregated network patterns](/azure/azure-local/plan/network-patterns-overview-disaggregated?view=azloc-2610&preserve-view=true)
- [Solution Builder Extension lifecycle integration](/azure/azure-local/update/solution-builder-extension?view=azloc-2610&preserve-view=true)
