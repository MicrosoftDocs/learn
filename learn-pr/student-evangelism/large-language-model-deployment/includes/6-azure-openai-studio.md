Playgrounds in Azure OpenAI Studio are interfaces that you can use to experiment with your deployed models without needing to create your own client application.

## Completions playground

The completions playground allows you to make calls to your deployed model and adjust its parameters by using a text-in/text-out interface. Select the deployment name of your model under **Deployments**. If you're not sure where to start, you can use the provided examples. When you're more comfortable, you can enter your own prompts.

:::image type="content" source="../media/completions-playground.png" alt-text="Screenshot of the Azure OpenAI Studio completions playground." lightbox="../media/completions-playground.png":::

## LLM capabilities

LLMs have built-in capabilities that you can use without extra training. LLMs can do more than generate new words. They're also capable of the following behavior:

- **Extracting information**: You can provide an LLM with some text and ask it to extract specific pieces of information from that text. For example, if you provide the LLM with this text:

  *"Hello, my name is Robert Smith"*

  Ask it to *extract the person's name* from this text. It returns:

  "Robert Smith"

- **Changing the format of content**: You can provide an LLM with some text and ask it to summarize by using a specific format. For example, if you provide the LLM with this text:

  *"I like the following colors: red, green, and yellow. I also like the following food: macaroni, cheese, and honey"*

  Ask it to summarize what you like, in a table or JSON format. It returns:

  `{ "colors": ["red", "green", "yellow"], "food": ["macaroni", "cheese", "honey"] }`

- **Classifying content**: You can provide an LLM with some text and ask it to classify the content into different known categories or even give it your own categories. For example, if you provide the LLM with this text:

  *"I loved your product it really helped me do what I wanted"*

  Ask it whether this text was negative or positive. It returns:

  "positive"

- **Summarizing content**: You can provide an LLM with a chunk of text and ask it to summarize it for you. For example, if you provide the LLM with this text:

  *"Hey James, I had a fun last weekend with you we spend lots of time playing on the beach. Let's do that again soon! Bye."*

  Ask it to summarize what the person wants from you. It returns:

  "The person is asking James to spend time with them again soon"

- **Generating novel content**: You can ask an LLM to generate new content about nearly anything you could think of. For example, if you ask the LLM to write a haiku about happiness, it returns:

  "The sun sets gently <br>
	Warm breeze whispers through the trees <br>
  Peaceful, happy heart"
