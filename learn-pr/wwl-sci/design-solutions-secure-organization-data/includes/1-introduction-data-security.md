Data security design requires a structured approach grounded in established frameworks and security principles. This unit covers the foundational concepts and frameworks that guide your data security architecture decisions.

## Data security design principles

Effective data security design follows Zero Trust principles: verify explicitly, use least privilege access, and assume breach. These principles translate into specific architectural considerations:

- **Know your data**: You can't protect what you don't know exists. Discovery and classification form the foundation of any data security strategy.

- **Protect data across its lifecycle**: Data requires protection at rest, in transit, and in use. Each state presents unique risks and requires specific controls.

- **Implement defense in depth**: Layer multiple security controls so that if one fails, others continue to provide protection.

- **Automate protection where possible**: Manual processes don't scale. Use automation to consistently apply policies across your data estate.

## Framework alignment for data security

When designing data security solutions, align your architecture with established frameworks:

- **Cloud Adoption Framework (CAF)**: Provides guidance for data classification, governance, and protection as part of cloud adoption planning.

- **Well-Architected Framework (WAF)**: The Security pillar emphasizes data protection through encryption, classification, and access controls.

- **Microsoft Cybersecurity Reference Architecture (MCRA)**: Offers technical reference architectures showing how Microsoft security capabilities integrate for comprehensive data protection.

- **Microsoft Cloud Security Benchmark (MCSB)**: Defines eight [data protection controls](/security/benchmark/azure/mcsb-v2-data-protection) covering discovery, classification, encryption, and key management that guide your design decisions throughout this module.

These frameworks work together to help you design solutions that are secure, compliant, and operationally efficient.
