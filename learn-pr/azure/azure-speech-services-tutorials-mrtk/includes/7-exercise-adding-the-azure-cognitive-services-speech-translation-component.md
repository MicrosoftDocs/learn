# 7. Exercise: Adding the Azure Cognitive Services speech translation component

In this module, you will add speech translation to your project which will allow you to translate and transcribed your speech into three different languages.

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Translation Recognizer (Script)** component to the Lunarcom object and configure it as follows:

* Change the **Target Language** to a language of your choosing, for example, _German_

![Add the Lunarcom Translation Recognizer (Script)](../media/tutorial3-section1-step1-1.png)

2. If you now enter Game mode, you can test the speech translation by first pressing the satellite button. Then, assuming your computer has a microphone, when you say something, your speech will be translated into the chosen language and transcribed on the terminal panel:

![Test the speech translation](../media/tutorial3-section1-step1-2.png)

> [!CAUTION]
> The application needs to connect to Azure, so make sure your computer/device is connected to the internet.
