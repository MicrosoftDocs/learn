

Organizations need to know their data to identify important information across the estate and ensure that data is handled in line with compliance requirements. Admins can enable their organization to know its data through data classification and explorer capabilities available in the Microsoft Purview portal.

### Sensitive information types

Sensitive information types (SIT) are pattern-based classifiers. They have set patterns that can be used to identify them. For example, an identification number in a country/region may be based on a specific pattern, like this:

*123-456-789-ABC*

Microsoft Purview includes many built-in sensitive information types based on patterns that are defined by a regular expression (regex) or a function.

Examples include:

- Credit card numbers
- Passport or identification numbers
- Bank account numbers
- Health service numbers

Refer to [Sensitive information type entity definitions](/microsoft-365/compliance/sensitive-information-type-entity-definitions) for a listing of available built-in sensitive information types.

Data classification in Microsoft Purview also supports the ability to create custom sensitive information types to address organization-specific requirements. For example, an organization may need to create sensitive information types to represent employee IDs or project numbers.

Also supported is exact data match (EDM) classification. EDM-based classification enables you to create custom sensitive information types that refer to exact values in a database of sensitive information. In the Microsoft Purview portal sensitive information types are referred to as **EDM classifiers**.

Sensitive information types can be used with sensitivity labels, retention labels, and across many Microsoft Purview and Microsoft Priva Solutions.

### Trainable classifiers

Trainable classifiers use artificial intelligence and machine learning to intelligently classify your data. They're most useful classifying data unique to an organization like specific kinds of contracts, invoices, or customer records. This method of classification is more about training a classifier to identify an item based on what the item is, not by elements that are in the item (pattern matching).
Two types of classifier are available:

- **Pre-trained classifiers** - Microsoft has created and pretrained many classifiers that you can start using without training them. These classifiers appear with the status of **Ready to use**. Microsoft Purview comes with five pretrained classifiers that detect and classify things like resumes, source code, harassment, profanity, and threat (relates to committing violence or doing physical harm).

- **Custom trainable classifiers** - Microsoft supports the ability to create and train custom classifiers. They're most useful when classifying data unique to an organization, like specific kinds of contracts, invoices, or customer records.

To get a custom trainable classifier to accurately identify an item as being in a particular category of content, it must first be presented with many samples of the type of content in the category. This feeding of positive samples is known as seeding and is used to create a prediction model for the classifier.

The model gets tested to determine if the classifier can correctly distinguish between items that match the category and items that don't. The result of each prediction is manually verified, which serves as input to improve the accuracy of the prediction model.

After the accuracy score of the model has stabilized, the classifier can be published.
Trainable classifiers can then sort through items in locations like SharePoint Online, Exchange, and OneDrive, and classify the content.

> [!NOTE]
> At this time, classifiers only work with items that aren't encrypted.

### Understand and explore the data

Data classification can involve large numbers of documents and emails. To help administrators derive insights and understanding, the Explorers node under Information Protection in the Microsoft Purview portal provides tools such as the activity explorer and content explorer that provide details at a glance, including:

- The number of items classified as sensitive information and which classifications they are.
- Details on the locations of data based on sensitivity.
- Summary of actions that users are taking on sensitive content across the organization.

Administrators can also use the information gained from these tools to guide their actions.

- ***Content explorer***: Content explorer provides a current snapshot of the items that have a sensitivity label, a retention label or have been classified as a sensitive information type in your organization. It enables administrators with the appropriate role permissions to further drill down into items by allowing them to access and review the scanned source content that's stored in different kinds of locations, such as Exchange, SharePoint, and OneDrive.

  Access to content explorer is highly restricted because it makes it possible to read the contents of scanned files. A user that requires access to content explorer must have an account in one or more of the content explorer roles groups.

- ***Activity explorer***: Activity explorer provides visibility into what content has been discovered and labeled, and where that content is. It makes it possible to monitor what's being done with labeled content across the organization. Admins gain visibility into document-level activities like label changes and downgrades (such as when someone changes a label from confidential to public), or when files are copied to removable media or a network share.

  Admins use the filters to see all the details for a specific label, including file types, users, and activities. Activity explorer helps you understand what's being done with labeled content over time. Admins use activity explorer to evaluate if controls already in place are effective.

# [Activity explorer](#tab/activity-explorer)
:::image type="content" source="../media/activity-explorer.png" lightbox="../media/activity-explorer.png" alt-text="A screenshot of the activity explorer page in the Microsoft Purview portal.":::

# [Content explorer](#tab/content-explorer)
:::image type="content" source="../media/content-explorer.png" lightbox="../media/content-explorer.png" alt-text="A screenshot of the content explorer page in the Microsoft Purview portal.":::

---

