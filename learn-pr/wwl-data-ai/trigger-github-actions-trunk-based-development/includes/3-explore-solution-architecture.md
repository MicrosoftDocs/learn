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

The training script to train the model is stored in a repository (repo) on GitHub. Even though a first iteration of the model was considered accurate enough to be deployed and consumed by the web application, the data science team wants to keep experimenting to try to improve the model. 

You want to allow the data science team to experiment, without touching the code ready for production. You also want to ensure that whenever any new or updated code goes through quality checks. After you verify the code to train the model, you'll use the updated training script to train a new model and deploy it.

To keep track of changes and to verify your code before changing the production code, it's necessary to work with branches. You've agreed with the data science team that every time they want to make a change, that they'll create a **feature branch** to copy the code in the repo and make their changes there.

Any data scientist can create a feature branch and work in there. Once they've updated the code and want that code to be the new production code, they'll have to create a **pull request**. 
In the pull request, it will be visible for others what the proposed changes. 

Whenever a pull request is created, you want to automatically check whether the code works and that the quality of the code is up to your standards. After the code passes the quality checks, the lead data scientist needs to review the changes and approve the updates before the pull request can be merged, and the code in the main branch can be updated accordingly.

> [!Important]
> No one should ever be allowed to push changes to the main branch. To safeguard your code, especially production code, you'll want to enforce that the main branch can only be updated through pull requests that need to be approved.

