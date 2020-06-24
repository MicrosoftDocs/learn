This is the important part. Once deployed as a web service, your model can be accessed from anywhere. This means that rather than refit a model every time you need a new prediction for a business or humanitarian use case, you can send the data to the pre-fitted model and get back a prediction.

1. Choose the model that you want to deploy. In this case, we will deploy the most accurate model, **VotingEnsemble**. Select **Deploy**.

   :::image type="content" alt-text="Choose the run to deploy" source="../media/best-run-details.png" loc-scope="azure":::

1. Name the deployment and make sure you choose **ACI** (Azure Compute Instance).

   :::image type="content" alt-text="Name the deployment" source="../media/best-run-deploy.png" loc-scope="azure":::

1. Now you can access the REST API endpoint created for you by viewing **Endpoints**.

   > [!Note]
   > It might take a few minutes for the endpoint to be created.

   :::image type="content" alt-text="View the REST API endpoint" source="../media/rest-api-endpoint.png" loc-scope="azure":::
