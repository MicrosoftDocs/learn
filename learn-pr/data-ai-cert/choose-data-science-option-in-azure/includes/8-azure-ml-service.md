The Azure Machine Learning service supports integration of your data science pipelines with Azure. It allows you to scale up and automate model management, model training, model selection, hyperparameter tuning, feature selection, and model evaluation. When you are ready, the service allows you to easily deploy your trained models to Azure containers where they can be used. The key advantage of this service is that it makes it easy for your data science project to take advantage of containerization and automation. You get better results in less time.

## What it includes

The Azure Machine Learning (AML) service supports open-source technologies, which include a plethora of packages for practicing machine learning via Python. AML service includes common data science tools as extensions. If you're wondering why this would be beneficial for a data scientist, this technology permits the use of at scale data because it can run on a local machine then be scaled up to the cloud when needed.

![Screenshot of AML Framework](../media/8-aml-framework.png)

## How the Data Science Process Looks in AML service

The roles that have technologies available on this platform are data engineer, data scientist, and developer. We outline below what tools are available for each role in AML service.

![Screenshot of Engineering Icon](../media/8-engineering-icon.png)

### Data Engineering

Data preparation can be done using the open-source AML Data Prep SDK or pandas and you can do your data preparation locally or leverage Azure containers.

### Data Scientist

The AML service does not replace your data science tool so use whatever Python IDE you like. In fact, bring your existing machine learning pipelines. The AML service can easily be incorporated into your Python code to take advantage of the powerful AML service features. Many model training frameworks are supported including support for Deep Learning. This includes:

- Scikit-learn
- TensorFlow
- PyTorch
- CNTK
- MXNet

![Screenshot of Combined Icons](../media/8-combined-icons.png)

### Developer

The AML service is compatible with four targets for deployment:

- Azure Container Instances
- Azure Kubernetes Services
- Azure IoT Edge
- Field-programmable gate array