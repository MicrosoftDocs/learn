Microsoft Defender for Cloud continually compares the configuration of your resources with requirements in industry standards, regulations, and benchmarks. The regulatory compliance dashboard provides insights into your compliance posture based on how you're meeting specific compliance requirements.

:::image type="content" source="../media/compliance-dashboard.png" alt-text="Screenshot of the Regulatory compliance dashboard." lightbox="../media/compliance-dashboard.png":::

## How are regulatory compliance standards represented in Defender for Cloud?

Industry standards, regulatory standards, and benchmarks are represented in Defender for Cloud's regulatory compliance dashboard. Each standard is an initiative defined in Azure Policy.

To see compliance data mapped as assessments in your dashboard, add a compliance standard to your management group or subscription from within the Security policy page.

When you've assigned a standard or benchmark to your selected scope, the standard appears in your regulatory compliance dashboard with all associated compliance data mapped as assessments. You can also download summary reports for any of the standards that are assigned.

Microsoft tracks the regulatory standards themselves and automatically improves its coverage in some of the packages over time. When Microsoft releases new content for the initiative, it appears automatically in your dashboard as new policies mapped to controls in the standard.

## What regulatory compliance standards are available in Defender for Cloud?

By default, every subscription has the **Microsoft Cloud Security Benchmark** assigned. This is the Microsoft-authored, Azure-specific guidelines for security, and compliance best practices based on common compliance frameworks.

Available regulatory standards:

- PCI-DSS v3.2.1:2018
- SOC TSP
- NIST SP 800-53 R4
- NIST SP 800 171 R2
- UK OFFICIAL and UK NHS
- Canada Federal PBMM
- Azure CIS 1.1.0
- HIPAA/HITRUST
- SWIFT CSP CSCF v2020
- ISO 27001:2013
- New Zealand ISM Restricted
- CMMC Level 3
- Azure CIS 1.3.0
- NIST SP 800-53 R5
- FedRAMP H
- FedRAMP M

## Add a regulatory standard to your dashboard

### Prerequisites

To add standards to your dashboard:

- The subscription must have Defender for Cloud's enhanced security features enabled
- The user must have owner or policy contributor permissions

### Add a standard

1. From Defender for Cloud's menu, select Regulatory compliance to open the regulatory compliance dashboard. Here you can see the compliance standards currently assigned to the currently selected subscriptions.

1. From the top of the page, select Manage compliance policies. The Policy Management page appears.

1. Select the subscription or management group for which you want to manage the regulatory compliance posture.

1. To add the standards relevant to your organization, expand the Industry & regulatory standards section and select Add more standards.

1. From the Add regulatory compliance standards page, you can search for any of the available standards:

1. Select Add and enter all the necessary details for the specific initiative such as scope, parameters, and remediation.

1. From Defender for Cloud's menu, select Regulatory compliance again to go back to the regulatory compliance dashboard.

    Your new standard appears in your list of Industry & regulatory standards.
