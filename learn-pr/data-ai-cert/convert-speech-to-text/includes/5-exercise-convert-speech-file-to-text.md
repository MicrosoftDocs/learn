# Exercise - Convert Speech from and Audio File to Text

In this exercise, you will make use of the Speech Service you created earlier.  This exercise does not require any configuration on your local computer for a development environment as we will use Visual Studio Code Online.  The steps will detail what is required to get the online environment configured correcly, tasks that will be required for each exercise to work correctly.   All resources are stored in a GitHub repo that you will link to during the exercise steps.

::: zone pivot="python"

1. Start by opening a browser tab or window and navigating to Visual [Studio Code Online](https://visualstudio.microsoft.com/services/visual-studio-online/)

[!NOTE] At this time, Safari is not a suppored browser for the preview of VS Code Online

2. You will require an Azure subscription to create an environment for Visual Studio Code Online
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop down at the top of the page.
1. Select **Create Environment**
1. Select your Subscription in the Select Billing pane and choose a location for the service.
1. Select Create.
1. Once your plan is created, you can then create you first environment.  
1. If the Create Environment panel does not open automatically, simply select **Create environment**.
1. Enter an environment name of your choosing, example **SpeechToTextPython"
1. Copy the following URL and past it into the Git Repository area on the Create Environment panel, https://github.com/MicrosoftLearning/AI-SpeechToText
1. Leave the rest of the settings at their default and select Create.
1. It will take a few minutes for the environment to be created so while you wait, go to your Speech service in the Azure portal and copy one of your keys, and also note the region where the service was created.
1. Once teh environment indicates that it is available, either select the title or select the three vertical dots in the lower right of the environment box and choose Connect.
1. VS Code Online will now synchronize the GitHub repo and run the scripts that were present in the .devcontainer.  This is required to setup the proper Python environment, in this case 3.5.3
1. If you get any messages about installing additional extensions or components, choose to do so.  This is only for your local system and is not required to run the code in the online environment.
1. Select the speechtotext.py file in the explorer pane.
1. Locate the spech_keu, service_region line in the file and paste your key into the proper spot and set the region to where you created your Speech Service, such as **westus**.
1. You will need to add a package for the Cognitive Services speech functions so open a terminal window in VS Code Online and paste the following command in the terminal window, and hit Enter to add the package, *sudo pip install --upgrade azure-cognitiveservices-speech*
1. Locate the **Run Python File in Terminal** button in the upper right corner of VS Code Online and select it to run the code.
1. The result of the speech to text transcription is displayed in the terminal windoww.  Feel free to download the narration.wav file from the GitHub repo if you want to hear the audio that was used.
1. You can also upload your own audio file to the repo, sync VS Code Online with the repo, change the audio_filename option and run it again.

::: zone-end

::: zone pivot="csharp"

1. Start by opening a browser tab or window and navigating to Visual [Studio Code Online](https://visualstudio.microsoft.com/services/visual-studio-online/)

[!NOTE] At this time, Safari is not a suppored browser for the preview of VS Code Online

2. You will require an Azure subscription to create an environment for Visual Studio Code Online
1. Select the **Get started** button.
1. Sign in using your Microsoft Account that is linked to your Azure subscription
1. If this is the first time you have used Visual Studio Code online, you will be required to create a new plan, which should be selected in the drop down at the top of the page.
1. Select **Create Environment**
1. Select your Subscription in the Select Billing pane and choose a location for the service.
1. Select Create.

::: zone-end
