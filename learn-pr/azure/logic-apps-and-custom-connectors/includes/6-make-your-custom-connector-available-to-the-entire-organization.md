Now that you have created the custom connector for the picture framing API, you want to make it available to all the users in your organization, so that they can call that API from their own Logic Apps workflows. You also know that many of your customers use Logic Apps. If you can publish your new connector to them, they can make calls to your API easily.

## Share a connector with your organization

If you have created a custom connector and used it in a Logic Apps workflow, that connector is, by default, available to other users of Logic Apps in your organization. They can add it to their Logic Apps as long as, in their app's region:

- They share the same Azure Active Directory tenant with you.
- They share the same Azure subscription with you.

Azure Logic Apps shares custom connectors automatically and users see them when they choose connectors in their apps. However, you might want to inform them about the new connector, its purpose, and how to use it.

## Share a connector with the community

If your API is available for external users to query, consider publishing the Logic Apps connector as well. Publishing will make it much easier for anyone who wants to access your data and uses Logic Apps to build workflows. It will also help to promote your API and drive its adoption in the community.

The picture framing API is a good example: anyone can access it if they have a subscription and can write code that makes REST API calls. However, if you publish your new connector, those people who use Logic Apps can query the API from their workflows without writing any code. Some people may be unaware of your picture framing API. If they find your connector in the Logic Apps catalog, they may decide to use it and buy a subscription to it.

To publish your connector in the Logic Apps catalog, you have to submit it to Microsoft for certification. If the connector meets the certification criteria, Microsoft will publish the connector and all Logic Apps users will see it.

### Certification criteria

Microsoft will only certify your connector if it meets the following criteria:

| Feature | Description | Required or Recommended |
| --- | --- | --- |
| Software-as-a-Service ownership | Your organization must own the API that the connector provides access to. | Required |
| Authentication | Your API must support OAuth2, API Key, or basic authentication. | Required |
| Support | Provide a support contract to users so that customers can request help for technical problems. | Required |
| Availability | Guarantee at least 99.9% uptime in your Service Level Agreement (SLA) | Recommended |
| | | |

### Things to check before submission

You should fully test your connector before you submit it for certification. Make sure you are confident that no bugs or other issues will arise. Common problems that you should check for include:

- **Errors in the OpenAPI definition**. Eliminate any invalid JSON code in the API definition file and ensure that it complies with the OpenAPI schema.
- **Full information in the definition**. Every operation, input parameter, and response attribute in the OpenAPI specification that you submit should have summary, description, and visibility information.

### How to submit a connector for certification

The certification process takes around two weeks, but this duration depends on how well you have met the above criteria. The process runs like with these steps:

1. **Nomination**. Visit the nomination form to submit your connector. Microsoft will send a Partner Agreement.
1. **Review**. Once the agreements are signed, a Microsoft employee reviews the connector. You may be required to provide the connector ID, the OpenAPI definition, an icon file, a test account, an email address for support, and other information.
1. **Publish**. Microsoft stages the connector and publishes it as "Preview".
1. **Support and Updates**. Once the connector is published and people begin using it, monitor the related product forums to find out if customers are having any problems. If you need to submit a new version, use the same nomination form. When the connector has been published for some time, you can ask your nomination contact to remove the "Preview" tag.
