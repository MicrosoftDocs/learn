

Organizations need to know their data to identify important information across the estate and ensure that data is handled in line with compliance requirements. Admins can enable their organization to know its data through data classification capabilities and tools in the Microsoft Purview compliance portal, such as sensitive information types, trainable classifiers, content explorer, and activity explorer.

Identifying and classifying sensitive items that are under your organization's control is the first step in the Information Protection discipline. Microsoft Purview provides three ways of identifying items so that they can be classified:

- manually by users
- automated pattern recognition, like sensitive information types
- machine learning

### Sensitive information types

Sensitive information types (SIT) are pattern-based classifiers. They have set patterns that can be used to identify them.  For example, an identification number in a country/region may be based on a specific pattern, like this:

*123-456-789-ABC*

Microsoft Purview includes many built-in sensitive information types based on patterns that are defined by a regular expression (regex) or a function.

Examples include:

- Credit card numbers
- Passport or identification numbers
- Bank account numbers
- Health service numbers

Refer to [Sensitive information type entity definitions](/microsoft-365/compliance/sensitive-information-type-entity-definitions) for a listing of available built-in sensitive information types.

Data classification in Microsoft Purview also supports the ability to create custom sensitive information types to address organization-specific requirements.  For example, an organization may need to create sensitive information types to represent employee IDs or project numbers.

Also supported is exact data match (EDM) classification. EDM-based classification enables you to create custom sensitive information types that refer to exact values in a database of sensitive information.

To explore how to classify data using sensitive info types with Microsoft Purview Information Protection, select the interactive guide available in the Learn more section of the Summary and resources unit of this module.

### Trainable classifiers

Trainable classifiers use artificial intelligence and machine learning to intelligently classify your data. They're most useful classifying data unique to an organization like specific kinds of contracts, invoices, or customer records. This method of classification is more about training a classifier to identify an item based on what the item is, not by elements that are in the item (pattern matching).
Two types of classifier are available:

- **Pre-trained classifiers** - Microsoft has created and pretrained many classifiers that you can start using without training them. These classifiers will appear with the status of **Ready to use**.  Microsoft Purview comes with five pretrained classifiers that detect and classify things like resumes, source code, harassment, profanity, and threat (relates to committing violence or doing physical harm).

- **Custom trainable classifiers** - Microsoft supports the ability to create and train custom classifiers. They're most useful when classifying data unique to an organization, like specific kinds of contracts, invoices, or customer records.

To get a custom trainable classifier to accurately identify an item as being in a particular category of content, it must first be presented with many samples of the type of content in the category. This feeding of positive samples is known as seeding and is used to create a prediction model for the classifier.

The model gets tested to determine if the classifier can correctly distinguish between items that match the category and items that don't. The result of each prediction is manually verified, which serves as input to improve the accuracy of the prediction model.

After the accuracy score of the model has stabilized, the classifier can be published.
Trainable classifiers can then sort through items in locations like SharePoint Online, Exchange, and OneDrive, and classify the content.

> [!NOTE]
> At this time, classifiers only work with items that aren't encrypted.

### Understand and explore the data

Data classification can involve large numbers of documents and emails. To help administrators to easily derive insights and understanding, the overview section of the data classification pane in compliance portal provides many details at a glance, including:

- The number of items classified as sensitive information and which classifications they are.
- Details on the locations of data based on sensitivity.
- Summary of actions that users are taking on sensitive content across the organization.

Administrators can also use the content and activity explorers to gain a deeper understanding and guide their actions.

#### What is the content explorer?

The content explorer is available as a tab in the data classification pane of compliance portal. It enables administrators to gain visibility into the content that has been summarized in the overview pane.

Access to content explorer is highly restricted because it makes it possible to read the contents of scanned files.  There are two roles that grant access to content explorer:

- Content explorer list viewer.
- Content explorer content viewer.

Anyone who wants to access content explorer must have an account in one or both of the role groups.

With content explorer, administrators get a current snapshot of individual items that have been classified across the organization. It enables administrators to further drill down into items by allowing them to access and review the scanned source content that's stored in different kinds of locations, such as Exchange, SharePoint, and OneDrive.

#### What is the activity explorer?

Activity explorer provides visibility into what content has been discovered and labeled, and where that content is. It makes it possible to monitor what's being done with labeled content across the organization. Admins gain visibility into document-level activities like label changes and label downgrades (such as when someone changes a label from confidential to public).

Admins use the filters to see all the details for a specific label, including file types, users, and activities. Activity explorer helps you understand what's being done with labeled content over time. Admins use activity explorer to evaluate if controls already in place are effective.

Here are a few of the activity types that can be analyzed:

- File copied to removable media
- File copied to network share
- Label applied
- Label changed

Admins can use more than 30 filters for data including:

- Location
- User
- Sensitivity label
- Retention label

The value of understanding what actions are being taken with sensitive content is that admins can see if the controls that they've already put in place, such as [data loss prevention policies](/microsoft-365/compliance/dlp-create-deploy-policy), are effective or not. For example, if it’s discovered that a large number of items labeled *Highly Confidential* have suddenly been downgraded to *Public*, admins can update policies and act to restrict undesired behavior as a response.

### Explore data classification in the compliance portal

The video below walks you through the various data classification capabilities available in the compliance portal.

> [!NOTE]
> The user interface (UI) in Microsoft 365 is continually evolving so the UI shown in the video may not reflect the most recent updates.


> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4vx8x]
