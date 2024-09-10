
Azure AI Personalizer is an Azure AI service that uses *reinforcement learning* to empower your applications to make smarter decisions. Reinforcement learning is a process that enables Azure AI Personalizer to choose the best *action* for a given *context*, aiming to maximize a *reward*:

- **Context**: The total information that represents the state of your app, scenario, or users that might be relevant to making a decision.
    - For instance: Device type (such as laptop, or phone), location, and popular topics of interest of users that visit a site.
- **Actions**: Sets of items that can be chosen, together with specific attributes that describe each item.
    - For example: A set of technology review articles and the topics that are discussed in each article.
- **Reward**: A numerical score ranging between zero and one that indicates whether the decision was bad (zero), or good (one)
    - For instance: A score of one indicates that a user definitely opened a suggested article, and a zero would mean the user didn't open the article.

You use Azure AI Personalizer through the following APIs:

- Your app calls the **Rank API** whenever it needs to make a decision (each call is referred to as an *event*). In each event, your app sends a request in JSON format, describing  a set of actions, a description of each action, and a description the current context. Each event has an *event ID*. Azure AI Personalizer then uses its backend model to decide and return the ID of the best action that maximizes the total average reward.
- Your app then calls the **Reward API** whenever it can provide feedback to help Azure AI Personalizer to learn whether the action ID it returned was valuable. For instance, if a product was purchased successfully by a user after it was suggested to them. You can base the reward score on your own organization's business metrics and objectives, and generate it using rules inside your app or through an algorithm. You then provide your feedback to the API.

## Create an Azure AI Personalizer resource

An Azure AI Personalizer resource is also referred to as an *Azure AI Personalizer learning loop*. You create a resource (learning loop) for each content area or subject domain of your app. For example, if you want to be able to choose the best content for multiple content areas of a specific page in your app, you'd create a learning loop for each individual area.

You can create a resource using the Azure portal or Azure CLI:

### Use the Azure portal to create an AI Personalizer resource

1. In the Azure portal, search for Azure AI services.Then select **Create** under **Personalizer** in the results list.

    :::image type="content" source="../media/create-personalizer-portal.png" alt-text="A screenshot of the Azure portal showing how to create an Azure AI Personalizer resource.":::

1. You select your subscription, resource group, and name for your resource. For pricing tier can choose between the **Free** or **Standard**, depending on your needs.
1. You select **Review + create**, to review your choices, then select **Create** create your resource.
1. You go to your newly created Azure AI Personalizer resource, then in the Keys and Endpoint pane, you copy the **Key** and **Endpoint**:

    :::image type="content" source="../media/copy-key-endpoint.png" alt-text="A screenshot showing the Key and Endpoint pane.":::

### Use the Azure CLI to create a resource

To create a resource using the Azure CLI, do the following:

1. Make sure you're signed into the Azure CLI by running the following command:

    ```bash
    az login
    ```

    > [!TIP]
    > If you're using the Azure Cloud Shell, you won't have to do this.

1. You then create a resource group:

    ```bash
    az group create \
        --name my-personalizer-resource-group \
        --location westus2
    ```

1. Then you create your AI Personalizer resource using the following command:

    ```bash
    az cognitiveservices account create \
        --name my-personalizer-learning-loop \
        --resource-group my-personalizer-resource-group \
        --kind Personalizer \
        --sku F0 \
        --location westus2 \
        --yes
    ```

1. When your resource has been created, the command returns a JSON response that will contain your **endpoint**. You can then run the following command to also get your **key**:

    ```bash
    az cognitiveservices account keys list \
        --name my-personalizer-learning-loop \
        --resource-group my-personalizer-resource-group
    ```

You can then use your endpoint and key to call both the Rank API and the Reward API.