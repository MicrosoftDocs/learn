When you deploy a model to an endpoint to integrate with an application, you can choose to design it for real-time or batch predictions.

The type of predictions you need depends on how you want to use the model's predictions 

To decide whether to design a real-time or batch deployment solution, you need to consider the following questions: 

- How often should predictions be generated?
- How soon are the results needed?
- Should predictions be generated individually or in batches?
- How much compute power is needed to execute the model?

## Identify the necessary frequency of scoring

A common scenario is that you're using a model to score new data. Before you can get predictions in real-time or in batch, you must first collect the new data. 

There are various ways to generate or collect data. New data can also be collected at different time intervals. 

For example, you can collect temperature data from an Internet of Things (IoT) device every minute. You can get transactional data every time a customer buys a product from your web shop. Or you can extract financial data from a database every three months.

Generally, there are two types of use cases:

1. You need the model to score the new data as soon as it comes in. 
2. You can schedule or trigger the model to score the new data that you've collected over time.

:::image type="content" source="../media/frequency.png" alt-text="Diagram showing a visual representation of real-time and batch predictions.":::

Whether you want real-time or batch predictions *doesn't necessarily depend on how often new data is collected*. Instead, it depends on how often and how quickly you need the predictions to be generated. 

If you need the model's predictions immediately when new data is collected, you need real-time predictions. If the model's predictions are only consumed at certain times, you need batch predictions.

## Decide on the number of predictions

Another important question to ask yourself is whether you need the predictions to be generated individually or in batches. 

A simple way to illustrate the difference between individual and batch predictions is to imagine a table. Suppose you have a table of customer data where each row represents a customer. For each customer, you have some demographic data and behavioral data, such as how many products they've purchased from your web shop and when their last purchase was.

Based on this data, you can predict customer churn: whether a customer will buy from your web shop again or not.

Once you've trained the model, you can decide if you want to generate predictions:

- **Individually**: The model receives a *single row of data* and returns whether or not that individual customer will buy again.
- **Batch**: The model receives *multiple rows of data* in one table and returns whether or not each customer will buy again. The results are collated in a table that contains all predictions.

You can also generate individual or batch predictions when working with files. For example, when working with a computer vision model you may need to score a single image individually, or a collection of images in one batch.

## Consider the cost of compute

In addition to using compute when training a model, you also need compute when deploying a model. Depending on whether you deploy the model to a real-time or batch endpoint, you'll use different types of compute. To decide whether to deploy your model to a real-time or batch endpoint, you must consider the cost of each type of compute.

If you need **real-time predictions**, you need compute that is always available and able to return the results (almost) immediately. **Container** technologies like *Azure Container Instance* (ACI) and *Azure Kubernetes Service* (AKS) are ideal for such scenarios as they provide a lightweight infrastructure for your deployed model. 

However, when you deploy a model to a real-time endpoint and use such container technology, the compute is *always on*. Once a model is deployed, you're continuously paying for the compute as you can't pause, or stop the compute as the model must always be available for immediate predictions.

Alternatively, if you need **batch predictions**, you need compute that can handle a large workload. Ideally, you'd use a **compute cluster** that can score the data in *parallel* batches by using multiple nodes. 

When working with compute clusters that can process data in parallel batches, the compute is provisioned by the workspace when the batch scoring is triggered, and scaled down to 0 nodes when there's no new data to process. By letting the workspace scale down an idle compute cluster, you can save significant costs.

## Decide on real-time or batch deployment

Choosing a deployment strategy for your machine learning models may be challenging, as different factors may influence your decision. 

In general, if you need individual predictions immediately when new data is collected, you need real-time predictions.

If you need the model to score new data when a batch of data is available, you should get batch predictions.

There are scenarios where you expect to need real-time predictions when batch predictions can be more cost-effective. Remember that you're continuously paying for compute with real-time deployments, even when no new predictions are generated. 

If you can allow for a 5-10 minutes delay when needing immediate predictions, you can opt to deploy your model to a batch endpoint. The delay is caused in the time it needs to start the compute cluster after the endpoint is triggered. However, the compute cluster will also stop after the prediction is generated, minimizing costs and potentially being a more cost-effective solution.

Finally, you also have to consider the required compute for your model to score new data. Simpler models require less cost and time to generate predictions. More complex models may require more compute power and processing time to generate predictions. Therefore, you should consider how you'll deploy your model before deciding on how to train your model.

