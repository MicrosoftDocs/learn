GPT-3, GPT-3.5, and GPT-4 models from OpenAI are prompt-based. With prompt-based models, the user interacts with the model by entering a text prompt, to which the model responds with a text completion. This completion is the model's continuation of the input text.

You input some text as a prompt, and the model generates a text completion that attempts to match whatever context or pattern you gave it. For example, if you give the AI the prompt, "As Descartes said, I think, therefore", it returns the completion " I am" with high probability.

At a practical level, the prompt-based models allow you to develop applications that enable users to ask questions of your data as free-form text and the model responds with the answer.

For example, imagine you work for an e-commerce company that sells pet products. You have thousands of products and these products contain multiple user-submitted reviews. You would like to use AI help your customer service team reduce the amount of time they spend extracting insights from these reviews and localizing them. The customer service team could ask questions such as "Which brand of dog food have customers complained that their dogs won't eat?", and the model returns an answer based on the reviews.

Let's take a deeper look at text completions, how to improve completion quality, and build a simple application that can use Azure OpenAI to answer questions about our data.
