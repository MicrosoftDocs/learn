The Azure Databricks foundation and security review are complete. The final setup stage installs the managed marketplace app, makes it available to the intended users, and configures its workspace and channel behavior.

## Install the marketplace app

A Microsoft 365 administrator installs Databricks Genie from Microsoft Marketplace:

1. Open [Microsoft Marketplace](https://marketplace.microsoft.com/).
2. Search for **Databricks Genie**.
3. Open the app listing and review the publisher information.

    :::image type="content" source="../media/microsoft-marketplace.png" alt-text="Screenshot of Microsoft Marketplace with the Databricks Genie app selected.":::

4. Select **Get it now**.

    :::image type="content" source="../media/microsoft-365-admin-center-deploy-databricks-genie.png" alt-text="Screenshot of the Microsoft 365 admin center deployment page for Databricks Genie.":::

5. Complete the approved consent flow when prompted. If the organization uses organization-wide Microsoft Graph consent, a Global Administrator completes that action.

    :::image type="content" source="../media/databricks-genie-consent.png" alt-text="Screenshot of the Azure Databricks Genie consent prompt during app deployment.":::

The Teams marketplace installation is also the supported direct setup path for Databricks Genie in Microsoft Copilot.

## Assign app availability

App availability determines who can find, install, and use Databricks Genie. In a tenant that uses app-centric management:

1. In Teams admin center, go to **Teams apps** > **Manage apps**.
2. Search for and open **Databricks Genie**.
3. Select **Users and groups**.
4. Under **Availability**, select **Edit availability**.
5. Select **Specific users or groups**.
6. Add the designated business group, and then select **Apply**.

:::image type="content" source="../media/microsoft-teams-admin-databricks-genie-app-availability.png" alt-text="Screenshot of Teams admin center availability settings for the Databricks Genie app.":::

Use **Everyone** only when the organization intends to make the app available tenant-wide. **No one** makes the app unavailable. Pinning or installing an app doesn't override an availability assignment of **No one**.

Availability changes can take up to 24 hours to appear and, in rare cases, up to six days. Account for this propagation period when communicating the setup date.

> [!NOTE]
> Some tenants still show Teams app permission policies instead of app-centric management. Use the access-management method displayed in the tenant and follow the current [Teams app-centric management guidance](/microsoftteams/app-centric-management).

## Decide whether to install or pin the app

Availability lets assigned users install the app. An administrator can also preinstall the app or pin it in the Teams navigation for the target population.

- **Installation** places the app in the assigned user's Teams client.
- **Pinning** makes an installed app easier to find.
- **Availability** authorizes the user to add and use the app.

Treat these as separate controls. A setup policy or app-centric installation can improve discovery, but it doesn't grant access to a user outside the availability assignment.

## Configure a user's workspace

The first time an assigned user opens the app, they connect it to Azure Databricks:

1. In Teams, open **Apps**, and then open **Databricks Genie**.
2. Enter a question or open the app configuration.
3. Select **Configure** when prompted.

    :::image type="content" source="../media/microsoft-teams-connect-databricks-genie.png" alt-text="Screenshot of Microsoft Teams prompting a user to connect to Azure Databricks Genie.":::

4. Enter the target Azure Databricks **Workspace URL**.

    :::image type="content" source="../media/microsoft-teams-connect-databricks-genie-configure-workspace.png" alt-text="Screenshot of Microsoft Teams showing the workspace selection for Azure Databricks Genie.":::

5. Select **Continue**, and then sign in to Azure Databricks.

The sign-in establishes the user's Azure Databricks identity. It doesn't create workspace membership or grant missing entitlements.

Users can also open Databricks Genie from **More agents** in Microsoft Copilot or type `@Databricks` in a new Copilot Chat. The current Azure Databricks documentation refers to this surface as Microsoft 365 Copilot. Tenant labels can vary as Microsoft Copilot naming changes.

## Configure a Teams channel

A channel owner configures the app when a channel should use a consistent workspace, visibility setting, or Genie Agent:

1. In the target channel, enter `@Databricks Genie`.
2. Add the app to the channel if Teams prompts for installation.
3. Enter `config`.
4. Select the connected workspace.
5. Select public or private message visibility, subject to the workspace policy.
6. Select Genie One or a specific Genie Agent, and then save the channel-wide setting.

If no agent is selected, the channel uses Genie One. Selecting a specific agent sends channel questions to that agent through Genie One.

If **Allow public messages in collaboration platforms** is off, channel and group messages do not work and only direct messages are supported.

## Apply configuration precedence

When settings differ, the integration applies them in this order:

1. **Workspace settings** have the highest priority. If the workspace disables public collaboration messages, channel and group-chat use isn't available.
2. **Channel-wide settings** selected by a channel owner override personal settings in that channel.
3. **Personal settings** apply when no channel-wide value overrides them.

After the documented propagation period, confirm that assigned users can find Databricks Genie in Teams and Microsoft Copilot. The completed setup now includes the managed app, its assigned audience, and its Azure Databricks and Teams scopes.