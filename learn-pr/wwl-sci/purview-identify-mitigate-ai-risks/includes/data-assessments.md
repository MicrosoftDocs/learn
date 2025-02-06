AI tools like Microsoft 365 Copilot can unintentionally expose misclassified or over-permissioned content. Data assessments help security teams detect these risks early, apply protections, and maintain compliance.

Microsoft 365 Copilot and other AI tools can surface misclassified, over-permissioned, or outdated content, increasing the likelihood of unintentional data exposure. By running data assessments, organizations can identify these risks early, apply appropriate protections, and ensure compliance with internal policies and regulatory requirements.

## Default data assessments

Microsoft Purview Data Security Posture Management (DSPM) for AI automatically runs a weekly assessment on the top 100 SharePoint sites used by Microsoft 365 Copilot. This built-in assessment helps organizations identify high-risk data exposure without manual configuration.

To review the latest weekly assessment:

1. Navigate to **DSPM for AI** in the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Assessments** from the navigation pane.
1. Open the **Oversharing Assessment for the week of <month, year>**.
1. Review key findings, including:
   - Number of sensitive files accessed
   - Frequency of access
   - External sharing risks

   :::image type="content" source="../media/data-assessment-oversharing.png" alt-text="Screenshot of the Oversharing assessments page in Microsoft Purview, showing details on total items, sensitivity labels, and data with sharing links." lightbox="../media/data-assessment-oversharing.png":::

The weekly assessment helps identify trends in data exposure, allowing organizations to detect misconfigured access settings, overly permissive sharing, or files that contain sensitive data but lack proper classification. Reviewing these results regularly ensures that security policies are informed by actual risks rather than assumptions.

For a deeper analysis of specific users, sites, or data sources, security teams can run custom assessments tailored to their needs.

## Run a custom data assessment

Organizations might need to scan beyond the default assessment to evaluate AI security risks in different users, sites, or content types. Custom data assessments allow security teams to define the scope of their analysis.

To create and run a custom assessment:

1. Navigate to **DSPM for AI** > **Data assessments**.
1. Select **Create assessment**.
1. On the **Basic details** page:
   - Enter an **Assessment name**.
   - Provide an optional **Description** to define the purpose of the assessment.
1. On the **Add users** page:
   - Choose whether to Include all users or Include specific users or groups.
1. On the **Data sources** page, select the SharePoint sites or other data sources you want to scan.
1. On the **Review and run the data assessment scan**, select **Save and run** to run the custom assessment.

Assessments can take up to 48 hours to complete. After the assessment completes, review the findings in the Protect and Monitor tabs to determine the appropriate security actions.

## Review and act on assessment results

After a data assessment runs, security teams can analyze the results and take action using the **Protect** and **Monitor** tabs. These tabs provide insights into how sensitive data is being accessed and shared, and offer remediation options to reduce oversharing risks.

### Protect tab - Apply security controls

The **Protect** tab helps security teams limit access to high-risk data and enforce compliance measures. Recommended actions include:

- **Restrict access by label**: Use Microsoft Purview Data Loss Prevention (DLP) to prevent Microsoft 365 Copilot from summarizing data that has specific sensitivity labels. For more information about how this works and supported scenarios, see [Learn about the Microsoft 365 Copilot policy location](/purview/dlp-microsoft365-copilot-location-learn-about?azure-portal=true).

- **Restrict all items**: Use [SharePoint Restricted Content Discoverability](/sharepoint/restricted-content-discovery?azure-portal=true) to prevent Microsoft 365 Copilot from indexing specified SharePoint sites.

   :::image type="content" source="../media/data-assessment-dlp-restrict-items.png" alt-text="Screenshot showing the options in the Protect tab in Data assessments to restrict access to sensitive data." lightbox="../media/data-assessment-dlp-restrict-items.png":::

- **Apply auto-labeling policies**: [Automatically apply sensitivity labels](/purview/apply-sensitivity-label-automatically?azure-portal=true#how-to-configure-auto-labeling-policies-for-sharepoint-onedrive-and-exchange) to unlabeled files containing sensitive information.

- **Enforce retention policies**: Use [Microsoft Purview Data Lifecycle Management retention policies](/purview/create-retention-policies?azure-portal=true) to delete content that hasn't been accessed for at least three years.

   :::image type="content" source="../media/data-assessment-apply-label.png" alt-text="Screenshot showing the options in the Protect tab in Data assessments to manage sensitivity labels and policies for a specific SharePoint site." lightbox="../media/data-assessment-apply-label.png":::

### Monitor tab - Review sharing and access risks

The **Monitor** tab provides visibility into how data is shared and accessed across the organization. It includes tools for reviewing and managing access:

- **Run a SharePoint site access review**: Identify and assess sites that are shared broadly or externally. IT administrators can delegate access reviews to site owners.
- **Run an identity access review**: Review group memberships, enterprise application access, and role assignments in Microsoft Entra ID to ensure only the right users maintain access.

   :::image type="content" source="../media/data-assessment-monitor.png" alt-text="Screenshot showing the options in the Monitor tab in Data assessments to Run a site access review and Run an identity access review." lightbox="../media/data-assessment-monitor.png":::

By regularly reviewing assessment results in both the **Protect** and **Monitor** tabs, organizations can enforce security policies, reduce oversharing risks, and ensure compliance with data protection requirements.
