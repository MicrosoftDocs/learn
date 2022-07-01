You work at Proseware, a young start-up, aiming to improve health care. Together with the data science team, you've recently finished work on operationalizing a diabetes classification model. In other words, you've converted notebooks to scripts that you can execute as an Azure Machine Learning job.

During a presentation of the end-to-end solution to the business and technical stakeholders at Proseware, several questions came up around how to scale the use of this model both from a model creation standpoint and from a consumption standpoint. 

In health care, many models use medical data of patients to predict diseases. From previous projects, we've learned that these models are often highly dependent on the geographical location of the population the model is trained on. To make this model scalable, we need to ensure that different versions of the model can automatically be trained based on different data segments.

In the meeting, the business and technical stakeholders have decided to create a **machine learning operations (MLOps)** strategy to allow for the rapid creation, update, and deployment of models such as the classification model the data science team has developed for the practitioner web app. 

As Proseware uses GitHub to version control its code, the decision was made to use **GitHub Actions** as the automation component of the MLOps strategy. 

The first step in implementing the automation process is to develop a GitHub Action to train the diabetes classification model using Azure Machine Learning jobs. 

To create the GitHub Action to trigger model training using Azure Machine Learning compute, you’ll want to:

- Create a **service principal** using the Azure CLI.
- Store the credentials of the service principal as a **secret** in GitHub.
- Create a GitHub Action to train the model using Azure Machine Learning compute.
