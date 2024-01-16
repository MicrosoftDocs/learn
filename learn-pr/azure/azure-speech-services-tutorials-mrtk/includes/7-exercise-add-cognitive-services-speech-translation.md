In this module, you will add speech translation to your project, which will allow you to translate and transcribe your speech into three different languages.

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Translation Recognizer (Script)** component to the Lunarcom object and configure it as follows:

    * Change the **Target Language** to a language of your choosing, for example: _German_

    :::image type="content" source="../media/translation-recognizer.png" alt-text="Screenshot of Add the Lunarcom Translation Recognizer (Script)." lightbox="../media/translation-recognizer.png":::

2. If you now enter Game mode, you can test the speech translation by pressing the satellite button. Then, when you say something, your speech will be translated into the chosen language and transcribed on the terminal panel:

    :::image type="content" source="../media/test-speech-translation.png" alt-text="Screenshot of Test the speech translation." lightbox="../media/test-speech-translation.png":::

    > [!CAUTION]
    > The application needs to connect to Azure, so make sure your computer/device is connected to the internet.
