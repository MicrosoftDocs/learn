Disconnected operations is a purpose-built local management model, not an ordinary connected deployment left offline. Its production design includes a dedicated management cluster, separate workload capacity, supported local services, and explicit commercial and operational boundaries.

You learned how authentication, group synchronization, RBAC, certificates, DNS, and time support trustworthy management. You also practiced evaluating artifact integrity separately from authenticity, coordinating compatible updates across three layers, and checking workload dependencies rather than assuming public-cloud feature parity.

You connected workload onboarding to scoped policy enforcement, separated appliance protections from customer security responsibilities, and planned nonhuman credential rotation across issuing systems and consumers. You also considered how new vulnerability information changes artifact decisions and how to respond to compromise without relying on cloud-connected tooling.

Finally, you separated control-plane backup from workload protection and traced recovery through prerequisites, same-version restore, resource reconnection, re-registration where required, and application validation. Secure retirement completes that lifecycle by addressing resources, access, retained data, media, and commercial obligations separately.

A production-ready design can explain not only how a workload runs today, but how an authorized team will govern it, deploy it again, update it safely, respond to incidents, recover it, and eventually retire it without an unapproved external dependency.

## Reference documentation

The essential concepts are explained in the module. Use these references to confirm release-specific values and executable procedures when implementing your design.

- [Disconnected architecture, eligibility, and service catalog](/azure/azure-local/manage/disconnected-operations-overview?view=azloc-2610)
- [Platform expansion-pack lifecycle](/azure/azure-local/manage/disconnected-operations-platform-expansion-packs?view=azloc-2610)
- [Dedicated management-cluster hardware and topology](/azure/azure-local/manage/disconnected-operations-control-plane-appliance?view=azloc-2610)
- [Node preparation and certificate trust](/azure/azure-local/manage/disconnected-operations-prepare?view=azloc-2610)
- [Acquisition and compatible versions](/azure/azure-local/manage/disconnected-operations-acquire?view=azloc-2610)
- [Network planning](/azure/azure-local/manage/disconnected-operations-network?view=azloc-2610)
- [Identity integration and limitations](/azure/azure-local/manage/disconnected-operations-identity?view=azloc-2610)
- [Local resource-provider registration](/azure/azure-local/manage/disconnected-operations-deploy?view=azloc-2610#register-required-resource-providers)
- [Management-cluster bootstrap and Key Vault prerequisites](/azure/azure-local/manage/disconnected-operations-deploy?view=azloc-2610)
- [Local policy assignments and unsupported features](/azure/azure-local/manage/disconnected-operations-policy?view=azloc-2610)
- [PKI requirements](/azure/azure-local/manage/disconnected-operations-pki?view=azloc-2610)
- [Identity-provider and ingress certificate rotation](/azure/azure-local/manage/disconnected-operations-certificate-rotation?view=azloc-2610)
- [CLI versions and custom-cloud configuration](/azure/azure-local/manage/disconnected-operations-cli?view=azloc-2610)
- [Disconnected release announcements](/azure/azure-local/manage/disconnected-operations-whats-new?view=azloc-2610)
- [Version-scoped known issues](/azure/azure-local/manage/disconnected-operations-known-issues?view=azloc-2610)
- [Control-plane update procedure](/azure/azure-local/manage/disconnected-operations-update?view=azloc-2610)
- [Disconnected Azure Local instance updates](/azure/azure-local/manage/disconnected-operations-update-azure-local-instance?view=azloc-2610)
- [Security controls and recovery-material protection](/azure/azure-local/manage/disconnected-operations-security?view=azloc-2610)
- [Disconnected billing and licensing boundaries](/azure/azure-local/manage/disconnected-operations-billing?view=azloc-2610)
- [Fallback diagnostic collection](/azure/azure-local/manage/disconnected-operations-fallback?view=azloc-2610)
- [On-demand diagnostic collection and upload](/azure/azure-local/manage/disconnected-operations-on-demand-logs?view=azloc-2610)
- [Control-plane backup](/azure/azure-local/manage/disconnected-operations-back-up-restore?view=azloc-2610)
- [Control-plane restore](/azure/azure-local/manage/disconnected-operations-restore?view=azloc-2610)
- [Post-restore reconnection and re-registration](/azure/azure-local/manage/disconnected-operations-post-restore-overview?view=azloc-2610)
- [Version-specific management and data-cluster re-registration](/azure/azure-local/manage/disconnected-operations-post-restore-repair-register-management-cluster?view=azloc-2610)
- [Post-restore resource-bridge recovery](/azure/azure-local/manage/disconnected-operations-post-restore-recover-azure-resource-bridge-resources?view=azloc-2610)
- [Recovery of data clusters created after backup](/azure/azure-local/manage/disconnected-operations-post-restore-recover-data-cluster-created-post-backup?view=azloc-2610)
- [Disconnected Kubernetes overview](/azure/aks-hybrid-edge/local/disconnected-operations/overview)
- [Disconnected Kubernetes creation and management](/azure/aks-hybrid-edge/local/disconnected-operations/create-manage-cluster)
- [Azure Virtual Desktop on Azure Local connectivity requirements](/azure/virtual-desktop/azure-local-overview#limitations)
