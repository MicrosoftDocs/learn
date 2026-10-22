Before you can govern AI infrastructure, you need visibility into what exists across your Azure environment. Consider a scenario where your data science teams have deployed Azure OpenAI Service instances, Azure Machine Learning workspaces, and storage accounts for training datasets across multiple subscriptions. Without a centralized catalog, your governance team can't answer fundamental questions: How many AI models are running in production? Which datasets contain regulated data? Who owns each resource?

Infrastructure inventory, data discovery, and model cataloging provide different parts of this visibility. Use Azure resource inventory tools to identify deployed services, Microsoft Purview Data Map to scan supported data sources, and the Azure Machine Learning integration to catalog registered ML assets. The capabilities and refresh behavior depend on the source.

## Discover infrastructure and register supported sources

Use [Azure Resource Graph](/azure/governance/resource-graph/overview) to query resource properties across subscriptions you can access. For your AI deployment, use resource types, locations, and tags to identify Azure OpenAI Service resources, Azure Machine Learning workspaces, and storage accounts. Keep ownership and approved-region information with this inventory. This is an infrastructure inventory process, not a Purview data-source scan.

For training data, register supported sources such as Azure Blob Storage and Azure Data Lake Storage Gen2 in Purview. Configure authentication, permissions, network access, scan scope, scan rule sets, and a schedule appropriate to the data. Registering an Azure subscription or resource group lets you discover and scan supported sources within that scope. It doesn't make every Azure resource type a supported connector. For setup guidance, see [Discover and govern multiple Azure sources](/purview/register-scan-azure-multiple-sources).

Register each Azure Machine Learning workspace directly using the Azure Machine Learning connector. This integration is in preview. After registration, the workspace pushes metadata to Purview automatically on a daily basis. You don't configure a recurring Purview scan to retrieve this metadata.

The integration extracts metadata for workspaces, models, datasets, and jobs. Assets must be registered in the ML workspace to appear in Purview. Use this catalog to explore the available asset relationships, rather than treating it as a real-time inventory of all models, deployments, and inference endpoints. See [Connect to and manage Azure Machine Learning in Microsoft Purview (preview)](/purview/register-scan-azure-machine-learning).

Azure OpenAI Service isn't listed as a native Data Map source. Inventory its Azure resources separately and scan the supported storage sources that hold data for the workload. Purview capabilities for governing AI prompts and responses are separate from Data Map connector support.

## Classification schemas and sensitivity labeling

For supported file types in Azure Blob Storage and Azure Data Lake Storage Gen2, Purview scans can identify sensitive data patterns by using built-in and custom classifications. For example, a scan of your training-data container can identify credit card numbers or personal identifiers. Review the results with the data owner to determine the required handling controls.

Classifications describe the data found in an asset. Sensitivity labels express your organization's sensitivity categories and require separate labeling configuration. Data Map sensitivity labeling is in preview, and support varies by source. For supported locations, configure auto-labeling policies rather than assuming that every classification automatically produces a sensitivity label.

The Azure Machine Learning connector supports metadata and lineage, but not automatic classification, sensitivity labeling, or Data Map access policies for ML assets. A model and its inference endpoint don't automatically inherit a label from a training dataset through this integration. Use the [Data Map source capability matrix](/purview/data-map-data-sources) to check support before designing a labeling or access workflow.

Custom classification rules let you identify business-specific patterns in supported data sources. Configure these rules in scan rule sets for the relevant sources, then verify the results. Keep classification findings separate from the access permissions, network settings, and encryption controls that protect the underlying resources. For labeling behavior, see [Sensitivity labels in Data Map FAQ (preview)](/purview/data-map-sensitivity-labels-faq).

## Integration with governance workflows

Use catalog findings to inform governance decisions. Suppose a scan identifies personal data in a training dataset. Review its available lineage to identify related training jobs and models, then use Azure Machine Learning deployment records to identify the endpoints that serve those models.

Your security team can then review storage access, model permissions, and endpoint network exposure against the data's sensitivity. Configure these controls in the relevant Azure services. A classification or catalog label doesn't automatically create Azure role-based access control (RBAC) assignments or private endpoints for an ML model.

For access requests, define an approval process that records the requester, business justification, approving owner, and granted permissions. If you automate this process, configure the workflow and its permission changes explicitly. Don't assume that a dataset classification triggers an approval workflow for models or endpoints.

Now that you understand how inventory, catalog metadata, and data classification support governance decisions, you're ready to explore how Azure Policy enforces resource guardrails.
