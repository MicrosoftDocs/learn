Review the Databricks Genie app as a third-party application before granting consent or making it available. Microsoft permissions control the app's collaboration access, while Azure Databricks permissions continue to control the data query.

## Distinguish the permission types

The app requests two categories of Microsoft permissions:

- **Microsoft Entra ID delegated permissions** support sign-in and access to the signed-in user's basic profile. The current app lists `offline_access` and `User.Read`.
- **Teams resource-specific consent (RSC) permissions** apply to the chat, channel, or team where the app is installed. They include permissions to read and send relevant messages, send activity notifications, read channel members, and read channel settings.

The app might temporarily display `User.ReadBasic.All` during installation. Azure Databricks documentation states that this permission is no longer used and is being removed from the requested set. Review the permissions shown by the current app package rather than relying on an older approval record.

## Review Microsoft Graph consent

In [Teams admin center](https://admin.teams.microsoft.com/), a Teams administrator can inspect the permissions requested by a third-party app. Only a Global Administrator grants organization-wide consent to Microsoft Graph permissions through this flow. Whether the delegated permissions require administrator consent depends on the tenant's user-consent policy. Organization-wide approval is a deployment choice, not an inherent property of every delegated permission.

1. In Teams admin center, go to **Teams apps** > **Manage apps**.
2. Search for **Databricks Genie**.

    :::image type="content" source="../media/microsoft-teams-admin-center-manage-apps.png" alt-text="Screenshot of Teams admin center search results for the Databricks Genie app.":::

3. Open the app and select **Permissions**, or select **View details** from the permissions column.
4. Compare the displayed permissions with the current [Databricks Genie app permissions](/azure/databricks/integrations/msft-teams#required-app-permissions-on-microsoft).
5. Review the publisher, permission purpose, privacy statement, terms of use, and organizational data-handling requirements.
6. If the approved deployment uses organization-wide consent, have a Global Administrator grant it after the review.

    :::image type="content" source="../media/microsoft-teams-admin-center-grant-consent.png" alt-text="Screenshot of the Databricks Genie app page showing the Grant admin consent link.":::

Organization-wide consent means assigned users aren't prompted to review the Microsoft Graph permissions individually. App availability remains a separate decision.

## Review resource-specific consent

RSC limits a permission to the Teams resource where the app is installed. For example, channel-message read access applies to the team where a resource owner adds the app rather than to every channel in the tenant.

Team owners can grant RSC when they add an app if Microsoft Entra group-owner consent settings permit it. Confirm whether the organization's policy allows this behavior. If it doesn't, include the required administrator action in the deployment process.

RSC doesn't grant access to Unity Catalog data. It permits the app to participate in the Teams conversation that carries the question and answer.

## Account for Azure Databricks sign-in consent

Each user signs in to the selected Azure Databricks workspace. If Microsoft Entra blocks user consent for the Azure Databricks enterprise application, the user receives a **Need admin approval** message even when they already belong to the workspace.

An appropriate Microsoft Entra administrator can grant tenant-wide consent to the Azure Databricks enterprise application. Confirm the application by its application ID: `aaec40b0-c0ae-4211-a98b-6fc160abb71b`.

Use [Grant tenant-wide admin consent to an application](/entra/identity/enterprise-apps/grant-admin-consent) for the current portal steps and least-privileged roles. This consent is for Azure Databricks sign-in. It's distinct from consent granted to the Databricks Genie Teams app.

## Review the data boundary

The Databricks Genie app sends questions to Azure Databricks and returns answers to Microsoft 365. Include these points in the security review:

- The user authenticates to Azure Databricks with their own identity.
- Unity Catalog governs the source data query.
- Azure Databricks partner-powered AI and trust settings apply to Genie processing.
- Teams message visibility determines who can see the returned answer in the conversation.
- Microsoft 365 app approval doesn't extend Microsoft service terms or protections to processing performed by a non-Microsoft service.

After the permission and data-boundary review is approved, the Microsoft 365 administrator can install and assign the app.