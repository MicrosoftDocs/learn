It's very important to define a long-term data strategy that, when executed, results in incremental value returns for the business. Business outcomes are the direct measure of how well the strategy is executed, based on the priority.

### Integration of Data Management and Analytics into the Cloud Adoption Strategy

 Most common business outcomes are:

- Empower your employees
- Engage with customers
- Optimize operations
- Transform products

### Data management and analytics motivations

Here are some common drivers for Data Management and Analytics that are aligned to innovation:

- A scalable analytics framework designed to enable building an enterprise data platform
- Self-service to empower users in data exploration, data asset creation, and product development
- Foster a data-led culture with reusable data assets, data communities, secure third-party exchange, and in-place sharing
- Share data with confidence secured by policies, common identity, confidentiality, and encryption
- Improved customer experiences and engagements
- Transformation of products or services
- Market disruption with new products or services
- Democratization and self-service environments

The following key themes outline how you can realize these motivations in your strategy. Carefully analyze them and think about how they relate to a coherent data strategy.

:::image type="content" source="../media/strategy-key-themes.png" alt-text="Diagram of Key Themes." lightbox="../media/strategy-key-themes.png":::

### Develop a data-driven culture

Here, the focus is on how an organization can mature over time by applying a systematic, principled approach.

:::image type="content" source="../media/data-strategy-maturity.png" alt-text="Diagram of data strategy maturity." lightbox="../media/data-strategy-maturity.png":::

### A principled approach to your data strategy

### Data Ingestion

One of the key principles in getting data from various systems and sources is creating structured steps through orchestration. This orchestration should support easier updates to the code and logic that performs the ingestion through continuous integration by using tools like DevOps.

### Storage

You need to choose the right storage technologies based on your workloads. For advanced analytics support, the storage solution should provide support for various file formats and have the ability to move from one tier to another in an automated way. It should also support capabilities for batch and stream processing. Finally, you should always tag your data.

### Data Processing

Once data is persisted in the storage, data processing deals with transforming it to a usable format. When defining data processing, it's important to consider real-time versus batch, compute scaling, GPU support, memory limits, and so on.

### Analytics

Finally, the business value is in the form of an analytics solution that allows the business to make intelligent decisions.

## A prescriptive plan

A data management and analytics scenario helps collate all four layers together with people, processes, security, and compliance. We also suggest using the recommended architectures from [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/) to get started. These architectures use the Microsoft Cloud Adoption Framework and leverage Microsoft's experience working through thousands of large-scale enterprise deployments.

The Data Management and Analytics architecture consists of two core building blocks:

- Data Management Landing Zone
- Data Landing Zone

The following diagram is an overview of a data platform with a central data management landing zone and multiple data landing zones:

:::image type="content" source="../media/high-level-design-single-data-landing-zone.png" alt-text="Diagram of single landing zones." lightbox="../media/high-level-design-single-data-landing-zone.png":::

In this module, we'll work on provisioning these major components:

- Data Management Landing Zone
- Data Landing Zone
- Data Product Landing Zone
