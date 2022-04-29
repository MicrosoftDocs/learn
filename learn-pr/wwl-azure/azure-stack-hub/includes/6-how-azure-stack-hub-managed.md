Azure Stack Hub uses the same operations model as Azure. An Azure Stack Hub operator can deliver various services and apps to tenant users, similar to how Microsoft delivers Azure services to tenant users.

:::image type="content" source="../media/how-stack-managed-ccafc3a6.png" alt-text="Diagram of how Azure Stack Hub uses the same operations model as Azure.":::


You can manage Azure Stack Hub with the administrator portal, user portal, or PowerShell. The Azure Stack Hub portals are each backed by separate instances of Azure Resource Manager. An **Azure Stack Hub Operator** uses the administrator portal to manage Azure Stack Hub, and to do things like create tenant offerings and maintain the health and monitor status of the integrated system. The user portal provides a self-service experience for consumption of cloud resources like virtual machines (virtual machines), storage accounts, and web apps.

As an Azure Stack Hub operator, you can deliver virtual machines, web apps, highly available SQL Server, and MySQL Server databases. You can also use Azure Stack Hub quickstart Azure Resource Manager templates to deploy SharePoint, Exchange, and more.

An operator can manage Azure Stack Hub with the administrator portal or PowerShell. You can configure Azure Stack Hub to deliver services to tenants using plans, quotas, offers, and subscriptions. Tenant users can subscribe to multiple offers. Offers can have one or more plans, and plans can have one or more services. Operators also manage capacity and respond to alerts.

Users consume services that the operator offers. Users can deploy, monitor, and manage services that they've subscribed to, like web apps, storage, and virtual machines. Users can manage Azure Stack Hub with the user portal or PowerShell.
