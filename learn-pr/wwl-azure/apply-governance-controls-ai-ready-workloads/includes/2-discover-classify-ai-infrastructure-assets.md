Before you can govern AI infrastructure, you need visibility into what exists across your Azure environment. Consider a scenario where your data science teams have deployed Azure OpenAI Service instances, Azure Machine Learning workspaces, and storage accounts for training datasets across multiple subscriptions. Without a centralized catalog, your governance team can't answer fundamental questions: How many AI models are running in production? Which datasets contain regulated data? Who owns each resource?

Microsoft Purview Data Map solves this discovery challenge by automatically scanning your Azure subscriptions and cataloging AI resources. Unlike manual inventory spreadsheets that become outdated within days, Purview maintains a real-time catalog that reflects your actual environment. The Data Map discovers four critical categories of AI assets: Azure OpenAI Service deployments, Azure Machine Learning models and endpoints, training datasets in storage accounts, and inference pipelines. Each discovered asset appears in Purview's unified catalog with metadata including resource location, creation date, and ownership information.

## Automated discovery process

Purview's discovery engine integrates with Azure Resource Graph to enumerate AI resources across subscriptions you specify during setup. When you register an Azure subscription as a data source in Purview, the scanner queries Resource Graph APIs to identify Azure OpenAI Service instances, Azure Machine Learning workspaces, and storage accounts tagged for AI workloads. This automated approach eliminates the manual effort of tracking resources across environments. The scanner runs on a schedule you configure—typically daily for production environments—ensuring your catalog stays current as teams deploy new models or decommission old ones.

Once discovered, each asset requires classification to support governance decisions. With this foundation of discovery in place, you need a systematic approach to categorizing the sensitivity of your AI resources and the data they process.

## Classification schemas and sensitivity labeling

Purview applies classification rules to AI assets using built-in and custom schemas that identify sensitive data patterns. For training datasets stored in Azure Data Lake Storage or Blob Storage, Purview's automated classification engine scans file contents looking for patterns that match regulatory categories: credit card numbers, social security identifiers, healthcare records, or personal data. When the classifier detects sensitive patterns, it applies appropriate labels automatically—eliminating the manual review burden that slows governance initiatives.

Building on automated classification, you can integrate information protection sensitivity labels that propagate throughout the AI lifecycle. Suppose your organization defines a "Confidential - Customer Data" label for datasets containing personal data. When Purview classifies a training dataset with this label, the protection follows the data through transformation pipelines. The Azure Machine Learning model trained on that dataset inherits the sensitivity label, as does the inference endpoint that serves predictions. This cascading protection ensures governance controls remain consistent from source data to production deployment.

At the same time, you maintain flexibility for AI assets that require manual classification decisions. Custom classification rules let you define business-specific patterns—for example, identifying proprietary product designs or internal financial forecasts in training data. You create these rules using regular expressions or keyword matching, then assign them to scan policies that target specific storage accounts or resource groups. This becomes especially important when your organization's data sensitivity extends beyond regulatory categories into competitive intellectual property.

:::image type="content" source="../media/confidential-sensitivity-label-applied-train-dataset.png" alt-text="Diagram showing how a Confidential sensitivity label applied to a training dataset automatically propagates to derived models during training.":::

## Integration with governance workflows

The classified asset catalog becomes the foundation for downstream governance capabilities. With assets discovered and labeled, you can enforce access controls based on sensitivity. For example, your policy might restrict "Highly Confidential" AI models to private network access only, preventing public internet exposure. Purview's integration with Azure role-based access control (RBAC) lets you map sensitivity labels to permission requirements: data scientists can read training datasets labeled "Internal Use Only," while only designated model reviewers can access "Confidential" model artifacts.

Consider what happens when a new data scientist joins your team. Without Purview classification, they might accidentally use a dataset containing customer personal data for an experimental model, creating compliance risk. With classification in place, the dataset's "Confidential" label triggers an approval workflow before granting access. The data scientist submits a justification, their manager approves, and Purview logs the decision for audit purposes. This automated governance reduces security team workload by 40-60% compared to manual access request processing.

Now that you understand how Purview discovers and classifies AI assets, you're ready to explore how Azure Policy enforces guardrails that prevent noncompliant deployments before they reach production. The combination of asset visibility and proactive policy enforcement creates a defense-in-depth governance strategy.

:::image type="content" source="../media/microsoft-purview-data-map.png" alt-text="Diagram showing Azure subscriptions feeding into Microsoft Purview Data Map through Azure Resource Graph.":::

*Microsoft Purview Data Map discovering and cataloging AI assets across Azure environments with automated classification and sensitivity labeling*



