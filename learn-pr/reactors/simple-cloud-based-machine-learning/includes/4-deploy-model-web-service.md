This part is important. After your model is deployed as a web service, it can be accessed from anywhere. Instead of refitting a model every time you need a new prediction for a business or humanitarian use case, you can send the data to the pre-fitted model and get back a prediction.

1. Select the model that you want to deploy. In this case, we'll deploy the most accurate model, **VotingEnsemble**. Select **Deploy**.

   :::image type="content" alt-text="Select the run to deploy" source="../media/best-run-details.png" loc-scope="azure":::

1. Name the deployment, and make sure you select **ACI** (Azure Compute Instance).

   :::image type="content" alt-text="Name the deployment" source="../media/best-run-deploy.png" loc-scope="azure":::

1. Now you can access the REST API endpoint created for you by viewing **Endpoints**.

   > [!NOTE]
   > It might take a few minutes for the endpoint to be created.

   :::image type="content" alt-text="View the REST API endpoint" source="../media/rest-api-endpoint.png" loc-scope="azure":::
