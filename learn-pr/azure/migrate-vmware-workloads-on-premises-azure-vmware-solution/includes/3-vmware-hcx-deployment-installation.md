VMware HCX Cloud Manager is installed as an add-on in an existing Azure VMware Solution private cloud. After installing the add-on, obtain the HCX Connector OVA, deploy it on-premises, and configure its connection to vCenter Server.

## Before you begin

Use a deployed Azure VMware Solution private cloud with working connectivity from the administration host and the on-premises environment. You need sufficient compute, memory, datastore space, and free IP addresses for the Connector and the service appliances in your design.

Confirm these access requirements:

- Azure permissions, such as the Contributor role at the appropriate scope, to manage the private cloud's HCX add-on.
- An on-premises vCenter account that belongs to the vSphere administrators group and has the Administrator role for HCX registration. An authorized service account can be used instead of the default administrator account.
- The Connector appliance administrator credentials that you'll create during OVA deployment.
- An Azure VMware Solution account with the CloudAdmin role for site pairing. For ongoing connected-service use, prefer an appropriately authorized service account where your identity design supports one.

Azure RBAC doesn't grant vCenter or HCX appliance permissions. Keep these credential types separate. You can study the module without deploying resources, but performing the procedures requires the resources and permissions listed here.

Before deploying the OVA, prepare its management IP address, prefix, default gateway, hostname, DNS servers, and time synchronization. Check appliance resource requirements for the selected release and verify that the administration host can reach the required management interfaces.

> [!IMPORTANT]
> Confirm the private cloud's applicable portable VCF entitlement and licensing compliance. Availability of HCX Enterprise features doesn't mean that a new Azure VMware Solution host includes a VCF subscription.
>
> Confirm the activation requirements for the AVS-provided Connector build and obtain the applicable information through the Azure VMware Solution HCX add-on workflow. Don't assume an activation key is perpetual, enable unrestricted internet access as a default remedy, or replace the AVS workflow with a generic VCF activation recipe.

## Install HCX Cloud Manager

1. In the [Azure portal](https://portal.azure.com), open the existing Azure VMware Solution private cloud and select **Manage** > **Add-ons**.
2. Select **Get started** for **HCX Workload Mobility**.
3. Follow the installation flow for the private-cloud generation. For the Azure virtual-network deployment flow, select **Enable and deploy** when prompted. Review the terms and, if you agree, accept them and select **Install** where that action is presented.
4. Wait for installation to complete. On **Migration using HCX**, record the actual HCX Manager IP and obtain the activation information required for the on-premises Connector. If the confirmed activation workflow requires a portal-issued key and one isn't present, use **Add** as directed by the portal.

Confirm that the add-on has installed before continuing. Use the actual HCX Manager endpoint shown for the deployment. Don't construct an address by substituting values into an example IP address.

## Download the HCX Connector OVA

1. From an administration host with private-cloud connectivity, sign in to the Azure VMware Solution vCenter Server using an authorized account. The private cloud's **Identity** page in the Azure portal provides the vCenter connection information and built-in CloudAdmin credentials.
2. Open the private cloud's vSAN datastore and browse to `AVS_Official_HCX_Connector_Binaries`.
3. Select the Connector OVA for the supported release required by your migration plan, and download it to the administration machine that you'll use to deploy the on-premises appliance.
4. If the folder or required version isn't available, open an Azure support request. Don't substitute a different build without confirming compatibility and service support.

This folder is the documented location for the Connector OVA. It isn't a statement about the location of every type of HCX upgrade bundle.

## Deploy the HCX Connector OVA on-premises

Sign in to the on-premises vCenter Server from the machine that has the downloaded OVA.

1. Right-click the destination datacenter and select **Deploy OVF Template**.
2. Select the local OVA that you downloaded from the Azure VMware Solution vSAN datastore.
3. On **Select a name and folder**, name the Connector appliance, select its location, and select **Next**.
4. On **Select a compute resource**, choose the vSphere cluster and select **Next**.
5. Review the template details and required resources, then select **Next**.
6. Review the license agreements. If you agree, select **I accept all license agreements** and select **Next**.
7. Select the datastore for the appliance and select **Next**.
8. Select the management network segment prepared for the Connector and select **Next**.
9. In **Customize template**, set the appliance administrator and root passwords requested by the template. Configure the hostname, management IP address, prefix length, and default gateway. Supply the DNS and time-synchronization settings required by the selected release, and select **Next**.
10. On **Ready to complete**, verify the configuration and select **Finish**.
11. After deployment completes, power on the appliance in vCenter Server. Allow 10-15 minutes for startup before continuing.

The `admin` credentials created during deployment are for the Connector appliance. They aren't the vCenter registration credentials.

## Activate and configure the Connector

> [!IMPORTANT]
> Confirm the activation workflow for the AVS-provided Connector build before continuing. Microsoft and Broadcom public instructions describe different licensing paths and wizard orders. If the installed wizard doesn't match the documented AVS flow, stop and confirm the supported procedure with Microsoft Support. Don't use evaluation mode or a different licensing recipe to bypass an unresolved entitlement issue.

The following key-based sequence follows Microsoft's AVS installation guidance but is pending confirmation for the selected Connector build. Use it only after confirming that it applies to your deployment. It isn't a universal activation sequence or a record of a completed supported-build walkthrough.

1. In the Azure portal, open **Manage** > **Add-ons** > **Migration using HCX** for the private cloud. Copy the activation key for this Connector. Generate a key with **Add** only if one is needed.
2. In a browser on the administration host, open `https://<connector-ip>:9443`, replacing `<connector-ip>` with the on-premises Connector's management address. Sign in with the `admin` credentials created during OVA deployment.
3. Open **Licensing**, enter the applicable activation information, and select the activation action shown by the installed version.
4. If activation fails, check the reported error, key or entitlement, DNS, time synchronization, and the outbound connectivity or proxy required by this activation mode. Resolve the cause and retry before continuing.
5. In **Datacenter Location**, provide the nearest location for the on-premises Connector and select **Continue**.
6. In **System Name**, enter a name or accept the default, then select **Continue**.
7. Select **Yes, Continue** to configure the connection to vCenter Server.
8. In **Connect your vCenter**, enter the on-premises vCenter FQDN or IP address and the registration account. This account must belong to the vSphere administrators group and have the Administrator role. Select **Continue**.
9. Configure the vCenter Single Sign-On (SSO) endpoint, normally the same FQDN or IP address as vCenter Server. Enter the endpoint in the format requested by the wizard and select **Continue**.
10. Review the configuration and select **Restart**. Wait for the services to restart, then sign in again.
11. Confirm that both vCenter Server and SSO connections report healthy status. If either connection isn't healthy, correct the endpoint, credentials, or connectivity before creating a site pair.

> [!NOTE]
> The wizard might label the authentication step **Configure SSO/PSC**. In the vSphere 8 environment used in this scenario, vCenter Server hosts the authentication services on the vCenter appliance. Use that existing service rather than deploying a separate authentication appliance.

## Confirm access to the HCX service UI

After completing the confirmed activation and registration workflow, configure access to HCX operations:

1. In the Connector appliance management interface, open **Configuration** > **HCX Role Mapping**. Confirm that the intended vCenter SSO group is mapped to an HCX role that permits the required operations. The default Administrator mapping uses the local vSphere administrators group.
2. Open the on-premises HCX Connector service UI at `https://<connector-ip-or-fqdn>` on TCP 443. Replace `<connector-ip-or-fqdn>` with the Connector's management address or resolvable hostname.
3. Sign in with a vCenter SSO account in the mapped group and confirm that you can access the required HCX operations. Resolve role-mapping or sign-in errors before creating a site pair.

The service UI is different from `https://<connector-ip-or-fqdn>:9443`, which is the appliance management interface and uses the local `admin` credentials created during deployment. Your source SSO login is also separate from the destination CloudAdmin credentials that you'll enter during site pairing.

In the next unit, you'll create a site pair, configure network profiles, and create a compute profile.
