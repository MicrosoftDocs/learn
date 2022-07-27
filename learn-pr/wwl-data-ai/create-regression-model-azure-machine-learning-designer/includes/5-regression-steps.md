You can think of the steps to train and evaluate a regression machine learning model as: 
1. **Prepare data**: Identify the features and label in a dataset. Pre-process, or clean and transform, the data as needed.   
2. **Train model**: Split the data into two groups, a training and a validation set. Train a machine learning model using the training data set. Test the machine learning model for performance using the validation data set. 
3. **Evaluate performance**: Compare how close the model's predictions are to the known labels.  
4. **Deploy a predictive service**: After you train a machine learning model, you need to convert the training pipeline into a real-time inference pipeline. Then you can deploy the model as an application on a server or device so that others can use it. 

Let's follow these four steps as they appear in Azure Designer. 

## Prepare data 
Azure machine learning designer has several pre-built components that can be used to prepare data for training. These components enable you to clean data, normalize features, join tables, and more. 
![Screenshot of designer components that can be used to prepare data.](../media/prepare-data-example.png)

## Train model 
![Screenshot of designer components that can be connected to train a regression model.](../media/train-model-example.png)

It's common practice to train the model using a subset of the data, while holding back some data with which to test the trained model. This enables you to compare the labels that the model predicts with the actual known labels in the original dataset.

The score model component for regression models generates the predicted numeric label value.  

## Evaluate performance 
![Screenshot of a right click on the evaluate model in completed jobs to see evaluation results.](../media/evaluate-model-example.png)

After training a model, it is important to evaluate its performance. There are many performance metrics and methodologies for evaluating how well a model makes predictions. Azure Designer's evaluation metrics are located within the jobs pane.  

- **Mean Absolute Error (MAE)**: The average difference between predicted values and true values. This value is based on the same units as the label, in this case dollars. The lower this value is, the better the model is predicting.
- **Root Mean Squared Error (RMSE)**: The square root of the mean squared difference between predicted and true values. The result is a metric based on the same unit as the label (dollars). When compared to the MAE (above), a larger difference indicates greater variance in the individual errors (for example, with some errors being very small, while others are large).
- **Relative Squared Error (RSE)**: A relative metric between 0 and 1 based on the square of the differences between predicted and true values. The closer to 0 this metric is, the better the model is performing. Because this metric is relative, it can be used to compare models where the labels are in different units.
- **Relative Absolute Error (RAE)**: A relative metric between 0 and 1 based on the absolute differences between predicted and true values. The closer to 0 this metric is, the better the model is performing. Like RSE, this metric can be used to compare models where the labels are in different units.
- **Coefficient of Determination (R<sup>2</sup>)**: This metric is more commonly referred to as *R-Squared*, and summarizes how much of the variance between predicted and true values is explained by the model. The closer to 1 this value is, the better the model is performing.


## Deploy a predictive service  
You have the ability to deploy a service that can be used in real-time. In order to automate your model into a service that makes continuous predictions, you need to create and deploy an inference pipeline.  

#### Inference pipeline 
![Screenshot of the inference pipeline options in the jobs pane.](../media/inference-pipeline-example.png)
To deploy your pipeline, you must first convert the training pipeline into a real-time inference pipeline. This process removes training components and adds web service inputs and outputs to handle requests.

The inference pipeline performs the same data transformations as the first pipeline for *new* data. Then it uses the trained model to *infer*, or predict, label values based on its features. This model will form the basis for a predictive service that you can publish for applications to use.
#### Deployment 
After creating the inference pipeline, you can deploy it as an endpoint. In the endpoints page, you can view deployment details, test your pipeline service with sample data, and find credentials to connect your pipeline service to a client application. 

It will take a while for your endpoint to be deployed. The Deployment state on the **Details** tab will indicate *Healthy* when deployment is successful. 

![Screenshot of the endpoints page for a successfully deployed model.](../media/endpoints-example-1.png)

On the **Test** tab, you can test your deployed service with sample data in a JSON format. The test tab is a tool you can use to quickly check to see if your model is behaving as expected. Typically it is helpful to test the service before connecting it to an application.
 
![Screenshot of the test tab on the endpoints page.](../media/endpoints-example-3.png)

You can find credentials for your service on the **Consume** tab. These credentials are used to connect your trained machine learning model as a service to a client application.

![Screenshot of where to find the key and endpoint on the consume tab.](../media/endpoints-example-2.png)
