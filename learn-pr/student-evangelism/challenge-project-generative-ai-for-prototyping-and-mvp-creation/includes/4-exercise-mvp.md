
We created our protype, which enables us to visualize how our project would look like as well as the tools we would need to bring it to life. In this section, we cover how we can narrow down on the key features for our product and build a Minimal Viable Product. A Minimal Viable Product (MVP) is the simplest version of your product your users can use.

An MVP is a tangible product that you can use to test and validate your prototype with customers.

## Step 1: Use Bing Chat to narrow down your product features

In this step, we will ask Bing Chat to suggest some features we can build for our product.

### Steps

1. Copy the sample prompt provided below and make any edits you want
2. Paste it into Bing chat

### Sample Prompt

> Hey Bing, from what I have shared so far about my idea, I now want to implement and start building. Can you help me narrow down the main features my product should have?

### Sample Response
![Project features](./media/poject-features.png)

_Sure, I can help you narrow down the main features your product should have based on your idea. Based on your summary and UI ideas, I think your product should have the following main features:_

_IoT and AI integration: Your product should be able to connect and communicate with various devices, such as sensors, cameras, drones, and satellites, that can collect data on wildlife and human activities and threats. Your product should also be able to use AI to process and analyze the data, using techniques such as computer vision, natural language processing, machine learning, or deep learning. Your product should also be able to use AI to generate alerts, recommendations, or interventions based on the data and analysis results..._

_I hope these features can help you with your product development. If you have any questions or feedback, please let me know. 😊_

But before we focus on each feature separately, let us ask Bing chat to help identify the tools and services we will need to put this together.

### Sample Prompt on tools/services for our project

> Thanks for the help so far. To successfully implement these features, which tools/ services will I need to get? Please use a list and respond in short bullet points and categorize the tools per feature/ functionality.

### Sample Response on tools/services for our project
![Tools and services to implement our features](./media/tools-for-project.png)

_You’re welcome. Based on the web search results, I can suggest some tools and services that you may need to get for each feature or functionality of your software solution. Here is a list of possible tools and services for each feature or functionality:_

_- IoT and AI integration: You may need to get some hardware devices, such as sensors, cameras, drones, or satellites, that can collect data on wildlife and human activities and threats. You may also need to get some software platforms, such as Arduino1, Apache NetBeans2, or AWS IoT, that can provide IoT and AI development tools, such as IDEs, SDKs, libraries, frameworks, or APIs. You may also need to get some cloud platforms, such as Azure, Google Cloud, or IBM Cloud, that can provide IoT and AI services, such as data storage, processing, analysis, visualization, communication, or action._

_- User interface and experience: You may need to get some UI design tools, such as Adobe XD, Figma, or Sketch, that can help you create and prototype your user interface, such as an app, website, or dashboard. You may also need to get some UI development tools, such as React, Angular, or Vue, that can help you build and deploy your user interface. You may also need to get some UX testing tools, such as UserTesting, Hotjar, or Crazy Egg, that can help you evaluate and improve your user experience._

_- Analytics and machine learning: You will need to leverage the power of AI to analyze and process your IoT data, such as detecting, identifying, and tracking wildlife and human activities and threats. You will need to use the relevant AI tools and services, such as TensorFlow, PyTorch, or Azure Machine Learning, to build and deploy your machine learning models. These tools and services provide the necessary features, such as data preprocessing, model training, testing, and optimization, to enable your AI development._

## Step 2: Select a feature and flesh out more details on implementation

In this step, we select one of the features and brainstorm with Bing Chat how we can have it implemented and the tools we may need. This will start preparing us to understand the workload that is ahead of you to bring this idea to life.

Now let's focus on each feature/ functionality separately.

### Steps for a specific feature

1. Copy the sample prompt provided below and make any edits you want
2. Paste it into Bing chat

### Sample Prompt for a specific feature

> We are building a wildlife AI system. How can we create a dashboard for users to view and manage the data collected? In addition, suggest which tools/ frameworks/ languages we need to successfully build our application. Summarize the response in bullet points.

### Sample Response for a specific feature

_To create a dashboard for users to view and manage the data collected from your wildlife AI system, you can follow these steps:_

_Choose a suitable IoT platform that can handle the data collection, processing, visualization, and device management. [For example, you can use AWS IoT, Azure IoT, Google Cloud IoT, or ThingsBoard](https://bing.com/search?q=tools+and+frameworks+for+IoT+and+AI+development)[1](https://bing.com/search?q=tools+and+frameworks+for+IoT+and+AI+development)._

_Connect your IoT devices, such as sensors, cameras, drones, and satellites, to the IoT platform using the appropriate IoT protocols, such as MQTT, CoAP, or HTTP. [You can use tools like Arduino](https://bing.com/search?q=tools+and+frameworks+for+IoT+and+AI+development)[2](https://www.geeksforgeeks.org/top-iot-tools/)[, Kinoma](https://bing.com/search?q=tools+and+frameworks+for+IoT+and+AI+development)[2](https://www.geeksforgeeks.org/top-iot-tools/)[, or Mainspring](https://bing.com/search?q=tools+and+frameworks+for+IoT+and+AI+development)[2](https://www.geeksforgeeks.org/top-iot-tools/) to build and program your IoT devices..._

![Image showing sample response](./media/sample-response.png)

Bing will give us an overview of the different tools we may need to ensure we successfully implement a product. We can ask Bing for ideas on how we can use this in the project as follows:

> [!NOTE]
>If you're a student, you can have 100USD free Azure credits to use it in your technology. Learn more about it, [at Azure for Studens](https://azure.microsoft.com/free/students/?WT.mc_id=academic-114050-bethanycheum).
> If you're new to azure, you can sign in and try azure for 30-days, register [at Azure free account](https://azure.microsoft.com/free/?WT.mc_id=academic-114050-bethanycheum)

Repeat step 2 for each feature until you have a clear understanding of how you can build the final product.

## Step 4: Now to the exciting part: Building our MVP.

You now have a proper guide to the technical requirements to implement your project. Next step is for you (and your team) to start building. Bing chat has helped us identify tools that you would need to install, so a good flow of events from here would be:

1. Review your sketch designs to ensure that you are clear on what you are building
2. Set up your local or virtual developer environment such as [GitHub Codespaces](https://github.com/features/codespaces?WT.mc_id=academic-114050-bethanycheum) to begin the project

### [Optional] Keep working with Bing chat

Here are some additional ways in you can keep using bang chat throughout your project development cycle. Be creative on how you engage the tool to guide your development or unblock you if you get stuck.

#### Example: Ask help on how to build specific components and on libraries to use

Note: Explore asking Bing chat for some code samples too

#### Sample Prompt on different components/libraries

> Can you guide me on how to create the calendar of emotions on react native?

#### Sample Response on different components/libraries

![Resources for calendar of emotions](./media/emotional-calendar.png)

As a student you have free access to [GitHub Copilot](https://education.github.com/pack?WT.mc_id=academic-114050-bethanycheum), that will be your coding buddy as you bring your MVP to life. You can use GitHub Copilot on various IDEs including Visual Studio, JetBrains, Neovim and Visual Studio Code.

But before you leave to create your awesome project, finish this module to identify more opportunities for you to share your project globally in a global student competition and access founders' programs for additional support to launch your very own startup.

## Step 5: Free deployment services to share your project with others

The purpose of building an MVP is to ensure that you can be able to test and validate your ideas. In addition, it gives you an opportunity to finally put your product to potential customers. We can ask Bing to give us ideas of how we can deploy our product, for example:

### Sample Prompt on deployment

> Part of my solution is a website, and I am also thinking of building my company website. As a student, how can I deploy websites using Microsoft services or free tools to avail this to my users?

### Sample Response on deployment

_I can help you with some options on how to deploy it to final users using Microsoft services or free tools. Here are some possible ways:_

_- You can use Azure Static Web Apps to host your website for free on the Azure cloud platform. Azure Static Web Apps is a service that automatically builds and deploys full stack web apps from a GitHub repository......_

_- You can use Web Deploy to publish your website to an Azure App Service. Web Deploy is a tool that simplifies the migration, management, and deployment of web applications and websites. You can use it to package and deploy your website from Visual Studio or the command line...._

_- You can use GitHub Pages to host your website for free on GitHub. GitHub Pages is a service that allows you to create and publish websites directly from your GitHub repository..._

_I hope these options help you with your deployment. If you need more assistance, please let me know._

## Next Steps

Whether you are building a website, an application or an API there are various tools you can utilize to deploy your solution, be sure to modify the prompt to match your needs. Some additional resources you can use to deploy your solution are:

- [Deploy your company website on Azure using Azure Static Web Apps](https://learn.microsoft.com/training/paths/azure-static-web-apps/?WT.mc_id=academic-114050-bethanycheum)
- [Deploy your web application with Azure using Azure Web Apps](https://learn.microsoft.com/training/paths/deploy-a-website-with-azure-app-service/?WT.mc_id=academic-114050-bethanycheum)
- [Publish your API on Azure](https://learn.microsoft.com/azure/api-management/import-and-publish?WT.mc_id=academic-114050-bethanycheum)
- [Configure a virtual dev environment for all your software engineers – GitHub Codespaces.](https://github.com/features/codespaces?WT.mc_id=academic-114050-bethanycheum)
- [Build a database for your application on Azure.](https://learn.microsoft.com/azure/developer/javascript/database-developer-guide?tabs=MySQL%2Cazure-cli?WT.mc_id=academic-114050-bethanycheum)
