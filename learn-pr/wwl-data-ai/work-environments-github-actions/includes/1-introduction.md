Imagine you're a machine learning engineer, tasked with taking a model from development to production. To train, test, and deploy a machine learning model it's best to use **environments** as part of your **machine learning operations** (**MLOps**) strategy.

After a data scientist has trained and tested the model, you'll want to deploy the model, test the deployment, and finally deploy the model to production where it will be consumed at a large scale. In line with software development practices, these tasks should be performed in different environments. By using environments like a development, staging, and production environment, you can separate the MLOps workflow.  

To create different environments, you can create different Azure Machine Learning workspaces that are linked to separate GitHub environments. By using GitHub Actions, you can automate workflows across environments, adding gated approvals to mitigate risks. 

## Learning objectives

In this module, you'll learn how to:

- Set up environments in GitHub.
- Use environments in GitHub Actions.
- Add approvals to assign required reviewers before moving the model to the next environment.

