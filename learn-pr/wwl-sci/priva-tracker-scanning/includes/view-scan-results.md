After you run scans using Microsoft Priva Tracker Scanning, the next step is to review the results. Scan results provide detailed insights into your organization's tracking technologies, compliance objects, and potential issues. This information helps you take proactive steps to align your tracking practices with privacy standards.

Scan results are accessible from each registered website's details page. By analyzing the data, you can categorize trackers, resolve compliance issues, and ensure transparency in how your organization uses tracking technologies.

## Access scan results

To view scan results, navigate to the **Registered websites** page in Tracker Scanning:

1. Select a website name to open its **Details** page.
1. In the left navigation menu, select **Compliance scans** to see a list of all scans for the selected website.

From here, you can view a summary of the scans and select individual scans to see more in-depth results.

## Understand scan results

Scan results are divided into multiple views and tabs to help you analyze the data effectively:

### Summary view

The website's **Details** page provides an overview of scan results, including:

- **Overview**: Key details about the website, such as its URL, tracker categories, and publishing profiles.
- **Compliance scans**: A list of scans created for the website. Selecting a scan opens its detailed page, where you can edit the scan, rerun it, or view its results.
- **Trackers identified**: A list of all trackers found in scans of the website.

   > [!NOTE]
   > To display the list of trackers, you must select Show filtered list on the page. The list reflects the current point in time and might change as extra scans are performed.

- **Consent models**: Lists any [consent models](/privacy/priva/consent-management-create?azure-portal=true) associated with the website.

## Detailed scan results

To explore scan results in more detail, select a scan name from the **Compliance scans** tab, then select **See results**. The scan's details page includes the following tabs:

### Scan details

The **Scan details** tab provides a high-level summary, including:

- Scan date and duration.
- Number of pages scanned.
- Number of trackers identified.

   :::image type="content" source="../media/scan-details.png" alt-text="Screenshot showing the scan details page in tracker scanning." lightbox="../media/scan-details.png":::

### Scan results

The **Scan results** tab highlights critical issues requiring attention, such as:

- **Uncategorized trackers**: Trackers that need to be categorized or removed.
- **Compliance issues**: Missing compliance objects like consent banners or privacy notices.
- **Failed URLs**: Pages that couldn't be scanned due to errors.

   :::image type="content" source="../media/scan-results.png" alt-text="Screenshot showing the scan results page in tracker scanning." lightbox="../media/scan-results.png":::

Below these summaries, you'll find detailed tables with additional information, such as:

- **Trackers identified** and **Tags**: Displays trackers identified during the scan, including their type, category, frequency, and associated HTML tags.
- **External websites**: Lists webpages outside the scan's scope, such as those with different top-level domains.
- **Compliance issues**: Summarizes potential issues, such as uncategorized trackers or missing compliance elements.
- **Failed URLs**: Identifies unscanned pages within the website's domain, with troubleshooting details.
- **Consent models identified**: Lists any consent models detected during the scan.

## Additional insights

### Tracker-tag relationships

For detailed information about how trackers relate to tags, select the Trackers and Tags tab on the scan's details page. This provides an in-depth view of tracker relationships and deployment contexts.

> [!TIP]
> If certain trackers aren't detected by scans, you can add them manually. Learn more in Add a tracker manually.

### External websites

The External websites tab identifies webpages outside the scan scope. For example:

- Pages on subdomains (for example, products.contoso.com).
- Pages with different top-level domains (for example, contoso.net).

These pages might require further review or configuration to ensure they're included in future scans.

## Scan time estimates

If you enabled scan time estimates during setup, the Scan time estimates tab displays performance metrics, including:

- Time taken to scan each page.
- Total pages scanned versus unscanned pages.
- Any unscanned pages within the domain.

These insights can help you optimize scan configurations and troubleshoot issues. For instance, reducing the number of pages or narrowing the scan scope can improve performance.

Analyzing scan results in Microsoft Priva Tracker Scanning provides valuable insights into your organization's tracking technologies and compliance status. By reviewing detailed scan data, addressing compliance issues, and understanding tracker relationships, you can take informed steps to enhance transparency and align with privacy standards. With regular scans and proactive management, your organization can maintain trust and meet evolving privacy expectations.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
