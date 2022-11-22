Imagine you're a machine learning engineer, working together with a data science team on a diabetes classification model. The workflow created by the data science team preprocesses data and trains the model. You want to automatically execute the workflow. By doing so, you'll enable automated training (and retraining) of the classification model in different environments, driven by different events. 

Automation is an important part in machine learning operations (MLOps). Similar to DevOps, MLOps allows for rapid development and delivery of machine learning artifacts to consumers of those artifacts. An effective MLOps strategy allows for the creation of automated workflows to train, test, and deploy machine learning models while also ensuring model quality is maintained.

Using GitHub Actions, you'll automatically execute an Azure Machine Learning job to train a model. To execute your Azure Machine Learning jobs with GitHub Actions, you'll save your Azure credentials as a secret in GitHub. You'll then define the GitHub Action using YAML.

## Learning objectives

In this module, you'll learn how to:

- Create and assign a service principal the permissions needed to run an Azure Machine Learning job.
- Store Azure credentials securely using secrets in GitHub.
- Create a GitHub Action using YAML that uses the stored Azure credentials to run an Azure Machine Learning job. 

