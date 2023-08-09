**Automation** is one of the most important practices of **machine learning operations** (**MLOps**). By automating tasks, you can deploy new models to production more quickly.

Next to automation, another key aspect of MLOps is **source control** to manage code and track any changes. 

Together, you can use automation and source control to trigger tasks in the machine learning workflow based on changes to the code. However, you want the automated task to be triggered only when the code changes have been verified and approved.

For example, after retraining a model using new hyperparameter values, you want to update the hyperparameter in the source code. After verifying and approving the change to the code that is used to train the model, you want to trigger the new model to be trained.

GitHub is a platform that offers GitHub Actions for automation and repositories using Git for source control. You can configure your GitHub Actions workflows to be triggered by a change in your repo. 

## Learning objectives

In this module, you'll learn how to:

- Work with feature-based development.
- Protect the main branch.
- Trigger a GitHub Actions workflow by merging a pull request.