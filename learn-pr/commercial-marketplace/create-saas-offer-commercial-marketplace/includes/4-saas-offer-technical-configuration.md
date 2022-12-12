Now that you understand the baseline SaaS offer concepts, we’ll review some information that'll help you build a SaaS offer that’s sold through Microsoft. As a reminder, an offer that’s sold through Microsoft is also referred to as a **transact offer**.

The commercial marketplace leverages APIs to manage the entire lifecycle of SaaS subscriptions purchased through the marketplace. Subscription activation, usages, updates, and cancellations are facilitated through a set of SaaS subscription APIs. You’ll have to integrate with these APIs to sell your SaaS offer through Microsoft.

To facilitate communication about subscription statuses and events between your organization and the commercial marketplace, you’ll need to provide a **landing page URL**, a **connection webhook**, and the **Azure Active Directory identity** that your application will use when communicating with the marketplace. If you decide to use the marketplace metering service to add a consumption-based pricing element to your offer, you’ll also need to integrate with the marketplace metered billing APIs.

:::image type="content" source="../media/7-technical-configuration.png" alt-text="Screenshot of the technical configuration fields required to publish a transact offer.":::

### Your offer's landing page

Your SaaS offer’s landing page is the URL to which customers will be redirected after getting your offer from Microsoft AppSource or Azure Marketplace. The landing page has two technical requirements:

- It must be integrated with Azure Active Directory (Azure AD) to log customers in before using your application.

- It should collect any additional customer information you need before activating the customer’s SaaS subscription. Additional information might include supplemental customer contact information, user preferences, or user configurations that your company needs to activate the subscription.

### Your connection webhook

Your offer’s connection webhook facilitates communication between the commercial marketplace and your organization. Your webhook is used to relay information about customer subscriptions that were initiated from the commercial marketplace. Below, we’ve provided a table with some of the events that your connection webhook will need to communicate:

| Event             | Meaning                                                                                    | Actions taken by your SaaS application                                                                                                                                                                                            |
|-------------------|--------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Change plan**       | Customer has requested to change the plan to which they're subscribed.                              | Complete or deny the plan change request. Mark the operation as successful or failed.                                                                                                                                             |
| **Change   quantity** | Customer has requested a change to the number of seats of access.                        | Complete or deny the quantity change request. Mark the operation as successful or failed.                                                                                                                                         |
| **Suspend**           | There's been a billing issue with the customer account.                                | The specific action taken will depend on your organization’s business requirements and the way your application works. As an example, you can configure it to reduce subscription functionality to avoid costly customer usage.  |
| **Unsubscribe**       | Customer has either deleted their subscription or customer payment is >30 days past due. | Terminate the customer’s subscription and perform any necessary cleanup.                                                                                                                                                          |
| **Reinstate**         | After suspension, a customer payment is received to resolve billing issue.               | Reinstate the customer subscription. Mark the operation as successful.                                                                                                                                                            |

### Azure Active Directory (Azure AD) integration

Azure Active Directory (Azure AD) is the Microsoft cloud-based identity- and access-management service. Azure AD makes SaaS offer purchases from the commercial marketplace easier and more secure. By integrating your offer with Azure AD, you’ll be able to automate the process of provisioning users to your SaaS application.

You’ll need to provide your Azure AD tenant ID and your Azure AD application ID when you publish your offer in Partner Center. The two identities work together to provide controlled, permission-based access to your application. You can find both required Azure AD IDs in the Azure portal. For additional details on Azure AD and where to find your tenant and application IDs, you can reference our [documentation on adding technical details for your SaaS offer](/azure/marketplace/create-new-saas-offer-technical).

### Marketplace metered billing API integration

If you decide to use the marketplace metering service to add a usage-based pricing component to your offer, you’ll also need to integrate with the marketplace metered billing APIs. You'll use these APIs to define how often you want to communicate customer usages with Microsoft. The information is used to bill your customers in accordance with their subscription. For more details, reference our [documentation on the metering service APIs](/azure/marketplace/partner-center-portal/marketplace-metering-service-apis).

> [!TIP]
> We recommend that you send meters on a cadence of no more than once per hour and no less than once per day.

Metered billing also makes use of anomaly detection, which calls out usage levels that seem questionable. This analysis helps prevent customer billing errors due to a variety of causes, including:

- Bugs in the meter reporting
- Configuration errors
- Fraudulent usage

For more detailed information on anomaly detection, you can reference our [documentation on the anomaly detection service for metered billing](/azure/marketplace/partner-center-portal/anomaly-detection-service-for-metered-billing).

### Other resources to help you get started

To assist with development, Microsoft has published several tools to speed your development:

- Client libraries for several common languages including .NET-based languages and JVM-based languages.
- An OpenAPI specification to allow you to quickly develop in other languages supported by various OpenAPI library generators.

The client libraries and OpenAPI specification are all open source. You can access them, plus other helpful content, in the [commercial marketplace samples index on GitHub](https://github.com/Azure-Samples/commercial-marketplace-samples).

For more learning opportunities, check out the [Mastering SaaS offers](https://aka.ms/MasteringTheMarketplace/saas) series. These videos, sample code, and hands-on labs will help you learn more about publishing your custom SaaS offer on the Microsoft commercial marketplace.
