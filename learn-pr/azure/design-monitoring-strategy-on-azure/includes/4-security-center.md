Because your company is a financial organization, it needs to meet the highest standards for security. Each transaction that a customer or partner initiates must be entirely protected from threats. Your company must also respond effectively to each potential threat. For example, if a virtual machine is compromised, you must act rapidly and address the issue.

You'll provide information on how to protect resources and respond to threats by using Azure Security Center.

## Criteria for assessing Azure Security Center

You use Security Center if:

- You want to identify and address risks and threats to your infrastructure.
- You don't have the traditional in-house skills and capital needed to secure a complex infrastructure.
- You want to secure an infrastructure that consists of on-premises and cloud resources.

## Understand the security posture of your architecture

Security Center gives detailed analyses of different components of your environment. These components include data security, network security, identity and access, and application security. This way, Security Center helps you understand the security of your architecture. You can then build and maintain better infrastructures.

![Analysis of your architecture](../media/4-security-center-dashboard.png)

Security Center recommends how to address the issues and risks that it has uncovered. You use recommendations like the following one to improve the security and compliance of your architecture.

![Recommendations](../media/4-recommendation.png)

## Protect against threats with Azure Security Center

Use access and application controls in Security Center to help protect your resources. These controls block suspicious activity. For example, you protect your virtual machines through just-in-time (JIT) virtual machine access. JIT is a feature that blocks persistent access to virtual machines. Your virtual machines are only accessed based on audited access that you configure.

You enable JIT through the **Just in time VM access** option in the **ADVANCED CLOUD DEFENSE** section of Security Center in the Azure portal. You'll see all virtual machines that already have JIT enabled, and a list of recommended virtual machines that should have JIT enabled. Choose a virtual machine in the recommended list, and then use the **Enable JIT on (number) VM** option to configure JIT for the virtual machine. 

Security Center shows you a list of default ports that JIT will target. You can also configure your own, as shown in the following example.

![JIT configuration](../media/4-just-in-time.png)

You can control which applications are allowed to run on your virtual machines through adaptive application controls. In the background, Security Center uses machine learning to look at the processes running on your virtual machine. It creates exception rules for each resource group that holds your virtual machines, and it gives recommendations.

You can configure adaptive controls by using the **Adaptive application controls** option under the **ADVANCED CLOUD DEFENSE** section of the Azure Security Center menu. You'll see resource groups that contain your virtual machines. Use the **Recommended** section to view the list of resource groups that Security Center recommends for adaptive application controls.  

![Adaptive application controls](../media/4-adaptive-application-controls.png)

When you select a resource group, you use **Create application control rules** to target the virtual machines. You also use it to target the processes, which should have the rule applied.

## Respond to threats with Azure Security Center

You have the responsibility to dismiss alerts if no action is required, such as if there are false positives. You also need to act to address known attacks and block, for example, known malicious IP addresses. Also, you must decide which alerts require more investigation.

Security Center gives a centralized view of all of your security alerts. Security Center ranks security alerts based on their severity. Security Center also combines related alerts as much as possible into a single security incident.

![Incident overview](../media/6-security-center-alert-incident.png)

Security Center helps you respond to threats faster, and in an automated way, through playbooks. Playbooks are automated procedures that you run against alerts. You configure a playbook in the **Playbooks** pane of the Azure Security Center menu. You create a playbook by configuring a logic app.

![Logic app](../media/4-create-logic-app.png)

Your created playbook appears in a list.

![List of playbooks](../media/4-playbook-created.png)

Edit your playbook by selecting it and using the Azure Logic Apps Designer that appears.

![Logic App designer](../media/4-logic-app-designer.png)

After you create a new blank logic app, you can use the designer to search for Security Center connectors and triggers for your playbook. For example, look for *Azure Security Center* and see all the triggers you can use. You then choose a trigger that details what should happen when the playbook is triggered.

![Select a trigger](../media/4-select-trigger.png)

You then define actions that should be taken and which conditions must be met for these actions. Your actions can specify that an email should be sent when an alert is triggered.

![Define actions and conditions for a trigger](../media/4-define-actions.png)

View your security alerts through the **Security alerts** pane under the **THREAT PROTECTION** section on the main menu.  

![View security alerts](../media/4-security-alerts.png)

You drill down into specific security incidents by selecting an incident.

![Incident details](../media/4-security-incident.png)

From here, you can see the list of alerts that the incident holds. You request more information about a specific alert by selecting one.

![Alert details](../media/4-details-security-alert.png)

You can then choose to run your configured playbooks against your alert.

You can further investigate the alert by using the **Continue investigation** option. An investigation map shows all of the entities that are related to this alert.

![Investigation map](../media/4-security-map.png)

You request more information about a specific entity in the map by selecting it. Entities include devices or even users. The map expands with new entities, and properties for the selected entity are displayed on the right. Use this information to better understand a particular path that an attack might have taken.
