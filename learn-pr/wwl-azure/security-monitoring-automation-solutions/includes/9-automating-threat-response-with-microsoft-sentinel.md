This unit describes a sample scenario of how you can use a playbook and automation rule to automate incident response and remediate security threats. Automation rules help you triage incidents in Microsoft Sentinel, and are also used to run playbooks in response to incidents or alerts. For more information, see [Automation in Microsoft Sentinel: Security orchestration, automation, and response (SOAR)](/azure/sentinel/automation/automation).

The sample scenario described in this article describes how to use an automation rule and playbook to stop a potentially compromised user when an incident is created.

> [!NOTE]
> Because playbooks make use of Azure Logic Apps, additional charges may apply. Visit the [Azure Logic Apps](https://azure.microsoft.com/pricing/details/logic-apps/) pricing page for more details.

> [!IMPORTANT]
> Microsoft Sentinel is generally available within Microsoft's unified security operations platform in the Microsoft Defender portal. For preview, Microsoft Sentinel is available in the Defender portal without Microsoft Defender XDR or an E5 license. For more information, see [Microsoft Sentinel in the Microsoft Defender portal](/azure/sentinel/microsoft-sentinel-defender-portal).

## Prerequisites

The following roles are required to use Azure Logic Apps to create and run playbooks in Microsoft Sentinel.

| **Role**                                  | **Description**                                                                                             |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| Owner                                     | Lets you grant access to playbooks in the resource group.                                                   |
| Microsoft Sentinel Contributor            | Lets you attach a playbook to an analytics or automation rule.                                              |
| Microsoft Sentinel Responder              | Lets you access an incident in order to run a playbook manually, but doesn't allow you to run the playbook. |
| Microsoft Sentinel Playbook Operator      | Lets you run a playbook manually.                                                                           |
| Microsoft Sentinel Automation Contributor | Allows automation rules to run playbooks. This role isn't used for any other purpose.                       |

The following table describes required roles based on whether you select a Consumption or Standard logic app to create your playbook:

| **Logic app** | **Azure roles**                 | **Description**                                                                            |
| ------------- | ------------------------------- | ------------------------------------------------------------------------------------------ |
| Consumption   | Logic App Contributor           | Edit and manage logic apps. Run playbooks. Doesn't allow you to grant access to playbooks. |
| Consumption   | Logic App Operator              | Read, enable, and disable logic apps. Doesn't allow you to edit or update logic apps.      |
| Standard      | Logic Apps Standard Operator    | Enable, resubmit, and disable workflows in a logic app.                                    |
| Standard      | Logic Apps Standard Developer   | Create and edit logic apps.                                                                |
| Standard      | Logic Apps Standard Contributor | Manage all aspects of a logic app.                                                         |

The Active playbooks tab on the Automation page displays all active playbooks available across any selected subscriptions. By default, a playbook can be used only within the subscription to which it belongs, unless you specifically grant Microsoft Sentinel permissions to the playbook's resource group.

### Extra permissions required to run playbooks on incidents

Microsoft Sentinel uses a service account to run playbooks on incidents, to add security and enable the automation rules API to support CI/CD use cases. This service account is used for incident-triggered playbooks, or when you run a playbook manually on a specific incident.

In addition to your own roles and permissions, this Microsoft Sentinel service account must have its own set of permissions on the resource group where the playbook resides, in the form of the Microsoft Sentinel Automation Contributor role. Once Microsoft Sentinel has this role, it can run any playbook in the relevant resource group, manually or from an automation rule.

To grant Microsoft Sentinel with the required permissions, you must have an Owner or User access administrator role. To run the playbooks, you'll also need the Logic App Contributor role on the resource group that contains the playbooks you want to run.

## Stop potentially compromised users

SOC teams want to make sure that potentially compromised users can't move around their network and steal information. We recommend that you create an automated, multifaceted response to incidents generated by rules that detect compromised users to handle such scenarios.

Configure your automation rule and playbook to use the following flow:

1.  An incident is created for a potentially compromised user and an automation rule is triggered to call your playbook.
2.  The playbook opens a ticket in your IT ticketing system, such as ServiceNow.
3.  The playbook also sends a message to your security operations channel in Microsoft Teams or Slack to make sure your security analysts are aware of the incident.
4.  The playbook also sends all the information in the incident in an email message to your senior network admin and security admin. The email message includes Block and Ignore user option buttons.
5.  The playbook waits until a response is received from the admins, then continues with its next steps.
    
    
     -  If the admins choose Block, the playbook sends a command to Microsoft Entra ID to disable the user, and one to the firewall to block the IP address.
     -  If the admins choose Ignore, the playbook closes the incident in Microsoft Sentinel, and the ticket in ServiceNow.

The following screenshot shows the actions and conditions you would add in creating this sample playbook:

[:::image type="content" source="https://learn.microsoft.com/en-us/azure/sentinel/media/tutorial-respond-threats-playbook/logic-app.png" alt-text="Screenshot of a Logic App showing this playbook's actions and conditions.":::
](https://learn.microsoft.com/en-us/azure/sentinel/media/tutorial-respond-threats-playbook/logic-app.png#lightbox)
