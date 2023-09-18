


To build your final solution you'll use a combination of different Azure services. Also, you'll need an IDE, like Visual Studio Code, to write, test your code and deploy it to the Cloud. In this section, you'll learn what you need to set up your project development environment.

## Project specification
Your customer asked you to develop a web application that integrates computer vision capabilities that can be used by its employees while developing new content. The application will allow users to analyze an existing image and generate a new one from a text description.

You'll use [Azure AI Vision](https://learn.microsoft.com/azure/ai-services/computer-vision/overview?WT.mc_id=academic-105496-cacaste) and [Azure OpenAI](https://learn.microsoft.com/azure/ai-services/openai/overview?WT.mc_id=academic-105496-cacaste) cognitive services to implement the required functionalities. Also, you'll use the [React JavaScript framework](https://react.dev/) to develop the web application and [Azure Static Web App](https://learn.microsoft.com/azure/static-web-apps/overview?WT.mc_id=academic-105496-cacaste) to host it on the Cloud and ensure continuous integration and delivery (CI/CD) of your code.

## Set up
You need an Azure subscription with Azure OpenAI enabled to complete this challenge. As part of Microsoft's commitment to responsible AI, access to Azure OpenAI service is currently limited to a set of Azure customers requesting it in advance, by filling out [this form](https://customervoice.microsoft.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR7en2Ais5pxKtso_Pz4b1_xUOFA5Qk1UWDRBMjg0WFhPMkIzTzhKQ1dWNyQlQCN0PWcu). If your application doesn't match the [acceptance criteria](https://learn.microsoft.com/legal/cognitive-services/openai/limited-access?context=%2Fazure%2Fcognitive-services%2Fopenai%2Fcontext%2Fcontext&WT.mc_id=academic-105496-cacaste), you can rely on the [OpenAI public APIs](https://platform.openai.com/docs/api-reference/introduction) to build your prototype.
Not sure what's the difference between the two services? Learn more [here](https://learn.microsoft.com/azure/cognitive-services/openai/overview#comparing-azure-openai-and-openai/?WT.mc_id=academic-105496-cacaste).

### Prerequisites
1. Create an Azure subscription. If you're a student you can benefit from a [free Azure for students subscription](https://azure.microsoft.com/free/students/?WT.mc_id=academic-105496-cacaste). If you're not a student, you can still sign up for a [free Azure trial](https://azure.microsoft.com/free/?WT.mc_id=academic-105496-cacaste). 
2. Install [Visual Studio Code](https://code.visualstudio.com/), [Node.js and npm](https://nodejs.org/) to develop and run your application locally.
3. Install [Azure Static Web Apps VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps&WT.mc_id=academic-105496-cacaste) and create a [GitHub account](https://github.com/) to deploy your application to Azure Static Web Apps and set up a CI/CD pipeline.

