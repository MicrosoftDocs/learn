In this exercise, we learn how to deploy an Azure API Management instance. To showcase the capabilities of Azure API Management, we deploy an Azure Sample containing features like load balancing, circuit breakers, and token-based rate limiting.

> [!NOTE] 
> Ensure you have the following installed before you begin:
> [Azure Development CLI](/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows), azd

## Clone the repo

Open up a terminal and run:

```bash
git clone https://github.com/Azure-Samples/genai-gateway-apim.git
```

Once the repo is cloned, navigate to the `genai-gateway-apim` directory and let's deploy it:

## Deploy the Azure sample

Before we can deploy the Azure sample, we need to authenticate with Azure. Run the following command:

```bash
az auth login
```

At this point, you should be taken to a browser window where you can authenticate with Azure. When done authenticating, can close the browser window and return to the terminal. The terminal should also display a message that you're successfully authenticated.

Let's now deploy the Azure sample. Run the following command:

```bash
azd up
```

This command should take a few minutes to complete. Once done, you should see a message that the deployment was successful.

## Run sample

At this point, the resources are created in Azure and you should also have a `.env` file created populated with the needed values for you to run the sample. It should look something like this:

```bash
APIM_ENDPOINT="<Your APIM Endpoint>"
API_SUFFIX="<Your API Suffix>"
API_VERSION="<Your API Version>"
DEPLOYMENT_ID="<Your Deployment Name>"
SUBSCRIPTION_KEY="<Your Subscription Key>"
```

To run the sample, run the following commands:

```bash
cd src
npm install
npm start
```

Your sample should now be running. You can access it by navigating to `http://localhost:3000`.

You should see a web page with a text box and a button, like so:

:::image type="content" source="../media/azure-api-management.png" alt-text="Screenshot of app with input box and button.":::

Try it out by typing a message to generate a response text from the AI model.

Congratulations, you successfully deployed an Azure API Management instance and can use it to manage your APIs.
