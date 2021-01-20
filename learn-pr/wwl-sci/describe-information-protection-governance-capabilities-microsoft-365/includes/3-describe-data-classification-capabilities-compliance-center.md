Organizations need to know their data so that they can identify important information across their estate and ensure that data is handled in a way that is in line with compliance requirements. Admins can enable their organization to know its data through data classification capabilities and tools in the Microsoft 365 compliance center, such as sensitive information types, trainable classifiers, content explorer, and activity explorer.

## Sensitive information types

With Microsoft 365 compliance center, admins can identify and protect sensitive information types.  Sensitive information types have set patterns that can be used to identify them.  For example, an identification number in a country/region may be based on a specific pattern, like this:

*123-456-789-ABC*

Microsoft 365 includes many built-in sensitive information types based on patterns that are defined by a regular expression (regex) or a function.

Examples include:

- Credit card numbers
- Passport or identification numbers
- Bank account numbers
- Health service numbers

Refer to [Sensitive information type entity definitions](https://docs.microsoft.com/microsoft-365/compliance/sensitive-information-type-entity-definitions?view=o365-worldwide) for a listing of available built-in sensitive information types.

Data classification in Microsoft 365 also supports the ability to create custom sensitive information types to address organization-specific requirements.  For example, an organization may need to create sensitive information types to represent employee IDs or project numbers.

## Trainable classifiers

Trainable classifiers use artificial intelligence and machine learning to intelligently classify your data. They are most useful classifying data unique to an organization like specific kinds of contracts, invoices, or customer records. This method of classification is more about training a classifier to identify an item based on what the item is, not by elements that are in the item (pattern matching).
There are two types of classifiers available:

- **Pre-trained classifiers** - Microsoft has created and pre-trained a number of classifiers that you can start using without training them. These classifiers will appear with the status of **Ready to use**.  Microsoft 365 comes with five pre-trained classifiers that can detect and classify things like resumes, source code, harassment, profanity, and threat (relates to committing violence or doing physical harm).  To learn more, visit Pre-trained classifiers.

- **Custom trainable classifiers** - Microsoft supports the ability to create and train custom classifiers. They are most useful when classifying data unique to an organization, like specific kinds of contracts, invoices, or customer records.

To get a custom trainable classifier to accurately identify an item as being in a particular category of content, it must first be presented with many samples of the type of content that are in the category. This feeding of positive samples is known as seeding and is used to create a prediction model for the classifier.

The model gets tested to determine if the classifier can correctly distinguish between items that match the category and items that don't. The result of each prediction is manually verified, which serves as input to improve the accuracy of the prediction model.

Once the accuracy score of the model has stabilized the classifier can be published.
Once published, trainable classifiers can sort through items in locations like SharePoint Online, Exchange, and OneDrive, and classify the content.

> [!NOTE]
> At this time, classifiers only work with items that are in English and that are not encrypted.

## Understand and explore the data

Data classification can involve large numbers of documents and emails. To help administrators to easily derive insights and understanding, the overview section of the data classification pane in compliance center provides many details at a glance, including:

- The number of items classified as sensitive information type and which classifications those are.
- Details on the locations of data based on sensitivity.
- Summary of actions that users are taking on sensitive content across the organization.

Additionally, administrators can use the content and activity explorers to gain a deeper understanding and guide their actions.

## What is the content explorer?

The content explorer is available as a tab in the data classification pane of compliance center, and enables administrators to gain visibility into the content that has been summarized in the overview pane.
Access to content explorer is highly restricted because it makes it possible to read the contents of scanned files.  There are two roles that grant access to content explorer:

- Content explorer list viewer
- Content explorer content viewer

Anyone who wants to access content explorer must have an account in one or both of the role groups.

With the content explorer, administrators can get a current snapshot of individual items that have been classified across the organization. It enables administrators to further drill down into items by allowing them to access and review the scanned source content that is stored in a variety of locations such as Exchange, SharePoint, and OneDrive.

## What is the activity explorer?

**Activity explorer** provides visibility into what content has been discovered and labeled, and where that content is. It makes it possible to monitor what's being done with labeled content across the organization. Admins gain visibility into document-level activities like label changes and label downgrades (such as when someone changes a label from confidential to public). Admins can use the filters to see all the details for a specific label, including file types, users, and activities. Activity explorer makes it possible to understand what is being done with labeled content over time. Admins can use activity explorer to evaluate if controls already in place are effective.

Here are just a few of the activity types that can be analyzed:

- File copied to removable media
- File copied to network share
- Label applied
- Label changed

Admins can use over 30 filters to filter the data including:

- date range
- activity type
- location
- user
- sensitivity label
- retention label

The value of understanding what actions are being taken with sensitive content is that admins can see if the controls that they have already put into place, such as [data loss prevention policies](https://docs.microsoft.com/microsoft-365/compliance/data-loss-prevention-policies?view=o365-worldwide) are effective or not. For example, if it’s discovered that a large number of items that have been labeled *Highly Confidential*, have suddenly been downgraded to *Public*, admins can update policies and act to restrict undesired behavior as a response.

## Compliance center tour

The video below gives you a detailed tour and additional information on the various data classification capabilities available in the compliance center:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4vx8x]