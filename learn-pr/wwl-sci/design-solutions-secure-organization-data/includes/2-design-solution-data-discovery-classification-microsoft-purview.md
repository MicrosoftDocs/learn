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

Classification taxonomy is a hierarchical depiction of data categorization. There isn't a universal standard for classification—it's driven by your organization's motivation for protecting data. Taxonomy might capture compliance requirements, promised features for workload users, or other criteria driven by business needs.

As a workload owner, rely on your organization to provide a well-defined taxonomy. All workload roles must have a shared understanding of the structure, nomenclature, and definition of the sensitivity levels. Don't define your own classification system that conflicts with organizational standards.

Your classification scheme should:

- **Align with business requirements**: Classifications should reflect how your organization thinks about data sensitivity
- **Support regulatory compliance**: Include classifications that map to HIPAA, PCI-DSS, and other relevant regulations
- **Enable automation**: Design classifications that can be applied automatically based on content patterns
- **Scale across the organization**: Use consistent classifications that work for all business units

The WAF Security pillar recommends defining data classifications that enable risk-based controls. Example classification labels cover sensitivity levels, information types, and compliance scope:

| Category | Example labels |
|----------|----------------|
| **Sensitivity levels** | Public, General, Confidential, Highly Confidential, Secret |
| **Information types** | Financial, Credit Card, Credentials, Health fields, Intellectual Property, Personal data |
| **Compliance scope** | HIPAA, PCI, CCPA, SOX |

### Defining classification scope

Be granular and explicit when defining what's in scope for classification. The WAF Security pillar emphasizes that classification should extend beyond primary data stores to related components:

- **Data store granularity**: Classify at the table level or even column level for tabular systems
- **Backup systems**: Has your highly sensitive data store's backup been classified?
- **Caching layers**: If you're caching user-sensitive data, is the cache in scope?
- **Analytical data stores**: How is aggregated or derived data classified?
- **Preproduction environments**: Do you need to classify data in development and test systems?

Start with these questions to define your scope:

- What's the origin of data and information type?
- What's the expected restriction based on access (public, regulatory, internal use)?
- What's the data footprint—where is it stored and how long should it be retained?
- Which architecture components interact with the data?
- How does data move through the system?
- What information is expected in audit reports?

### Designing architecture based on classification labels

Classification should influence your architectural decisions. The WAF Security pillar identifies key areas where classification drives design:

**Segmentation strategy**: Classification labels influence traffic isolation boundaries. Critical flows might require end-to-end TLS, while other traffic can use different encryption standards.

**Encryption choices**: Sensitivity levels affect encryption decisions:
- Highly sensitive data might require double encryption
- Different secrets might require varied levels of protection (HSM vs. standard secret stores)
- Compliance labels dictate protection standards (for example, PCI-DSS mandates FIPS 140-2 Level 3, requiring HSMs)

**Data in use protection**: For the most sensitive classifications, consider confidential computing to protect data during processing.

**Classification persistence**: Classification information should move with the data as it transitions through the system. Data labeled as confidential should be treated as confidential by all components that interact with it—including removing or obfuscating personal data from application logs.

**Reporting and masking**: Classification impacts how data is exposed in reports. Based on information type labels, you might need to apply data masking algorithms for obfuscation. Define which roles should have visibility into raw data versus masked data.

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

- **Establish a data classification scheme** that defines sensitivity levels and handling requirements
- **Implement automated discovery** to find sensitive data across cloud and on-premises environments
- **Apply sensitivity labels** that persist with data and enable downstream protection
- **Maintain data inventories** that track where sensitive data resides

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

## Bringing it together

Effective data discovery and classification requires a unified organizational taxonomy applied consistently across your data estate. Start by defining what you need to protect and why, then be explicit about scope—extending classification to backups, caches, and analytical stores. Prioritize automated discovery with tools like Microsoft Purview, but validate results through manual verification. Classification provides value when it triggers protection actions, so design your architecture so that labels influence encryption choices, access controls, and segmentation. Build classification maintenance into operations, because stale metadata leads to compliance issues and erroneous risk assessments.
