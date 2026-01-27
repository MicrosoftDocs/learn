Data discovery and classification is the foundational step in any data security strategy. Before you can protect sensitive data, you must first know where it exists, what type of data it is, and how sensitive it is. This unit focuses on the design considerations and framework controls you should evaluate when architecting data discovery and classification solutions.

## Design considerations for data discovery and classification

When evaluating solutions for data discovery and classification, consider these key factors aligned with the MCSB control DP-1 (Discover, classify, and label sensitive data):

### Data estate visibility

Your organization likely has data spread across multiple locations:

- **Cloud services**: Azure Storage, Azure SQL, Microsoft 365, and third-party SaaS applications
- **On-premises systems**: File servers, databases, and legacy applications
- **Hybrid environments**: Data that moves between cloud and on-premises

A comprehensive discovery solution must provide visibility across this entire estate. The CAF emphasizes that you can't govern what you can't see, making automated discovery essential for organizations adopting cloud services.

### Classification taxonomy design

Your classification scheme should:

- **Align with business requirements**: Classifications should reflect how your organization thinks about data sensitivity
- **Support regulatory compliance**: Include classifications that map to GDPR, HIPAA, PCI-DSS, and other relevant regulations
- **Enable automation**: Design classifications that can be applied automatically based on content patterns
- **Scale across the organization**: Use consistent classifications that work for all business units

The WAF Security pillar recommends defining data classifications that enable risk-based controls. Common classification levels include:

| Classification | Description | Example controls |
|----------------|-------------|------------------|
| **Public** | Information intended for public disclosure | No restrictions |
| **Internal** | Information for internal business use | Basic access controls |
| **Confidential** | Sensitive business information | Encryption, restricted access |
| **Highly Confidential** | Most sensitive data | Strong encryption, audit logging, DLP |

### Sensitive information type detection

When evaluating discovery solutions, consider support for:

- **Built-in sensitive information types**: Pre-configured patterns for common data like credit card numbers, social security numbers, and passport numbers
- **Custom sensitive information types**: Organization-specific patterns for employee IDs, project codes, or proprietary data formats
- **Trainable classifiers**: Machine learning models that identify sensitive content based on examples rather than patterns
- **Exact data match**: Matching against your actual sensitive data values for high-precision detection

### Labeling strategy

Design your labeling approach to address:

- **Manual labeling**: Users apply labels based on their knowledge of content sensitivity
- **Automatic labeling**: Labels applied automatically when content matches sensitive information types
- **Recommended labeling**: System suggests labels that users can accept or override
- **Default labeling**: Baseline labels applied when no other label is appropriate

The MCRA emphasizes that labels should persist with data as it moves across your environment, enabling consistent protection regardless of location.

## MCSB controls for data discovery and classification

### DP-1: Discover, classify, and label sensitive data

This control requires organizations to:

1. **Establish a data classification scheme** that defines sensitivity levels and handling requirements
2. **Implement automated discovery** to find sensitive data across cloud and on-premises environments
3. **Apply sensitivity labels** that persist with data and enable downstream protection
4. **Maintain data inventories** that track where sensitive data resides

### DP-2: Monitor anomalies and threats targeting sensitive data

Effective classification enables threat monitoring by:

- Identifying when sensitive data is accessed from unusual locations
- Detecting potential data exfiltration attempts
- Alerting on bulk access to classified data
- Tracking sharing of sensitive documents outside the organization

## Microsoft solutions for data discovery and classification

Microsoft provides integrated capabilities to address these requirements:

### Microsoft Purview Information Protection

[Microsoft Purview Information Protection](/purview/information-protection) provides:

- **Sensitive information types**: Over 300 built-in types covering global regulations and common data patterns
- **Trainable classifiers**: Machine learning models for content like contracts, resumes, and source code
- **Sensitivity labels**: Labels that apply protection and persist across Microsoft 365 and beyond
- **Auto-labeling policies**: Rules that automatically apply labels based on content analysis

### Microsoft Purview Data Map

[Microsoft Purview Data Map](/purview/concept-elastic-data-map) extends discovery beyond Microsoft 365:

- **Multi-cloud scanning**: Discover and classify data in Azure, AWS, and GCP
- **On-premises scanning**: Scan file shares, SQL servers, and SAP environments
- **Data lineage**: Track how sensitive data flows through your organization
- **Glossary integration**: Map technical assets to business terms

### Microsoft Defender for Cloud

For Azure workloads, [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) provides:

- **Data-aware security posture**: Identify databases and storage accounts containing sensitive data
- **Risk prioritization**: Focus remediation on resources with the most sensitive data
- **Integration with Purview**: Leverage Purview classifications in security assessments

### Azure SQL Data Discovery & Classification

[Data Discovery & Classification](/azure/azure-sql/database/data-discovery-and-classification-overview) for Azure SQL provides:

- **Column-level classification**: Identify and label sensitive columns in databases
- **Built-in recommendations**: Suggested classifications based on column names and data patterns
- **Microsoft Purview integration**: Sync classifications with your enterprise labeling strategy

## Design recommendations

When designing your data discovery and classification solution:

1. **Start with data governance goals**: Define what you're trying to protect and why before selecting tools

2. **Implement a unified classification taxonomy**: Use consistent classifications across all data sources and tools

3. **Prioritize automated discovery**: Manual processes don't scale—invest in automated scanning

4. **Integrate with protection mechanisms**: Classification provides value when it triggers protection actions

5. **Plan for multi-cloud and hybrid**: Ensure your solution covers all locations where data resides

6. **Enable monitoring and reporting**: Track classification coverage and identify gaps in your data estate
