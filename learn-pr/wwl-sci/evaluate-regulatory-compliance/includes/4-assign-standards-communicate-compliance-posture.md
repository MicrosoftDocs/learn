After investigating gaps in the ISO 27001 dashboard, Contoso Healthcare's Security Officer (CISO) now needs broader visibility. The security team must add NIST SP 800-53 for federal client requirements, generate audit reports for the external compliance team, and provide a unified compliance view across all of Contoso's digital assets—not just Azure. Here, you learn how to assign other standards, generate audit-ready reports, and integrate cloud infrastructure compliance data with Microsoft Purview Compliance Manager.

## Assign compliance standards in the Azure portal

Standard assignment and policy configuration happen in the Azure portal—not the Defender portal. The Defender portal provides a read-only view of compliance data, but you manage which standards to monitor through the Azure portal's security policy interface.

To assign a standard:

1. Sign in to the [Azure portal](https://portal.azure.com) and open **Microsoft Defender for Cloud**.
2. Select **Regulatory compliance**, then choose **Manage compliance policies**.
3. Select your subscription or management group.
4. Navigate to **Security policies**.
5. Locate the standard you want to enable and toggle the status to **On**.

After you enable a standard, Defender for Cloud begins evaluating your resources against that standard's controls.

| Configuration aspect | Key consideration |
|----------------------|-------------------|
| Required permissions | Owner or Policy Contributor role on the subscription |
| Required prerequisites | Any Defender plan enabled—except Defender for Servers Plan 1 or Defender for API Plan 1 |
| Recommended scope | Assign at management group level for aggregate tracking |
| Initial data population | Up to 12 hours for first assessment results |

Standard assignment follows Azure Policy's scope hierarchy. When you assign a standard at a management group level, all nested subscriptions inherit the assignment and contribute to aggregate compliance tracking. This approach gives you organization-wide visibility rather than subscription-by-subscription reporting. If you assign a standard but have no resources in scope—for example, enabling PCI-DSS when you have no payment systems—the standard doesn't appear in the dashboard until relevant resources exist.

Available standards include ISO 27001, NIST SP 800-53, PCI-DSS, CIS benchmarks, SOC 2, FedRAMP, and HIPAA. Microsoft adds new standards regularly based on customer demand and regulatory landscape changes.

> [!NOTE]
> Microsoft added several new standards to the compliance dashboard in mid-2025, including the Digital Operational Resilience Act (DORA), the European Union Artificial Intelligence Act (EU AI Act), the Korean Information Security Management System for Public Cloud (k-ISMS-P), and the CIS Microsoft Azure Foundations Benchmark v3.0. Check the Defender for Cloud documentation to confirm current availability before including any of these standards in production compliance programs.

## Download audit reports

After a standard completes its initial assessment, you can generate audit-ready reports directly from the compliance dashboard. Auditors typically request point-in-time compliance evidence, and the PDF report format provides exactly that—a formatted summary showing overall compliance percentage, control-by-control status, and resource-level findings.

To download a report:

1. Open the compliance dashboard in either the Azure portal or the Defender portal.
2. Select the standard you want to report on.
3. Select **Download report**.
4. Choose your format:
   - **PDF** - formatted summary for auditors and stakeholders, including compliance score, control-by-control status, and remediation recommendations.
   - **CSV** - underlying assessment data with resource-level detail for each control, suited for spreadsheet analysis and governance tools.

Beyond point-in-time reports, the **Compliance over time workbook** tracks compliance score trends for each standard. This workbook demonstrates continuous improvement posture—a key requirement for many audit frameworks—by visualizing how your compliance score changes as you remediate findings and onboard new resources.

## Integrate with Microsoft Purview Compliance Manager

Defender for Cloud integrates with Microsoft Purview Compliance Manager to provide unified compliance visibility across your entire digital estate. When you add any standard to the Defender for Cloud compliance dashboard—including standards monitoring AWS and GCP resources—the resource-level compliance data automatically surfaces in Compliance Manager for the same standard.

This integration bridges the gap between security operations and compliance management. The security team configures standards and remediates findings in Defender for Cloud, while the legal and compliance team manages improvement actions and status in Compliance Manager. Compliance Manager aggregates data from Microsoft 365, endpoints, cloud infrastructure, and on-premises systems into a single compliance view. For Contoso Healthcare, compliance view means the CISO sees patient data compliance across Azure storage accounts, Microsoft 365 mailboxes, and on-premises file servers in one dashboard.

No more configuration is required—the integration activates automatically when you assign standards in Defender for Cloud.

> [!NOTE]
> Allow up to seven days for Compliance Manager to fully collect and factor in initial compliance data. Smaller, single-subscription environments typically populate faster—the seven-day window reflects large multicloud deployments where data aggregates across many subscriptions.

## Create custom standards with Defender CSPM

Built-in standards cover major regulatory frameworks, but organizations often need custom security baselines aligned to internal policies or industry-specific requirements. Custom standards and recommendations appear in the regulatory compliance dashboard alongside built-in frameworks. All customers can create custom recommendations based on Azure Policy. To create custom recommendations using KQL queries, the **Defender CSPM** paid plan is required.

Custom recommendations use KQL (Kusto Query Language) queries to evaluate resource configurations against your specific requirements. For example, Contoso Healthcare might create a "Healthcare Data Security Baseline" that enforces encryption and network isolation rules on storage accounts containing patient data—requirements more specific than HIPAA's general controls. These custom recommendations integrate into the compliance dashboard with the same assessment, scoring, and remediation workflow as built-in standards.

With standards assigned and reports generated, Contoso's security team can provide the CISO with both a current compliance snapshot, and a trend workbook that demonstrates progress over time.
