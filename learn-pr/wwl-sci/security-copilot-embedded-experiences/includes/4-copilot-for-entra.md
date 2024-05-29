
Identity risk investigation is a crucial step to defend an organization. Microsoft Entra ID Protection applies the capabilities of Microsoft Copilot for Security to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation.

Before you get started with Copilot in Microsoft Entra, your organization must be onboarded to Microsoft Copilot for Security, the Entra plugin must be enabled in Copilot, and users must have the appropriate role permissions. Copilot assumes the permissions of the user when it tries to access the data to answer the queries, so you need to have the required permissions to access the Entra data.

To view and investigate a user’s risky sign-ins:

1. Sign in to the Microsoft Entra admin.

1. Navigate to Protection > Identity Protection and then to the Risky users report.

    :::image type="content" source="../media/entra-risky-users-v2.png" lightbox="../media/entra-risky-users-v2.png" alt-text="Screen capture of the risky users list in Identity Protection.":::

1. Select a user from the risky users report.

1. Select the Summarize tab in the Risky User Details window.

     :::image type="content" source="../media/entra-risky-users-summarize-v2.png" lightbox="../media/entra-risky-users-summarize-v2.png" alt-text="Screen capture showing the Copilot generated summary.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why the user risk level was elevated.
- What to do: lists actionable insights tailored to the incident at hand to resolve the risk.
- Help and documentation: lists customized recommendation for how to mitigate against those types of attacks, with quick links to help and documentation.

Users can provide feedback on the generated content.

:::image type="content" source="../media/entra-feedback.png" lightbox="../media/entra-feedback.png" alt-text="Screen capture showing the feedback menu.":::