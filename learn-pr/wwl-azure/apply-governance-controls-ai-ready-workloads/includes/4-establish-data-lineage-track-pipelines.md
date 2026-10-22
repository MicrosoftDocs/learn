Governance policies enforce rules at deployment time, but maintaining compliance also requires understanding the relationships between data sources, training jobs, and models. Consider an audit request for the training data and model versions used by your fraud-detection service during a reporting period.

## Configure lineage capture for supported services

Microsoft Purview Data Map captures lineage through supported service integrations. Coverage depends on the connector, the assets involved, and the activities your pipeline uses. Registering or scanning a source doesn't automatically capture every transformation or deployment associated with it.

Connect Azure Data Factory to your Purview account and grant the required permissions to its managed identity. When supported activities run, Data Factory pushes metadata about source data, output data, and the activity to Data Map. For example, a supported pipeline can expose the relationships between an Azure SQL source, a transformation, and output in Azure Data Lake Storage.

Check the supported activities and sources before relying on a pipeline's lineage for an audit. For configuration and coverage, see [How to connect Azure Data Factory and Microsoft Purview](/purview/data-map-lineage-azure-data-factory). Azure Synapse pipeline lineage also requires its own supported integration.

:::image type="content" source="../media/automate-lineage-capture-workflows.png" alt-text="Diagram showing Azure Data Factory moving data from Azure SQL Database to Azure Data Lake Storage, with Purview connections to data services.":::

For Azure Machine Learning, register the workspace using the preview integration. Metadata for registered datasets, jobs, models, and the workspace is pushed to Purview daily. Where the relationships are available, the **Lineage** tab shows source data registered in Purview, ML data assets, training jobs, and resulting models. See [Azure Machine Learning integration and lineage](/purview/register-scan-azure-machine-learning#lineage).

The documented integration doesn't provide automatic lineage for every inference endpoint, application request, or real-time feature-store connection. Keep deployment and inference records separately, and supplement the catalog when your workload includes steps that the connector doesn't cover.

## Verify coverage and analyze dependencies

Purview's lineage viewer presents assets and their relationships as a graph. Use it to identify the known upstream sources and downstream outputs for a dataset or model. Validate that the expected assets and relationships appear before treating the graph as complete evidence.

For the fraud-detection workload, review coverage by checking that:

- The relevant source data and training assets are registered.
- The expected training jobs and resulting models appear.
- The relationships match the pipeline's inputs and outputs.
- Deployment records identify the model version used by each endpoint.
- Application records identify the endpoint and model version used during the reporting period.

The last two checks use deployment and application evidence, not automatic Data Map endpoint lineage. Record identifiers that let you correlate that evidence with the catalog's training assets and models.

Suppose your data engineering team identifies a quality problem in a source dataset. Follow the available lineage to find related training assets, jobs, and models. Confirm the affected dataset versions and job inputs in Azure Machine Learning, then review deployment records to identify production services that require investigation. This process identifies potentially affected assets without assuming that the graph shows every production dependency.

## Use lineage with governance and audit evidence

If a storage scan identifies personal data in a training dataset, use its available lineage to scope a model security review. Verify access permissions, encryption, and endpoint network controls in the services that enforce them. Lineage shows relationships. It doesn't prove that those controls are enabled or automatically change permissions when a dataset's classification changes.

For an audit, combine the catalog's lineage with retained ML job records, dataset and model version identifiers, deployment history, and relevant application logs. Record code and environment versions and training parameters in the ML workflow when reproducibility is required, rather than assuming that all of these details appear in Purview.

Asset-level lineage doesn't establish which individual customer records influenced a specific prediction. Answering record-level questions requires additional evidence about dataset contents and the application's inputs and processing. Design that evidence collection for the audit requirement, with appropriate access controls and retention.

If you automate review notifications or approval tasks, configure and test that workflow separately. Use the catalog to identify relationships, and verify actual resource settings before making a governance decision.

The next unit provides an exercise in enabling threat protection for AI services. It complements catalog and lineage review with monitoring of AI workload threats.
