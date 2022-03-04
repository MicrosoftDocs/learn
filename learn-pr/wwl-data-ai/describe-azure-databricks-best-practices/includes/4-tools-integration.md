Now that you have configured your workspaces and security, you need to consider tools used for development and data movement orchestration, as well as integrations with other services.

## Favor cluster scoped init scripts over global and named scripts

[Init Scripts](https://docs.azuredatabricks.net/user-guide/clusters/init-scripts.html) provide a way to configure cluster's nodes and to perform custom installs. Init scripts can be used in the following modes:

  * **Global**: by placing the Init script in `/databricks/init` folder, you force the script's execution every time any cluster is created or restarted by users of the workspace.
  * **Cluster Named (deprecated)**: you can limit the init script to run only on for a specific cluster's creation and restarts by placing it in `/databricks/init/<cluster_name>` folder.
  * **Cluster Scoped**: in this mode, the Init script is not tied to any cluster by its name and its automatic execution is not a virtue of its dbfs location. Rather, you specify the script in cluster's configuration by either writing it directly in the cluster configuration UI or storing it on DBFS and specifying the path in [Cluster Create API](https://docs.azuredatabricks.net/user-guide/clusters/init-scripts.html#cluster-scoped-init-script). Any location under DBFS `/databricks` folder except `/databricks/init` can be used for this purpose, such as: `/databricks/<my-directory>/set-env-var.sh`

You should treat Init scripts with *extreme* caution because they can easily lead to intractable cluster launch failures. If you really need them, please use the **Cluster Scoped execution mode** as much as possible because:

  * ADB executes the script's body in each cluster node. Thus, a successful cluster launch and subsequent operation are predicated on all nodal Init scripts executing in a timely manner without any errors and reporting a zero exit code. This process is highly error prone, especially for scripts downloading artifacts from an external service over unreliable and/or misconfigured networks.
  * Because Global and Cluster Named Init scripts execute automatically due to their placement in a special DBFS location, it is easy to overlook that they could be causing a cluster to not launch. By specifying the Init script in the Configuration, there's a higher chance that you'll consider them while debugging launch failures.

## Use cluster log delivery feature to manage logs

By default, Cluster logs are sent to default DBFS but you should consider sending the logs to a blob store location under your control using the [Cluster Log Delivery](https://docs.azuredatabricks.net/user-guide/clusters/log-delivery.html#cluster-log-delivery) feature. The Cluster Logs contain logs emitted by user code, as well as Spark framework's Driver and Executor logs. Sending them to a blob store controlled by yourself is recommended over default DBFS location because:

  * ADB's automatic 30-day default DBFS log purging policy might be too short for certain compliance scenarios. A blob store location in your subscription will be free from such policies.
  * You can ship logs to other tools only if they are present in your storage account and a resource group governed by you. The root DBFS, although present in your subscription, is launched inside a Microsoft Azure managed resource group and is protected by a read lock. Because of this lock, the logs are only accessible by privileged Azure Databricks framework code. However, constructing a pipeline to ship the logs to downstream log analytics tools requires logs to be in a lock-free location first.

## Additional considerations

- Use [Azure Data Factory](https://docs.azuredatabricks.net/user-guide/dev-tools/data-pipelines.html#azure-data-factory) to orchestrate pipelines / workflows (or something like [Airflow](https://docs.azuredatabricks.net/user-guide/dev-tools/data-pipelines.html#apache-airflow)).
- Connect your IDE or custom applications to Azure Databricks clusters using [DB-Connect](https://docs.azuredatabricks.net/user-guide/dev-tools/db-connect.html).
- Sync notebooks with [Azure DevOps](https://docs.azuredatabricks.net/user-guide/notebooks/azure-devops-services-version-control.html) for seamless version control.
- Use [Databricks CLI](https://docs.azuredatabricks.net/user-guide/dev-tools/databricks-cli.html) for CI / CD from relevant enterprise tools/products, or to integrate with other systems like on-prem SCM or Library Repos, etc.
- Use [Library Utilities](https://docs.azuredatabricks.net/user-guide/dev-tools/dbutils.html#library-utilities) to install python libraries scoped at notebook level (cluster-scoped libraries may make more sense in certain cases).
