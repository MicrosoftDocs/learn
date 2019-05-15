Microsoft provides several Azure platforms that help with the machine learning process. All these products simplify the data science process in unique ways. They each have different features and purposes which we will explore here.

The following table summarizes some of these services.

| Product | What it is | What you can do with it |
| ------- | ---------- | ----------------------- |
| Azure Machine Learning service | A managed cloud service for Machine Learning. | Train, deploy, and manage models in Azure using Python,  Azure CLI, and Azure portal. |
Azure Machine Learning Studio | A drag-and-drop visual interface for Machine Learning. | Build, experiment, and deploy models using preconfigured algorithms. Ideal for learning about Machine Learning. |
Azure Databricks | Apache Spark–based analytics platform with an integrated notebook interface that seamlessly integrates with Azure Active Directory (Azure AD) and data services. | Build and deploy models and data workflows with big data. |
Azure Data Science Virtual Machine. | A virtual machine with preinstalled data science tools. | Develop machine learning solutions in a preconfigured data science environment. |
SQL Server Machine Learning Services | Integrated with Microsoft SQL Server, this scalable analytics server supports the Python and R language. | Build and develop models in an on-premises SQL server that scales to match the SQL Server engine. Microsoft Machine Learning Server is also available as a cluster type in Azure HDInsight. |

Let's explore these services in more detail.

## Scale, automate, and deploy with Azure Machine Learning service

The Azure Machine Learning service supports data science pipeline integration with Azure. It allows you to scale up and automate:

- Model management
- Model training
- Model selection
- Hyper-parameter tuning
- Feature selection
- Model evaluation

The Azure Machine Learning service also enables you to more easily deploy your trained models to Azure containers where you can use them. The key advantage of this service is that it makes it easier for your data science project to utilize containerization and automation, resulting in better results in less time.

Examples of tools you typically use with this service include:

- Azure Machine Learning SDK
- Python
- Jupyter Notebook
- Microsoft Visual Studio
- JetBrains PyCharm 
- Your favorite IDE

### Utilize the Azure Machine Learning Studio platform

Azure Machine Learning Studio is a GUI-based platform that's an excellent place for beginner data scientists and analysts to learn. As an interactive platform, it provides a visual display for the modeling process, including deployment options. Azure Machine Learning Studio integrates a drag-and-drop method of the iterative data science process for simple use. It  also includes an automated deployment service that supports REST API calls to score data.

Examples of tools included with Azure Machine Learning Studio are:

- Data visualization
- Drag-and-drop interface
- Azure (Jupyter) Notebooks
- Project samples

> [!TIP]
> Azure Machine Learning Studio is primarily a learning platform and for limited-scale use.

### Azure Databricks platform

*Azure Databricks* is a secure, all-in-one data science team collaboration platform. It includes a powerful notebook interface, job scheduling, Azure Active Directory integration, granular security control, and seamless Azure integration. Azure Databricks has a GUI-based cloud portal that makes it even easier to use the Spark big data platform. You can more easily create and modify Spark clusters, and turn them off when not using them without losing data. 

Azure Databricks features include, but are not limited to:

- Azure Databricks notebooks, which support SQL, Python, R, Scala, and Java
- Job scheduler
- Local built-in Blob Storage
- Seamless, secure access to Azure data services such as Azure Blob Storage, Azure SQL database, Azure SQL Datawarehouse, and Azure CosmosDB
- Graphical UI to quickly spin up and scale Spark clusters
- Proprietary Spark optimizations

### Azure Data Science Virtual Machine
Built specifically for data science, *Azure Data Science Virtual Machines* (DSVMs) are preconfigured virtual machines you create in Azure that have many popular machine learning tools preinstalled. It provides data scientists a simple way to begin and iterate through the modeling process.

Examples of DSVMs tools include:

- SQL Server / Machine Learning Server
- Microsoft R Open
- Jupyter notebooks
- Anaconda Python
- Sample code demonstrating how to use various Azure-based Machine Learning services

### SQL Server Machine Learning Services

*SQL Server Machine Learning Services* runs on the SQL Server on-premises platform, and supports scale up and high performance of Python and R code. With it, you can work with SQL Server data in place. You also get all the SQL Server features including tighter security, excellent performance, the ability to schedule model training with the SQL Agent service, and persistence of models to database tables. In addition, you can encapsulate Python and R code in stored procedures, and they can interoperate with T-SQL so you can have the high performance of T-SQL with the advanced Machine Learning features or R and Python.

Along with core Python and R tools, SQL Server Machine Learning Service includes a set of components for data scientists.

- Python components and packages for data manipulation, transformation, visualization, and analysis.
- R packages such as RevoScaleR, MicrosoftML (R), opalR, and sqlRUtils to perform data science tasks in the R language.