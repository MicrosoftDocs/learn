After VMware HCX Connector is installed on-premises, link it to VMware HCX Cloud in Azure VMware Solution. This unit and the next one go over the steps involved in this task.

## What is a site pair?  

The first step involves creating a *site pair*. A site pair establishes the management, authentication, and orchestration relationship between the source and destination HCX systems over an existing routed connection. In this scenario, the source is the on-premises VMware vSphere environment, and the destination is Azure VMware Solution. The following table describes the components:

| Component| Notes |
| :------- | :----- |
| HCX Connector (source) | Deployed on-premises using the AVS-provided OVA. Initiates site pairing and the migration workflows in this module. |
| HCX Cloud Manager (destination) | Installed as an add-on in the Azure VMware Solution private cloud. Confirm installation has completed before site pairing. Provides destination HCX services, including optional Layer 2 Network Extension. |

## Add a site pair

Before connecting, confirm that the on-premises Connector can route to the actual HCX Cloud Manager endpoint over TCP 443. Use the routed connection you configured for your private-cloud generation and network design. ExpressRoute isn't an inherent requirement of site pairing.

1. Open the on-premises HCX Connector service UI at `https://<connector-ip-or-fqdn>` on TCP 443. Sign in with a vCenter SSO account in a group mapped to an HCX role that permits site pairing.
2. Under **Infrastructure**, select **Site Pairs**, then select **New Site Pair**.
3. If prompted for the site type, select **VMware** for this vSphere-based site pair.
4. Enter the remote HCX URL using the actual Azure VMware Solution HCX Cloud Manager IP address obtained in the last unit: `https://<cloud-manager-ip>`.
5. Enter credentials for an Azure VMware Solution account with the CloudAdmin role. For ongoing connected-service use, prefer an appropriately authorized service account where the identity design supports one. The built-in **cloudadmin@vsphere.local** account can be used for this exercise.
6. Confirm that the destination certificate is trusted. If prompted to trust or import a certificate, verify that it belongs to the intended HCX Cloud Manager before accepting it.
7. Select **Create** and monitor the pairing operation. Resolve any authentication, certificate, or connectivity errors before continuing.
8. Confirm that **Site Pairs** shows the intended Cloud Manager and Connector as connected.

The service UI uses role-mapped vCenter SSO credentials. Don't use the local `admin` credentials for this sign-in or confuse this interface with appliance administration on TCP 9443.

## Create network profiles

The Connector deploys service appliances that use the networks and address pools identified during planning. Configure the Management, vMotion, Replication, and Uplink traffic profiles. These roles don't automatically require four separate subnets. Management, Uplink, and Replication can reuse network infrastructure where the design permits. Use a dedicated replication VMkernel network if your hosts have one.

For VPN-connected deployments, set the uplink network-profile MTU to 1350 on both sides to account for encapsulation overhead. The default 1500 is sufficient for most ExpressRoute deployments, but confirm the effective path MTU. The on-premises traffic profiles aren't the separate cloud-side Generation 2 subnet layout.

1. In the on-premises HCX Connector service UI, sign in with the role-mapped vCenter SSO account.

2. Under **Infrastructure**, select **Interconnect** > **Network Profiles**, then select **Create Network Profile**.

    :::image type="content" source="../media/4-hcx-create-network-profile.png" alt-text="Screenshot of creating an HCX network profile." lightbox="../media/4-hcx-create-network-profile.png":::

3. For each network profile, select the network and port group, provide a name, and configure the planned address pool and applicable network settings. Ensure the pool has capacity for the service appliances in your design and doesn't overlap addresses already in use. Select **Create**.

    :::image type="content" source="../media/4-example-configurations-network-profile.png" alt-text="Screenshot of how to create a network profile within HCX Connector on-premises.":::

## Create a compute profile

The compute profile contains the compute, storage, network, and service settings that HCX uses when configuring the service mesh.

1. Under **Infrastructure**, select **Interconnect** > **Compute Profiles** > **Create Compute Profile**.
2. Enter a name for the profile and select **Continue**.
3. Select the services needed for the chosen walkthrough. Enable **Hybrid Interconnect** and **Replication Assisted vMotion** for RAV. Enable **Hybrid Interconnect** and **Bulk Migration** for Bulk. If the lab will demonstrate both methods using different VMs, enable both migration services. For RAV, confirm the applicable Enterprise entitlement. Enable **Network Extension** only if the network plan requires it. Resolve unavailable services before selecting **Continue**.
4. In **Select Service Resources**, select the on-premises clusters whose workloads will use the selected HCX services, then select **Continue**.
5. On **Select Deployment Resources and Reservations**, use **Select Resource** to choose the cluster or resource pool where HCX will deploy its service appliances. This is appliance placement, not the list of workload clusters selected in the previous step.
6. On the same page, use **Select Datastore** to choose storage for the appliances. If required, use **Select Folder** to choose their VM folder.
7. Review the CPU and memory reservations and confirm that the selected deployment resources can satisfy them. Broadcom recommends 100-percent CPU and memory reservations as a best practice for HCX operations. Select **Continue**.
8. In **Select Management Network Profile**, select the prepared management profile and select **Continue**.
9. In **Select Uplink Network Profile**, select the prepared uplink profile and select **Continue**.
10. In **Select vMotion Network Profile**, select the prepared vMotion profile and select **Continue**.
11. In **Select vSphere Replication Network Profile**, select the prepared replication profile and select **Continue**.
12. If you're using Network Extension, on **Select Distributed Switches for Network Extensions**, select the supported workload switches containing the networks you plan to extend, then select **Continue**. This selection concerns workload networks, not the switch used solely for vMotion. Skip it if you aren't using Layer 2 extension.
13. Review the connection rules and select **Continue**.
14. Select **Finish**, then confirm that the profile appears under **Interconnect** > **Compute Profiles** with the intended service and network selections.

> [!NOTE]
> If you select multiple compute resources or datastores, HCX uses the first selection until its capacity is exhausted. Check the selection order against your appliance-placement plan.

> [!NOTE]
> Network Extension requires supported distributed networking, such as a vSphere distributed switch or supported NSX network. A workload network on a vSphere Standard Switch can't be extended by HCX. This doesn't mean every HCX vMotion network must use a distributed switch.

If you change services in a compute profile already used by a healthy service mesh, use **Interconnect** > **Service Mesh** > **Resync** for the affected mesh and verify its service selection and health. Resync applies profile changes. It isn't a software upgrade or a generic repair for a failed deployment.

In the next unit, you'll create the service mesh and verify the appliances and transport connections.
