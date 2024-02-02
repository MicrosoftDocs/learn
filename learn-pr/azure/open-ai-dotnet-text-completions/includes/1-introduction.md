The GPT-3.5, and GPT-4 models from OpenAI are prompt-based optimized for conversational interfaces. With prompt-based models, the user interacts with the model by entering a text prompt, to which the model responds with a text or chat completion. This completion is the model's continuation of the input text.

You input some text as a prompt, and the model generates a completion that attempts to match whatever context or pattern you gave it. For example, if you give the AI the prompt, "As Descartes said, I think, therefore", it returns the completion " I am" with high probability.

At a practical level, the prompt-based models allow you to develop applications that enable users to ask questions of the model as free-form text and the model responds with the answer. GPT-3.5 and GPT-4 are even capable of having multi-turn conversations with the users of your application.

For example, imagine you want to build an AI that recommends hikes to people based on the preferences they enter for the hike. The AI could ask them what attributes they are looking for, and then respond based on what they input.

Let's take a deeper look at both text and completions, how to improve completion quality, and build a simple application that can use Azure OpenAI to chat with the model to get hiking recommendations.
