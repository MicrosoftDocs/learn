To complete this exercise, you'll need the following:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com](https://azure.microsoft.com?azure-portal=true).
- A Visual Studio Online environment. This provides a hosted instance of Visual Studio Code, in which you'll be able to run the notebooks for the lab exercises. To set up this environment:
   1. Click the button below to create a Visual Studio Online environment. If prompted, sign in using the Microsoft account associated with your Azure subscription.
    2. If you don't already have a Visual Studio Online billing plan, create one. This is used to track resource utilization by your Visual Studio Online environments. Then create an environment with the following settings:
        - **Environment Name**: *A name for your environment - for example, **ai-fundamentals**.*
        - **Git Repository**: MicrosoftDocs/ai-fundamentals
        - **Instance Type**: Standard (Linux) 4 cores, 8GB RAM
        - **Suspend idle environment after**: 120 minutes
    3. Wait for the environment to be created. This will take around a minute.
    4. Wait for another minute or so while the environment is set up for you. It might look like nothing is happening, but in the background we are installing some extensions that you will use in the labs. You'll see the following things happen:
        - A collection of notebook (.ipynb) files will appear in the pane on the left
        - After a few minutes (during which there's no apparent activity, but in the background we're setting up the environment for you), a file named **z REFRESH NOW!** will appear at the bottom of the list of files in the pane on the left. This is your indication that everything has been installed.
    5. After the **z REFRESH NOW!** file has appeared, ***refresh the web page*** to ensure all of the required extensions are loaded and set the color scheme to a light background. Then you're ready to start.
    6. After you have refreshed the web page, you can delete the **z REFRESH NOW** file if you want to. You can also change the color scheme to suit your preference - just click the **&#9881;** icon at the bottom left and select a new **Color Theme**.

> [!div class="nextstepaction"]
> [Launch Visual Studio Online](https://online.visualstudio.com/environments/new?azure-portal=true&name=ai-fundamentals&repo=MicrosoftDocs/ai-fundamentals)