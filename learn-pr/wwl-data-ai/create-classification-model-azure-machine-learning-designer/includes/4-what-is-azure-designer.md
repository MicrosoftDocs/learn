In Azure Machine Learning studio, there are several ways to author classification machine learning models. One way is to use a visual interface called *designer* that you can use to train, test, and deploy machine learning models. The drag-and-drop interface makes use of clearly defined inputs and outputs that can be shared, reused, and version controlled.  

Each *designer* project, known as a pipeline, has a left panel for navigation and a canvas on your right hand side. To use *designer*, identify the building blocks, or components, needed for your model, place and connect them on your canvas, and run a machine learning job.  

![A screenshot of the Azure Machine Learning Studio's Designer interface.](../media/designer-canvas-screenshot.png)

## Pipelines

Pipelines let you organize, manage, and reuse complex machine learning workflows across projects and users. A pipeline starts with the dataset from which you want to train the model. Each time you run a pipeline, the configuration of the pipeline and its results are stored in your workspace as a pipeline job.  

![Screenshot of the pipelines page in Azure Machine Learning designer.](../media/pipeline-page-example.png)

## Components 

An Azure Machine Learning component encapsulates one step in a machine learning pipeline. You can think of a component as a programming function and as a building block for Azure Machine Learning pipelines. In a pipeline project, you can access data assets and components from the left panel's **Asset Library** tab.
 
![Screenshot of the asset library's components button in Azure Machine Learning designer.](../media/components-example.png)

## Datasets 

You can create data assets on the **Data** page from local files, a datastore, web files, and Open Datasets. These data assets will appear along with standard sample datasets in *designer*'s **Asset Library**. 
![Screenshot of the Data page in Azure Machine Learning designer.](../media/data-creation-location.png)

## Azure Machine Learning Jobs 

An Azure Machine Learning job executes a task against a specified compute target. Jobs enable systematic tracking for your machine learning experimentation and workflows. Once a job is created, Azure Machine Learning maintains a run record for the job. All of your jobs' run records can be viewed in Azure Machine Learning studio. 

In your designer project, you can access the status of a pipeline job using the **Submitted jobs** tab on the left pane. 
![Screenshot of the submitted jobs tab in Azure Machine Learning designer.](../media/submitted-jobs-location.png)

You can find all the jobs you have run in a workspace on the **Jobs** page.  
![Screenshot of the jobs page in Azure Machine Learning designer.](../media/jobs-page-location.png)



