After you've created and tested an inference pipeline for real-time inferencing, you can publish it as a service for client applications to use.

> [!NOTE]
> In this exercise, you'll deploy the web service to an Azure Container Instance (ACI). This type of compute is created dynamically, and is useful for development and testing. For production, you should create an *inference cluster*, which provide an Azure Kubernetes Service (AKS) cluster that provides better scalability and security.

## Deploy a service

1. View the **Predict Diabetes** inference pipeline you created in the previous unit.
2. Select **Job detail** on the left hand pane. This will open up another window. 
    ![Screenshot of job details next to the completed job. ](../media/completed-job-inference.png)
3. In the new window, select **Deploy**.
    ![Screenshot of the deploy button for your Predict Auto Price inference pipeline.](../media/deploy-screenshot.png)
4. At the top right, select **Deploy**, and deploy a **new real-time endpoint**, using the following settings:
    -  **Name**: predict-diabetes
    -  **Description**: Classify diabetes
    - **Compute type**: Azure Container Instance
5. Wait for the web service to be deployed - this can take several minutes. The deployment status is shown at the top left of the designer interface.

## Test the service

1. On the **Endpoints** page, open the **predict-diabetes** real-time endpoint.
    ![Screenshot of the location of the Endpoints option on the left-hand pane.](../media/endpoints-screenshot.png)
2. When the **predict-diabetes** endpoint opens, select the **Test** tab. We will use it to test our model with new data. Delete the current data under **Input data to test real-time endpoint**. Copy and paste the below data into the data section:  

```JSON
{
  "Inputs": {
    "WebServiceInput0":
      [
        { "PatientID": 1882185,
          "Pregnancies": 9,
          "PlasmaGlucose": 104,
          "DiastolicBloodPressure": 51,
          "TricepsThickness": 7,
          "SerumInsulin": 24,
          "BMI": 27.36983156,
          "DiabetesPedigree": 1.3504720469999998,
          "Age": 43 }
        ]
      },
  "GlobalParameters":  {}
}
```

> [!NOTE]
> The JSON above defines features for a patient, and uses the **predict-diabetes** service you created to predict a diabetes diagnosis.

3. Select **Test**. On the right hand of the screen, you should see the output **'DiabetesPrediction'**. The output is 1 if the patient is predicted to have diabetes, and 0 if the patient is predicted not to have diabetes.  

    ![Screenshot of the Test pane.](../media/test-interface.png)

    You have just tested a service that is ready to be connected to a client application using the credentials in the **Consume** tab. We will end the lab here. You are welcome to continue to experiment with the service you just deployed. 