> [!Note]
> **Sarah: Action items**
> 
> - Code block says "See Prerequisites." These will need to be defined and maybe add a link.
> - Need output cell content. Search on TBD.
>

The `azureml` package is installed by default with Azure Notebooks, so we don't have to worry about that. It uses an Azure ML Studio workspace ID and authorization token to connect your notebook to the workspace. You will obtain the ID and token by following these steps:

1. Open [Azure ML Studio](https://studio.azureml.net/?azure-portal=true) in a new browser tab and sign in with a Microsoft account. Azure ML Studio is free and does not require an Azure subscription. After you sign in with your Microsoft account (the same credentials that you used for Azure Notebooks), you're in your "workspace."

1. On the left, select **Settings**.

   :::image type="content" alt-text="In Azure ML Studio, select Settings." source="../media/azure-ml-studio-select-settings.png" loc-scope="azure":::

1. Open the **Name** tab. The **Workspace ID** field contains your workspace ID. Copy the ID value into the `workspace_id` value in the code cell shown in the last step.

   :::image type="content" alt-text="In Azure ML Studio, under Settings, on the Name tab, select the value in the Workspace ID field." source="../media/azure-ml-studio-workspace-identifier.png" loc-scope="azure":::

1. Open the **Authorization Tokens** tab. The tab shows two authentication tokens. Copy either token value into the `authorization_token` value in the code cell shown in the last step.

   :::image type="content" alt-text="In Azure ML Studio, under Settings, on the Authorization Tokens tab, select one of the token values." source="../media/azure-ml-studio-authorization-tokens.png" loc-scope="azure":::

1. Run the following code cell. If it runs without error, you're ready to continue.

   ```Python
   from azureml import Workspace

   # Replace the values with those from your own Azure ML Studio instance. See the Prerequisites.
   # The workspace_id is a string of hexadecimal characters. The token is a long string of random characters.
   workspace_id = 'your_workspace_id'
   authorization_token = 'your_auth_token'

   ws = Workspace(workspace_id, authorization_token)
   ```

   ```Output
   TBD
   ```
