**Azure Machine Learning service** provides SDKs and cloud services you can use to integrate your data science pipelines with Azure. It allows you to scale up and automate:

- Model management
- Model training
- Model selection
- Hyper-parameter tuning
- Feature selection
- Model evaluation

When you are ready, the service allows you to easily deploy your trained models to Azure containers where they can be used. The key advantage of Azure Machine Learning service is that it makes it easier for your data science project to utilize containerization and automation, meaning you get better results in less time.

## What is included in Azure Machine Learning service

The Azure Machine Learning service supports open-source technologies, which include a plethora of packages for practicing machine learning via Python. Azure Machine Learning service includes common data science tools as extensions. If you're wondering why this would be beneficial for a data scientist, this technology permits the use of at-scale data because it can run on a local machine, then be scaled up to the cloud when needed.

![Screenshot of the Azure Machine Learning framework.](../media/8-aml-framework.png)

## Roles in Azure Machine Learning service

The platform is designed to support three specific roles:

1. Data Engineer
1. Data Scientist
1. Developer

### Data Engineer

The primary task a data engineer will do with Azure Machine Learning service is to ingest and prepare data for analysis. You can prepare your data locally, or leverage Azure containers. To prepare/transform the data you can use the open-source Azure Machine Learning Data Prep SDK, or the Pandas open-source library.

### Data Scientist

The Azure Machine Learning service doesn't replace any of your data science analysis tools. 

You can bring all of your existing machine learning pipelines into Azure Machine Learning service and incorporate your Python code to utilize the powerful Azure Machine Learning service features. In addition to support for deep learning, many model training frameworks are supported, including:

:::row:::
  :::column span="3":::
- Scikit-learn
- TensorFlow
- PyTorch
- Microsoft Cognitive Toolkit (CNTK)
- Apache MXNet
  :::column-end:::
  :::column:::
![Screenshot of multiple Icons.](../media/8-combined-icons.png)
  :::column-end:::
:::row-end:::

### Developer

Once a model has been built and trained, you can create an _image_ of the model and all components needed to use the model. An image contains:

1. The model.
1. A scoring script or application which passes input to the model and returns the output of the model.
1. The required dependencies (for example, the Python scripts or packages needed by the model or scoring script).

Images can be packaged either as Docker images, or field programmable gate array (FPGA) images.

Azure Machine Learning service can deploy images to either a web service (running in Azure Container Instance, FPGA, or Azure Kubernetes Services), or an IoT module (using IoT Edge). Once deployed, developers can invoke models from their applications to process data and return results.
