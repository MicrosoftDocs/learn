Named entities are specific types of [sensitive information types](/purview/sensitive-information-type-learn-about?azure-portal=true) (SIT) that you can use to detect person names, physical addresses, and medical terms and conditions. Named entities are complex dictionary and pattern-based classifiers that show up in the compliance console by default. You can see them by navigating to **Microsoft Purview compliance portal > Data classification > Sensitive info types**.

Named entities are flexible tools that can be used in various ways. Here are a couple of examples of use cases for named entity SITs:

- **Prevent data leakage**: If an organization wants to prevent sharing of confidential data like social security numbers or credit card numbers, they can create a DLP policy that uses a named entity SIT to detect that sensitive information.
- **Comply with regulations**: Named entity SITs can be used with DLP policies to help organizations comply with HIPAA regulations. Organizations can use named entity SITs to detect medical terms and conditions in messages or files. Once detected, a policy can take actions such as encrypting the message or blocking the file.

Named entity SITs come in two types:

### Unbundled

These named entity SITs have a narrower focus, such as a single region, or a single class of terms. Use them when you need a DLP policy with a narrower detection scope.

### Bundled

Bundled named entity SITs detect all possible matches in a class, such as _All physical addresses_. Use them as broad criteria in your DLP policies for detecting sensitive items. To use bundled SITs, you must activate [Advanced classification scanning and protection](/purview/dlp-configure-endpoint-settings?azure-portal=true#advanced-classification-scanning-and-protection) for the relevant [data loss prevention settings](/purview/dlp-configure-endpoint-settings?azure-portal=true) before they're discoverable.

## Examples of named entity SITs

Here are some examples of named entity SITs. You can find all of them in [Sensitive information type entity definitions](/purview/sensitive-information-type-entity-definitions?azure-portal=true).

|Named entity |Description  |Bundled/unbundled  |
|---------|---------|---------|
|All full names    |Detect all possible matches of full names.         |   bundled      |
|All physical addresses    |Detects all possible matches of physical addresses.     | bundled |
|All medical terms and conditions    |Detects all possible matches of medical terms and conditions. |bundled |
|Australia physical addresses |  Detects patterns related to physical addresses from Australia. Included in All physical addresses SIT. |unbundled |
|Blood test terms     |Detects terms related to blood tests, such as 'hCG.' English terms only. Included in All medical terms and conditions SIT      |unbundled |
|Brand medication names     |Detects names of brand medication, such as 'Tylenol.' English terms only. Included in All medical terms and conditions.         |unbundled |

## Examples of enhanced DLP policies

DLP makes special use of named entities in _enhanced policy templates_. These are pre-configured DLP policies that you can customize for your organization's needs. You can also [create your own DLP policies](/purview/dlp-create-deploy-policy?azure-portal=true) from a blank template and use a named entity SIT as a condition. You can find 10 enhanced DLP policies in the **Microsoft Purview compliance portal** by navigating to **Data loss prevention** > **Create policy**. Enhanced templates can be used in DLP and auto-labeling.

For more information about enhanced DLP policies that use named entity SITs, see [Examples of enhanced DLP policies](/purview/named-entities-learn?azure-portal=true#examples-of-enhanced-dlp-policies).

## Monitor named entities with Microsoft Purview Information Protection interactive guide

Use the **Monitor named entities with Microsoft Purview Information Protection** interactive guide for a step-by-step walkthrough.

[:::image type="content" source="../media/named-entities-microsoft-purview-interactive-guide.png" alt-text="Cover for an interactive guide that says Monitor named entities with Microsoft Purview Information Protection." border="false":::](https://mslearn.cloudguides.com/guides/Monitor%20named%20entities%20with%20Microsoft%20Purview%20Information%20Protection)

Learn more:
- [Use named entities in your data loss prevention policies](/purview/named-entities-use?azure-portal=true)