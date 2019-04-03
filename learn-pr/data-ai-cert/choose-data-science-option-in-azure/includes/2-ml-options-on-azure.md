Microsoft provides seven different Azure platforms designed for aiding the machine learning process. Even though many of the platforms have similar functionalities, each was designed to solve different types of problems.

The table below summarizes some of these services.

| Product | What it is | What you can do with it |
| ------- | ---------- | ----------------------- |
| Azure Machine Learning Service | Managed cloud service for Machine Learning | Train, deploy, and manage models, in Azure using Python, the Azure CLI, and the portal |
| Azure Machine Learning Studio | Drag-and-drop visual interface for Machine Learning | Build, experiment, and deploy models using preconfigured algorithms. Ideal for learning about machine learning |
| Azure Databricks | Spark-based analytics platform with an integrated notebook  interface that seamlessly integrates with Azure AD and data services | Build and deploy models and data workflows with Big Data |
| Azure Data Science Virtual Machine | A virtual machine with pre-installed data science tools | Develop machine learning solutions in a pre-configured data science environment |
| SQL Server / Machine Learning Server | Integrated with SQL Server, this scalable analytics server supports the Python and R language. | Build and develop models inside on-premises SQL server that scale to match the SQL Server engine. Note:  Machine Learning Server is also available as a cluster type in HDInsight. |

## Differences Between Products

With all these options, you may wonder what the differences between them are and when you should use each. Let's take a look at each one is detail.

## The Azure Machine Learning Service

The Azure Machine Learning service supports integration of your data science pipelines with Azure. It allows you to scale up and automate model management, model training, model selection, hyperparameter tuning, feature selection, and model evaluation. When you are ready, the service allows you to easily deploy your trained models to Azure containers where they can be used. The key advantage of this service is that is make it easy for your data science project to take advantage of containerization and automation. You get better results in less time.

Examples of tools typically used with this service include:

- Azure ML Service SDK
- Python
- Jupyter Notebook, Visual Studio, PyCharm or your favorite IDE

### Azure Machine Learning Studio

Azure Machine Learning Studio is a GUI-based platform that is an excellent place for beginner data scientists and analysts learn. It is an interactive platform that gives a visual display for the modeling process, including deployment options. AML Studio integrates a drag-and-drop method of the iterative data science process for simple use. It includes an automated deployment service that supports REST API calls to score data.

Example of tools included:

- Data visualization
- Drag-and-drop interface
- Azure (Jupyter) Notebooks
- Project Samples

### Azure Databricks

Azure Databricks provides a GUI-based cloud portal that simplifies using the Spark big data platform. Creating and modifying Spark clusters can be done easily and clusters can be turned off when not in use without losing data. Azure Databricks is a secure, all-in-one, data science team collaboration platform, that includes a powerful notebooks interface, job scheduling, active directory integration, granular security control, and seamless Azure integration.

Features include:

- Azure Databricks Notebooks which support SQL, Python, R, Scala, and Java.
- Active Directory Integration
- Job Scheduler
- Local Built-In Blob Storage
- Seamless Secure Access to Azure Data Services such as Blob, Azure SQL DB, Azure DW, CosmosDB, etc.
- GUI to Easily Create Spark Clusters
- Proprietary Spark Optimizations

### Azure Data Science Virtual Machine

Built specifically for data science, Azure Data Science Virtual Machines (DSVMs) are pre-configured virtual machines you create in Azure that have many popular machine learning tools pre-installed. It provides data scientists a simple way to begin and iterate through the modeling process.

Examples of tools include:

- SQL Server / Machine Learning Server
- Microsoft R Open
- Jupyter notebooks
- Anaconda Python
- Sample Code Demonstrating How to Use Various Azure based Machine Learning Services

### SQL Server / Machine Learning Server

The SQL Server / Machine Learning Server is a service that runs on the SQL Server on-premises platform and supports scale up and high performance of Python and R code. With it, you can work with SQL Server data in place. You get all the features of SQL Server including tight security, excellent performance, the ability to schedule model training with SQL Agent, and persistence of models to database tables. Python and R code can be encapsulated in stored procedures and can interoperate with T-SQL so you can get the high performance of T-SQL with the advanced machine learning features or R and Python.

Tools include:

- Commercial High Scale Python Modules
- Commercial High Scale R Packages