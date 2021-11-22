The policy definitions that you create by using Azure Policy are mainly used to implement governance for resource consistency, regulatory compliance, security, cost, and management. You can specify configuration requirements for any resources that are created and take one of these actions:

* Identify resources that are out of compliance.
* Block the resources from being created.
* Add the required configuration.

That means that besides of compliance and control, you can add required configuration at scale. The append and modify effect types are responsible to allow this.

So just to give you some examples, see below some actions you can do at scale using  Azure Policy:

* Deploy Azure Monitor agent to all your virtual machines
* Enable Azure Backup for virtual machines
* Ensure auditing is enabled to all your Azure SQL Database instances
* Ensure secure connections (HTTPS) to storage accounts
* Prevent inbound RDP from internet on your virtual machines

## When to use Azure Policy

As mentioned, Azure Policy is a service that you use to create, assign, and manage policy definitions. 

Those policy definitions are mainly used to implement governance for resource consistency, regulatory compliance, security, cost, and management. You can specify configuration requirements for any resources that are created and take one of these actions:

* Identify resources that are out of compliance
* Block the resources from being created
* Add the required configuration

That means that besides of compliance and control, you can add required configuration at scale. The append and modify effect types are responsible to allow this.

So just to give you some examples, see below some actions you can do at scale using  Azure Policy:

* Deploy Azure Monitor agent to all your virtual machines
* Enable Azure Backup for virtual machines
* Ensure auditing is enabled to all your Azure SQL Database instances
* Ensure secure connections (HTTPS) to storage accounts
* Prevent inbound RDP from internet on your virtual machines

* **Actions at scale**
  * Deploy Azure Monitor agent to all your virtual machines
  * Enable Azure Backup for virtual machines
  * Ensure auditing is enabled to all your Azure SQL Database instances
  * Ensure secure connections (HTTPS) to storage accounts
  * Prevent inbound RDP from internet on your virtual machines

## Considerations of Azure Policy implementation

Here are four important topics to be considered for a successful implementation:

* Assessment
* Test
* Deploy
* Check

The assessment is where you will have an overview about the status of your environment. Then, before making changes in your environment through policies to take actions, assign a policy just to audit your environment. You can use the Overview option from the menu to get this functionality.

Before creating policies, which will make changes in your environment, make sure to test everything.

Validate your policy syntax, the actions that will be taken and the scope in use (Management Groups, Subscriptions, and Resource Groups). Validate all policy inclusions, exclusions and exemptions.

For the deployment initially, make sure you will be running your policy against a controlled environment or dedicated subscription. Be aware that Azure Policy assignments don’t come into effect immediately. There is a policy evaluation delay, which is around 30 minutes or so. Also, auditing your resources might take some time as the Azure Policy engine needs to evaluate all resources against policy rules within the assigned scope.

Finally use the Compliance option to check the results of your policy assignments. In this report image screenshot it is noted that the compliance is sitting at 39%. Columns in the report indicate the resource names, the scope that is applied, and the compliance state for each listed resource.  The resources are listed as rows in the table with white x enclosed in a solid red circle and the text "Non-compliant". 

:::image type="content" source="../media/2-compliance.png" alt-text="Screenshot depicting the Azure Policy Compliance report." lightbox="../media/2-compliance.png":::

* Deploy Azure Monitor agent to all your virtual machines
* Enable Azure Backup for virtual machines
* Ensure auditing is enabled to all your Azure SQL Database instances
* Ensure secure connections (HTTPS) to storage accounts
* Prevent inbound RDP from internet on your virtual machines
