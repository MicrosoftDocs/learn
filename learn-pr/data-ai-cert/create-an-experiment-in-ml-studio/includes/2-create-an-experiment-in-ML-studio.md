We'll start by creating an experiment in Azure ML Studio that uses a pre-built data set around building energy considerations.

## Create the Sample Experiment

In this exercise you will import a data set into Azure ML Studio and use that to create an experiment that will be used to publish a web service. The experiment we create will not be complex and is only used to illustrate how to create a machine learning model and to publish and consume it as a web service.

1. Download and extract the [Building Data.zip](https://github.com/MicrosoftDocs/mslearn-work-with-vision-cognitive-services/blob/master/Building%20Data.zip?raw=true) file for use as the dataset.

1. Navigate to the Azure ML Studio portal [https://studio.azureml.net](https://studio.azureml.net?azure-portal=true). 
1. Sign in using the Microsoft account associated with your Azure account.
1. Click the Datasets icon on the left nav bar of Azure Machine Learning Studio.  
1. Click the **New** button in the lower left corner to upload the dataset.
1. Choose **DataSet**, then **From Local File**.
1. Click **Choose File** and locate the file you just downloaded and select it.
1. Select the Check Mark in the lower right corner to upload the dataset.
1. Verify that **Building Data.csv** is listed as a dataset.
1. Click the Experiments icon in Azure ML Studio.
1. Click **New** to create a new experiment and select **Blank Experiment**.
1. Expand the **Saved Datasets** and then **My Datasets** folders and locate **Building Data.csv**.  

    ![Adding a data set](../media/5-create-an-experiment-in-ML-studio-dataset-selection.png)

1. Drag and drop this dataset onto the designer surface.
