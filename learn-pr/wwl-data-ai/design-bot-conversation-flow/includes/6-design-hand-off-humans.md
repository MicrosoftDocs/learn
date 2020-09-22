Have you ever used an automated switchboard system when calling customer service?  How long did you last in the navigation nightmare that some switchboards send you on? This experience offers some insight into how users may experience a bot interaction as well. You will likely encounter users who do not want to interact with a bot or any automated system. They want to interact with a person. You should consider, in your user experience design, the bot-to-human handoff.

In the article on bot navigation, we discussed scenarios where the bot didn't know how to respond or was stuck in a conversation flow that wasn't productive. Your design should recognize when these scenarios exist and initiate a smooth transition from the bot to a human.

The Microsoft Bot Framework is an open platform that allows developers to integrate with a variety of agent engagement platforms. Microsoft currently supports two models for agent handoff integration.

## Bot as an agent

In this model, both live agents and bots are connected to an **Agent Hub**. When users engage in a conversation, the bot can handle the interaction as if it was initiated from any supported channel. Escalation to a live agent (human) will result in the bot disengaging from the conversation and the human agent taking over.  The message routing is handled by the agent hub making the implementation relatively simple.

## Bot as a proxy

In this model, an agent hub is still utilized however, the user will engage with the bot initially. Once the bot detects that it is no longer able to help, a message router component in the bot will redirect the conversation to the agent hub.  The conversation is then dispatched to an appropriate agent. Even though the bot has redirected the user, it stays in the loop. You can configure the bot to log the transcript of the conversation as well as continue to provide content to both parties in the conversation (human agent and user).

This model offers the greatest flexibility and control over the bot interactions with the agent hub and users. Your bot can still support a variety of channels to allow for greater reach of the bot experience. You also have more control over how conversations get escalated to the human agents.

## What triggers the handoff

How can your bot determine when it is time to handoff to a human agent? Integration with Language Understanding (LUIS) and the Text Analytics API. LUIS should be carefully considered due to the possibility of misunderstanding a user's intent. Understanding the limitations of LUIS in understanding natural language is key in deciding if it is the right choice.

Integrating the Text Analytics API offers the ability to utilize the sentiment analysis feature. Sentiment analysis evaluates text and will return a score and a label for each sentence passed in. Labels are either negative, neutral, or positive. The accompanying score is a value that ranges from 0 to 1.  Values closer to 0 are more negative while values closer to 1 are more positive. Sentiment analysis also supports a wide [range of languages](https://docs.microsoft.com/azure/cognitive-services/text-analytics/text-analytics-supported-languages).