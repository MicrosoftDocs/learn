Use environments in your machine learning operations (MLOps) strategy to train, test, and deploy your model safely, while maintaining a stable solution. 

After a data scientist has trained and tested the model, you'll want to deploy the model, test the deployment and finally deploy the model to production where it will be consumed at a large scale. In line with software development practices, these tasks should be performed in different environments. By using environments like a development, staging, and production environment, you can separate the MLOps workflow to 



The Azure Machine Learning CLI (v2) can be used to environmentalize your MLOps systems. It is crucial to train/test a model, test the deployment, and run production inference in different environments to adhere to software development practices.

As a machine learning engineer or AI developer, it will be your responsibility to ensure an automated system that can move a model through such environments in a semi-automated way. It is important to maintain the human-in-the-loop for gated approval processes to mitigate risk of AI.
Using the Azure Machine Learning CLI (v2), you can execute semi-automated processes achieving this complex task moving a fully trained model from dev to test and from test to production.

You'll be using YAML to define the such pipeline and the machine learning extension of the Azure CLI (v2) to trigger the pipeline. 


## Learning objectives

In this module, you'll learn how to:

- Work with YAML to define environmental specialties to properly move trained models
- Run scripts as job with CLI v2 to enable semi-automated approach
- Understanding environmental verticalization of Machine Learning Systems

