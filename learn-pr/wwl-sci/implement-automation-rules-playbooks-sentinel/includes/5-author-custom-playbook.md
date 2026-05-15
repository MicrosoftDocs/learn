Content Hub playbooks cover many common scenarios, but Contoso's SOC has a specific requirement that no prebuilt template addresses: when a high-severity incident is created, post a formatted Teams notification to the security operations channel that includes the incident title, severity, entity list, and a direct link to the incident in the Defender portal—all within 60 seconds of incident creation. Building this from scratch takes about 20 minutes in the Logic Apps Designer, produces a reusable template your team can extend, and gives you hands-on familiarity with the Microsoft Sentinel connector.

## Design your playbook before building

Two trigger types are available for Microsoft Sentinel playbooks: the **Incident trigger** and the **Alert trigger**. Use the incident trigger for nearly all response playbooks. Incidents are Microsoft Sentinel's primary investigation unit—they contain grouped alerts, entity lists, comments, and status. The incident trigger provides all of that as structured input to your workflow.

The alert trigger is useful in one specific scenario: when you disable incident creation in your analytics rules (which is required when Microsoft Sentinel is onboarded to the Defender portal, to avoid duplicate incidents from Defender XDR). In that case, an alert-triggered playbook can still run response logic against individual alerts before they're grouped into an incident.

For the Contoso Teams notification playbook, the incident trigger is the right choice. The notification needs the incident title, severity, and entity list—all of which the incident trigger surfaces as dynamic content in Logic Apps.

## Build a Logic App with the Microsoft Sentinel incident trigger

To create the Logic App:

1. In the Azure portal, search for **Logic Apps** and select **Create**.
2. Select **Consumption** as the plan type. Enter a name—for example, `sentinel-teams-incident-notify` - and select the same subscription and resource group as your Microsoft Sentinel workspace.
3. Select **Review + create**, then **Create**. When deployment completes, select **Go to resource**.
4. In the Logic App resource, select **Logic app designer** under **Development tools**.
5. Select **Blank Logic App** to start from scratch.
6. In the search box, search for **Microsoft Sentinel**. Select **Microsoft Sentinel** under **Triggers**, then select **When a Microsoft Sentinel incident is created**.
7. Select **Sign in** and authenticate using your account. If your organization uses managed identity, switch the connection to **Managed Identity** in the connection settings.

The trigger is now configured. Every time an incident is created in your Microsoft Sentinel workspace, this Logic App receives the incident details as a structured JSON object.

## Add enrichment and notification actions

With the trigger in place, add the actions that retrieve incident data and post the notification:

1. Select **+ New step**. Search for **Microsoft Sentinel** and select **Get incident**. In the **Incident ARM ID** field, select the dynamic content icon and choose **Incident ARM ID** from the trigger output. This action retrieves the full incident object, including the entity list.
2. Select **+ New step**. Search for **Microsoft Teams** and select **Post message in a chat or channel**.
3. Select **Channel** as the message destination. Enter your Teams team and channel.
4. In the **Message** field, build the notification content using dynamic content from both the trigger and the **Get incident** action:

   ```
   New Sentinel Incident
   Title: [Incident Title]
   Severity: [Incident Severity]
   Status: [Incident Status]
   Created: [Incident Created Time]

   View incident: [Incident URL]
   ```

   Replace each bracketed item by selecting the corresponding field from the dynamic content panel. Use **Incident Title**, **Incident Severity**, **Incident Status**, **Incident Created Time UTC**, and **Incident URL** from the trigger output.

5. Select **Save** in the toolbar.

   > [!NOTE]
   > If the Teams connector's dynamic content fields don't appear, check that the Teams connection is authenticated. Select the Teams action's connection, select **Change connection**, and sign in with an account that has permission to post to the target channel.

## Connect the playbook to an automation rule and validate

Before the playbook can run automatically, assign its managed identity the Microsoft Sentinel Responder role (as covered in the previous unit). Then connect it to an automation rule:

1. In the Microsoft Defender portal, navigate to **Microsoft Sentinel** > **Automation**.
2. Select **Create** > **Automation rule**.
3. Name the rule, then set the trigger to **Incident created**, and add a condition for **Incident severity Equals High**.
4. Under **Actions**, select **Run playbook** and choose `sentinel-teams-incident-notify`.
5. Select **Apply**.

To validate the end-to-end flow, create a test incident manually or briefly enable a test analytics rule that you know activates.

Once the incident is created, open the Logic App in the Azure portal and select **Run history**. The most recent run appears at the top of the list. Select it to view each action in sequence—the Microsoft Sentinel trigger, the Get incident action, and the Teams post action. Each action shows its execution time, input payload, and output. A green checkmark on every action means the notification posted successfully. Check your Teams channel to confirm the message arrived with the expected content.

If the Teams action fails with a connection error, reauthorize the Teams connection in the Logic App's **Connections** settings.
