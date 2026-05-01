
Copilot is embedded across the Microsoft Entra admin center to help identity administrators and SOC analysts investigate and respond to identity risk. Whether you're reviewing a flagged user, assessing application risk, or correlating data across an identity-based security incident, Copilot surfaces the context you need without requiring you to navigate through multiple reports and logs manually.

> [!NOTE]
>The list of Copilot capabilities embedded in Microsoft Entra is continually growing. This unit provides just a sampling of those capabilities. For more information, see documentation on Microsoft Entra.

Some of the scenarios supported through the embedded experience include:

- Summarize risky user risk and get recommendations for mitigation.
- Assess application and workload identity risk.
- Investigate identity-based security incidents using sign-in logs, audit logs, and user details.

Before you get started with Copilot in Microsoft Entra, your organization must be onboarded to Security Copilot, the Microsoft Entra plugin must be enabled in Copilot, and users must have the appropriate role permissions. Copilot assumes the permissions of the user when it tries to access data to answer queries, so you need the required permissions to access Microsoft Entra data.

### Summarize risky user risk

Risky user summarization is often the starting point for an identity risk investigation. Microsoft Entra ID Protection applies the capabilities of Copilot to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. From a flagged user in the Risky users report, Copilot can immediately explain why the user was flagged and what to do next.

To view and investigate a user’s risky sign-ins:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

1. Navigate to Protection > Identity Protection and then to the Risky users report.

    :::image type="content" source="../media/entra-risky-users-v2.png" lightbox="../media/entra-risky-users-v2.png" alt-text="Screen capture of the risky users list in Identity Protection.":::

1. Select a user from the risky users report.

1. Select the Summarize tab in the Risky User Details window.

     :::image type="content" source="../media/entra-risky-users-summarize-v2.png" lightbox="../media/entra-risky-users-summarize-v2.png" alt-text="Screen capture showing the Copilot generated summary.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why the user risk level was elevated.
- What to do: lists actionable insights tailored to the incident at hand to resolve the risk.
- Help and documentation: lists customized recommendations for how to mitigate against those types of attacks, with quick links to help and documentation.

Users can provide feedback on the generated content.

:::image type="content" source="../media/entra-feedback.png" lightbox="../media/entra-feedback.png" alt-text="Screen capture showing the feedback menu.":::

### Investigate app risk

Risky users represent one dimension of identity risk. Applications and workload identities represent another. Organizations typically have many apps registered in their tenant, and it can be difficult to identify which ones pose the greatest risk—especially when permissions are granted incrementally over time.

Copilot is embedded in the **Enterprise apps**, **App Registrations**, and **Identity Protection Risky workload identities** blades of the Microsoft Entra admin center. Using natural language prompts, identity admins can ask questions like "Show me risky apps" or "Which apps have high-privilege permissions" to assess application risk across the tenant. Copilot draws on ID Protection risky workload identity data to return prioritized lists of at-risk service principals, along with their permissions, ownership, and risk level.

Copilot can also surface apps with tenant-wide application permissions or highly privileged Microsoft Entra administrator roles, identify unused apps that can be quickly removed to reduce the attack surface, and flag apps with credentials approaching expiry. Direct links back to each app in the admin center let you take remediation action without leaving the investigation context.

> [!NOTE]
> Identifying risky workload identities requires a Workload Identities Premium license or a Microsoft Entra ID P2 license.

### Investigate identity-based security incidents

Risky user and app risk signals often surface as part of a broader security incident involving a compromised or suspicious account. When that happens, you need to correlate identity data across multiple sources—user details, sign-in logs, audit logs, and group memberships—to understand the full scope and take action quickly.

Copilot in the Microsoft Entra admin center helps you do this without switching between reports. Launch the Copilot panel using the **Copilot** button in the admin center menu bar, then use natural language prompts to gather everything you need in a single investigation session:

- Retrieve user profile details, including assigned roles, registered devices, and authentication methods.
- Query risky user details—risk level, risk state, risk history, and recent risky sign-ins.
- Review sign-in logs over a defined time period, filtered by IP address, location, or sign-in status.
- Retrieve audit logs to identify unusual or unauthorized actions performed by the user.
- Check group memberships to understand what resources a potentially compromised account can access.

After you complete the investigation, Copilot can help you deactivate any elevated roles you activated during the session and direct you to risk remediation documentation and incident response playbooks.