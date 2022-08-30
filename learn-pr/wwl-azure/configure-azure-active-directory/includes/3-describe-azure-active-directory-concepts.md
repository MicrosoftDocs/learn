To implement Azure AD in your corporate configuration, you need to understand some of the main concepts of the service.

The following table describes concepts regarding Azure AD and how they're related.

| Azure&nbsp;AD&nbsp;component | Description |
| --- | --- |
| **Identity** | An _identity_ is an object that can be authenticated. The identity can be a user with a username and password. Identities can also be applications or other servers that require authentication by using secret keys or certificates. Azure AD is the underlying product that provides the identity service. |
| **Account** | An _account_ is an identity that has data associated with it. To have an account, you must first have a valid identity. You can't have an account without an identity. |
| **Azure AD account** | An _Azure AD account_ is an identity that's created through Azure AD or another Microsoft cloud service, such as Microsoft 365. Identities are stored in Azure AD and are accessible to your organization's cloud service subscriptions. The Azure AD account is also called a _work or school account_.
| **Azure tenant (directory)** | An Azure _tenant_ is a single dedicated and trusted instance of Azure AD. Each tenant (also called a _directory_) represents a single organization. When your organization signs up for a Microsoft cloud service subscription, a new tenant is automatically created. Because each tenant is a dedicated and trusted instance of Azure AD, you can create multiple tenants or instances. |
| **Azure subscription** | An Azure subscription is used to pay for Azure cloud services. A subscription is linked to a credit card. Each subscription is joined to a single tenant. You can have multiple subscriptions. |