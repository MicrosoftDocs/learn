An Azure subscription is a logical unit of Azure services that is linked to an Azure account. Billing for Azure services is done on a per-subscription basis. If your account is the only account associated with a subscription, then you are responsible for billing.

Subscriptions help you organize access to cloud service resources. They also help you control how resource usage is reported, billed, and paid for. Each subscription can have a different billing and payment setup, so you can have different subscriptions and different plans by department, project, regional office, and so on. Every cloud service belongs to a subscription, and the subscription ID may be required for programmatic operations.

:::image type="content" source="../media/azure-subscriptions-e855533e.png" alt-text="Diagram showing the relationship between an Azure subscription and an account, which is simply an identity in Azure Active Directory. Users and services accessing subscription resources first authenticate through Azure AD.":::


## Azure accounts

Subscriptions have accounts. An Azure account is simply an identity in Azure Active Directory (Azure AD) or in a directory that is trusted by Azure AD, such as a work or school organization. If you don't belong to one of these organizations, you can sign up for an Azure account by using your Microsoft Account, which is also trusted by Azure AD.

## Getting access to resources

Every Azure subscription can be associated with an Azure Active Directory. Users and services will then authenticate with Azure Active Directory before accessing resources. 

> [!NOTE]
> Do you know how many subscriptions your organization has? Do you know how resources are organized into resource groups?
