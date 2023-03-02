
An Azure Active Directory (AD) tenant is created for you when you sign up for Azure. The tenant represents your account. You use the tenant to manage access to your subscriptions and resources.

When you create a new subscription, it's hosted in your account's Azure AD tenant. If you want to give others access to your subscription or its resources, you need to invite them to join your tenant. Doing so helps you control access to your subscriptions and resources. You can create additional subscriptions for your account in Azure. You might want an additional subscription to avoid reaching subscription limits, to create separate environments for billing and security, or to isolate data for compliance reasons.

If you want to create Azure subscriptions under your organization's Enterprise Agreement (EA), you need to have the Account Owner role for your organization.

If you need to transfer billing ownership of your Azure subscription if you're leaving your organization, or you want your subscription to be billed to another account. Transferring billing ownership to another account provides the administrators in the new account permission for billing tasks. They can change the payment method, view charges, and cancel the subscription.

## Manage API access to Azure subscriptions and resources

When you publish APIs through API Management, it's easy and common to gain access to those APIs by using subscription keys. Client applications that consume the published APIs need to include a valid subscription key in HTTP requests when they make calls to those APIs. To get a subscription key for accessing APIs, a subscription is required. A subscription is essentially a named container for a pair of subscription keys. Developers who need to consume the published APIs can get subscriptions, and they don't need approval from API publishers. API publishers can also directly create subscriptions for API consumers.

API Management supports additional mechanisms for gaining access to APIs, including:

 -  OAuth 2.0
 -  Client certificates
 -  IP allowlists

Azure policies encapsulate common API management functions, like those for access control, protection, transformation, and caching. You can chain these policies together into a pipeline that mutates a request’s context or changes the API behavior. You can apply these policies to a variety of scopes, trigger them on an error, and set them in the inbound and outbound directions.

## Who can transfer a subscription?

A billing administrator or the account administrator is a person who has permission to manage billing for an account. They're authorized to access billing on the Azure portal and do various billing tasks like create subscriptions, view and pay invoices, or update payment methods. If you're an Enterprise Agreement (EA) customer, your enterprise administrators can transfer billing ownership of your subscriptions between accounts.

To identify accounts for which you're a billing administrator, use the following steps:

 -  Visit the Cost Management + Billing page in Azure portal.
 -  Select All billing scopes from the left-hand pane.
 -  The subscriptions page lists all subscriptions where you're a billing administrator.
