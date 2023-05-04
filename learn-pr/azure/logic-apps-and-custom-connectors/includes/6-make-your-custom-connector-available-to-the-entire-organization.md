Now that you've created a custom connector for the Printer Framer API, you want to make the connector available to all the users in your organization. That way, they can call that API from their own Azure Logic Apps workflows. You also know that many of your customers use Azure Logic Apps. If you can publish your new connector to them, they can make calls to your API easily.

## Share a connector with your organization

If you've created and used a custom connector in a logic app workflow, by default, that connector is available to other Azure Logic Apps users in your organization. They can add the connector to workflows in logic app regions if they meet the following criteria:

- They share the same Azure Active Directory (Azure AD) tenant with you.
- They share the same Azure subscription with you.

Azure Logic Apps automatically shares custom connectors, which other users can see when they select connectors for their workflows. However, you might want to inform them about the new connector, its purpose, how to use it, and so on.

## Share a connector with the community

If external users can call your API, consider publishing your custom connector to the Azure community. Publishing makes building workflows with Azure Logic Apps and accessing your data through the API much easier. Making your custom connector more widely available also helps promote your API and drive community adoption.

The Print Framer API is a good example. Anyone who has a subscription and can write code that makes REST API calls can access your API. However, if you publish your custom connector, people who use Azure Logic Apps can call your API from their workflows without writing any code. Some people might not know about your API, so if they find your connector through the Azure Logic Apps connector gallery, they might decide to try the API and even buy a subscription.

To publish your connector in the Azure Logic Apps connector gallery, you have to submit the connector to Microsoft for certification. If the connector meets the certification criteria, Microsoft will publish the connector for all Azure Logic Apps users to find and use.

### Certification criteria

Microsoft only certifies connectors that meet the following criteria:

| Feature | Required or recommended | Description |
|---------|-------------------------|-------------|
| Software-as-a-Service ownership | Required | Your organization must own the API for which the connector provides access. |
| Authentication | Required | Your API must support OAuth2, API Key, or basic authentication. |
| Support | Required | You need to provide a support contract to users so that customers can request help for technical problems. |
| Availability | Recommended | Guarantee at least 99.9% uptime in your Service Level Agreement (SLA). |
||||

### Checklist before submitting a connector

Fully test your connector before you submit it for certification. Make sure you're confident that no bugs or other issues exist. The following list covers common problems to check and resolve:

- **Errors in the OpenAPI definition**: Eliminate any invalid JSON code in the API definition file. Make sure the API definition complies with the OpenAPI schema.
- **Full information in the definition**: Make sure that every operation, input parameter, and response attribute in the OpenAPI specification you submit has a summary, description, and visibility information.

### Submit a connector for certification

The certification process takes around two weeks, but this timeline depends on how well your connector meets the previous criteria. The process runs similarly to the following steps:

1. **Nomination**: Visit the nomination form to submit your connector. Microsoft will send a Partner Agreement.

1. **Review**: After the agreements are signed, a Microsoft employee reviews the connector. You might need to provide the connector ID, the OpenAPI definition, an icon file, a test account, an email address for support, and other information.

1. **Publish**: Microsoft stages and publishes the connector with the "Preview" tag.

1. **Support and updates**: After Microsoft publishes the connector and people start using it, monitor the related product forums to learn whether customers are having any problems. If you need to submit a new version, use the same nomination form. After the connector has been available for some time, you can ask your nomination contact to remove the "Preview" tag.

For more information, see [Submit your connector for Microsoft certification](/connectors/custom-connectors/submit-for-certification).
