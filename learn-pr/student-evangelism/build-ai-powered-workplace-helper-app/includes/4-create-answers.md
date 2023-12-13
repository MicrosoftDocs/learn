You created a chatbot that provides helpful information quickly that would take a long time to find otherwise. However, in an emergency, we must provide specific information quickly. In this section, you'll add Copilot Studio Topics to answer emergency-related questions. 

## Specifications

- Create a topic to deal with emergency-related questions.
- The topic should trigger on the words "fire", "police", "ambulance", and "emergency."
- When the topic is triggered, it should provide relevant local contact numbers for fire, police, and ambulance services (for example, 000, 911, or 111). The topic should list the street address of the building so it can be provided to authorities.
- For building-related emergencies, provide a contact number for the building manager.
- After providing the above contact information, add a node to your conversation flow that uses generative answers to provide other related information from the uploaded data sources.
  - When you add a new node, select **Advanced menu** then select **Generative Answers**.
  - Next, set the Input. In the **System** tab, select the **LastMessage.Text** variable.
- After it's set up, publish your Chatbot so it can be used in your Power App.

### Use Copilot

When you add a topic, you can add it blank or use Copilot to help build your solution. To use Copilot to build your topic flow:

1. Select the Copilot option.
1. Assign a topic name.
1. Describe what this topic helps users do and the kind of question you want it to answer.

Once the topic is generated, you can edit it.

## Check your work

To validate that you have satisfied the requirements for the second exercise, test your app behavior by following these steps:

1. Make sure your bot is saved.
1. Select **Test Your Bot**.
1. Ask your bot what you should do if there's a fire. Make sure that it provides both the specified answers and generative answers.
1. Ask your bot what the evacuation process is. Does it provide only generative answers?
1. Ask your bot other questions within the scope of its knowledge and see if it only provides generative answers.

For more information on Generative Answers Nodes, see this documentation [Generative Answers with Search and Summarize Content](/microsoft-copilot-studio/nlu-boost-node)
