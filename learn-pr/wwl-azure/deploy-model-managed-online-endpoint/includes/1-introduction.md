Imagine you trained a model to recommend restaurants. The model has been trained and tracked in Azure Machine Learning. You want to use the model in your application where consumers can browse restaurants in their area. Each time a consumer selects a restaurant in the application, you want the model to recommend other restaurants that might also be of interest to the consumer to improve the user experience. 

Whenever you train a model, you ultimately will want to consume the model. You want to use the trained model to predict labels for new data on which the model hasn't been trained.

To consume the model, you need to **deploy** it. One way to deploy a model is to integrate it with a service that allows applications to request instant, or **real-time**, predictions for individual or small sets of data points.

:::image type="content" source="../media/07-01-real-time.jpg" alt-text="Diagram showing an application requesting an instant prediction of a model.":::

In Azure Machine Learning, you can use **online endpoints** to deploy and consume your model.

## Learning objectives

In this module, you'll learn how to:

- Create managed online endpoints.
- Deploy your MLflow model to a managed online endpoint.
- Deploy a custom model to a managed online endpoint.
- Test online endpoints.
