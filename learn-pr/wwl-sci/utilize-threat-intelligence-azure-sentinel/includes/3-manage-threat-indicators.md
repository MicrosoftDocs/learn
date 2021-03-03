With the Threat Intelligence area, accessible from the Azure Sentinel menu, you can also view, sort, filter, and search your imported threat indicators without even writing a Logs query. This area also allows you to create threat indicators directly within the Azure Sentinel interface and perform everyday threat intelligence administrative tasks like indicator tagging and creating new indicators related to security investigations. Let's look at two of the most common tasks, creating new threat indicators and tagging indicators for easy grouping and reference.

1. Open the [Azure portal](https://portal.azure.com/?azure-portal=true) and navigate to the Azure Sentinel service.

1. Choose the workspace to which you've imported threat indicators using either threat intelligence data connector.

1. Select **Threat intelligence** from the **Threat management** section of the Azure Sentinel menu.

1. Select the **Add new** button from the top menu of the page.

1. Choose the indicator type, then complete the required fields marked with a red asterisk (*) on the New indicator panel.  Select **Apply**.

Tagging threat indicators is an easy way to group them to make them easier to find. Typically, you might apply a tag to indicators related to a particular incident or indicators representing threats from a known actor or a well-known attack campaign. You can tag threat indicators individually or multi-select indicators and tag them all at once. Since tagging is free-form, a recommended practice is to create standard naming conventions for threat indicator tags. You can apply multiple tags to each indicator.

