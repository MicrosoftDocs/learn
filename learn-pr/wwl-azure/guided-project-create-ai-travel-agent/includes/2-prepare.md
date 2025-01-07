This module is a guided project where you use Visual Studio Code to develop a proof-of-concept artificially intelligent travel assistant. The project demonstrates how the Semantic Kernel SDK can interface with a large language model (LLM) to process and retrieve information, and integrate native code to perform specialized tasks. In this project, you develop the functionality to assist users with their travel plans. Let's start by setting up your development environment!

## Project overview

In this project, you apply what you learned about the Semantic Kernel SDK. The AI Travel Agent project uses Visual Studio Code to simulate a travel agent that performs tasks such as destination recommendation, currency conversion, and more. This project demonstrates how the Semantic Kernel SDK can be used to create artificially intelligent agents that can automate custom tasks. 

## Setup

Use the following steps to prepare for the Guided Project exercises:

> [!IMPORTANT]
> You must have .NET Framework 8.0 installed and a Github account to complete these steps.

1. Open Visual Studio Code

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**

1. In the URL bar, enter `https://github.com/MicrosoftLearning/APL-2005-Guided-Project.git`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop

1. Click the **Select as Repository Destination** button

    You need to be signed in to GitHub to successfully clone the project

1. Open the project in Visual Studio Code

1. In Explorer, right-click the **AITravelAgent/Starter** folder and click **Open in Integrated Terminal**

1. Expand the **Starter** folder

    You should see a "Plugins" folder, a "Prompts" folder, and "Program.cs" file.

1. Open the **Program.cs** file and update the following variables with your Azure OpenAI Services deployment name, API key, endpoint

    ```csharp
    string yourDeploymentName = "";
    string yourEndpoint = "";
    string yourKey = "";
    ```

    > [!NOTE]
    > The deployment model must be "gpt-35-turbo-16k" for some of the Semantic Kernel SDK features to work.

Now you're ready to begin the Guided Project exercises. Good luck!
