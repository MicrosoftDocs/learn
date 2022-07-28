In Azure Machine Learning studio, there are several ways to author regression machine learning models. One way is to use a visual interface called *designer*, that you can use to train, test, and deploy machine learning models using a drag-and-drop interface. The drag-and-drop interface makes use of clearly defined inputs and outputs that can be shared, reused, and version controlled.  

![A screenshot of the Azure Machine Learning Studio's Designer interface.](../media/designer-canvas-screenshot.png)

To begin a *designer* project, you need to create a new pipeline. The interface has a left panel for navigation to tabs including an **Asset Library**, and a canvas on your right hand side. You can access the building blocks for your project in the Asset Library using the search bar, or by scrolling through the *Data* and *Component* assets.   

## Pipelines 
To use the Azure Machine Learning designer, you create a *pipeline*. Pipelines let you organize, manage, and reuse complex machine learning workflows across projects and users.

A pipeline starts with the dataset from which you want to train the model. Each time you run a pipeline, the configuration of the pipeline and its results are stored in your workspace as a pipeline job.  

## Azure Machine Learning Jobs 
An Azure Machine Learning (ML) job executes a task against a specified compute target. Jobs also enable systematic tracking for your ML experimentation and workflows. Once a job is created, Azure ML maintains a run record for the job. All of your jobs' run records can be viewed in Azure ML studio. 

In your designer project, you can access the status of a pipeline job using the **Submitted jobs** tab on the left pane. 
![Screenshot of the submitted jobs tab in Azure Machine Learning designer.](../media/submitted-jobs-location.png)

You can find all the jobs you have run in a workspace on the **Jobs** page.  
![Screenshot of the jobs page in Azure Machine Learning designer.](../media/jobs-page-location.png)

## Datasets 
To train a regression model, you need a dataset that includes historical *features*, characteristics of the entity for which you want to make a prediction. You also need known *label* values, the numeric value that you want to train a model to predict.

You can create data assets on the **Data** page from local files, a datastore, web files, and Open Datasets. 
![Screenshot of the Data page in Azure Machine Learning designer.](../media/data-creation-location.png)

## Components 
An Azure Machine Learning component encapsulates one step in a machine learning pipeline. You can think of a component as a programming function and as a building block for Azure Machine Learning pipelines.

You can access datasets and components from the left panel's **Asset Library** tab.