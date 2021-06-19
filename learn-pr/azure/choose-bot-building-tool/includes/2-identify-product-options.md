At it's core a bot can be thought of as a web application that has a conversational interface. A user connects to a bot though a channel such as Facebook, Slack, or Microsoft Teams. The bot reasons about input and performs relevant tasks. This can include asking the user for additional information or accessing services on behalf of the user. The bot performs recognition on the user's input to interpret what the user is asking for or saying. The bot generates responses to send to the user to communicate what the bot is doing or has done. Depending on how the bot is configured and how it is registered with the channel, users can interact with the bot through text or speech, and the conversation might include images and video.

In this module, we'll cover three options that your company could use for building bots.

## Power Virtual Agents

Power Virtual Agents lets you create powerful chatbots that can answer questions posed by your customers, other employees, or visitors to your website or service. The You can use the Power Virtual Agents web app to create chatbots using a guided, no-code graphical interface, removing the need for code-based or developer expertise.

Topics inform the bot conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to type. These phrases are matched to a specific topic using built-in natural language understanding. For example, a user might type "Open hours" into your bot—the AI will be able to match that to the Store hours topic and begin a conversation that asks which store the customer is interested in, and then display the hours the store is open.

You can extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using the Bot Framework SDK.

## QnA Maker

QnA Maker is a Azure-based Natural Language Processing (NLP) service that allows you to create a natural conversational layer over your data. It is used to find the most appropriate answer for any input from your custom knowledge base (KB) of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents, in their current form, to your knowledge base. These documents, such as an FAQ, product manual, spreadsheet, or web page, are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs. The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, publish the knowledge base to a working Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

## Bot Framework Composer and Azure Bot Service

