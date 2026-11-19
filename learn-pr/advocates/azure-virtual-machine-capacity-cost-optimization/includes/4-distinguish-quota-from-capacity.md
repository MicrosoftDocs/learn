The smaller VM looks like a good fit for Atlas, but can Azure provide it in the chosen zone? Even with enough regional and VM-family quota, a subscription restriction can rule out that size in the zone, or Azure might have no suitable host available when you need it. In this unit, you use catalog restrictions, quota records, and allocation errors to identify what's blocking a resize and decide whether to request more quota, use an approved alternative, or stop before disrupting the workload.

## Follow the allocation decision gates

Quota limits how many resources a subscription can consume. Capacity is the hardware Azure can actually assign for the requested size and placement at the time of allocation. A size appearing in the catalog proves neither. Use each of the following checks as a decision gate before approving disruption:

1. Check that the exact target supports the operating system, disks, network, security, and application.
1. Check that the subscription can use the size in the target region and, if required, the selected availability zone (an isolated group of datacenters within that region). A restriction can block a size even when quota remains.
1. Count the complete planned deployment against two separate vCPU limits: the total for the region and the limit for the relevant family of related sizes, such as Dsv5. Both must have room.
1. Check where Azure is allowed to place the VM. An availability set distributes VMs across hardware-failure and maintenance groups, while a proximity placement group keeps them close for low latency. Either can limit which hosts are eligible. If the plan relies on an existing capacity reservation, check its size, location, and remaining reserved quantity.
1. Confirm a realistic fallback and budget before attempting allocation.
1. Treat the actual allocation result as new evidence; stop or use only a preapproved alternative when it fails.

Read the decision tree from top to bottom. If a check fails, follow its branch to the right: a quota increase can address a vCPU limit, but it can't make hardware available in a particular zone.

:::image type="content" source="../media/allocation-decision-gates.svg" alt-text="Diagram that shows six allocation checks and what to do if one fails. Only a successful allocation confirms hardware is available for the VM.":::

For reference, an authorized operator can use this read-only Azure CLI query to inspect the catalog entry, or stock-keeping unit (SKU), in a specific subscription and region. It returns capabilities and restrictions, not a count of available hosts. The examples below supply the evidence you need without running the query.

```powershell
az vm list-skus --subscription "<subscription-id>" --location "<approved-region>" --resource-type virtualMachines --size Standard_D2s_v5 --all --query "[?name=='Standard_D2s_v5']" --output json
```

The `--all` option includes restricted entries; the exact-name query avoids partial size matches and retains the complete selected records. Save the response, retrieval time, command outcome, subscription, region, and selected zone or nonzonal placement. For a fresh canary, also inspect the starting D4s v5 size by replacing both occurrences of `Standard_D2s_v5`.

Inspect `locationInfo` and each restriction's `type`, `values`, `restrictionInfo`, and `reasonCode`. A location restriction must apply to the selected region; a zone restriction must apply to that region and the selected zone. Use `restrictionInfo.locations` and `restrictionInfo.zones` where provided. A restriction on another zone doesn't by itself rule out your selected zone.

An empty restriction list isn't a capacity guarantee. A failed query or missing size record leaves eligibility unresolved; obtain the missing evidence before disruption. Keep catalog restrictions separate from quota, the current hardware cluster's resize options, and the actual allocation result.

In the portal, **Subscriptions** > the selected subscription > **Usage + quotas** shows regional and family limits. Count retained VMs and any proposed test copy. Shutting down the guest leaves its compute hardware allocated. Deallocating the VM releases that hardware but doesn't delete the VM or automatically remove its quota usage. A separate canary can therefore require additional quota even when its target is smaller than the source.

The baseline quota fixture has 20 regional vCPUs used out of 32 and 8 Dsv5-family vCPUs used out of 16. Creating a separate four-vCPU canary produces 24 of 32 regional and 12 of 16 family usage. Both gates pass, but actual capacity remains unproven.

## Classify recorded failures

Use recorded failures rather than consuming quota or repeatedly creating machines to force a failure. The messages below are shortened, synthetic examples. Times are in Coordinated Universal Time (UTC).

Q1 and Q2 returned the same error code, but different quota limits blocked the requests. S1 shows a different kind of evidence: the catalog lookup succeeded and revealed a restriction before any resize was attempted.

| Case | Time (UTC) | Operation | Error code or restriction reason | What happened |
|---|---|---|---|---|
| Q1 | 08:00 | create | `OperationNotAllowed` | The region has a quota of 32 vCPUs. With 30 in use, only 2 remain for a request of 4. |
| Q2 | 08:05 | create | `OperationNotAllowed` | The region has 12 vCPUs available under its quota, but all 16 vCPUs in the VM-family quota are in use. The request needs 2 more. |
| A1 | 08:10 | start | `ZonalAllocationFailed` | Quota is sufficient, but the target size is unavailable in the selected zone. |
| C1 | 08:15 | resize | `InvalidParameter` | The target size supports 4 data disks, but the VM has 5 attached. |
| P1 | 08:20 | resize | `AllocationFailed` | The existing availability set restricts allocation to its current hardware cluster. |
| S1 | 08:25 | catalog lookup | `NotAvailableForSubscription` | The lookup succeeded. The target size is restricted for this subscription in the selected placement, so the operator didn't attempt the resize. |

The next-action table separates problems that otherwise look similar.

| Cases | Classification | Appropriate next action |
|---|---|---|
| Q1 and Q2 | Regional or family quota | Request a quota increase for review or reduce the approved footprint. Don't retry blindly. |
| A1 | Actual zonal capacity | Use an approved size or placement alternative, retry only within the approved time or attempt limit, or abort. |
| C1 | Size compatibility | Select a compatible target or redesign through change control |
| P1 | Placement-constrained allocation | Check whether the current cluster (the group of hosts available to this set) supports the size. Don't stop peer VMs without separate approval. |
| S1 | Subscription size restriction | Verify the subscription's entitlement to use the size in that location, not the operator's access role. Resolve the restriction or select an approved alternative. Retrying won't change eligibility. |

An availability-set resize can require deallocating all members if the requested size is unavailable on the current cluster. Approval to resize one VM doesn't authorize disruption to its peers.

## Separate pricing commitments from capacity commitments

A reserved VM instance (VM reservation) discounts matching VM usage over an agreed term. A savings plan instead commits you to a fixed spend per hour for discounted rates on eligible usage. If no eligible workload uses the coverage, you still pay for the unused commitment. Neither discount reserves the hardware needed for a resize.

An on-demand capacity reservation reserves a specific size, location, and quantity after Azure accepts the reservation. Creation itself requires quota and available capacity. A VM must be associated with the matching reservation to consume it, and unused reserved capacity incurs charges. Its availability commitment is subject to the applicable service terms.

An association with a capacity reservation group doesn't prove that a reserved slot is free. If the matching reservation is fully used, another VM may still be allocated when quota and hardware are available, but the reservation's capacity availability service-level agreement (SLA) doesn't cover that extra VM. Purchasing discounted pricing doesn't resolve an allocation failure.
