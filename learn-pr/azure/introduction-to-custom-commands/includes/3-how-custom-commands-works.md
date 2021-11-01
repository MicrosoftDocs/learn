Custom Commands requires an Azure account and a Speech service resource. The subscription has free and standard pricing tiers and provides an endpoint and subscription key for you to access the service.

## Speech Studio

Creating a new Custom Command Voice Assistant app takes less than 10 minutes with the Speech Studio, as the low-code solution makes it easy to iteratively add commands, parameters and test your application’s behavior. To start a new project, go to the Speech Studio portal, sign into the portal, and select **Custom Commands** and **New Project.** From there, fill in the form, or follow the example below to create a basic command and control voice assistant application that will control lights in your house.

The link to the Speech Studio Portal can be found in the Unit 6 – Summary. Below we see the Speech Studio WebUI:

:::image type="content" source="../media/3-speech-studio.png" alt-text="Screenshot showing the web user interface for the Azure speech studio for custom commands." lightbox="../media/3-speech-studio.png":::

A **LUIS** authoring service is required for the app to understand the queries and commands sent to the assistant. The LUIS model has multiple pricing tiers but requires a standard tier prediction resource to process speech inputs in your final published app. If you only want to train and test your app, then the free LUIS authoring resource is sufficient.

:::image type="content" source="../media/3-speech-studio-2.png" alt-text="Screenshot showing how to select prediction resource in the Azure speech studio." lightbox="../media/3-speech-studio-2.png":::

### Creating commands

Once you have set up your portal access, commands can then be created via the Speech Studio UI.
To create a custom command, you’ll need to provide:

* **Example sentences** that can trigger this command, such as “turn off, turn on, or change to”
* **Parameters** are the information needed to complete the command, in this case:
    * What the function is once a command is triggered, like turning the device on or off
    * Subject context to determine specific devices, for example, the bathroom air conditioning unit
    * Parameters can also be used to define *conditions* that trigger custom actions.
* **Completion rules** are actions that must be taken after the command is ready to be fulfilled, such as:
    * *Confirmation response*, once the device is turned on or off, respond with a voice assistant line
* **Interaction rules**, which we don’t use here, but can be used to handle more specific or complex situations
    * Confirmation requests or multi-device interactions can be defined here

To get started, select **New command** in the top-left pane. You will then be required to add example sentences and phrases to activate the command. In the example below, we have created turn on/off commands and added example sentences used to train the LUIS model for your project, and eventually trigger actions you specify.

:::image type="content" source="../media/3-creating-commands.png" alt-text="Screenshot showing example sentences for custom commands in the Azure speech studio." lightbox="../media/3-creating-commands.png":::

### Configuring commands

Once you have created your example sentences, you'll need to set up your parameters.

Here, we’ve set parameters to define the function of turning on and off the lights, which devices are selected with *SubjectDevice*, and what parts of the device or system are controlled with the *SubjectContext* parameter. The image below shows the SubjectContext parameters with different rooms around the house as predefined input values.

:::image type="content" source="../media/3-configuring-commands.png" alt-text="Screenshot showing parameter examples for custom commands in the Azure speech studio." lightbox="../media/3-configuring-commands.png":::

In addition to parameters, you can also set *conditions.* **Conditions are the requirements that must be met for a rule to execute.** In the example below, we can see the conditions are:

* Do we want the lights on or off
* What _SubjectContext_ is chosen: which room do we want to turn on the lights-such as the bedroom, bathroom, or all
* What _SubjectDevice_ is chosen: the device is the smart lightbulbs.

If we wanted to add more smart devices from the house to our Custom Commands, we could add new SubjectDevice parameters to specify the conditions.

:::image type="content" source="../media/3-configuring-commands-2.png" alt-text="Screenshot showing completion rules for custom commands in the Azure speech studio." lightbox="../media/3-configuring-commands-2.png":::

As previously mentioned, you can also create completion rules.

In the image below, we can see the completion rule set as the action **send speech response,** which is a voice response by the Custom Commands assistant. This action can have multiple voice responses depending on which parameters and conditions are met.

So if a user requested, “turn **on all** the **lights**,” we would see the conditions of the completion rules met with the parameters, onoff parameter=**”on”**, SubjectContext=**”all”**, and SubjectDevice=**”lights”**.

This would trigger the specified actions—in this case, the system would send a speech response action, “OK, turning all the lights on,” and then turn on all the lights in the house.

:::image type="content" source="../media/3-completion-rules.png" alt-text="Screenshot showing completion rules for custom commands in the Azure Speech Studio." lightbox="../media/3-completion-rules.png":::

### Testing your commands

Once you have created your command, you can **train and test** the behavior of your application in the Studio to see if it works as intended. If you require more detail, you can select **turn details** for more information on how the voice input was processed.

![Screenshot showing an example of testing your custom commands application in the Azure speech studio.](../media/3-testing-commands.png)

While the commands or functions given to the voice assistant can be complex, one of the major strengths of Custom Commands is the sequential and straightforward nature of the development process. Users can test the voice assistant functionality quickly, and incrementally add further control to their smart devices as the need arises.

### Testing  voice assistants

The Windows Voice Assistant Client is a C# application that makes it easy to test interactions with your bot before creating a custom client application. It demonstrates how to use the Speech SDK to manage communication with the voice assistant and detailed diagnostic information to fine-tune your app.

The client application connects to the Custom Commands service that hosts your dialog, allowing testing and troubleshooting through the **activity log** and **activity payload.** With these client logs, you can see the input information, your apps interpretation of the command, and system responses in detail, as shown below:

![Screenshot showing an example of creating a Windows voice assistant.](../media/3-windows-voice-assistant.png)

## Integrating / implementing  Custom Commands

The voice assistants can be exposed via Web endpoints to send custom activities to devices and applications, including with other Azure Cognitive Services. Remote Skills allow Custom Commands to be exposed as skills for Azure Bot Framework.

Below is an overview of the workflow to integrate your Custom Commands app into a client application:

:::image type="content" source="../media/3-custom-commands-workflow.png" alt-text="Diagram showing the workflow of the custom commands application." lightbox="../media/3-custom-commands-workflow.png":::

## Custom voice

Another way to customize Custom Commands responses is to select an output voice. This customization feature provides developers with the ability to change the voice to a unique custom voice, as part of the capability from the Speech Service SDK. A custom voice is a variation of the artificial human-like voice that is produced by Azure’s neural networks and is known as a Neural Voice. With the Speech Studio’s *custom neural voice project*, Neural Voices can be customized to imitate your audio training data's pitch, tone, rhythm, and pronunciation. This feature enables your voice assistant to sound like your preferred gender presentation, age, or brand persona.

In the image below, we can see the Custom voice page found in the **settings** on the Speech Studio. Here we can adjust your assistant’s language spoken and voice—including pre-built voices or your own Custom voice model.
