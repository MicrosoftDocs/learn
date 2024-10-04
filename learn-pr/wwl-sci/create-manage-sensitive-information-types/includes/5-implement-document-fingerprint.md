As an information worker, you handle sensitive documents every day, whether they're legal forms, employee records, or compliance documents. Protecting this data from unauthorized access or accidental sharing is critical. Document fingerprinting in Microsoft Purview simplifies this by automatically detecting and safeguarding standard forms used in your organization.

## What is document fingerprinting?

Document fingerprinting converts common forms, such as a standard contract or patent application, into a unique sensitive information type (SIT). This SIT is then used to create data loss prevention (DLP) policies that automatically detect, block, or allow outbound communications containing sensitive information.

For example, you can create a document fingerprint for a blank health insurance form. Once set up, the DLP policy can identify any instances of that form being sent out with sensitive details filled in, even if the rest of the document has been slightly modified.

## Features of document fingerprinting

Document fingerprinting offers several benefits:

- **Works across multiple platforms**: DLP policies using document fingerprints can be applied to Exchange, SharePoint, OneDrive, Teams, and devices.
- **Supports multiple matching types**: Both partial and exact matching are available, ensuring flexible and accurate detection.
- **Multilingual detection**: Detects content in multiple languages, including dual-byte languages such as Chinese, Japanese, and Korean.
- **Improved accuracy**: By focusing on unique word patterns, document fingerprinting reduces false positives and improves detection accuracy for sensitive forms.

## How document fingerprinting works

Document fingerprinting works by identifying the unique word patterns within a document. When you upload a form or template, DLP analyzes this pattern and generates a fingerprint in the form of a small Unicode XML file containing a hash value, rather than storing the document itself. This fingerprint becomes a SIT that can be associated with your DLP policies to detect outbound documents that match the original form.

For instance, imagine you upload a blank patent application template. Once the fingerprint is created, any document that includes this template, whether partially filled out or completely, can be automatically detected and managed by your DLP policy.

The image illustrates this process.

1. **Fingerprint creation**: The system analyzes the patent template and creates a fingerprint based on its word patterns. This fingerprint can now be used for detection.

1. **Fingerprint matching**: When a document containing that patent template is scanned, the DLP system detects a match based on the unique fingerprint and applies the relevant policy to manage the document accordingly.

:::image type="content" source="../media/document-finger.png" alt-text="Diagram illustrating the workflow for document fingerprinting." lightbox="../media/document-finger.png":::

This process ensures that only documents following the original format are detected, even if personal data is added later.

### Supported file types

Document fingerprinting supports most file types allowed in mail flow rules, including text-based formats like .docx, .pdf, and .txt. However, template file types like .dotx aren't supported. For more information on file types, see [Supported file types for mail flow rule content inspection](/exchange/security-and-compliance/mail-flow-rules/inspect-message-attachments#supported-file-types-for-mail-flow-rule-content-inspection?azure-portal=true).

#### Limitations of document fingerprinting

Document fingerprinting works best with text-based documents. It doesn't detect sensitive information in:

- Password protected files
- Image only files
- Files missing text from the original form
- Files larger than 4 MB

## Matching options in document fingerprinting

### Partial matching

With partial matching, DLP policies can detect forms that are only partially filled out. You can adjust the detection confidence level to **low**, **medium**, or **high** to determine how much of the text needs to match. For example, you might allow documents where 30% of the text matches the fingerprint to trigger a DLP alert.

A high confidence level returns the fewest false positives but might result in more false negatives. Low or medium confidence levels return more false positives but few to zero false negatives. For example, if you set a low confidence level, the system might flag more documents as potentially sensitive, but some might be false alarms (false positives). A high confidence level would be stricter and might miss some sensitive documents (false negatives).

- **Low confidence**: Captures most sensitive documents but might generate more false positives.
- **Medium confidence**: Balances between false positives and false negatives.
- **High confidence**: Detects only exact matches, minimizing false positives but risking missed documents.

### Exact matching

Exact matching ensures only documents identical to the original template are flagged. This option is ideal when you want a strict policy that triggers only if the entire text of the form matches the original.

## Create a fingerprint based SIT in Microsoft Purview

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true), then navigate to **Solutions** > **Information Protection** > **Classifiers** > **Sensitive info types**.

1. On the **Sensitive info types** page, select **Create Fingerprint based SIT**.

1. On the **Name your fingerprint based SIT** page, enter a name and description for your new SIT, then select **Next**.
1. **Upload a file to create a fingerprint for the file**, then optionally adjust the requirements for each confidence level.

   :::image type="content" source="../media/document-fingerprinting-confidence-levels.png" alt-text="Screenshot showing where to adjust the confidence level in creating a document fingerprint SIT." lightbox="../media/document-fingerprinting-confidence-levels.png":::

   To use exact matching, expand the dropdown for **High**, then select **Exact**.

1. Select **Next**.
1. On the **Review settings and finish** page, review your settings, then select **Create**.
1. On the confirmation page, select **Done**.

To use document fingerprinting with devices, [**Advanced classification scanning and protection**](/purview/dlp-configure-endpoint-settings#advanced-classification-scanning-and-protection?azure-portal=true) must be turned on.

Fingerprints are stored in a separate rule pack. This rule pack has a maximum size limit of 150 KB. Given this limit, you can create about 50 fingerprints per tenant.

For more information about creating a new DLP policy using fingerprint-based SITS, see [Create a new policy using your fingerprint SIT](/purview/document-fingerprinting#create-a-new-policy-using-your-fingerprint-sit-using-the-compliance-portal?azure-portal=true).
