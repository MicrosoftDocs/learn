Let's revise the machine learning operations (MLOps) architecture to understand the purpose of what we're trying to achieve. 

Imagine that together with the data science and software development team, you've agreed on the following architecture to train, test, and deploy the diabetes classification model:

![Diagram of machine learning operations architecture.](../media/01-01-architecture.png)

> [!Note]
> The diagram is a simplified representation of a MLOps architecture. To view a more detailed architecture, explore the various use cases in the [MLOps (v2) solution accelerator](https://github.com/Azure/mlops-v2).

The architecture includes:

1. **Setup**: Create all necessary Azure resources for the solution.
2. **Model development (inner loop)**: Explore and process the data to train and evaluate the model.
3. **Continuous integration**: Package and register the model.
4. **Model deployment (outer loop)**: Deploy the model.
5. **Continuous deployment**: Test the model and promote to production environment.
6. **Monitoring**: Monitor model and endpoint performance.

The data science team is responsible for the model development. The software development team is responsible for integrating the deployed model with the web app used by practitioners to assess whether a patient has diabetes. You're responsible of taking the model from model development to model deployment.

You expect the data science team to constantly propose changes to the scripts used to train the model. Whenever there's a change to the training script, you need to retrain the model and redeploy the model to the existing endpoint. 

You want to allow the data science team to experiment, without touching the code ready for production. You also want to ensure that any new or updated code automatically goes through agreed upon quality checks. After you verify the code to train the model, you'll use the updated training script to train a new model and deploy it.

To keep track of changes and to verify your code before updating the production code, it's *necessary* to work with branches. You've agreed with the data science team that every time they want to make a change, they'll create a **feature branch** to create a copy of the code and make their changes to the copy.

Any data scientist can create a feature branch and work in there. Once they've updated the code and want that code to be the new production code, they'll have to create a **pull request**. 
In the pull request, it will be visible for others what the proposed changes are, giving others the opportunity to review and discuss the changes.

Whenever a pull request is created, you want to automatically check whether the code works and that the quality of the code is up to your organization's standards. After the code passes the quality checks, the lead data scientist needs to review the changes and approve the updates before the pull request can be merged, and the code in the main branch can be updated accordingly.

> [!Important]
> **No one** should ever be allowed to **push changes to the main branch**. To safeguard your code, especially production code, you'll want to enforce that the main branch can only be updated through pull requests that need to be approved.

