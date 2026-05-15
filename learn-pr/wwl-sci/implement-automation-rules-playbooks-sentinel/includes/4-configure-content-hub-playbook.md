Before you build a custom playbook from scratch, check the Content Hub. Microsoft and partners publish hundreds of prebuilt Logic Apps playbook templates as part of Microsoft Sentinel solutions—covering common scenarios like incident notifications, account disabling, IP blocking, and ticket synchronization. For many response workflows, a Content Hub playbook gets you to a working, tested solution in under 30 minutes, with no Logic Apps authoring required.

## Find playbook solutions in the Content Hub

In the Microsoft Defender portal, select **Microsoft Sentinel**, then select **Content hub** under **Content management**. To filter for playbooks, select **Content type** in the filter panel and choose **Playbook**.

Each solution card shows the solution name, publisher, and the types of content it includes. Select a solution card to open the details pane, which lists every content item the solution contains—including how many playbooks, analytics rules, workbooks, and data connectors come with it. For the Contoso SOC notification use case is search for "Microsoft Sentinel Incidents" or "Teams notification" to find solutions that include incident notification playbooks.

:::image type="content" source="../media/content-hub-playbook.png" alt-text="Screenshot of the Content Hub in the Microsoft Defender portal filtered to show playbook solutions.":::

When you identify a solution that fits your scenario, review the permissions documentation in the details pane before installing. Most playbook solutions require you to create API connections during or after deployment—for example, a Teams connection authenticated with a service account or a managed identity.

## Deploy a Content Hub playbook to your subscription

To install a playbook solution:

1. In the solution details pane, select **Install** (or **Update** if a newer version is available).
2. On the **Basics** tab, select your **Subscription**, **Resource group**, and **Workspace**. The Logic App resource deploys to the resource group you select.
3. On the subsequent tabs, review the playbook components. Some solutions prompt you to configure settings—such as the Teams channel ID or email recipient—during deployment. Enter the values specific to Contoso's environment.
4. On the **Review + create** tab, wait for **Validation passed**, then select **Create**.

Deployment takes one to three minutes. When it completes, navigate to the resource group in the Azure portal to confirm the Logic App resource is present.

## Grant the playbook access to Microsoft Sentinel

For a playbook to interact with Microsoft Sentinel—reading incident data, posting comments, or updating status—its identity needs permission to do so. A Logic App uses a **managed identity** for this purpose.

To assign the required role:

1. In the Azure portal, navigate to the resource group that contains your Microsoft Sentinel workspace.
2. Select **Access control (IAM)**, then select **Add role assignment**.
3. In the **Role** tab, search for and select **Microsoft Sentinel Responder**. This role grants the minimum permissions a playbook needs: read incidents, post comments, and update incident status.
4. In the **Members** tab, set **Assign access to** to **Managed identity**, then select **+ Select members**. Find the Logic App by name, select it, and confirm.
5. Select **Review + assign**.

:::image type="content" source="../media/playbook-managed-identity-rbac.png" alt-text="Screenshot of the Add role assignment page in the Azure portal assigning the Microsoft Sentinel Responder role to a Logic App managed identity.":::

> [!IMPORTANT]
> If you skip this step, the playbook fails with a 401 Unauthorized error every time it tries to call the Microsoft Sentinel connector. You can diagnose this by selecting the Logic App in the Azure portal, opening **Run history**, and selecting a failed run to view the error detail on the Microsoft Sentinel connector action.

This same managed identity and role assignment pattern applies beyond playbooks. When an autonomous AI agent—such as an agent built on Azure AI Foundry—needs programmatic access to Microsoft Sentinel to read incidents, add comments, or update status, you assign the same Microsoft Sentinel Responder role to the agent's managed identity on the same workspace. The identity model is identical whether the caller is a Logic Apps playbook or an AI-powered automation agent.

## Activate the playbook and test the response flow

With the Logic App deployed and authorized, connect it to an automation rule:

1. In the Microsoft Defender portal, select **Automation**, then select **Create** > **Automation rule**.
2. Configure the trigger and conditions for when the playbook should run—for example, **Incident created**, severity **High**.
3. Under **Actions**, select **Add action**, then select **Run playbook**. Select the playbook you deployed from the list.
4. Select **Apply** to save the rule.

To test, create a test incident manually or wait for a real incident that matches the rule conditions. Once triggered, navigate to **Microsoft Sentinel** > **Automation** > the playbook name, and select **Run history** to confirm the playbook executed. Select the run record to view each action's input, output, and duration. A successful run shows green checkmarks on every action. If any action failed, the run record shows the exact error and the input that caused it—making diagnosis straightforward even for complex multi-step playbooks.
