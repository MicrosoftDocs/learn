## Deploying Zero Trust for Microsoft 365

Microsoft 365 is built intentionally with many security and information protection capabilities to help you build Zero Trust into your environment. Many of the capabilities can be extended to protect access to other SaaS apps your organization uses and the data within these apps.

This illustration represents the work of deploying Zero Trust capabilities. This work is broken into units of work that can be configured together, starting from the bottom and working to the top to ensure that prerequisite work is complete.

![Diagram showing the Microsoft 365 Zero Trust deployment stack.](../media/microsoft-365-zero-trust-deployment-stack.png)

In this illustration:

-   Zero Trust begins with a foundation of identity and device protection.
-   Threat protection capabilities are built on top of this foundation to provide real-time monitoring and remediation of security threats.
-   Information protection and governance provide sophisticated controls targeted at specific types of data to protect your most valuable information and to help you comply with compliance standards, including protecting personal information.

This article assumes you have already configured cloud identity. If you need guidance for this objective, see [**Deploy your identity infrastructure for Microsoft 365**](/microsoft-365/enterprise/deploy-identity-solution-overview).

## Step 1: Configure Zero Trust identity and device access protection — starting-point policies

The first step is to build your Zero Trust foundation by configuring identity and device access protection.

:::image type="content" source="../media/microsoft-365-zero-trust-architecture-step-1b.png" alt-text="Diagram showing the process to configure Zero Trust identity and device access protection." lightbox="../media/microsoft-365-zero-trust-architecture-step-1b.png":::

Go to [**_Zero Trust identity and device access protection_**](/microsoft-365/security/office-365-security/microsoft-365-policies-configurations?view=o365-worldwide) for prescriptive guidance to accomplish this. This series of articles describes a set of identity and device access prerequisite configurations and a set of Microsoft Entra Conditional Access, Microsoft Intune, and other policies to secure access to Microsoft 365 for enterprise cloud apps and services, other SaaS services, and on-premises applications published with Microsoft Entra application proxy.

Device enrollment for policies that require managed devices. See [Step 2. Manage endpoints with Intune](/microsoft-365/security/microsoft-365-zero-trust?view=o365-worldwide#step-2-manage-endpoints-with-intune) to enroll devices.

Start by implementing the starting-point tier. These policies do not require enrolling devices into management.

:::image type="content" source="../media/identity-access-starting-point-tier.png" alt-text="Diagram showing the Zero Trust identity and device access policies — starting-point tier." lightbox="../media/identity-access-starting-point-tier.png":::

## Step 2: Manage endpoints with Intune

Next, enroll your devices into management and begin protecting these with more sophisticated controls.

:::image type="content" source="../media/microsoft-365-zero-trust-architecture-step-2.png" alt-text="Diagram showing the Manage endpoints with Intune element." lightbox="../media/microsoft-365-zero-trust-architecture-step-2.png":::

Go to [**_Manage devices with Intune_**](/microsoft-365/solutions/manage-devices-with-intune-overview?view=o365-worldwide) for prescriptive guidance to accomplish this.

## Step 3: Add Zero Trust identity and device access protection — Enterprise policies

With devices enrolled into management, you can now implement the full set of recommended Zero Trust identity and device access policies, requiring compliant devices.

:::image type="content" source="../media/microsoft-365-zero-trust-architecture-enterprise-policies.png" alt-text="Diagram showing the Zero Trust identity and access policies with device management." lightbox="../media/microsoft-365-zero-trust-architecture-enterprise-policies.png":::

Return to [**_Common identity and device access policies_**](/microsoft-365/security/office-365-security/identity-access-policies?view=o365-worldwide) and add the policies in the Enterprise tier.

:::image type="content" source="../media/identity-access-enterprise-tier.png" alt-text="Diagram showing the Zero Trust identity and access policies — Enterprise (recommended) tier." lightbox="../media/identity-access-enterprise-tier.png":::

## Step 4: Evaluate, pilot, and deploy Microsoft Defender XDR

Microsoft Defender XDR is an extended detection and response (XDR) solution that automatically collects, correlates, and analyzes signal, threat, and alert data from across your Microsoft 365 environment, including endpoint, email, applications, and identities.

:::image type="content" source="../media/microsoft-365-zero-trust-architecture-defender.png" alt-text="Diagram showing the process of adding Microsoft Defender XDR to the Zero Trust architecture." lightbox="../media/microsoft-365-zero-trust-architecture-defender.png":::

Go to [**_Evaluate and pilot Microsoft Defender XDR_**](/microsoft-365/security/defender/eval-overview?view=o365-worldwide) for a methodical guide to piloting and deploying Microsoft Defender XDR components.

See the guidance to read about the architecture requirements for each component of Microsoft Defender XDR.

## Step 5: Protect and govern sensitive data

Implement Microsoft Purview Information Protection to help you discover, classify, and protect sensitive information wherever it lives or travels.

Microsoft Purview Information Protection capabilities are included with Microsoft Purview and give you the tools to know your data, protect your data, and prevent data loss.

:::image type="content" source="../media/microsoft-365-zero-trust-architecture-info-protect.png" alt-text="Diagram showing the Information protection capabilities protecting data through policy enforcement." lightbox="../media/microsoft-365-zero-trust-architecture-info-protect.png":::

While this work is represented at the top of the deployment stack illustrated earlier in this article, you can begin this work anytime.

Microsoft Purview Information Protection provides a framework, process, and capabilities you can use to accomplish your specific business objectives.

:::image type="content" source="../media/purview-information-protection-solution-overview.png" alt-text="Diagram showing Microsoft Purview Information Protection." lightbox="../media/purview-information-protection-solution-overview.png":::

For more information on how to plan and deploy information protection, see [**_Deploy a Microsoft Purview Information Protection solution_**](/microsoft-365/compliance/information-protection-solution?view=o365-worldwide).

If you're deploying information protection for data privacy regulations, this solution guide provides a recommended framework for the entire process: [**_Deploy information protection for data privacy regulations with Microsoft 365_**](/microsoft-365/solutions/information-protection-deploy?view=o365-worldwide).
