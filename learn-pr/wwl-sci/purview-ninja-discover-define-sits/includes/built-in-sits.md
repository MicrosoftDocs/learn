Microsoft Purview Information Protection provides built-in Sensitive Information Types (SITs). They're designed to automatically detect and classify common types of sensitive data, such as credit card numbers, Social Security numbers, and health records. These SITs use industry-standard patterns and validation logic to help organizations identify and protect sensitive information across various data repositories. By using built-in SITs, organizations can streamline compliance efforts and reduce the risk of exposing regulated or confidential data.

In order to begin this process for your organization, start by completing these steps.

## Step 1: Assess data sources and environment

- Inventory all repositories, including file shares, email systems, databases, and cloud storage solutions. Also include collaboration platforms like Microsoft Teams or SharePoint, and user endpoints like desktops and mobile devices. This comprehensive inventory helps ensure that no data storage location is overlooked during sensitive information discovery.

- Include both legacy environments from the original company and systems from any newly acquired or merged organizations. This approach ensures that inherited data sources, which might have different structures or security postures, are also evaluated for sensitive information.

- Document data flows and integration points by mapping how information moves between systems, applications, and users. Understanding the pathways and connections between repositories is critical to identifying where sensitive data might be exposed or at risk during transfers or processing.

- Ensure all necessary permissions are in place to access the content explorer tool. This tool scans and identifies sensitive information across your organization's systems. The content explorer provides visibility into data classification and helps pinpoint high-risk items that require remediation. For more information, see [content explorer](/purview/data-classification-content-explorer).

- Additionally, use Data Security Posture Management (DSPM) solutions that offer advanced analytics reports. These reports can identify unprotected sensitive assets across all connected data sources, allowing you to quickly address security gaps, prioritize remediation, and strengthen your organization's overall data protection posture. For more information, see [Analytics reports](/purview/data-security-posture-management-reports#analytics-reports).

## Step 2: Define the scope of sensitive data types for your organization

- List regulatory, business, and contractual requirements for data protection. This ensures that your organization adheres to all relevant laws, industry standards, and client agreements regarding the handling of sensitive information.

- Identify key data types: customer records, employee data, intellectual property, financial documents, and any proprietary information. Properly classifying these data types helps prioritize protection efforts and streamlines compliance with regulatory mandates.

- Engage stakeholders to validate and prioritize sensitive data types. Collaboration with business leaders and data owners helps ensure that all critical information assets are accurately identified and adequately safeguarded.

## Step 3: Cross reference organization sensitive types and out-of-box sensitive information types

Identify relevant [built-in sensitive information types](/purview/sit-sensitive-information-type-entity-definitions). Examples include, Social Security Numbers, credit card numbers, bank account information and, health data. These built-in types are essential for quickly detecting and protecting regulated or high-risk data across all organizational repositories.

Additional scenarios regarding sensitive information that might be worth considering can be found in the [sensitive information type common scenarios documentation](/purview/sit-common-scenarios). Reviewing these scenarios can help you address unique or emerging risks relevant to your company's operations and compliance requirements.
