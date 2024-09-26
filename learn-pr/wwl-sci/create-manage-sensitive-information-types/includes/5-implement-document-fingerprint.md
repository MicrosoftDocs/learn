As an information worker in your organization, you may handle many kinds of sensitive information during a typical day. In the Microsoft Purview compliance portal, document fingerprinting makes it easier for you to protect this information by identifying standard forms that are used throughout your organization. This article describes the concepts behind document fingerprinting and how to create a document fingerprint using the compliance portal or using PowerShell.

Document fingerprinting includes the following features:

- Data loss prevention (DLP) can use document fingerprinting as a detection method in Exchange, SharePoint, OneDrive, Teams, and Devices.
- Document fingerprint features can be managed through the Microsoft Purview compliance portal.
- [Partial matching](#partial-matching) is supported.
- [Exact matching](#exact-matching) is supported.
- Improved detection accuracy
- Support for detection in multiple languages, including dual-byte languages such as Chinese, Japanese, and Korean.

## Basic scenario for document fingerprinting

Document fingerprinting is a Microsoft Purview Data Loss Prevention (DLP) feature that converts a standard form into a sensitive information type (SIT), which you can use in the rules of your DLP policies. For example, you can create a document fingerprint based on a blank patent template. You can then create a DLP policy that detects and blocks all outgoing patent templates with sensitive content filled in. As an option, you can set up [policy tips](/purview/use-notifications-and-policy-tips?azure-portal=true) to notify senders that they might be sending sensitive information, and that the sender should verify that the recipients are qualified to receive the patents. This process works with any text-based forms used in your organization. Other examples of forms that you can upload include:

- Government forms
- Health Insurance Portability and Accountability Act (HIPAA) compliance forms
- Employee information forms for Human Resources departments
- Custom forms created specifically for your organization

Ideally, your organization already has an established business practice of using certain forms to transmit sensitive information. To enable detection, upload an empty form to be converted to a document fingerprint. Next, set up a corresponding policy. Once you complete these steps, DLP detects any documents in outbound mail that match that fingerprint.

## How document fingerprinting works

We all know documents don't actually have fingerprints, but this name helps explain the feature. In the same way that a person's fingerprints have unique patterns, documents have unique word patterns. When you upload a file, DLP identifies the unique word pattern in the document. A document fingerprint is then created based on that pattern. That document fingerprint is then used to detect outbound documents with the same pattern. That's why uploading a form or template creates the most effective type of document fingerprint. Everyone who fills out a form uses the same original set of words and then adds their own words to the document. If the outbound document isn't password protected, DLP can determine whether the document matches the document fingerprint. The document also needs to contain all the text from the original form to match the document fingerprint.


![Fingerprint matching diagram.](../media/document-finger.png)

Let's examine the patent template. Notice there are three main sections: _Patent title_, _Inventors_, and _Description_. Each section has its own description—this is the word pattern. Make sure to upload the template in a supported file type and in plain text. Next DLP converts that word pattern into a document fingerprint, which is a small Unicode XML file containing a unique hash value that represents the original text. As a security measure, only this unique hash value is stored and not the original document itself. The original document can't be reconstructed from the hash value. From there, the patent fingerprint then becomes a SIT that you can associate with a DLP policy. After you associate the fingerprint with a DLP policy, DLP detects any outbound emails containing content that matches the patent fingerprint and deals with it according to your organization's policy.

Let's say you don't want regular employees to send outgoing messages containing patent information. You can set up a DLP policy using the patent fingerprint to detect and block those emails. You also might want to allow your legal department to send patents to other organizations due to business needs. You can set exceptions for specific departments to send sensitive information in your DLP policy. You can also allow them to override a policy tip with a business justification.

### Supported file types

Document fingerprinting supports the same file types that are supported in mail flow rules (also known as transport rules). For a list of supported file types, see [Supported file types for mail flow rule content inspection](/exchange/security-and-compliance/mail-flow-rules/inspect-message-attachments#supported-file-types-for-mail-flow-rule-content-inspection?azure-portal=true). One quick note about file types: mail flow rules and document fingerprinting don't support the **.dotx** file type, which is a template file in Microsoft Word. When you see the word "template" in this and other document fingerprinting articles, it refers to a document that you've established as a standard form, not the template file type.

#### Limitations of document fingerprinting

Document fingerprinting doesn't detect sensitive information in the following cases:

- Password protected files
- Files that contain images only
- Documents that don't contain all the text from the original form used to create the document fingerprint
- Files larger than 4 MB

### Partial matching

To configure partial matching of a document fingerprint, when configuring the confidence level, choose **Low**, **Medium** or **High** and designate how much of the text in the file must match the fingerprint in terms of a percentage between 30% - 90%.

A high confidence level returns the fewest false positives but might result in more false negatives. Low or medium confidence levels return more false positives but few to zero false negatives. For example, if you set a low confidence level, the system might flag more documents as potentially sensitive, but some may be false alarms (false positives). A high confidence level would be stricter and might miss some sensitive documents (false negatives).

- **low confidence**: Matched items have the fewest false negatives but contain more false positives than other levels. Low confidence returns all low, medium, and high confidence matches.
- **medium confidence**: Matched items contain an average number of false positives and false negatives. Medium confidence returns all medium, and high confidence matches.
- **high confidence**: Matched items have the fewest false positives but contain more false negatives than other levels.

### Exact matching

To configure exact matching of a document fingerprint, select **Exact** as the value for the high confidence level. When you set the high confidence level to **Exact**, only files that have exactly the same text as the fingerprint are detected. If the file has even a small deviation from the fingerprint, it isn't detected. For instance, if you choose **Exact**, the system only flags documents that match the fingerprint word-for-word. This means it doesn't catch documents that are even slightly different, possibly missing some that should be flagged (false negatives).

### Create a fingerprint based SIT in the compliance portal

1. In the Microsoft Purview compliance portal, select **Data classification** and then choose **Classifiers**.
1. On the **Classifiers** page, choose **Sensitive info types** > **Create Fingerprint based SIT**.
1. Enter a name and description for your new SIT.
1. Upload the file you wish to use as the fingerprint template.
1. OPTIONAL: Adjust the requirements for each confidence level and then choose **Next**. For more information, see [Partial matching](#partial-matching) and [Exact matching](#exact-matching).
1. Review your settings > **Create**.
1. When the confirmation page displays, choose **Done**.

To use document fingerprinting with devices, [**Advanced classification scanning and protection**](/purview/dlp-configure-endpoint-settings#advanced-classification-scanning-and-protection?azure-portal=true) must be turned on.

Fingerprints are stored in a separate rule pack. This rule pack has a maximum size limit of 150 KB. Given this limit, you can create about 50 fingerprints per tenant.

For more information about creating a new DLP policy using fingerprint-based SITS, see [Create a new policy using your fingerprint SIT](/purview/document-fingerprinting#create-a-new-policy-using-your-fingerprint-sit-using-the-compliance-portal?azure-portal=true).
