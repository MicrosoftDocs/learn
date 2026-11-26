The [Optimization agent](/azure/copilot/optimization-agent) helps you evaluate Azure Advisor cost recommendations for virtual machines (VMs) and Virtual Machine Scale Sets (VMSS). Use it to understand why Advisor flagged a resource and compare the estimated cost and carbon reductions of different sizes.

Choose the starting point that matches your question:

- **“Should we resize this VM?”** In Azure Advisor's cost recommendations, select **Optimize** beside the affected resource. Alternatively, choose **New chat > Optimization** in Azure Copilot and supply the resource ID or subscription ID if the scope is unclear.
- **“Which services drove last month's bill?”** Use [Azure Copilot with Microsoft Cost Management](/azure/copilot/analyze-cost-management) at the relevant billing or subscription scope. This explains past spending across services; a resize recommendation answers a different question.

## Compare sizes against peak demand

Suppose Advisor flags a reporting VM that uses little CPU most days. Ask the agent, “Why is this size recommended? Compare it with an alternative and show the estimated cost and carbon reductions relative to the current VM.”

The workload owner knows that the month-end report needs 12 GiB of memory. An 8-GiB candidate can't run that report, even if it offers the largest estimated savings. For a 16-GiB candidate, check CPU, storage, and networking limits, then compare its estimated cost and carbon reduction with keeping the current size.

:::image type="content" source="../media/optimization-peak-memory.svg" alt-text="Diagram that shows an 8 GiB VM falls short of the 12 GiB report requirement, while a 16 GiB VM meets the memory requirement.":::

Check which dates Advisor analyzed. Its [default lookback for resize recommendations is seven days](/azure/advisor/advisor-cost-recommendations#resize-sku-recommendations), so it can miss month-end. Before approving a resize, record the report's completion time, application latency, and resource use on the current VM during a representative month-end run. If the lookback missed the peak, use retained monitoring data from that run or wait for the next one. Low usage can also reflect capacity held for disaster recovery. If neither candidate meets the workload's requirements, keep the current size.

Before choosing a size, check reservation and savings plan coverage and effective costs in Cost Management. [Advisor estimates savings at retail rates](/azure/advisor/advisor-cost-recommendations#limitations); it doesn't account for your discounts, reservations, or savings plans. Moving the reporting VM to a family outside your reservation could increase your bill even if Advisor shows a saving.

## Plan and verify the resize

For a scale set, first check what Advisor recommends changing:

- **Fewer instances of the current size:** Can the remaining instances handle peak demand if one fails? If Azure Monitor autoscale manages the count, check the active profile's minimum, maximum, and rules. With a minimum of three, for example, a manual reduction to two won't hold: [autoscale returns the count to at least three](/azure/azure-monitor/autoscale/autoscale-best-practices#manual-scaling-is-reset-by-autoscale-minimum-and-maximum). Review the recommendation with the owner rather than lowering a minimum that protects availability.
- **A different VM size (SKU):** Check the orchestration mode and hardware before choosing a rollout. If a Uniform scale set's current hardware can't host the new SKU, [its VMs must be deallocated before the SKU change](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-upgrade-scale-set#properties-that-require-deallocation-to-change). Rolling updates can't keep those VMs available during deallocation. If the workload must stay online, have the owner choose a compatible size or approve a separate plan that maintains availability.

For a SKU change that can proceed, check the [upgrade policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-upgrade-policy#upgrade-policy-modes). **Manual** leaves existing instances at their current size until you update them. **Rolling** updates them in batches. **Automatic** doesn't guarantee an update order and can take all instances down at once. Have the scale-set owner approve the rollout and verify instance and application health as it proceeds.

Use the following procedure for the single reporting VM. Don't use its script on a scale set.

1. Ask the agent for an **Azure CLI or PowerShell** script for the size you selected. Before running it, verify the subscription, target VM, and exact size. Check that the size is available for that VM and supports its disks and networking.
1. Before taking the VM offline, open the target subscription's **Usage + quotas**. Check **Total Regional vCPUs** and the target VM family's vCPU quota in that region. Even a smaller VM can exceed its new family's quota. If either limit would be exceeded, resolve the shortfall or choose an approved alternative first. [Sufficient quota doesn't reserve compute capacity](/azure/virtual-machines/quotas#quota-and-capacity) on the required hardware or in the zone.
1. Check whether the reporting VM belongs to an [availability set](/azure/virtual-machines/sizes/resize-vm?tabs=powershell#change-the-vm-size). If the target size isn't available on its current hardware cluster, moving the set to another cluster can require deallocating **every VM in the set**. Don't run a script that stops peers under a change approved for one VM. Choose a compatible size on the current cluster or arrange a separate maintenance window with all affected owners.
1. Check the reporting VM's OS disk type and where it writes its results. Copy any results you need from the [temporary disk](/azure/virtual-machines/managed-disks-overview#temporary-disk) to persistent storage before resizing. Temporary storage isn't durable, even if the OS disk is persistent.

   > [!WARNING]
   > A persistent OS disk keeps its contents across a resize. Resizing a VM with an [ephemeral OS disk](/azure/virtual-machines/ephemeral-os-disks) reprovisions the OS and discards local OS changes. Don't use the usual deallocate/start procedure for that VM. Stop and plan the rebuild with the workload owner.

1. Plan for an interruption: [resizing a running VM restarts it](/azure/virtual-machines/sizes/resize-vm), and some changes require deallocation first. If the script explicitly deallocates a VM with a persistent OS disk, make sure it explicitly starts the VM after a successful resize. Agree on a maintenance window with the workload owner.
1. Identify the address clients use. When you deallocate an Azure Resource Manager VM but keep its network interface (NIC) on the same subnet, the [dynamically assigned private IP address is retained](/azure/virtual-network/virtual-networks-faq#do-private-ip-addresses-change-for-vms-in-a-virtual-network). A [Standard public IP address](/azure/virtual-network/ip-services/public-ip-addresses#sku) is static and stays the same while you keep the public IP resource. If you delete and recreate the NIC or public IP resource, don't assume its replacement will have the same address.
1. Run the reviewed script during the maintenance window. Check the outcome of the resize and any required start. The configured size can show the requested size after a failure, and a successful report doesn't prove the resize succeeded. If either operation fails, inspect its error in the **Activity log** and check the VM's current [power state](/azure/virtual-machines/states-billing#power-states-and-billing).

   - If the VM is still running, check whether the report endpoint is serving clients on the previous size.
   - If the VM with a persistent OS disk is deallocated, the report might be offline. Notify the workload owner. After an [allocation failure](/troubleshoot/azure/virtual-machines/windows/allocation-failure#symptom), capacity isn't guaranteed even for the previous size. Based on the error, retry the start or select an authorized, compatible size and start the VM.

1. Before declaring recovery, confirm the VM's **Status** is **Running** on its **Overview** page and test the expected report endpoint from a client. Check DNS and any allowlists. After a successful resize, run the same representative report and compare its completion time, application latency, and resource utilization with the pre-resize baseline.
