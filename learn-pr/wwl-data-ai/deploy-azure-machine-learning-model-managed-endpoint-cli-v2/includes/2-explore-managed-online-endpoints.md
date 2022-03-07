To make a machine learning model available for other applications, you can deploy the model to a managed online endpoint.

The marketing team you work with has told you they want to get real-time predictions on whether a customer will churn or not. Every time they plan to send out special offers, they want to take the latest information of the customer to predict churn.

You'll learn how to use a managed online endpoint for real-time predictions.

## Real-time predictions

To get real-time predictions, you can deploy a model to an endpoint. An **endpoint** is an HTTPS endpoint to which you can send data, and which will send an almost immediate response back.

New data will be the input, for the scoring script hosted on the endpoint. The scoring script loads the trained model to predict the label for the new input data, which is also known as **inferencing**. The label is then part of the output that is sent back.

## Managed online endpoint

Within Azure Machine Learning, you can create a **managed online endpoint**. When using a managed online endpoint, you won't have to worry about infrastructure management.

All you need to do for the underlying infrastructure, is specify the VM type and scale settings. Everything else, like provisioning the compute and updating the host OS will be done automatically for you.

## Deploy your model

After creating an endpoint in the Azure Machine Learning workspace, you can deploy a model to that endpoint. To deploy your model to a managed online endpoint, you need to specify four things:

- **Model assets** like the model pickle file, or a **registered model** in the Azure Machine Learning workspace.
- **Scoring script** that loads the model.
- **Environment** which lists all necessary packages that need to be installed on the compute of the endpoint.
- **Compute size** and **scale settings** to ensure you can handle the amount of requests the endpoint will receive.

All these elements will be defined in the deployment. The deployment is essentially a set of resources required for hosting the model that does the actual inferencing.

## Blue/green deployment

One endpoint can have multiple deployments. One approach is to do blue/green deployment.

Let's take the example of the customer churn model. After experimentation, the data science team shares the best performing model with you. You use the blue deployment for the first version of the model. When new data is collected, the model may be retrained and a new version is registered to the Azure Machine Learning workspace. To test the new model, you can use the green deployment for the second version of the model.

Whenever the marketing team sends a request to the endpoint to get new real-time predictions, 90% of traffic may go to the blue deployment, and 10% of traffic to the green deployment. Having two versions of the model deployed to the same endpoint, allows you to test the model. It also allows you to transition seamlessly to the new version of the model by reconfiguring 90% traffic to the green deployment. If it turns out the new version doesn't perform better, you can easily roll back to the first version of the model by routing most traffic to the blue deployment again.

Deploying multiple models to an endpoint makes blue/green deployment possible. You can decide how much traffic should be routed to each deployed model. Using this approach, you can transition to a new version of the model without interrupting service for the client.

> [!Tip]
> Learn more about [deploying and scoring a machine learning model by using an online endpoint](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-managed-online-endpoints#understand-the-scoring-script)