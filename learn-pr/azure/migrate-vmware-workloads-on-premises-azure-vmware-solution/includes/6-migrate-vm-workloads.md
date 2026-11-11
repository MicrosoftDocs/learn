After you connect the on-premises VMware HCX Connector to Azure VMware Solution and establish a healthy service mesh, you can prepare Windows Server and Linux virtual machines (VMs) for migration. You configure and monitor migrations from the on-premises HCX Connector that initiated the site pairing.

Open the standalone Connector service UI at `https://<connector-ip-or-fqdn>` on TCP 443. Sign in with a vCenter SSO account in a group mapped to an HCX role that permits the required operations. The default Administrator mapping uses the local vSphere administrators group. The `https://<connector-ip-or-fqdn>:9443` endpoint is the appliance management interface and uses local `admin` credentials, not the SSO credentials for these operations.

> [!NOTE]
> The screenshots are historical examples; some show the vSphere Client plug-in. They illustrate the indicated actions. Use the standalone Connector service UI for the steps in this unit.

For the healthcare company's production workloads, evaluate HCX vMotion or Replication Assisted vMotion (RAV) against application availability requirements. This unit uses RAV for the live-migration example and Bulk Migration as an alternative for workloads with an approved outage. A healthy service mesh and supported software versions don't establish workload readiness on their own.

## Confirm workload readiness

Before migrating production VMs, confirm the following:

- The exact HCX, vCenter Server, and ESXi versions at both sites support the selected migration method. Review each VM's virtual hardware, devices, guest operating system, and application support requirements.
- For RAV, confirm that the VM uses hardware version 9 or later and that the source and destination CPU capabilities and EVC settings permit the live vMotion transition. Include reverse-migration compatibility in the recovery assessment.
- For Bulk Migration, confirm that VMware Tools is installed and that the VM meets the method's hardware and device requirements. Use a supported Tools version and verify guest shutdown behavior during the pilot.
- Identify VMs with vTPM, VM encryption, special disks or controllers, or other configurations restricted by the selected method. Stop and establish a supported migration and key-management plan for those VMs. Don't remove protection or change virtual hardware merely to bypass validation.
- The destination has sufficient CPU, memory, and datastore capacity, including temporary space needed for replication and cutover.
- Every virtual network adapter has a planned destination mapping. Verify DNS, authentication, required application connections, and firewall rules from the target network.
- The site pairing, service mesh, and required services are healthy. Run the available service-mesh diagnostics and measure underlay performance before estimating transfer and cutover windows.
- Application dependencies, migration order, cutover approval, recovery criteria, and a usable recovery point are documented. Record an application performance baseline and agree on acceptance criteria with the workload owner.

> [!NOTE]
> Azure Migrate can help discover and assess the source environment and its dependencies. VMware HCX performs the migration into Azure VMware Solution in this procedure.

Coordinate protection before starting each migration:

> [!IMPORTANT]
> Snapshot-based backup jobs and manual VM snapshots can interfere with HCX migration. Pause these operations only for the VMs being migrated before migration starts, and keep the pause in place until migration and switchover complete. Don't disable backups for unrelated VMs.
>
> Confirm a usable recovery point and agree on protection during the migration window. Where appropriate, use a supported file-level backup method that doesn't take VM snapshots. After cutover, resume or reconfigure protection for the destination VMs and confirm that a backup completes successfully.

After preparing the destination networks, use the appropriate walkthrough below to run a low-risk pilot before production waves. Record transfer time, cutover behavior, application availability, and post-migration performance. Complete the acceptance checks at the end of this unit, then use the results to adjust production wave sizes and maintenance windows.

## Prepare the destination networks

For each workload, decide whether to use HCX Network Extension or a prepared destination network without extension. If you're moving to a different subnet, plan and test the address changes and dependent DNS, routing, firewall, and application settings. You don't need to stretch every network.

### Configure an optional Network Extension

If you're retaining the source subnet through HCX Network Extension, complete and validate the extension before either migration walkthrough. Use your network plan's values, not the example addresses or names in the images.

1. Confirm that the source workload network uses supported distributed networking and was included in the compute profile's extension-eligible networks. Confirm that Network Extension is enabled and healthy in the service mesh.
2. From the standalone Connector service UI, select **Services** > **Network Extension** > **Create a Network Extension**.

    :::image type="content" source="../media/6-hcx-create-network-extension.png" alt-text="Screenshot of the action to create a network extension." lightbox="../media/6-hcx-create-network-extension.png":::

3. Select the appropriate service mesh and source workload network, then select **Next**.

    :::image type="content" source="../media/6-hcx-select-network-extension.png" alt-text="Screenshot of a source distributed port group selected for extension." lightbox="../media/6-hcx-select-network-extension.png":::

4. Under **Source Network to Extend**, enter the source network's existing **Gateway IP Address / Prefix Length**. Select the **Extension Appliance** that will carry the extended network and the **Destination First Hop Router** for the Azure VMware Solution network design. The latter identifies the cloud router associated with the destination segment; it doesn't move the VM's active default gateway to Azure during a basic extension.

    :::image type="content" source="../media/6-hcx-select-source-network-mandatory-fields.png" alt-text="Screenshot of the source gateway and prefix, extension appliance, and destination first-hop router fields." lightbox="../media/6-hcx-select-source-network-mandatory-fields.png":::

5. Review the settings and select **Submit**. Wait for successful extension status, then verify the destination network and connectivity before mapping VM adapters to it.

    :::image type="content" source="../media/6-hcx-network-extension-complete-status-green.png" alt-text="Screenshot of successful network-extension provisioning status." lightbox="../media/6-hcx-network-extension-complete-status-green.png":::

> [!IMPORTANT]
> In the basic stretched-network design, the default gateway remains at the source site. Selecting a destination first-hop router isn't an instruction to create a second active gateway with the same address. Plan the final gateway and routing transition separately. Mobility Optimized Networking is an optional design choice, not a requirement for this walkthrough.
>
> A green extension status doesn't prove that DHCP, DNS, authentication, or application traffic works.

### Allow DHCP across the extended network

Complete this procedure only when migrated VMs on the stretched network must obtain addresses from an on-premises DHCP server. NSX's default segment security settings block DHCP requests across the Layer 2 stretch.

1. In HCX **Network Extension**, identify the destination segment for the relevant extension.
2. Sign in to the Azure VMware Solution NSX Manager with an account authorized to manage that segment. Go to **Networking** > **Segments** > **Segment Profiles**.
3. Select **Add Segment Profile** > **Segment Security** and name the profile.
4. Keep **BPDU Filter** on. Set the **DHCP Server Block**, **DHCP Client Block**, **DHCPv6 Server Block**, and **DHCPv6 Client Block** controls to off for this stretched-network configuration. These controls block DHCP traffic; turning them off doesn't create a DHCP server. Save the profile.
5. In **Networking** > **Segments**, edit the affected destination segment. Under **Segment Profiles**, select the custom **Segment Security** profile and save the change. Don't change a shared default profile or unrelated workload segments.
6. With a pilot VM, verify lease acquisition or renewal from the intended DHCP server and the assigned gateway and DNS settings. Test routed connectivity through that gateway, DNS resolution, and application connectivity before migrating the production wave.

> [!IMPORTANT]
> Don't add an NSX DHCP relay merely to make DHCP work while the network is stretched. After the final unextend and gateway handoff, configure the destination DHCP service or relay required by the approved network design and test it again.

## Migrate virtual machines

For an Azure VMware Solution Generation 2 destination, RAV and Bulk Migration can experience slower performance and stalls during Base Sync and Online Sync. Use pilot results to allow longer replication windows and size migration waves before committing to a cutover window.

Choose the walkthrough that matches the approved migration method. Don't run both on the same VM as successive steps. In either workflow, validate the configuration before starting, even if the interface lets you select **Go** without validation.

If you changed an existing compute profile's service selection, use **Interconnect** > **Service Mesh** > **Resync** for the affected healthy mesh. Verify the resulting service selection and health before starting either walkthrough. Troubleshoot an unhealthy mesh rather than using Resync as a generic repair.

> [!IMPORTANT]
> Successful HCX validation checks the migration configuration. It doesn't replace application testing or guarantee that the workload will meet its service-level objectives after cutover.

You can also explore the existing [HCX migration click-through demo](https://regale.cloud/Microsoft/play/3210/hcx-migration#/0/0). Use your supported release's controls and approved migration plan for the actual operation.

### Use Replication Assisted vMotion for the live-migration example

RAV replicates disk data while the source VM runs and uses vMotion for the final live transition. It avoids a planned guest shutdown, but isn't a guarantee of uninterrupted application service. Confirm that the pilot meets the application's availability requirements.

Before continuing, confirm that HCX Enterprise is active. Confirm that **Hybrid Interconnect** and **Replication Assisted vMotion** are enabled in the applicable source and destination compute profiles and are enabled and healthy in the service mesh. Resolve unavailable services, entitlement issues, or compatibility errors first.

1. From the standalone Connector service UI, select **Services** > **Migration**, then select **Migrate**.

    :::image type="content" source="../media/6-hcx-services-migration.png" alt-text="Screenshot of the Migration page and Migrate action." lightbox="../media/6-hcx-services-migration.png":::

2. Confirm that the remote site connection identifies the intended source and Azure VMware Solution destination. Under **Select VMs for Migration**, select the source VMs for the approved wave, then select **Add**.

    :::image type="content" source="../media/6-hcx-migration-add-virtual-machines.png" alt-text="Screenshot of source VMs selected for addition to a migration." lightbox="../media/6-hcx-migration-add-virtual-machines.png":::

3. In **Transfer and Placement**, choose the destination compute container and datastore. Set the destination folder and disk format according to the placement plan.
4. Select **Replication-assisted vMotion** as the migration method. Expand each VM entry and verify that per-VM overrides use the intended method and placement.
5. Review **Switchover**, the switchover schedule, and any per-VM overrides. Align the live transition with the approved cutover window and application dependency order; don't leave its timing to unreviewed defaults.
6. Map every virtual network adapter to its intended destination network. If you're using Network Extension, confirm that its preparation and connectivity checks have completed.
7. Review the **Extended Options** available for RAV. Don't select virtual-hardware or EVC changes without reviewing their effect on the application and recovery plan. Select **Validate**, resolve blocking errors, and assess warnings. Repeat validation after changing the configuration.
8. Select **Go** to start migration. Monitor replication and switchover events through successful completion, then perform the workload acceptance checks below. A started job isn't a completed migration.

### Use Bulk Migration when an outage is approved

Bulk Migration replicates VM data while the source VM runs. During cutover, HCX shuts down the source VM, completes final synchronization and target preparation, and brings up the destination VM. Plan an application outage that can exceed a normal reboot. Use the pilot results to estimate the window rather than assuming a fixed duration.

Before continuing, confirm that **Hybrid Interconnect** and **Bulk Migration** are enabled in the applicable source and destination compute profiles and are enabled and healthy in the service mesh. Resolve unavailable services or compatibility errors first.

1. From the standalone Connector service UI, select **Services** > **Migration**, then select **Migrate**.

    :::image type="content" source="../media/6-hcx-migrate-virtual-machines.png" alt-text="Screenshot of the Migrate action in the on-premises HCX interface." lightbox="../media/6-hcx-migrate-virtual-machines.png":::

2. Confirm the source and Azure VMware Solution destination in the remote site connection. Select the source VMs for the approved wave, then select **Add**.

    :::image type="content" source="../media/6-hcx-select-vms-migration-add.png" alt-text="Screenshot of selecting a source VM and adding it to a migration." lightbox="../media/6-hcx-select-vms-migration-add.png":::

3. In **Transfer and Placement**, choose the destination compute container and datastore. Set the destination folder and disk format according to the placement plan.
4. Select **Bulk** as the migration method. Expand each VM entry under **VM for Migration** and confirm that any per-VM overrides use Bulk and the intended placement.
5. Configure an approved switchover window and review the **Switchover** settings. If you don't configure a schedule, switchover can begin automatically after synchronization. Don't start a production job until its outage window and recovery plan are approved.

    Review **Force Power-Off VM** under **Switchover**. Leave it unselected unless the workload owner has explicitly approved a forced shutdown. HCX normally attempts a graceful guest shutdown. This option permits forced power-off if the guest interrupts shutdown.

6. Map every virtual network adapter to its intended destination network. If you're using Network Extension, confirm that its preparation and connectivity checks have completed.
7. Review **Extended Options**. Don't enable guest customization, VMware Tools or virtual-hardware upgrades, or EVC changes without reviewing their effect on the application and recovery plan. Only use options supported for the selected migration method.
8. Select **Validate**. Resolve blocking errors and assess warnings before continuing. Repeat validation after changing the configuration.
9. Select **Go** to start migration. Monitor replication and switchover events through successful completion, then perform the following workload acceptance checks.

## Verify and accept the migrated workload

Complete these checks for the pilot and for each production wave, regardless of migration method:

1. Confirm that HCX reports successful completion for each VM. If a job fails, preserve its events and diagnostic evidence and determine its current state before retrying or cleaning it up.
2. In the Azure VMware Solution vCenter Server, confirm each VM's compute container, folder, datastore, network mappings, expected power state, and storage policy.
3. Check guest startup, IP configuration, name resolution, authentication, application health, and communication with dependent systems. Test from the clients that use the application, not only from the administration host.
4. Compare application performance with the source baseline. Resolve unexpected behavior before accepting the migration.
5. Confirm that destination monitoring and protection are active. Resume or reconfigure paused snapshot-based backup jobs after migration and switchover complete, then verify a successful destination backup.
6. Obtain workload-owner acceptance. Retain the required recovery artifacts and source resources for the approved retention period before decommissioning them.

> [!IMPORTANT]
> Successful RAV removes the source VM. Bulk Migration retains a powered-off source VM, but that copy doesn't include subsequent writes made at the destination. Plan recovery for the selected method and current application data, using a supported reverse migration or restore where appropriate. Don't assume that a source VM remains after RAV or that a retained Bulk VM can safely be powered on.
>
> Changes to per-VM EVC or virtual hardware can affect the ability to return to the source environment. Review these settings before migration, not after a recovery decision is needed.

> [!WARNING]
> Don't power on a retained source VM on the production network as an automatic rollback. It can have stale data or conflict with the destination VM. Follow the tested recovery plan for the migration method and the application's current data state. Choose a supported retry, reverse migration, or restore procedure according to the actual job state. Don't delete replicated disks or force cleanup as a generic response to failure.

## Complete the network transition

If you used Network Extension, the migration isn't a complete datacenter exit while the application still depends on the source gateway or other on-premises services. Complete a separate, controlled network handoff:

1. Confirm that all workloads and dependencies on the segment are ready to leave the source network. Agree on a routing and gateway cutover window and recovery plan. If the segment uses DHCP, identify the intended post-cutover DHCP provider and required routing before removing the extension. Plan the destination DHCP service or relay to a reachable DHCP server separately from the segment security profile used during the stretch.
2. Coordinate source-gateway retirement and destination-gateway activation so you don't introduce conflicting gateways or routes.
3. In **Services** > **Network Extension**, select the relevant extension and use the supported normal **Unextend** workflow. Review the option to connect the cloud network to its cloud edge gateway after unextending, and apply it according to the approved routing plan. Don't assume that removing the extension automatically activates destination routing or use a forced removal for a routine handoff.
4. After the unextend and gateway handoff, configure or activate the planned destination DHCP service or relay, if the segment uses DHCP. The segment security profile doesn't provide a DHCP service.
5. Test client-to-application connectivity, DHCP lease acquisition or renewal where used, routed connectivity through the gateway, DNS resolution, authentication, monitoring, and backup again after the network transition. Verify that DHCP supplies the intended gateway and DNS settings, where applicable. Confirm workload-owner acceptance of the final network state.
6. Retire source networking and HCX resources only when their approved retention and dependency checks are complete. Don't remove a service mesh, extension, or source gateway while another workload still depends on it.
