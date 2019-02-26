Let’s look at how we can use LUIS to add some natural language capabilities. LUIS allows you to map natural language utterances (words/phrases/sentences the user might say when talking to the bot) to intents (tasks or actions the user wants to perform). For our application, we might have several intents: finding pictures, sharing pictures, and ordering prints of pictures, for example. We can give a few example utterances as ways to ask for each of these things, and LUIS will map additional new utterances to each intent based on what it has learned.

> [!NOTE]
> This is an optional exercise. If you want to use a LUIS service tied to your Azure account for testing, you can follow these steps to create the LUIS service. If you want to use a test environment only, jump to the LUIS App exercise on this page.

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the portal, click **Create a resource** in the left sidebar, enter LUIS in the search box, and press Enter.
1. Select **Language Understanding**.
1. Click **Create**.

![Click Create to create a LUIS service](../media/3-create-luis-service-create.png)

1. Enter a unique name for your LUIS service, choose a subscription, select a location close to you.
1. Select the **S0** pricing tier for this service.
1. Create a new Resource Group called **LearnRG**.
1. Click **Create**.

Once the deployment has succeeded, go the resource page for the service. You'll need one of the displayed keys in later exercises.

## Create a LUIS App

Next, we'll create the LUIS application. Azure requires you to create the LUIS app in the geographic location that maps to where you created the service. Select one of the following URLs, based on the location in which you created your LUIS service in the previous steps, and open it in a new browser window.  Even if you didn't create the service in the optional exercise, it's best to use the location closest to you.

[North America](https://www.luis.ai/),
[Europe](https://eu.luis.ai/),
[Australia](https://au.luis.ai/)

1. Click the **Sign in** link in the right corner.
1. Sign in with your Microsoft Account.
1. On the Welcome page, click **Create a LUIS app now**.
1. Give your LUIS app a name, for example "PictureBotLUIS".
1. Select the Culture.
1. Give your app a description so it's clear what the purpose of the LUIS app is.
1. Click **Done** and the App will open to the Intents page with a single Intent called None.  

You'll enter Intents, Entities, and Utterances in the following exercises.