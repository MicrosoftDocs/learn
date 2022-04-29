Azure Synapse Studio comes with an integrated notebook experience. The Apache Spark notebooks in Azure Synapse Studio are a web interface that enables you to create, edit, and transform data within them. 
It provides a live coding experience, that also enables you to include visualizations and narrative text within the notebook. Notebooks are a great way to explore and validate some of the ideas you might have about the data you are working with. Notebooks enable you to experiment with your data so you can gain some useful insights about the data. 
The look and feel of the integrated notebook experience within Azure Synapse Studio is similar to that of Jupyter notebooks in Azure Machine Learning Service. 

If you navigate to the Azure Synapse Studio environment, you can find the notebooks in the Development hub of the studio experience. 
To access the studio environment, you can navigate to the Azure Synapse Analytics Workspace and launch the studio. 
You'll also find that there are some notebook examples available through the Knowledge Center. 

Notebooks also contain features that can aid your development as you write code. Some of these features include:

* Support for highlighting language syntax 
* Syntax error support
* Syntax code completion​
* The ability to export results 

To ingest data through notebooks, you can use a linked service already defined in the Azure Synapse workspace. An example could be a linked service defined for an Azure Storage account. By using a linked service, the keys and configurations associated with the storage account are stored in the linked service, and this information is used when you use the notebook to ingest data into an Apache Spark DataFrame from the storage account on which the linked service is defined.

There is an alternative way you can work with data. Every Azure Synapse workspace has an associated primary storage account defined when it is created. If you intend to browse data stored in the primary storage account, there's no need to provide the secrets or keys. In the Data tab on the left hand-side in the Synapse workspace, you can right-click on a file stored in the primary storage account, and then select **New notebook** to open a notebook with the data from the file generated.

Notebooks also enable you to write multiple languages in one notebook by using the magic commands expressed by using the %%\<Name of Language\> syntax. As a result you could create a temporary table to store ingested data within the notebook, and then use the magic command to enable multiple languages to work with this data.

With an Azure Synapse Studio notebook, you can:

- Get started with zero setup effort.
- Keep data secure with built-in enterprise security features.
- Analyze data across raw formats (CSV, txt, JSON, etc.), processed file formats (parquet, Delta Lake, ORC, etc.), and SQL tabular data files against Apache Spark and SQL.
- Be productive with enhanced authoring capabilities and built-in data visualization.