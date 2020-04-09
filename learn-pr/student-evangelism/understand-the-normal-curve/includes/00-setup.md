To complete this exercise, you'll need the following:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com](https://azure.microsoft.com?azure-portal=true).
- A Microsoft Azure Student subscription. If you don't already have one, you can sign up for a Azure for Student Subscription at [https://azure.microsoft.com/free/students](https://azure.microsoft.com/free/students?azure-portal=true).
- A Visual Studio Online environment based on the **MicrosoftDocs/ai-fundamentals** code repository. This provides a hosted instance of Visual Studio Code, in which you'll be able to run the notebooks for the lab exercises.

To set up a Visual Studio Online environment:

1. Open <a href = "https://online.visualstudio.com/environments/new?azure-portal=true&name=MSLearn-DataScience&repo=MSlearnBerkeley/Content" target="_blank" rel="noopener">Visual Studio Online</a> in a new browser tab; and if prompted, sign in using the Microsoft account associated with your Azure subscription.
2. If you don't already have a Visual Studio Online billing plan, create one. Then create an environment with the following settings:
    - **Environment Name**: *A name for your environment - for example, **MSLearn-DataScience**.*
    - **Git Repository**: MSlearnBerkeley/Content
    - **Instance Type**: Standard (Linux) 4 cores, 8GB RAM
    - **Suspend idle environment after**: 30 minutes
3. Wait for the environment to be created. This will take around a minute.
4. Wait for another minute or so while the environment is set up for you. It might look like nothing is happening, but in the background we're installing some components you'll need for the exercise. You'll see the following things happen:
    - A list of notebook (.ipynb) files will appear in the pane on the left.
