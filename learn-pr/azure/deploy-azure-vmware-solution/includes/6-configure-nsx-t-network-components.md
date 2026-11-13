The Generation 1 private cloud in this walkthrough deploys with NSX Manager as the software-defined network layer. Its preconfigured networking includes two gateways:

- NSX Tier-0 gateway configured in active-active mode
- NSX Tier-1 gateway configured in active-standby mode

These gateways support East-West connectivity between workload segments and North-South connectivity to external networks. Actual reachability depends on the configured routes and firewall policies.

## Set up NSX Manager components

After Azure VMware Solution is deployed, you can configure NSX components under **Workload Networking** in the Azure portal. The portal provides a simplified view for VMware administrators who aren't familiar with NSX Manager. You can also use NSX Manager for supported advanced network settings and features.

This unit uses the following portal features:

- **Segments**: Create network segments that are displayed in NSX Manager and vCenter Server.
- **DHCP**: If you use DHCP, create a DHCP server or DHCP relay.
- **Port mirroring**: Set up port mirroring to help troubleshoot network issues.
- **DNS**: Create a DNS forwarder to send DNS requests to a DNS server for resolution.

:::image type="content" source="../media/6-networking-configuration-portal.png" alt-text="Screenshot of workload networking options." lightbox="../media/6-networking-configuration-portal.png" :::

## Create an NSX network segment in the Azure portal

Attach virtual machines (VMs) created in or migrated to Azure VMware Solution to an appropriate NSX segment. The simplified Azure portal workflow connects new segments to the default Tier-1 gateway. After creation, the segment appears in NSX Manager and vCenter Server.

Use either this portal procedure or the NSX Manager alternative that follows; don't create the same segment twice. If you plan to use DHCP, configure the DHCP server or relay described later in this unit before assigning DHCP ranges.

1. In the Azure portal, select your Azure VMware Solution private cloud.
1. Under **Workload Networking**, select **Segments** > **+Add**:

    :::image type="content" source="../media/6-networking-add-new-segment.png" alt-text="Screenshot of Add segment in the Azure portal." lightbox="../media/6-networking-add-new-segment.png" :::

1. Provide details for the new logical networking segment:

    :::image type="content" source="../media/6-networking-new-segment-details.png" alt-text="Screenshot of segment settings in the Azure portal." lightbox="../media/6-networking-new-segment-details.png" :::

    Use the following field descriptions to complete the segment configuration:

    | Field | Value |
    | ----- | ----- |
    | **Segment name** | The name of the logical switch visible in vCenter Server. |
    | **Connected gateway** | This gateway is selected by default and is read only. |
    | **T1** | The default Tier-1 gateway. Segments created through this portal workflow connect only to this gateway. Additional supported Tier-1 gateways can be created in NSX Manager, but aren't visible in this simplified portal view. |
    | **Type** | The overlay network segment supported by Azure VMware Solution. |
    | **Subnet Gateway** | The subnet's gateway IP address and prefix, such as `10.60.10.1/24` if `10.60.10.0/24` is unused and doesn't overlap the management block or connected networks. Attached VMs use addresses from this subnet. |
    | **DHCP ranges (optional)** | Configure the DHCP server or relay first. Keep any client allocation range within the segment subnet, excluding the gateway and addresses reserved for DHCP or static use. For relay, also configure the external server's matching scope as described below. |

1. Select **OK** to create and attach the segment to the default Tier-1 gateway. Confirm that it appears in Azure VMware Solution, NSX Manager, and vCenter Server.

## Create an NSX network segment in NSX Manager

As an alternative to the portal, create the segment in NSX Manager. Select the private cloud's default Tier-1 gateway for this exercise. NSX Manager can also connect segments to other supported Tier-1 gateways that you've configured. Those gateways need the appropriate upstream connection, route advertisement, and services. Creating a segment alone doesn't establish unrestricted external connectivity.

From the jumpbox VM, connect to NSX Manager. Get the initial credentials from the private cloud's **Manage** > **VMware credentials** page.

1. In NSX Manager, select **Networking** > **Segments**, then select **Add Segment**.

    :::image type="content" source="../media/6-nsx-add-segment.png" alt-text="Screenshot of Add Segment in NSX Manager." lightbox="../media/6-nsx-add-segment.png" :::

1. Enter a segment name, choose the default Tier-1 gateway, and select the preconfigured overlay transport zone.
1. In **Subnets**, set the gateway interface address and prefix, not just the subnet's network address.

    :::image type="content" source="../media/6-nsx-add-segment-details.png" alt-text="Screenshot of segment settings in NSX Manager." lightbox="../media/6-nsx-add-segment-details.png" :::

    Use the following values for this exercise:

    | Field | Value |
    | ----- | ----- |
    | **Segment name** | The name of the segment visible in vCenter Server. |
    | **Connected gateway** | The private cloud's default Tier-1 gateway, such as `TNTxx-T1`. |
    | **Transport Zone** | The preconfigured overlay transport zone, such as `TNTxx-OVERLAY-TZ`. |
    | **Subnets: Gateway IP address/prefix** | An interface address such as `10.60.10.1/24`, only if `10.60.10.0/24` is unused. Use a non-overlapping RFC1918 workload block outside the management /22 and avoid the reserved ranges identified during planning. |

1. Apply the subnet configuration and select **Save**.
1. Confirm that the segment appears under **Networking** > **Segments** in NSX Manager and under **Networking** > **SDDC-Datacenter** in vCenter Server.

## Create a DHCP server or DHCP relay in the Azure portal

Applications and workloads need name resolution and either DHCP or static IP configuration. For new routed segments, you can use the DHCP service built into NSX or a local DHCP server in the private cloud.

Use the Azure portal's simplified networking experience to configure DHCP for the default Tier-1 gateway in this walkthrough. After creating the service, complete the consuming segments' configuration for the selected server or relay.

1. In the Azure VMware Solution private cloud, under **Workload Networking**, select **DHCP** > **+Add**.

1. Select **DHCP Server** or **DHCP Relay**, enter a name, and configure the selected service:

    - **DHCP Server**: Enter one unused IPv4 DHCP service address in CIDR notation with a prefix length of 30 or less. `/31` and `/32` aren't supported. Use a valid unicast host address, not a network, broadcast, multicast, loopback, or unspecified address. Don't reuse the segment gateway, a client allocation-pool address, or a static-binding address. For example, use `10.60.254.1/30` only if you've reserved that non-overlapping service subnet and confirmed that the address is unused. For the Gateway DHCP service used here, the service subnet can differ from the workload segment's subnet.
    - **DHCP Relay**: Enter one to three IP addresses of existing DHCP servers to which requests will be forwarded. These are destination server addresses, not addresses allocated to the relay.

    The following example shows the DHCP relay form.

    :::image type="content" source="../media/6-networking-add-dhcp-server-relay.png" alt-text="Screenshot of the Add DHCP pane with DHCP relay selected." lightbox="../media/6-networking-add-dhcp-server-relay.png" :::

1. Submit the DHCP configuration and wait for successful completion. Then return to **Workload Networking** > **Segments** to configure the consuming segments. For an NSX DHCP server, configure the client allocation ranges within the segment subnet. For the example gateway `10.60.10.1/24`, a pool could be `10.60.10.50-10.60.10.200`, provided those addresses are unused. Exclude the gateway and any DHCP service, static-binding, or other static addresses from the dynamic pool.

    A DHCP relay forwards requests. It doesn't create scopes on the destination server. Configure an active external scope for each consuming segment's subnet. For the example segment, use a scope for `10.60.10.0/24`, with an available client pool, default gateway `10.60.10.1`, and appropriate DNS servers reachable from the workloads. Configure exclusions and reservations on that server. Ensure routes and firewall rules permit DHCP requests and replies, including the return path. Azure portal segment settings don't configure this external scope.

An optional HCX L2-extended network that keeps an on-premises DHCP server is different from a new routed segment. Apply the documented segment-security profile to that extended segment only: enable **BPDU Filter** and turn off the DHCP toggles so DHCP can traverse the extension. Don't add an NSX DHCP relay solely because the server is on-premises while the network is still extended. Plan the DHCP server or relay configuration needed when the extension is removed or the workload fails over.

## Configure port mirroring in the portal

Port mirroring copies traffic from selected source VM interfaces to a destination for troubleshooting. Prepare a customer-managed destination VM with packet-capture or protocol-analysis software before enabling mirroring. Creating a mirroring profile doesn't install that software or analyze the packets. Use mirroring only for short-term troubleshooting.

The source VM group identifies the customer workload VMs whose traffic is copied. The destination VM group identifies the separate, customer-managed VM prepared to capture that traffic. For this exercise, use `workload-source-group` and `capture-destination-group` as example group names. Select the corresponding VMs when creating the groups. A group name alone doesn't establish its membership or prepare a VM for packet capture.

> [!IMPORTANT]
> For this optional mirroring procedure, first deploy or identify a source workload VM and a separate customer-managed capture VM in this Azure VMware Solution private cloud. The participating network interfaces must be attached to NSX overlay segments. The Logical SPAN workflow used here doesn't support VLAN segments. If no source workload VM exists yet, complete **Add a VM on an NSX network segment** later in this unit, then return here. Use the workload VM for the source group and the prepared capture VM for the destination group. The Azure jumpbox isn't a destination VM for this VM-group workflow.

1. In the Azure VMware Solution private cloud, under **Workload Networking**, select **Port mirroring** > **VM groups** > **+Add**.
1. Name the source VM group, select the VMs, then select **OK**.
1. Repeat the preceding step to create the destination VM group.

Next, create a port mirroring profile by defining the traffic direction for source and destination VM groups.

1. Make sure both the source and destination VM groups have been created.
1. Select **Port mirroring** > **Add**, and then provide the following values:

    | Field   | Value |
    | :---------- | :------------------ |
    | **Port mirroring name** | Provide a name for the profile. |
    | **Direction** | Select **Ingress**, **Egress**, or **Bi-directional**. |
    | **Source** | Select the workload source group, such as `workload-source-group`. |
    | **Destination** | Select the prepared capture VM's group, such as `capture-destination-group`. |

1. Select **OK** to complete the profile. The profile and VM groups will now be visible in the Azure VMware Solution console.

### Stop the temporary port-mirroring session

After completing the authorized packet capture, remove the exercise's port-mirroring profile. Closing the packet analyzer or stopping the capture VM isn't a substitute for removing the profile. Keep the private cloud and workload network for the remaining exercises.

Use Azure Cloud Shell Bash with Azure CLI 2.75.0 or later and the `vmware` extension, as in the Global Reach unit. Replace every `REPLACE_WITH_...` value. Identify the exact profile created for this exercise, not a VM group or another administrator's profile.

```bash
set -euo pipefail

avsSubscriptionId="REPLACE_WITH_AVS_SUBSCRIPTION_ID"
avsResourceGroup="REPLACE_WITH_AVS_RESOURCE_GROUP"
privateCloudName="REPLACE_WITH_PRIVATE_CLOUD_NAME"
portMirroringId="REPLACE_WITH_EXERCISE_PORT_MIRRORING_ID"

az vmware workload-network port-mirroring show \
  --subscription "$avsSubscriptionId" \
  --resource-group "$avsResourceGroup" \
  --private-cloud "$privateCloudName" \
  --port-mirroring "$portMirroringId"
```

Review the returned profile, including its source and destination, before continuing. If it isn't the exercise's profile, stop and correct the identifier. Run the following block in the same Cloud Shell session after reviewing the profile. If you start a new session, set the variables again.

```bash
az vmware workload-network port-mirroring delete \
  --subscription "$avsSubscriptionId" \
  --resource-group "$avsResourceGroup" \
  --private-cloud "$privateCloudName" \
  --port-mirroring "$portMirroringId"

az vmware workload-network port-mirroring list \
  --subscription "$avsSubscriptionId" \
  --resource-group "$avsResourceGroup" \
  --private-cloud "$privateCloudName" \
  --output table
```

Confirm the deletion prompt only for the intended profile, wait for the command to finish, and confirm that the profile no longer appears in the list. If the results are paginated, inspect the remaining pages before concluding that it's absent. Resolve any error rather than proceeding as though mirroring has stopped.

Keep unrelated profiles, VMs, segments, and shared VM groups unchanged. Remove exercise-only groups later only after confirming that no remaining profile uses them. Retain any required capture data according to your organization's handling policy.

## Configure a DNS forwarder in the Azure portal

The NSX DNS forwarding service uses a default DNS zone and up to five FQDN zones. Each FQDN zone can specify up to three upstream DNS servers. The zone's domain identifies which queries are forwarded to those servers. This DNS forwarding workflow applies to both Generation 1 and Generation 2.

A DNS service and default zone are provided with the private cloud. The default zone handles queries that don't match an associated FQDN zone. A provisioned default zone doesn't guarantee that its upstream servers are reachable. Choose reachable resolvers that can answer the required public and private queries, particularly with forced routing or restricted egress. For management reverse lookups, ensure the default zone also uses a resolver capable of answering the required reverse queries.

Keep changes to the default Tier-1 gateway's DNS service in the Azure portal. Creating an FQDN zone doesn't activate forwarding until you associate it with the DNS service.

To add conditional forwarding for a privately hosted domain:

1. In your Azure VMware Solution private cloud, under **Workload Networking**, select **DNS** > **DNS zones** > **+Add**.
1. Select **FQDN zone**. Enter the zone's resource name, the domain to match, and up to three reachable upstream DNS server IP addresses. Check the name and domain, then select **OK**.

    :::image type="content" source="../media/6-add-dns-zone.png" alt-text="Screenshot of Fully Qualified Domain Name zone settings dialog box." lightbox="../media/6-add-dns-zone.png" :::

1. Wait for successful zone creation in **Notifications**.
1. Select **DNS service** > **Edit**. In **FQDN zones**, select the new zone while preserving existing required zone associations and the default zone.
1. Select **OK** and wait for the service update to complete in **Notifications**.
1. Repeat for other required forward or reverse lookup zones, within the five-zone limit.

Workload VMs use these conditional-forwarding rules only when their DNS settings direct queries through this service or another correctly configured resolver. Set the relevant DNS address in DHCP options or the VM's static configuration. Use the actual service IP shown for your private cloud, not the planning unit's illustrative address.

Verify a required private name and any required reverse lookup through the DNS forwarding service, rather than querying only an upstream server directly. In NSX Manager, select **Networking** > **DNS**, expand the forwarding service, and select **View Statistics**. Choose the FQDN zone under **Zone Statistics** to inspect its forwarded queries. If resolution fails, check the zone association, upstream DNS reachability, routes, and DNS firewall rules.

## Verify on-premises vSphere network connectivity to the Azure VMware Solution private cloud

On the on-premises edge router, verify routes to the private cloud's management networks and required NSX workload segments. Confirm BGP propagation and the return routes to on-premises prefixes. Azure VMware Solution management appliances don't use a customer-advertised default route as their return path to private on-premises management networks; advertise the actual prefixes or appropriate RFC1918 summaries.

From an authorized management source, test HTTPS access to vCenter Server and NSX Manager. Confirm the relevant firewall policies in both directions. Don't disable firewalls to make a connectivity test pass; use the permitted management and application paths in the final checks below.

## Configure optional outbound internet access

New Generation 1 private clouds don't have internet access enabled by default. Choose an approved egress design before running an internet test. An isolated deployment can remain private without failing the deployment objective.

For a lab whose policy permits Managed SNAT, configure outbound access in the Azure portal:

1. Open your Azure VMware Solution private cloud.
1. Under **Workload networking**, select **Internet connectivity**.
1. Select **Connect using SNAT**, then select **Save** and wait for the configuration to complete.

Managed SNAT provides outbound connectivity, not inbound publishing. It doesn't provide control of outbound SNAT rules or the public IP address, or access to connection logs. It doesn't work when the private cloud receives a default route from Azure. If you need traffic inspection or those controls, use an approved inspected-egress design instead; configuring that design is outside this walkthrough.

Managed SNAT doesn't support internet ICMP ping. A failed ping doesn't prove that its outbound HTTPS path is broken. It also doesn't accept inbound-initiated internet connections. Validate inbound publishing separately only if that feature is intentionally configured.

## Add a VM on an NSX network segment

Deploy a VM in the Azure VMware Solution vCenter Server to test the paths required by your design:

- To and from Azure virtual networks.
- To and from on-premises environments.
- Outbound to the internet, only if you've explicitly configured it.

Deploy the VM as you would in any vSphere environment:

- Attach the VM to the network segment you created earlier.
- The VM can receive network configuration from a DHCP server, or you can configure the network configuration statically.

## Test the NSX segment connectivity

Use the test VM and authorized management sources to verify connectivity:

1. If using DHCP, confirm that the test VM obtains a lease from the intended DHCP server. Check its IP address, subnet prefix, default gateway, and DNS settings.
1. From the jumpbox, open the private vCenter Server and NSX Manager HTTPS endpoints.
1. Test an explicitly allowed application connection from the Azure VMware Solution VM to an Azure VM and a corresponding permitted connection back to the Azure VMware Solution VM.
1. Test the required on-premises-to-private-cloud and private-cloud-to-on-premises application paths, including the management access path relevant to this deployment.
1. Resolve a required private DNS name through the configured resolver, and verify reverse resolution if your workloads require it.
1. If outbound internet access is part of the design, resolve an approved public name and open an approved HTTPS site.

Record the source, destination, protocol, and result for each required path. Check route propagation, return routes, DNS, and the relevant firewall policies when a path fails. Successful tests validate those paths, not complete production or HCX migration readiness.

## Establish the deployment monitoring baseline

For a private cloud you'll retain beyond the exercise, configure a minimal operational handoff after the connectivity checks. Use an account that can read the monitored resources, create alert rules at the required scopes, and read the action groups you select.

Reading an existing action group lets you attach it to an alert, but doesn't grant permission to test it. Arrange for an operator with action-group testing permissions to perform the notification test. Viewing the AVS Maintenance information requires Contributor-level access, so involve the private-cloud operations owner if your monitoring account doesn't have that access. The subscription Contributor used earlier already covers these operations when the affected resources are in that subscription. A delegated monitoring operator doesn't need subscription Owner or blanket subscription Contributor access just to test an action group.

1. In the Azure portal, open the private cloud and select **Monitoring** > **Metrics**. Review the current metrics marked **(new)** for datastore usage, CPU, and memory.
1. Under **Monitoring** > **Alerts**, create a metric alert for **Percentage Datastore Disk Used (new)**. Scope it to the private cloud and configure the **dsname** dimension so each relevant vSAN datastore is evaluated separately. Don't average usage across datastores, which can hide pressure on an individual datastore. Choose a warning threshold that leaves time to respond before utilization reaches the 75% service limit. For example, 70% can be an initial warning threshold, but it isn't a Microsoft-mandated value. Choose the evaluation window and frequency for your workload's growth rate.
1. Attach an existing **Global** action group that notifies the responsible operations team, or create one if you have permission. This lets you use the group for the health alerts that follow. Confirm that recipients have completed any required verification, then test the action group and verify delivery. A notification test confirms delivery, not that the metric condition has been triggered.
1. Open **Help** > **Resource Health** and select **Add resource health alert**. Configure notifications for degraded or unavailable states and attach the operational **Global** action group. Keep the rule enabled.
1. In **Service Health**, create a separate alert scoped to the subscription, covering the relevant service issues (incidents), planned maintenance, and advisories. Use a **Global** action group for Service Health notifications. Service Health alerts don't replace Resource Health alerts.
1. When a maintenance event appears under **Operations** > **Maintenance**, review **Maintenance Ready**. If it shows **No**, open the linked actionable plan and address the blocking configuration before the event. Record the alert notification owner and escalation path as part of the deployment handoff.

> [!NOTE]
> These checks use AVS platform metrics and health events and don't require a guest monitoring agent. They don't prove application health or guarantee SLA eligibility. Workload-level monitoring and protection require their own configuration.
