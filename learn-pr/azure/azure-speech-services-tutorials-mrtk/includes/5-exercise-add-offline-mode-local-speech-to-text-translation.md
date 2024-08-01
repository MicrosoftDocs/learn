In this module, you'll add the ability to execute commands using Azure speech recognition, which allows you to make actions happen based on the word or phrase you define.

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Wake Word Recognizer (Script)** component to the Lunarcom object and configure it as follows:

    * In the **Wake Word** field, enter a suitable phrase; for example: _Activate terminal_.
    * In the **Dismiss Word** field, enter a suitable phrase; for example: _Dismiss terminal_.

    :::image type="content" source="../media/wake-word-recognizer.png" alt-text="Screenshot of Unity editor with Lunarcom Wake Word Recognizer script component highlighted." lightbox="../media/wake-word-recognizer.png":::

2. If you enter Game mode (as in the previous exercise) the terminal panel is enabled by default, but you can now disable it by saying the Dismiss Word, **Dismiss terminal**:

    :::image type="content" source="../media/speech-recognizer-feature.png" alt-text="Screenshot of Unity editor in play mode with speech recognizer feature in use" lightbox="../media/speech-recognizer-feature.png":::

3. You can enable the terminal panel again by saying the Wake Word, **Activate terminal**:

    :::image type="content" source="../media/active-terminal.png" alt-text="Screenshot of Unity editor in play mode with active terminal." lightbox="../media/active-terminal.png":::

    > [!CAUTION]
    > The application needs to connect to Azure, so make sure your computer/device is connected to the internet.
