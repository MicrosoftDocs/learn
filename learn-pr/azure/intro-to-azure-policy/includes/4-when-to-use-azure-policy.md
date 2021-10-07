## When to use Azure Policy

As mentioned, Azure Policy is a service that you use to create, assign, and manage policy definitions. 

Those policy definitions are mainly used to implementing governance for resource consistency, regulatory compliance, security, cost, and management. You can specify configuration requirements for any resources that are created and take one of these actions:

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