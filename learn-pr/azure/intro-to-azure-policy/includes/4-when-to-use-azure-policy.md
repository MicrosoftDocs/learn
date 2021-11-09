The policy definitions that you create by using Azure Policy are mainly used to implement governance for resource consistency, regulatory compliance, security, cost, and management. You can specify configuration requirements for any resources that are created and take one of these actions:

* Identify resources that are out of compliance.
* Block the resources from being created.
* Add the required configuration.

That means that besides compliance and control, you can add required configuration at scale. The **Append** and **Modify** effect types allow this.

The following examples are just some actions that you can do at scale by using Azure Policy:

* Deploy an Azure Monitor agent to all your virtual machines.
* Enable Azure Backup for virtual machines.
* Enable auditing for all your Azure SQL Database instances.
* Ensure secure connections (HTTPS) for storage accounts.
* Prevent inbound RDP connections from the internet on your virtual machines.
