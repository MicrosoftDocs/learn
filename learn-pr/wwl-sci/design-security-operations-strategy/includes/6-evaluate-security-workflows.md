Every security program includes multiple workflows for incident
response. These processes might include notifying relevant stakeholders,
launching a change management process, and applying specific remediation
steps. Security experts recommend that you automate as many steps of
those procedures as possible. Automation reduces overhead. It can also
improve your security by ensuring the process steps are done quickly,
consistently, and according to your predefined requirements.

**Consider these steps for your incident response workflow**

1. For each incident, begin an [attack and alert investigation and analysis](/microsoft-365/security/defender/investigate-incidents?view=o365-worldwide)
2. Perform containment to reduce any additional impact of the attack and eradication the security threat.
3. Recover from the attack by restoring your tenant resources to the state they were in before the incident.
4. Resolve the incident or escalate to a triage team member if the situation requires some human judgement.
 
### Incident response best practices

With these recommendations, responding to incidents can be done
effectively from technical and operations perspectives.

For the technical aspects of incident response, here are some goals to
consider:

-   Try to identify the scope of the attack operation - Most adversaries
    use multiple persistence mechanisms.

-   Identify the objective of the attack, if possible - Persistent
    attackers will frequently return for their objective (data/systems)
    in a future attack.

For security operations (SecOps) aspects of incident response, here are
some goals to consider:

-   Staying focused - Confirm you keep the focus on business-critical
    data, customer impact, and getting ready for remediation.

-   Providing coordination and role clarity - Establish distinct roles
    for operations in support of the crisis team and confirm that
    technical, legal, and communications teams are keeping each other
    informed.

-   Keeping your business perspective - You should always consider the
    impact on business operations by both adversary actions and your
    response actions.

### Recovery best practices

Recovering from incidents can be done effectively from both technical
and operations perspectives with these recommendations.

For the technical aspects of recovering from an incident, here are some
goals to consider:

-   Don't boil the ocean - Limit your response scope so that recovery
    operation can be executed within 24 hours or less. Plan a weekend to
    account for contingencies and corrective actions.

-   Avoid distractions - Defer long-term security investments like
    implementing large and complex new security systems or replacing
    anti-malware solutions until after the recovery operation. Anything
    that does not have a direct and immediate impact on the current
    recovery operation is a distraction.

For the operations aspects of recovering from an incident, here are some
goals to consider:

-   Have a clear plan and limited scope - Work closely with your
    technical teams to build a clear plan with limited scope. While
    plans may change based on adversary activity or new information, you
    should work diligently to limit scope expansion and take on
    additional tasks.

-   Have clear plan ownership - Recovery operations involve many people
    doing many different tasks at once, so designate a project lead for
    the operation for clear decision-making and definitive information
    to flow among the crisis team.

-   Maintain stakeholder communications - Work with communication teams
    to provide timely updates and active expectation management for
    organizational stakeholders.

### Workflow Automation

There are a few key technologies to be used for workflow automation in
Azure:

1.  **Azure Logic Apps** - Azure Logic Apps is a cloud-based platform
    for creating and running automated *workflows* that integrate your
    apps, data, services, and systems. With this platform, you can
    quickly develop highly scalable integration solutions for your
    enterprise and business-to-business (B2B) scenarios. As a member of
    Azure Integration Services, Azure Logic Apps simplifies the way that
    you connect legacy, modern, and cutting-edge systems across cloud,
    on premises, and hybrid environments. For more information on Azure
    Logic Apps, see [Overview for Azure Logic
    Apps](/azure/logic-apps/logic-apps-overview).

2.  **Microsoft Defender for cloud** - the workflow automation feature
    of Microsoft Defender for Cloud can trigger Logic Apps on security
    alerts, recommendations, and changes to regulatory compliance. For
    more information on creating workflow automation with Defender for
    Cloud, see [Automate responses to Defender for cloud
    triggers](/azure/defender-for-cloud/workflow-automation)

3.  **Microsoft Graph security** - With Azure Logic Apps and the
    Microsoft Graph Security connector, you can improve how your app
    detects, protects, and responds to threats by creating automated
    workflows for integrating Microsoft security products, services, and
    partners. For example, you can create Microsoft Defender for Cloud
    playbooks that monitor and manage Microsoft Graph Security entities,
    such as alerts. For more information on the integration, see
    [Improve threat protection by integrating security operations with
    Microsoft Graph Security & Azure Logic
    Apps](/azure/connectors/connectors-integrate-security-operations-create-api-microsoft-graph-security).

4.  **Microsoft Sentinel** -- Sentinel provides both automation rules
    and playbooks. Automation rules help you triage incidents by
    changing incident attributes or running playbooks. Playbooks are
    collections of procedures that can be run from Microsoft Sentinel in
    response to an alert or incident.

### Creating a workflow using Defender for Cloud and Azure Logic Apps

1.  From Defender for Cloud's sidebar, select **Workflow automation**.

![Screenshot of workflow automation page showing the list of defined automations.](media\workflow-automation.png) 

From this page you can create new automation rules, as well as enable, disable, or delete existing ones.

2.  To define a new workflow, click **Add workflow automation**. The
    options pane for your new automation opens.
![Add Workflow Automation](media\add-workflow-automation.png) 
 Here you can enter:

   a.  A name and description for the automation.

   b.  The triggers that will initiate this automatic workflow. For
    example, you might want your Logic App to run when a security alert
    that contains "SQL" is generated.

   c.  The Logic App that will run when your trigger conditions are met.
 
3.  From the Actions section, select **visit the Logic Apps page** to
    begin the Logic App creation process.

You'll be taken to Azure Logic Apps.

4.  Select **Add**.

![Creating a new Logic App.](media\microsoft-azure-logic-app.png) 

5.  Enter a name, resource group, and location, and select **Review and
    create** > **Create**.

The message **Deployment is in progress** appears. Wait for the
deployment complete notification to appear and select **Go to
resource** from the notification.

6.  In your new logic app, you can choose from built-in, predefined
    templates from the security category. Or you can define a custom
    flow of events to occur when this process is triggered.

The logic app designer supports these Defender for Cloud triggers:

-   **When a Microsoft Defender for Cloud Recommendation is created or triggered** - If your logic app relies on a recommendation that gets deprecated or replaced, your automation will stop working, and you'll need to update the trigger. To track changes to recommendations, use the [release notes](/azure/defender-for-cloud/release-notes).

-   **When a Defender for Cloud Alert is created or triggered** - You can customize the trigger so that it relates only to alerts with the severity levels that interest you.

-   **When a Defender for Cloud regulatory compliance assessment is created or triggered** - Trigger automations based on updates to regulatory compliance assessments.

![Trigger Automations](media\TriggerAutomations.png) 

7.  After you've defined your logic app, return to the workflow
    automation definition pane (\"Add workflow automation\").
    Click **Refresh** to ensure your new Logic App is available for
    selection.

![Refresh.](media\ActionsRefresh.png) 

8.  Select your logic app and save the automation. Note that the Logic
    App dropdown only shows Logic Apps with supporting Defender for
    Cloud connectors mentioned above.

**Creating a workflow using Microsoft Security Graph and Azure Logic
Apps**

#### Add triggers

In Azure Logic Apps, every logic app must start with a
[trigger](/azure/logic-apps/logic-apps-overview#logic-app-concepts),
which fires when a specific event happens or when a specific condition
is met. Each time that the trigger fires, the Logic Apps engine creates
a logic app instance and starts running your app's workflow.

When a trigger fires, the trigger processes all the new alerts. If no
alerts are received, the trigger run is skipped. The next trigger poll
happens based on the recurrence interval that you specify in the
trigger's properties.

This example shows how you can start a logic app workflow when new
alerts are sent to your app.

8.  In the Azure portal or Visual Studio, create a blank logic app,
    which opens the Logic App Designer. This example uses the Azure
    portal.

9.  On the designer, in the search box, enter \"microsoft graph
    security\" as your filter. From the triggers list, select this
    trigger: **On all new alerts**

10. In the trigger, provide information about the alerts that you want
    to monitor. For more properties, open the **Add new parameter**
    list, and select a parameter to add that property to the trigger.
    For a more detailed list of possible properties, see [Add
    triggers](/azure/connectors/connectors-integrate-security-operations-create-api-microsoft-graph-security#add-triggers).

11. When you're done, on the designer toolbar, select **Save**.

12. Now continue adding one or more actions to your logic app for the
    tasks you want to perform with the trigger results.

#### Add actions

Here are more specific details about using the various actions available
with the Microsoft Graph Security connector.

#### Manage alerts

To filter, sort, or get the most recent results, provide *only* the
[ODATA query parameters supported by Microsoft
Graph](/graph/query-parameters). *Don't
specify* the complete base URL or the HTTP action, for example,
<https://graph.microsoft.com/v1.0/security/alerts>, or the GET or PATCH
operation. Here's a specific example that shows the parameters for a
**Get alerts** action when you want a list with high severity alerts:

Filter alerts value as Severity eq 'high'

For more information about the queries you can use with this connector,
see the [Microsoft Graph Security alerts reference
documentation](/graph/api/alert-list).
To build enhanced experiences with this connector, learn more about the
[schema properties
alerts](/graph/api/resources/alert) that
the connector supports.

| Action | Description |
|---|---|
| Get alerts | Get alerts filtered based on one or more alert properties, for example, Provider eq 'Azure Security Center' or 'Palo Alto Networks'. |
| Get alert by ID | Get a specific alert based on the alert ID.|
| Update alert | Update a specific alert based on the alert ID. To make sure you pass the required and editable properties in your request, see the editable properties for alerts. For example, to assign an alert to a security analyst so they can investigate, you can update the alert's Assigned to property. |

### Manage alert subscriptions

Microsoft Graph supports
[*subscriptions*](/graph/api/resources/subscription),
or
[*webhooks*](/graph/api/resources/webhooks).
To get, update, or delete subscriptions, provide the [ODATA query
parameters supported by Microsoft
Graph](/graph/query-parameters) to the
Microsoft Graph entity construct and include security/alerts followed by
the ODATA query. *Don't include* the base URL, for example,
<https://graph.microsoft.com/v1.0>. Instead, use the format in this
example:

`security/alerts?\$filter=status eq 'NewAlert'`

| Action | Description |
|---|---|
| Create subscriptions | Create a subscription that notifies you about any changes. You can filter this subscription for the specific alert types you want. For example, you can create a subscription that notifies you about high severity alerts. |
| Get active subscriptions | Get unexpired subscriptions. |
| Update subscription | Update a subscription by providing the subscription ID. For example, to extend your subscription, you can update the subscription's expirationDateTime property. |
| Delete subscription | Delete a subscription by providing the subscription ID. |

### Manage threat intelligence indicators

To filter, sort, or get the most recent results, provide *only* the
[ODATA query parameters supported by Microsoft
Graph](/graph/query-parameters). *Don't
specify* the complete base URL or the HTTP action, for example,
<https://graph.microsoft.com/beta/security/tiIndicators>, or the GET or
PATCH operation. Here's a specific example that shows the parameters
for a **Get tiIndicators** action when you want a list that has the DDoS
threat type:

Filter threat intelligence indicator value as threatType eq 'DDoS'

For more information about the queries that you can use with this
connector, see ["Optional Query Parameters" in the Microsoft Graph
Security threat intelligence indicator reference
documentation](/graph/api/tiindicators-list).
To build enhanced experiences with this connector, learn more about the
[schema properties threat intelligence
indicator](/graph/api/resources/tiindicator)
that the connector supports. For more information on possible threat
intelligence actions, see [Manage threat
indicators](/azure/connectors/connectors-integrate-security-operations-create-api-microsoft-graph-security#manage-threat-intelligence-indicators).

### Creating a playbook with Microsoft Sentinel and Logic Apps

1.  Create a new playbook from the Microsoft Sentinel navigation under
    Automation. Decide whether you will use an **incident trigger** or
    an **alert trigger**.

2.  Complete the required fields on the **Create playbook** window.

3.  Add actions to define what happens when you call the playbook. These
    could be actions, logical conditions, loops, or switch case
    conditions.

4.  Create an automation rule from the Microsoft Sentinel navigation
    under Automation.

    a.  You can specify analytics rules or conditions for the automation
        rule to take effect.

    b.  You can also specify what actions you want the automation rule
        to take -- such as assigning an owner or running a playbook.

    c.  You can also create an analytics rule in response to alerts.

For more detailed instructions on creating playbooks, see [Use playbooks
with automation rules in Microsoft
Sentinel]/azure/sentinel/tutorial-respond-threats-playbook?tabs=LAC).