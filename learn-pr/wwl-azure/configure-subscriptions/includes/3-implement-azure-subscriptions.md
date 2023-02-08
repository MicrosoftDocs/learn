An Azure subscription is a logical unit of Azure services that's linked to an Azure account. An Azure account is an identity in Azure Active Directory (Azure AD) or a directory that's trusted by Azure AD, such as a work or school account. Subscriptions help you organize access to Azure cloud service resources, and help you control how resource usage is reported, billed, and paid.

:::image type="content" source="../media/azure-subscriptions-e855533e.png" alt-text="Diagram that shows the relationship between an Azure subscription and an Azure account, which is an identity in Azure Active Directory.":::

### Things to know about subscriptions

As you think about the subscriptions to implement for your company, consider the following points:

- Every Azure cloud service belongs to a subscription.

- Each subscription can have a different billing and payment configuration.

- Multiple subscriptions can be linked to the same Azure account.

- More than one Azure account can be linked to the same subscription.

- Billing for Azure services is done on a per-subscription basis.

- If your Azure account is the only account associated with a subscription, you're responsible for the billing requirements.

- Programmatic operations for a cloud service might require a subscription ID.

### Things to consider when using subscriptions

Consider how many subscriptions your organization needs to support the business scenarios. As you plan, think about how you can organize your resources into resource groups.

- **Consider the types of Azure accounts required**. Determine the types of Azure accounts your users will link with Azure subscriptions. You can use an Azure AD account or a directory that's trusted by Azure AD like a work or school account. If you don't belong to one of these organizations, you can sign up for an Azure account by using your Microsoft Account, which is also trusted by Azure AD.

- **Consider multiple subscriptions**. Set up different subscriptions and payment options according to your company's departments, projects, regional offices, and so on. A user can have more than one subscription linked to their Azure account, where each subscription pertains to resources, access privileges, limits, and billing for a specific project.

- **Consider a dedicated shared services subscription**. Plan for how users can share resources allocated in a single subscription. Use a shared services subscription to ensure all common network resources are billed together and isolated from other workloads. Examples of shared services subscriptions include Azure ExpressRoute and Virtual WAN.

- **Consider access to resources**. Every Azure subscription can be associated with an Azure AD. Users and services authenticate with Azure AD before they access resources. 