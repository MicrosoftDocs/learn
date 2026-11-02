In this paper exercise, you act as Contoso's platform deployment reviewer. 

> [!NOTE]
> You don't need a subscription, cluster, parameter file, or credentials. All records below are fictional, simplified teaching evidence, not captured product logs.

Using your own separate notes, make a short decision for each phase: **proceed or hold**, note the evidence supporting that decision, the responsible owner, and the next authorized action. Examine the suggested answers only after recording your decisions.

## Phase A: Review readiness

Contoso proposes a two-node AD DS-based hyperconverged deployment. The change record contains the following evidence.

| Record | Supplied evidence |
| --- | --- |
| Hardware | Both nodes match the approved OEM image, firmware, driver, and extension baseline |
| Directory | The OU and lifecycle deployment account are prepared and delegated |
| Arc | Both Azure Local nodes are connected in the intended resource group |
| Template | A template was approved last week, but the operator downloaded "latest" today without comparing revisions |
| Azure permissions | The deployment caller has Contributor, but no role-assignment authority has been established for the template's role assignments |
| Addresses | The proposed infrastructure pool contains six addresses, but two are already assigned to the nodes |
| Adapters | The second node's documented storage-port mapping disagrees with the parameter file |
| Storage and witness | `configurationMode` is `InfraOnly`, `witnessType` is `Cloud`, and a dedicated witness account is planned |
| Checks | `Test-AzResourceGroupDeployment` returned no findings, but no target-environment validation results are attached |

Answer these questions:

1. Is this deployment ready to enter `Deploy`?
1. Which four explicit contract defects need correction, and which team owns each?
1. What additional readiness evidence is missing?
1. Are `InfraOnly` and the cloud witness defects in this scenario?

## Phase B: Diagnose and recover

Assume the readiness defects were corrected, the supported `Validate` phase completed, and `Deploy` began. The restricted incident record now contains:

```text
09:04  A required credential retrieval reports access denied.
09:05  The dependent extension cannot complete configuration.
09:08  The resource bridge deployment stage reports failure.
09:10  Azure Local shows Deployment failed.
```

An engineer suggests rerunning the ARM template with `deploymentMode` set to `Validate`. Another suggests deleting the custom location and creating a replacement bridge.

Answer these questions:

1. What's the first dependency to investigate, and what evidence identifies its consumer?
1. Why are the proposed recovery actions inappropriate?
1. After the confirmed dependency is repaired, what determines the next action?
1. How would your response change if local orchestration were still running?

## Phase C: Assess handover

Assume the supported recovery completed. The commissioning record contains:

| Evidence | Observation |
| --- | --- |
| Cloud operation | Deployment succeeded, and the identifiers and template revision were retained |
| Membership | Both expected nodes are available, and the intended cloud witness is configured |
| Storage | Infrastructure volumes are present, but a storage repair job is still active |
| Network | Expected intents report healthy, and DNS and endpoint checks are current |
| Workload management | Bridge and VM extension report healthy, and the expected custom location exists |
| Workload resources | The image and workload network are ready, but workload storage paths haven't been created |
| Recovery | Encryption is enabled, but recovery-material custody hasn't been recorded |

The application team asks for production workload admission immediately.

Answer these questions:

1. Can you approve an unrestricted workload-ready handover?
1. Which observations are blockers, and which expected deployment choice explains one of them?
1. What evidence must the owners provide before the handover can proceed?

## Suggested solution

> [!NOTE]
> Only review the suggested solution after you've attempted to complete the exercise above.

**Phase A: Hold.** The current evidence doesn't justify `Deploy`.

The template revision is no longer tied to the approval. The platform/change owner must compare and pin the complete template set. The Azure governance owner must establish the documented role-assignment authorization without granting unnecessary broad access. The network/addressing owner must reserve at least six appropriate available infrastructure addresses, separate from the node addresses. The platform and network owners must reconcile the second node's adapter mapping with the physical connections.

Target-environment readiness evidence is also missing. Passing the non-deploying ARM check doesn't prove the Azure Local nodes satisfy the environment requirements. After the contract defects are corrected, authorize the documented `Validate` phase and review its findings.

`InfraOnly` isn't a defect because deferred workload storage was approved. The two-node hyperconverged cloud witness is appropriate to the scenario. Neither choice proves the rest of the system is ready.

**Phase B: Investigate credential retrieval first.** Determine the actual identity that attempted retrieval, the secret/version, the access method, the requested action, and the relevant vault authorization and connectivity. Correlate cloud and local operation identifiers. Don't assume that the human deployment caller is also the runtime secret consumer.

Validation already completed and the system is now in **Deployment failed** state. The license-sync warning makes another `Validate` submission inappropriate. Deleting the custom location or replacing the bridge would alter orchestrator-owned state without repairing the confirmed dependency.

Once the owner corrects the dependency, use the supported recovery/resume procedure for that failed stage and workflow. If local orchestration is still active, don't submit a competing deployment. Confirm progress, preserve evidence, and escalate ambiguity.

**Phase C: Hold unrestricted workload admission.** Cloud success is only one part of acceptance.

The storage owner must establish acceptable storage health and resiliency after investigating the repair activity. The platform/storage owner must create and verify the planned workload volumes and storage paths. Their absence is explained by `InfraOnly`, but still blocks the requested workload-ready scope. The security/operations owner must record and verify the protected recovery-material custody process.

Collect current evidence after those actions, complete the approved workload-management checks, and document operational ownership. Only then make the workload-ready handover decision. Application owners must still certify their application.

## Check your reasoning

A complete response distinguishes the four contract defects from missing evidence, treats `Validate` as a real change, follows the actual secret consumer rather than a guessed identity, avoids unsupported recovery, and refuses to equate Azure success with production workload readiness.
