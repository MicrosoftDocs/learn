Imagine you're a data scientist and you train machine learning models. You typically follow six steps to plan, train, deploy, and monitor the model:

:::image type="content" source="../media/machine-learning-process.png" alt-text="Diagram showing the six steps of the machine learning process.":::

1. **Define the problem**: Decide on what the model should predict and when it's successful. 
1. **Get the data**: Find data sources and get access. 
1. **Prepare the data**: Explore the data. Clean and transform the data based on the model's requirements.
1. **Train the model**: Choose an algorithm and hyperparameter values based on trial and error.
1. **Integrate the model**: Deploy the model to an endpoint to generate predictions.
1. **Monitor the model**: Track the model's performance.

> [!Note]
> The diagram is a simplified representation of the machine learning process. Typically, the process is iterative and continuous. For example, when monitoring the model you may decide to go back and retrain the model.

You should plan how you **integrate the model**, as it may affect how you train the model or what training data you use. To integrate the model, you need to deploy a model to an **endpoint**. You can deploy a model to an endpoint for either **real-time or batch predictions**.

## Deploy a model to an endpoint

When you train a model, the goal is often to integrate the model into an application. 

To easily integrate a model into an application, you can use **endpoints**. Simply put, an endpoint can be a web address that an application can call to get a message back. 

With Azure Machine Learning, you can deploy your model to an endpoint. Then you can integrate the endpoint into your own application and call the model to get the predictions in the application where you want to visualize them.

When you deploy a model to an endpoint, you have two options:

- Get **real-time** predictions
- Get **batch** predictions

### Get real-time predictions

If you want the model to score any new data as it comes in, you need predictions in real-time. 

Real-time predictions are often needed when a model is used by an application such as a mobile app or a website. 

Imagine you have a website that contains your product catalog:

1. A customer selects a product on your website, such as a shirt.
1. Based on the customer's selection, the model recommends other items from the product catalog immediately. The website displays the model's recommendations.

:::image type="content" source="../media/real-time.png" alt-text="Diagram showing a website of a web shop. A shirt is shown at the top and the recommendations, based on the shirt, are shown at the bottom.":::

A customer can select a product in the web shop at any time. You want the model to find the recommendations almost immediately. The time it takes for the web page to load and display the shirt details is the time it should take to get the recommendations or predictions. Then, when the shirt is displayed, the recommendations can also be displayed.

### Get batch predictions

If you want the model to score new data in batches, and save the results as a file or in a database, you need batch predictions.

For example, you can train a model that predicts orange juice sales for each future week. By predicting orange juice sales, you can ensure that supply is sufficient to meet expected demand. 

Imagine you're visualizing all historical sales data in a report. You'll want to include the predicted sales in the same report.

:::image type="content" source="../media/batch.png" alt-text="Diagram showing a report with several graphs. One graph is a line chart with a blue arrow highlighting the forecasted values.":::

Although orange juice is sold throughout the day, you only want to calculate the forecast once a week. You can collect the sales data throughout the week and call the model only when you have the sales data of a whole week. A collection of data points is referred to as a batch. 