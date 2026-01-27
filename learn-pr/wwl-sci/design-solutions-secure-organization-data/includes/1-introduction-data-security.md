Data security design requires a structured approach grounded in established frameworks and security principles. This unit covers the foundational concepts and frameworks that guide your data security architecture decisions.

## Data security design principles

Effective data security design follows Zero Trust principles: verify explicitly, use least privilege access, and assume breach. These principles translate into specific architectural considerations:

- **Know your data**: You can't protect what you don't know exists. Discovery and classification form the foundation of any data security strategy.

- **Protect data across its lifecycle**: Data requires protection at rest, in transit, and in use. Each state presents unique risks and requires specific controls.

- **Implement defense in depth**: Layer multiple security controls so that if one fails, others continue to provide protection.

- **Automate protection where possible**: Manual processes don't scale. Use automation to consistently apply policies across your data estate.

## Microsoft Cloud Security Benchmark data protection controls

The [Microsoft Cloud Security Benchmark (MCSB)](/security/benchmark/azure/mcsb-v2-data-protection) provides eight data protection controls that guide your design decisions:

| Control | Description |
|---------|-------------|
| **DP-1** | Discover, classify, and label sensitive data |
| **DP-2** | Monitor anomalies and threats targeting sensitive data |
| **DP-3** | Encrypt sensitive data in transit |
| **DP-4** | Enable data at rest encryption by default |
| **DP-5** | Use customer-managed key option when required |
| **DP-6** | Use a secure key management process |
| **DP-7** | Use a secure certificate management process |
| **DP-8** | Ensure security of key and certificate repository |

Throughout this module, you learn how to evaluate and design solutions that address these controls using Microsoft security capabilities.

## Framework alignment for data security

When designing data security solutions, align your architecture with established frameworks:

- **Cloud Adoption Framework (CAF)**: Provides guidance for data classification, governance, and protection as part of cloud adoption planning.

- **Well-Architected Framework (WAF)**: The Security pillar emphasizes data protection through encryption, classification, and access controls.

- **Microsoft Cybersecurity Reference Architecture (MCRA)**: Offers technical reference architectures showing how Microsoft security capabilities integrate for comprehensive data protection.

These frameworks work together to help you design solutions that are secure, compliant, and operationally efficient.
