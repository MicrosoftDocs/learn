As mentioned, Azure Policy is a service that you use to create, assign, and manage policy definitions. In general, the policies will be to address *compliance*, *control*, or *scale* needs.

Those policy definitions are mainly used to implementing governance for resource consistency, regulatory compliance, security, cost, and management. You can specify configuration requirements for any resources that are created and take one of these actions:

* Identify resources that are out of compliance
* Block the resources from being created
* Add the required configuration

Example scenarios where you could use Azure Policy:

* **Cost Control**
  * Restrict the SKU's of virtual machines allowed to be created
  * Avoid using Azure regions where the cost of a resource is higher
  * Restrict the usage of solutions from Azure Marketplace that can increase your costs
  
* **Security**
  * Enforce SSL connection to Azure MySQL database
  * Ensure authentication on Linux machines should require SSH keys
  * Ensure Windows machines should meet requirements for Windows Firewall Properties
  
* **Monitoring**
  * Activity logs should be retained for at least one year
  * Log Analytics Agent should be enabled for listed virtual machines images
  * An activity log alert should exist for specific Security operations
  
* **Backup**
  * Make sure all your virtual machines have Azure Backup enabled
  * Ensure that geo-redundant backup is enabled on Azure Database for MySQL or PostgreSQL
  * Ensure that long-term geo-redundant backup is enabled on Azure SQL Database
  
* **Governance**
  * Ensure the proper tag usage as well tag enforcement on resources
  * Audit virtual machines with a pending reboot
  * Manage your organizational-compliance requirements by specifying whether a SSL certificate lifetime action is triggered at a specific percentage of its lifetime or at a certain number of days prior to its expiration

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

The assessment is where you will find an overview about the status of your environment. Then, before making changes in your environment through policies to take actions, assign a policy just to audit your environment. You can use the Overview option from the menu to get this functionality.

Before creating policies, which will make changes in your environment, make sure to test everything.

Validate your policy syntax, the actions that will be taken and the scope in use (Management Groups, Subscriptions, and Resource Groups). Validate all policy inclusions, exclusions, and exemptions.

For the initial deployment, make sure you will be running your policy against a controlled environment or dedicated subscription. Be aware that Azure Policy assignments don’t come into effect immediately. There is a policy evaluation delay, which is around 30 minutes or so. Also, auditing your resources might take some time, as the Azure Policy engine needs to evaluate all resources against policy rules within the assigned scope.

Finally, use the Compliance option to check the results of your policy assignments.

:::image type="content" source="../media/2-compliance.png" alt-text="Screen with the Azure Policy Compliance." lightbox="../media/2-compliance.png":::
