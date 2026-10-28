In this exercise, you evaluate Contoso's fictional branch proposal without changing infrastructure. Your deliverable is a readiness decision, a finding register, and a retest plan. Allow about 15 minutes.

## Review the supplied evidence

The branch proposes two connected hyperconverged nodes with local identity and existing enterprise DNS. The intended solution and OEM combination are approved, but the evidence package contains the following observations.

| Item | Supplied evidence |
| --- | --- |
| Hardware | Node01 and Node02 match the approved model, CPU, drive population, NICs, and OEM software. Node02 reports Secure Boot disabled; TPM evidence is satisfactory |
| Azure access | The engineer has the two documented Arc onboarding roles at the resource group. Required providers are registered. No deployment-vault or Azure Stack HCI deployment roles have been established |
| Local account | Both nodes have the same approved non-built-in local administrator. Its expiry and rotation owner is recorded |
| Management tools | The operations plan names Windows Admin Center as the only administration tool |
| Vault | A dedicated vault is proposed. The proposal doesn't identify machine managed-identity grants or a postdeployment backup-verification owner |
| Address plan | Nodes use `192.168.50.21` and `.22`. The proposed infrastructure pool is `10.244.8.40` through `10.244.8.45`. DNS is `192.168.50.10` and `.11` |
| DNS and time | The normal DNS query fails on Node02, but a query to the approved resolver succeeds. Time checks identify the approved synchronized source on both nodes |
| Connectivity | A staging workstation passes Arc for Servers connectivity. The firewall owner confirms that cloud witness access isn't allowed from either node |
| Reports | The package contains only the latest staging report; the previous failed report was overwritten |

The address plan reserves six addresses, but quantity alone doesn't establish suitability. Similarly, existing accounts and a proposed vault don't establish a complete identity operating model.

## Make your decision

Complete the following tasks before reading the worked answer:

1. State whether the deployment is accepted or blocked, and identify evidence that genuinely supports the proposal.
1. Identify each unresolved prerequisite, its owner, and the smallest appropriate corrective action.
1. Propose a corrected address allocation without changing the approved node or DNS addresses.
1. Define which checks must run from the actual nodes and what broader validation remains necessary.
1. Specify the evidence to preserve before retesting and the conditions for final acceptance.

For each finding, record the requirement, observed condition, owner, correction, retest, and disposition. Don't invent successful results for tests that haven't been performed.

## Compare with the worked answer

The correct decision is **blocked**. Useful evidence includes the matched OEM inventory, the satisfactory TPM results, provider registration, consistent approved local account, and healthy time source. Those facts remain useful, but they don't cancel the blockers.

The following table identifies each unresolved finding, the responsible owner and corrective action, and the evidence required for acceptance.

| Finding | Owner and corrective action | Required acceptance evidence |
| --- | --- | --- |
| Secure Boot disabled on Node02 | Hardware owner obtains and applies OEM-approved remediation, with recovery precautions | Secure Boot enabled on Node02; affected hardware checks rerun |
| Only onboarding authority established | Azure owner establishes the complete documented deployment permission set at the correct scopes | Effective deployment authority verified without exposing secrets |
| Unsupported administration-only plan | Platform operations owner adopts supported PowerShell and portal workflows | Approved runbook that doesn't depend on Windows Admin Center |
| Incomplete vault operating model | Identity and security owners establish human and machine grants, network requirements, and backup-verification ownership | Predeployment design approved; extension and recovery-content checks included in deployment handoff |
| Invalid infrastructure pool | Network owner replaces the reserved-range allocation with an approved pool on the management subnet | Nonoverlap, contiguous availability, and exclusion from other allocation verified |
| Node02 DNS failure | DNS owner investigates Node02's normal resolution path and corrects the proven cause | Required names resolve correctly from both nodes and relevant infrastructure |
| Witness access blocked | Network owner permits the documented witness flow from each node | Witness endpoint access verified independently of Arc connectivity |
| Inadequate report retention | Deployment engineer establishes protected, versioned evidence retention | New reports preserved before each rerun; historical evidence gap acknowledged |

A suitable **proposed** infrastructure pool for the scenario is `192.168.50.40` through `192.168.50.45`, with `.40` used by the system/cluster record. It's on the same example management subnet and separate from the node and DNS allocations. It isn't automatically accepted: the network owner must still establish availability, route nonoverlap, and reservation.

Don't use `10.244.8.40` through `.45`; those addresses lie within `10.244.0.0/16` and aren't on the approved management subnet. The original pool therefore fails for two reasons.

The staging report doesn't prove either node's effective connectivity. Rerun the affected connectivity checks from both nodes, verify the witness path, and complete hardware, software, local-identity, network, and Arc-integration validation as applicable. Run the network and final deployment checks at their documented stages; don't claim that an early staging test can replace them.

Before each rerun, preserve the current report, scope, module version, target inventory, timestamp, and approved change record. The overwritten historical report can't be recreated honestly. Record the gap, collect a new baseline, and retain subsequent results.

## Define the final acceptance gate

Contoso can accept predeployment readiness when the corrected configuration meets the selected support requirements, all blocking findings are closed, required validation has completed against the final environment, and warnings have evidence-backed dispositions.

The handoff must identify what's still a **postdeployment** obligation, including confirming actual recovery backups and extension health. A plan for those checks is necessary before deployment, but it isn't evidence that those checks have already succeeded.

A concise decision might read:

> Predeployment readiness is blocked pending the owned hardware, authorization, management-tool, address, DNS, witness, and recovery-design corrections. Existing matching inventory and time evidence are retained. Acceptance requires fresh, scoped reports and final workflow validation for the corrected baseline; postdeployment backup verification remains an explicit handoff requirement.
