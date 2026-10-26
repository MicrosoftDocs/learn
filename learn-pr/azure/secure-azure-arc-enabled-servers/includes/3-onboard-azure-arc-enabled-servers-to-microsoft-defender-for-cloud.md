Tailwind Traders has connected its servers to Azure Arc and wants to protect them with Microsoft Defender for Cloud. In this unit, you enable Defender for Servers and verify both the Azure resource connection and endpoint protection.

Reference links for this unit are in the summary's **More info** section.

## Before you begin

Use the Azure subscription that contains your Arc-enabled servers. Confirm that each server reports a healthy Azure Arc connection. Servers that are already connected don't need another installation of the Azure Connected Machine agent. For servers not yet connected, follow *Azure Connected Machine agent deployment options*, including its operating-system, permission, and network prerequisites.

To change Defender plans, use an identity with Security Admin, Contributor, or Owner permissions at subscription scope, as described in *Defender for Cloud permissions*. Configuring particular monitoring components can require additional permissions; permission to change a plan isn't permission to configure every feature. Ensure your security team also grants the Defender portal device access needed for the verification steps.

> [!NOTE]
> To verify the Arc connection and extension state in the Azure portal, you also need permission to read the relevant Arc machines and their extensions. If you use Security Admin to manage Defender plans, ensure that you also have Azure Reader access to those machines or their resource group, or equivalent existing permissions. Security Admin alone doesn't grant these Arc resource reads. An existing Contributor or Owner assignment at the appropriate scope already provides them; don't request redundant role assignments. Access to device details in the Microsoft Defender portal is a separate requirement. See *Defender for Cloud permissions* and the *Security Admin role definition*.

Review *Defender for Endpoint integration prerequisites*. The server must run a supported operating system and reach the required endpoint service URLs. Review the Linux-specific requirements where applicable. If a machine already belongs to another Defender for Endpoint organization, coordinate its supported offboarding and onboarding with your security team; Defender for Cloud doesn't automatically move it to another organization.

> [!IMPORTANT]
> Defender for Servers is a paid plan. Turning Servers on selects Plan 2 by default. Plan 1 includes endpoint protection and agent-based vulnerability assessment; Plan 2 adds capabilities including file integrity monitoring (FIM). Review *Defender for Servers overview and plan comparison* and *Microsoft Defender for Cloud pricing* before enabling protection. Select Plan 2 if you intend to configure the FIM capability described in the next unit.

## Enable Defender for Cloud and Defender for Servers

These steps use Azure portal plan management. If your organization has moved this subscription to the announced Defender portal plan-management preview, use that experience's instructions instead; migrated plan settings become read-only in the Azure portal. See *Defender for Cloud release notes*.

To enable Defender for Servers in the Azure portal:

1. Sign in to the Azure portal and search for **Microsoft Defender for Cloud**.
1. Open the service. Its foundational security posture features become available for your subscription; paid workload-protection plans are configured separately.
1. Select **Environment settings**, and select the subscription containing the Arc-enabled servers.
1. On the Defender plans page, set **Servers** to **On**.
1. Select **Change plans**, confirm **Plan 2** for this module's full feature coverage, and select **Confirm**. If you intentionally select Plan 1 instead, don't expect the Plan 2-only capabilities.
1. Select **Save**.
1. In the subscription's **Settings and monitoring**, confirm that **Endpoint protection** is **On**. If you change this setting, select **Continue** and **Save**.

Defender for Endpoint integration is enabled by default when you enable Defender for Servers. It deploys or uses the endpoint sensor on supported machines that meet the prerequisites. An enabled subscription setting isn't proof that every individual server has finished onboarding.

## Verify the resource connection and endpoint protection

To verify protection for each Arc-enabled server:

1. In **Microsoft Defender for Cloud**, select **Inventory** and filter for the relevant Arc-enabled server resources.
1. For each server, inspect its extension state in the Azure portal. Confirm that the appropriate **MDE.Windows** or **MDE.Linux** extension has provisioned successfully.
1. In the Microsoft Defender portal, open the device inventory and confirm that the server is present and reporting current sensor information.
1. On Linux servers with Defender for Endpoint installed, run `mdatp health` and confirm that `healthy` and `licensed` are `true`.
1. If a server is absent or unhealthy, follow the *Defender for Endpoint deployment and verification by platform* guidance. Review agent health, extension errors, supported OS requirements, tenant association, and connectivity rather than assuming that another Arc installation will fix the problem.

The first subscription configured for endpoint integration in a tenant can take up to 12 hours to onboard. After the initial integration, new machines and subscriptions can take up to one hour. Allow for this onboarding time before diagnosing a missing device as a failed deployment.

Once protection is active, review the server's security recommendations and alerts. Recommendations identify configuration or vulnerability work to address; the absence of an alert doesn't by itself prove that the sensor is working.
