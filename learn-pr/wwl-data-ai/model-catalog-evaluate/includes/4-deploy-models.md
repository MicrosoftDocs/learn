After selecting a model from the catalog, you deploy it to create an accessible endpoint that your applications can use. The Microsoft Foundry portal guides you through the deployment process and provides tools to test your deployed model immediately.

:::image type="content" source="../media/request-endpoint.png" alt-text="Diagram of user question being processed by model deployed to endpoint.":::

## Understand deployment types

Microsoft Foundry supports several deployment types, each offering different characteristics for data residency, scaling, and billing:

**Serverless API** deployments provide a pay-per-call model where you're billed based on token usage. This option requires minimal configuration and scales automatically. It's ideal for applications with variable or unpredictable traffic patterns. Some models require Azure Marketplace subscriptions when using serverless deployment.

**Provisioned** deployments reserve dedicated capacity for consistent, high-volume workloads. You pay for reserved throughput rather than per-token, making costs predictable for applications with steady traffic. This option is best for production applications requiring specific throughput guarantees and consistent latency.

**Managed compute** deployments run models on Azure virtual machines that you configure and manage. You select the VM SKU and instance count, giving you control over the compute resources. Billing combines both hosting costs (VM charges) and inference costs (token processing). This option suits scenarios requiring specific hardware configurations or custom environments.

**Batch** deployments handle cost-optimized processing jobs where latency isn't critical. Submit large batches of requests that process asynchronously. While playground testing isn't available for batch deployments, they offer significant cost savings for non-interactive workloads.

Each model in the catalog indicates which deployment types it supports. Review these options on the model card before beginning deployment.

## Deploy a model

To deploy a model from the Microsoft Foundry portal:

First, navigate to the model you selected in the **Model catalog**. Open the model card to review its specifications and supported deployment types.

Select **Use this model** to open the deployment wizard. This button appears prominently on the model card.

If the model requires an Azure Marketplace subscription (common for models from partners and the community), you see terms of use. Review these terms and select **Agree and Proceed** to accept them. Models sold directly by Azure, such as Azure OpenAI models like GPT-4o-mini, don't require marketplace subscriptions.

Configure your deployment settings:
- **Deployment name**: By default, the system uses the model name. You can modify this to create meaningful names for multiple deployments of the same model. During inference, your code uses this deployment name in the `model` parameter to route requests.
- **Deployment type**: Select from the available options (serverless API, provisioned, managed compute, or batch) based on your requirements and the model's supported types.
- **Connected AI resource**: The portal automatically selects your project's Foundry resource. Select **Customize** if you need to change this connection. For serverless API deployments, ensure your project and resource are in a supported region for the model.

For managed compute deployments, you also configure:
- **Virtual machine SKU**: Choose from supported VM types. You need Azure Machine Learning compute quota for the selected SKU in your subscription.
- **Instance count**: Specify how many instances to deploy for load distribution and redundancy.

If you don't have dedicated quota for managed compute, you can use shared quota by selecting the appropriate checkbox. Shared quota deployments are automatically deleted after 168 hours.

After configuring all settings, select **Deploy**. The deployment process begins, and the portal displays the deployment details page. When deployment completes, your model is ready for use.

## Manage deployed models

After deployment, you manage your models from the **Models + Endpoints** section in the Microsoft Foundry portal. This section displays all model deployments grouped by resource.

From the deployment list, select a specific model to view its details:
- Deployment configuration and status
- Endpoint URL for API access
- Authentication keys or tokens
- Monitoring and usage metrics
- Option to delete or modify the deployment

The deployment details page provides the information your applications need to connect to and use the model.

## Test in the playground

The Microsoft Foundry portal includes interactive playgrounds where you test deployed models immediately, without writing code. From your model's deployment page, select **Open in playground** to launch the chat interface.

The playground pre-selects your deployment, so you can start testing immediately. In the chat interface:

Enter prompts in the message box and observe responses. The playground displays both your input and the model's generated output, helping you understand behavior and quality.

Experiment with different types of prompts to test various capabilities:
- Simple questions to verify basic understanding
- Complex multi-step reasoning problems
- Requests for specific formats or styles
- Edge cases that might reveal limitations

Adjust system messages to guide model behavior. System messages set context, tone, and instructions that apply to all user inputs. For example, you might instruct the model to "respond as a customer service representative" or "provide concise, technical explanations."

Modify parameters like temperature (creativity vs. consistency), max tokens (response length limits), and top-p (nucleus sampling) to fine-tune generation behavior.

Use **View code** to see examples of how to call your deployed model programmatically. The code samples show authentication, endpoint configuration, and request formatting in languages like Python, C#, and JavaScript. You can copy these samples directly into your application.

The playground serves as your development environment for prompt engineering and testing before integrating the model into your application.

## Access models programmatically

When you're ready to integrate the model into your application, you need three key pieces of information from the deployment details:

**Endpoint URL**: The API endpoint where your application sends requests. This URL is specific to your deployment.

**Authentication key**: The secret key or token your application presents to authenticate requests. Treat this as sensitive credentials.

**Deployment name**: The name you specified during deployment, used in the `model` parameter of API requests to route to your specific deployment.

Your application uses these details to construct API requests. The Microsoft Foundry portal provides SDKs and REST API documentation for various programming languages, along with code samples showing request formatting, authentication, and response handling.

With your model deployed and tested, you're ready to integrate it into applications or proceed to more comprehensive evaluation using automated metrics and test datasets.
