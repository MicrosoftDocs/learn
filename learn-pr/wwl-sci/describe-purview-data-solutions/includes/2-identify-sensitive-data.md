

Organizations need to know their data to identify important information across the estate and ensure that data is handled in line with compliance requirements. Admins can enable their organization to know its data through data classification and explorer capabilities available in the Microsoft Purview portal.

## Sensitive information types

Sensitive information types (SITs) are pattern-based classifiers that detect sensitive information—like social security numbers, credit card numbers, or bank account numbers—to identify sensitive items in your environment.

Every SIT is defined by a set of components that work together to determine when a match is detected:

- **Primary element**: The main element the SIT looks for. It can be a regular expression (with or without a checksum validation), a keyword list, a keyword dictionary, or a function.
- **Supporting elements**: Corroborating evidence that increases confidence in a match. For example, finding the keyword "Social Security Number" near a nine-digit number increases confidence that the number is genuinely a social security number, not just a random string of digits.
- **Confidence level**: Reflects how much supporting evidence is detected alongside the primary element. The three confidence levels—low, medium, and high—determine how aggressively a SIT flags potential matches. A high confidence level returns fewer false positives but might miss more true matches.
- **Proximity**: Specifies how close a supporting element must be to the primary element, measured in the number of characters between them.

Microsoft Purview includes many built-in sensitive information types based on these patterns, covering common scenarios across finance, health care, government, and more. Examples include:

- Credit card numbers
- Passport or identification numbers
- Bank account numbers
- Health service numbers

Microsoft Purview supports four categories of sensitive information types:

- **Built-in sensitive information types**: Microsoft creates and maintains these SITs, and they appear in the Purview portal by default. You can't edit them directly, but you can copy them as a template to create custom variations.
- **Named entity sensitive information types**: These SITs detect person names, physical addresses, and medical terms and conditions. They come in two forms: *unbundled* (narrow focus, such as addresses for a single country or region) and *bundled* (broad detection of all possible matches in a class, such as all physical addresses worldwide).
- **Custom sensitive information types**: When the built-in SITs don't meet your needs, you can create your own using regular expressions, keywords, and keyword dictionaries. For example, an organization might create a custom SIT to represent employee IDs or project codes.
- **Exact data match (EDM) sensitive information types**: EDM-based classification lets you create custom sensitive information types that reference exact values from a database of sensitive information. In the Purview portal, these are referred to as **EDM classifiers**. EDM classification is useful for highly specific data like employee IDs, patient record numbers, or proprietary product codes.

Sensitive information types are used across many Microsoft Purview solutions, including data loss prevention (DLP) policies, sensitivity labels, retention labels, insider risk management, communication compliance, auto-labeling policies, and Microsoft Priva.

## Trainable classifiers

Trainable classifiers use artificial intelligence (AI) and machine learning (ML) to intelligently classify your data. This method is most useful for classifying data that's unique to an organization—like specific kinds of contracts, invoices, or customer records—where pattern matching alone isn't sufficient. Rather than identifying elements in an item through pattern matching, a trainable classifier learns how to identify content based on what it *is*.

Two types of trainable classifiers are available:

- **Pre-trained classifiers**: Microsoft has created and pretrained many classifiers that you can start using without any additional training. These classifiers appear with the status of **Ready to use**. Microsoft Purview includes pretrained classifiers across a wide range of categories, including behavioral signals (such as harassment, profanity, and threat), financial documents, HR content (such as resumes), legal content, and more.

- **Custom trainable classifiers**: You can create and train your own classifiers when pretrained options don't meet your needs. Creation begins with *seeding*—providing a set of samples that are definitely in the category you want to classify, and another set that are definitely not. Microsoft Purview uses these samples to build a prediction model for the classifier. You then verify the results, sorting true positives, true negatives, false positives, and false negatives to improve the accuracy of the model. After the accuracy score of the model has stabilized, you can publish the classifier. Published classifiers sort through items in locations like SharePoint Online, Exchange, and OneDrive.

Trainable classifiers can be used as conditions for auto-labeling with sensitivity labels, retention label policies, communication compliance policies, and data loss prevention policies.

> [!NOTE]
> Classifiers only work with items that aren't encrypted.

## Understand and explore the data

Data classification can involve large numbers of documents and emails. To help administrators derive insights and understanding, the **Explorers** section under Information Protection in the Microsoft Purview portal provides two tools for reviewing classified content at a glance.

### Content explorer

Content explorer provides a current snapshot of the items in your organization that have a sensitivity label, a retention label, or have been classified as a sensitive information type. Administrators with the appropriate role permissions can drill down to access and review the scanned source content stored in locations like Exchange, SharePoint, and OneDrive. Content explorer helps admins understand:

- The number of items classified as sensitive information and which classification types apply.
- Where sensitive data is stored, by location and label.
- How sensitive content is distributed across the organization.

Access to content explorer is highly restricted because it makes it possible to read the contents of scanned files. A user who requires access must be assigned one of the designated content explorer role groups.

### Activity explorer

Activity explorer provides visibility into what content has been discovered and labeled, and what actions users are taking on that content. It lets you monitor document-level activities like label changes and label downgrades (for example, when a user changes a label from *Confidential* to *Public*), file copies to removable media or network shares, and other sensitive content interactions across the organization.

Admins use the filters to see all the details for a specific label, including file types, users, and activities. Activity explorer also receives signals from endpoint data loss prevention, providing visibility into activities on Windows and macOS devices—like printing sensitive documents or copying files to a USB drive. Admins use activity explorer to evaluate whether controls already in place are effective, and to identify areas where additional protection policy may be needed.

# [Activity explorer](#tab/activity-explorer)
:::image type="content" source="../media/activity-explorer.png" lightbox="../media/activity-explorer.png" alt-text="A screenshot of the activity explorer page in the Microsoft Purview portal, showing labeled items and user activity trends over time.":::

# [Content explorer](#tab/content-explorer)
:::image type="content" source="../media/content-explorer.png" lightbox="../media/content-explorer.png" alt-text="A screenshot of the content explorer page in the Microsoft Purview portal, showing classified items organized by label and location.":::

---

