You can manage your machine learning models with the Azure Machine Learning extension for the CLI (v2). When you execute code as an Azure Machine Learning **job**, you can easily set up automated model training.

Imagine you're a machine learning engineer at a company providing health care. The data science team has created a classification model that is able to predict whether someone has diabetes, based on their medical information.

Using Azure Machine Learning jobs, you want to execute all necessary steps to preprocess the data and train the model. When you define the job in YAML and run the job with the CLI (v2), your workflow can be scheduled or triggered whenever the model needs to be retrained. For example, when you have new data that the model should be trained on.

## Learning objectives

In this module, you'll learn how to:

- Convert notebook to scripts.
- Work with YAML to define a command or pipeline job.
- Run scripts as a job with the CLI v2.
