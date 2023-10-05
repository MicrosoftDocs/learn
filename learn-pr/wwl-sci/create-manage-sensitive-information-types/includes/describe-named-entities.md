*Named entities* are [sensitive information types](/purview/sensitive-information-type-learn-about?azure-portal=true) (SIT) that show up in the compliance console by default. Named entities are complex dictionary and pattern-based classifiers that you can use to detect person names, physical addresses, and medical terms and conditions. You can see them in the **Microsoft Purview compliance portal > Data classification > Sensitive info types**. Named entity SITs come in two types: 

### Unbundled

These named entity SITs have a narrower focus, such as a single region, or a single class of terms. Use them when you need a DLP policy with a narrower detection scope.

### Bundled

Bundled named entity SITs detect all possible matches in a class, such as *All physical addresses*. Use them as broad criteria in your DLP policies for detecting sensitive items. To use bundled SITs, you must activate [Advanced classification scanning and protection](/purview/dlp-configure-endpoint-settings#advanced-classification-scanning-and-protection?azure-portal=true) for the relevant [data loss prevention settings](/purview/dlp-configure-endpoint-settings?azure-portal=true) before they're discoverable.

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

DLP makes special use of named entities in *enhanced policy templates*. These are pre-configured DLP policies that you can customize for your organization's needs. You can also [create your own DLP policies](/purview/dlp-create-deploy-policy?azure-portal=true) from a blank template and use a named entity SIT as a condition. You can find 10 enhanced DLP policies in the **Microsoft Purview compliance portal** by navigating to **Data loss prevention** > **Create policy**. Enhanced templates can be used in DLP and auto-labeling.

For more information about enhanced DLP policies that used named entity SITs, see [Examples of enhanced DLP policies](/purview/named-entities-learn#examples-of-enhanced-dlp-policies?azure-portal=true).

## Monitor named entities with Microsoft Purview Information Protection interactive guide

Use the **Monitor named entities with Microsoft Purview Information Protection** interactive guide for a step-by-step walkthrough.

[:::image type="content" source="../media/named-entities-microsoft-purview-interactive-guide.png" alt-text="Cover for an interactive guide that says Monitor named entities with Microsoft Purview Information Protection." border="false":::](https://mslearn.cloudguides.com/guides/Monitor%20named%20entities%20with%20Microsoft%20Purview%20Information%20Protection)
