When collection or a retry produces a different error, pause before making another change. For example, suppose Contoso's first command exited with code `23`, but Azure rejects the retry with `AuthorizationFailed` when the operator tries to update the extension. The first command ran inside the guest. The retry never reached it, so the corrected command is still untested. Record the denied action and resource scope, then check the operator's role assignment. Reinstalling the extension wouldn't fix the permission error and could erase evidence of the original failure. Use the symptom to choose the next check:

| Problem | Response |
|---|---|
| Authorization denied | Confirm subscription and resource scope; request only the required VM operation permission through the administrator |
| SSH unavailable | Test the already prepared console or use boot diagnostics; use Run Command only if its agent dependency is healthy |
| Extension remains **Transitioning** (Azure hasn't reported a final result) | Compare the sequence, handler progress, and elapsed time. Look for a blocked dependency or an input prompt before submitting another request |
| Handler log missing | Confirm publisher/type, actual version directory, operation time, and whether the handler ever started |
| Result truncated | Collect a narrower guest log slice through the independent channel; don't infer omitted lines never existed |
| Protected data appears in output | Stop sharing, secure the original, redact the copy, and follow the organization's exposure process |

After the workload owner accepts the recovery evidence, close out only the temporary access and resources used for the incident:

1. Keep the corrected configuration in its owning deployment. Removing an extension doesn't undo changes made by its scripts. Don't remove a working handler, the platform agent, a shared monitoring agent, or a workload script as routine cleanup.
1. Retire temporary credentials or emergency access through the approved account process. Confirm another management path still works first.
1. Inventory any repair VM, disks, snapshots, networking, Bastion, and monitoring resources with their owners. A repair VM needs available compute quota in the approved region. Deallocating a VM releases its compute capacity but doesn't delete its disks or stop all related charges. Remove only resources approved for disposal, never a shared resource group.
1. Record who owns the remaining resources and evidence. Retain the private originals for the approved period, then dispose of settings files and evidence copies according to policy.
