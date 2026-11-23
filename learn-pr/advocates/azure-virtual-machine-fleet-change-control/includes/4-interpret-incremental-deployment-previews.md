Azure Resource Manager (ARM) what-if compares the state described by a Bicep or ARM template and its parameters with the resources that exist in Azure. For an infrastructure as a service (IaaS) VM, it can predict a resize, a change to a disk attachment, or the creation of a managed Run Command resource. It doesn't inspect files inside Windows, execute the script, or send traffic through the load balancer. Use the preview to answer **which Azure resources and properties would change**. Use a separate per-VM application check to find out what users would see.

In **incremental mode**, leaving a *resource* out of the template is different from leaving a *property* out of a resource you redeclare. For example, if the template declares only a managed command under `fc-canary`, it doesn't redeploy `fc-later` just because both VMs share a resource group. But if the template redeclares `fc-canary` to change its size, the VM definition represents its intended final state. Omitted properties can reset to defaults. For a guest-only change, you can reference the parent VM as `existing` in Bicep and declare the command as its child without restating the VM's disks, size, or identity.

**How to read a preview.** Preview the exact targets, template, parameters, subscription, and mode for the wave under review. The command below deliberately names one VM because the first approval covers only the canary. For the pilot, repeat the review for the 19 actual targets or preview their combined deployment and reconcile every changed resource with the pilot manifest. Don't extrapolate the canary's preview to the other pools. The excerpts are illustrative; you don't need to run anything.

```azurecli
az deployment group what-if --subscription "<approved-subscription-id>" --resource-group rg-returns --template-file portal-change.bicep --parameters vmName=fc-canary --mode Incremental
```

**Example 1: the expected command is created.** Start with the resource path. The `+` below applies to `display-change`, a child of `fc-canary`, not to the VM itself:

```text
+ Microsoft.Compute/virtualMachines/fc-canary/runCommands/display-change
```

If that is the only predicted change, take the plan and the reviewed script to the portal workload owner for canary approval. It isn't evidence that the file now contains `green`. After an approved run, inspect the script's exit code and check that `fc-canary` itself serves `VmOpsDisplay:green`.

**Example 2: one modified VM hides two changes.** Suppose the summary says `1 to modify`. The property lines tell you whether the change fits the request:

```text
~ Microsoft.Compute/virtualMachines/fc-canary
  ~ properties.hardwareProfile.vmSize: "Standard_D2s_v5" => "Standard_D4s_v5"
  - properties.storageProfile.dataDisks[0]: { lun: 0, name: "returns-data" }
```

The `~` on `vmSize` predicts a resize, which could restart the VM. The indented `-` predicts removal of a disk **attachment**. It doesn't say the managed disk resource will be deleted, but the application could lose access to its data. A resize might be appropriate for a separately approved capacity change. Neither difference is appropriate for a support-link update. Hold the rollout, correct the template, and review a fresh preview.

**Example 3: the pool loses capacity even if the guest stays healthy.** A preview shows the canary's network interface losing membership in its ten-backend pool. The canary could still return `green` directly, but only nine backends would be eligible to serve that pool's public traffic. Reject the unrelated network change. A fleet-wide success rate or a healthy response from another pool would hide its effect.

If what-if reports that it couldn't evaluate a resource, treat that part of the plan as unknown, not unchanged. Compare the affected property with the current configuration and resolve the discrepancy before proceeding. Also review any steps *outside* the template: a separate command to delete `fc-excluded` wouldn't appear in what-if output for this deployment.

**Record P1: competing previews.** Both proposals claim to deliver the same canary change. These are summaries to read, not templates to deploy.

| Preview | Predicted resource changes |
|---|---|
| A | Redeclare `fc-canary`, remove its assigned identity, detach an existing data disk, and make an unresolved change to shared network rules. The proposal also includes a separate step to delete `fc-excluded`. |
| B | Keep `fc-canary` unchanged as a VM resource. Add only its `display-change` managed command child resource for script `S1`. No disk, network, identity, size, or deletion changes are predicted. |

**Reject proposal A**: Compare every planned action with the portal workload owner's request to update a support link. Your review entry could read: `P1-A: rejected. Removes the canary's identity, detaches a data disk, and leaves a shared network change unresolved.` Also record that the separate step to delete `fc-excluded` violates the explicit exclusion, even though it isn't part of the template preview. Return the plan for correction and request a fresh preview.

**Submit proposal B for canary approval**: Match `fc-canary` to instance `c-17` in manifest `M1` and confirm that the only predicted change is the `display-change` child resource for reviewed script `S1`. Record `P1-B: request portal workload owner approval for S1 on fc-canary only. No command sent.` What-if hasn't run the script or proved that the portal serves the new link. After an approved attempt, compare the exit code with a direct application check on `fc-canary`. If the script reports failure even though the VM returns `VmOpsDisplay:green`, record both results and hold the next VM.
