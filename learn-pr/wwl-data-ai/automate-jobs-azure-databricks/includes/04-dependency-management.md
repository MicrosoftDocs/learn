**Dependency management** involves managing **libraries** and **packages** that your code depends on to function correctly. Managing dependencies like libraries and packages is crucial to keep your environment stable and consistent, and to ensure you can replicate results across different runs and clusters.

## Manage dependencies through cluster libraries

You can manage dependencies in Azure Databricks primarily through **cluster libraries**. When you use cluster libraries, you ensure that all nodes within a cluster have the necessary libraries preinstalled, providing a consistent runtime environment for your notebooks and jobs.

:::image type="content" source="../media/cluster-library.png" alt-text="Screenshot of installing a library on a cluster." lightbox="../media/install-library.png":::

> [!Tip]
> Learn more about cluster libraries and how to [install a library on a cluster](/azure/databricks/libraries/cluster-libraries?azure-portal=true)

### Securely store your libraries

Libraries can be installed from various sources, like from an object stored in an Azure Data Lake Storage (ADLS) or the Databricks File System (DBFS). However, any workspace user can modify library files stored in DBFS. Therefore, you should upload all libraries to **workspace files** or **Unity Catalog** volumes and installing your dependencies from there.

You can upload package or requirements.txt files to your workspace and reference your file when installing libraries on your clusters.

For example, your requirements.txt file that installs libraries necessary for machine learning can include the following list:

```txt
pandas==1.3.3
numpy==1.21.2
scikit-learn==0.24.2
matplotlib==3.4.3
```

> [!Tip]
> Learn more about how to [install libraries from workspace files](/azure/databricks/libraries/workspace-files-libraries?azure-portal=true).

### Specify library versions

Managing library versions is crucial to avoid conflicts and ensure compatibility between different libraries. In Azure Databricks, you can specify *exact library versions* to be installed, which helps in maintaining a consistent environment.

For example, when using PyPI to install scikit-learn for machine learning workloads, you can use `scikit-learn==0.19.1` to specify the version.

When you manage your dependencies in Azure Databricks, you're creating robust, maintainable, and scalable data analytics environments, which lead to smoother development cycles and more reliable insights.
