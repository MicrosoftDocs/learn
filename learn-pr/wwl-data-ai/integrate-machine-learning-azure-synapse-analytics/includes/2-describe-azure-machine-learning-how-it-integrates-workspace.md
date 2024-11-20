Azure Machine Learning can be used for any kind of machine learning, from classical ml to deep learning, supervised and unsupervised learning. Whether you prefer to write Python or R code with the SDK or work with no-code/low-code options in [the studio](/azure/machine-learning/overview-what-is-machine-learning-studio), you can build, train, and track machine learning and deep-learning models in an Azure Machine Learning Workspace. 

You can start training on your local machine and then scale out to the cloud. The service also interoperates with popular deep learning and reinforcement open-source tools such as PyTorch, TensorFlow, scikit-learn, and Ray RLlib. 

At a high level, a typical data science process contains the following steps:

* Business understanding
* Data acquisition and understanding
* Modeling
* Model deployment and scoring

For each step in the data science process, the integration between Azure Synapse and Azure Machine Learning capabilities can be helpful using the tools listed below.

* **Data ingestion and data orchestration pipelines**: This allows you to quickly build data pipelines to access and transform the data into a format that can be consumed for machine learning. [Learn more about data pipelines](/azure/data-factory/concepts-pipelines-activities?bc=/azure/synapse-analytics/breadcrumb/toc.json&toc=/azure/synapse-analytics/toc.json) in Synapse. 
* **Synapse Spark Pools**: In Azure Synapse, training machine learning models can be performed on the Apache Spark Pools with tools like PySpark/Python, Scala, or .NET.
* **Azure Machine Learning automated ML**: Thanks to seamless integration with Azure Machine Learning from Azure Synapse Notebooks, users can easily leverage automated ML in Synapse with passthrough Microsoft Entra authentication. 
* **T-SQL PREDICT function**: [T-SQL PREDICT](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-predict) in Synapse SQL pools to run your predictions right where your data lives. This powerful and scalable function allows you to enrich your data without moving any data out of your data warehouse.

The connection between an Azure Machine Learning workspace and a Synapse Analytics Workspace relies on a Microsoft Entra Application and a Service Principal. The service principal should be given the "contributor" role for the Azure Machine Learning workspace. Once the service principal is ready it can be used to create an Azure Machine Learning linked service in Synapse Analytics. You will have the chance to go through a step-by-step exercise in the next section.
