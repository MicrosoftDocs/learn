Azure OpenAI Service provides REST API access to OpenAI's powerful language models including the GPT-3, GPT-4, and ChatGPT model series. These models can be easily adapted to your specific task including but not limited to content generation, summarization, semantic search, and natural language to code translation.

In addition to the REST API access, a .NET SDK exists to access Azure OpenAI Service. And that's what we will use to build our application. But before building the application, let's learn a bit more about what Azure OpenAI is and what text completions are. Knowing that give us the foundation we need to build amazing applications with AI.

## Azure OpenAI overview

Azure OpenAI Service gives customers advanced language AI with OpenAI GPT-4, GPT-3, Codex, and DALL-E models with the security and enterprise promise of Azure. Azure OpenAI codevelops the APIs with OpenAI, ensuring compatibility and a smooth transition from one to the other.

With Azure OpenAI, customers get the security capabilities of Microsoft Azure while running the same models as OpenAI. Azure OpenAI offers private networking, regional availability, and responsible AI content filtering.

The completions endpoint is the core component of the API service. This API provides access to the model's text-in, text-out interface. Users simply need to provide an input **prompt** containing the English text command, and the model generates a text **completion**.

## Text completions

The completions endpoint can be used for a wide variety of tasks. It provides a simple but powerful text-in, text-out interface to any of the Azure OpenAI models. You input some text as a prompt, and the model generates a text completion that attempts to match whatever context or pattern you gave it. For example, if you give the API the prompt, "As Descartes said, I think, therefore", it returns the completion " I am" with high probability.

The actual completion results you see may differ because the API is stochastic by default. In other words, you might get a slightly different completion every time you call it, even if your prompt stays the same.

This simple, "text in, text out" interface means you can "program" the model by providing instructions or just a few examples of what you'd like it to do. Its success generally depends on the complexity of the task and quality of your prompt. A general rule is to think about how you would write a word problem for a middle school student to solve. A well-written prompt provides enough information for the model to know what you want and how it should respond.

We'll take a look at how to write a good prompt a bit later, but for now let's look at the different types of completions.

## Types of Azure OpenAI completions

As mentioned, you pass in a prompt to the Azure OpenAI API that provides instructions on what you want it to do. And you can make it do things like classify text, generate ideas, or even translate text into emojis.

### Classification

For this first completion type, let's dive deep into how to "program" the model with instructions.

You can tell the model you want it to sort data into predefined categories. This completion type is known as **Classification**.

For example, you can pass instructions, or a prompt, similar to following to the completion API:

```
This is a sentiment classifier

Example: "I loved the new movie!"
Sentiment: Positive

Example: "I hate it when my phone battery dies"
Sentiment: Negative

Example: "My day has been 👍"
Sentiment: Positive

Example: "This is the link to the article"
Sentiment: Neutral

Examples:
1. "I loved the new Batman movie!"
2. "I hate it when my phone battery dies"
3. "My day has been 👍"
4. "This is the link to the article"
5. "This new music video blew my mind"

Examples sentiment ratings:
1: Positive
2: Negative
3: Positive
4: Neutral
5: Positive

Examples:
1. "I can't stand homework"
2. "This sucks. I'm bored 😠"
3. "I can't wait for Halloween!!!"
4. "My cat is adorable ❤️❤️"
5. "I hate chocolate"

Examples sentiment ratings:
1.
```

After showing the API how the examples are classified by sentiment, we then provide it a list of examples and then a list of sentiment ratings with the same number index. The API is able to pick up from the first example how it's supposed to be classified. In the second example, it sees how to apply this to the list. This allows the API to rate five (and even more) examples in just one API call.

You can begin to see how the prompt, or the text passed to the API is the programming language.

### Generation

One of the most powerful yet simplest tasks you can accomplish with the API is generating new ideas or versions of input. You can give the API a list of a few story ideas and it tries to add to that list. We've seen it create business plans, character descriptions and marketing slogans just by providing it a handful of examples.

### Conversation

The API is extremely adept at carrying on conversations with humans and even with itself. With just a few lines of instruction, we've seen the API perform as a customer service chatbot that intelligently answers questions without ever getting flustered or a wise-cracking conversation partner that makes jokes and puns.

### Transformation

The API is a language model that is familiar with a variety of ways that words and characters can be used to express information. This ranges from natural language text to code and languages other than English. The API is also able to understand content on a level that allows it to summarize, convert and express it in different ways.

#### Translation

The API already has a grasp of many languages, such as French, so you do not need to teach it. Instead you just need to provide it enough examples of the translation in the prompt so it understands that it is translating from one language to another.

#### Conversion

In this example we convert the name of a movie into emoji. This shows the adaptability of the API to picking up patterns and working with other characters.

```
Back to Future: 👨👴🚗🕒
Batman: 🤵🦇
Transformers: 🚗🤖
Wonder Woman: 👸🏻👸🏼👸🏽👸🏾👸🏿
Spider-Man: 🕸🕷🕸🕸🕷🕸
Winnie the Pooh: 🐻🐼🐻
The Godfather: 👨👩👧🕵🏻‍♂️👲💥
Game of Thrones: 🏹🗡🗡🏹
Spider-Man:
```

### Summarization

The API is able to grasp the context of text and rephrase it in different ways. For example, the API can take a block of text and create an explanation a child would understand.

### Completion

While all prompts result in completions, it can be helpful to think of text completion as its own task in instances where you want the API to pick up where you left off. For example, if given this prompt, the API will continue the train of thought about vertical farming.

```
Vertical farming provides a novel solution for producing food locally, reducing transportation costs and
```

### Factual responses

The API has a lot of knowledge that it's learned from the data it was trained on. It also has the ability to provide responses that sound real but are in fact made up. There are two ways to limit the likelihood of the API making up an answer.

**1. Provide a ground truth for the API** If you provide the API with a body of text to answer questions about (like a Wikipedia entry) it is less likely to confabulate a response.

**2. Use a low probability and show the API how to say "I don't know"** If the API understands that in cases where it's less certain about a response that saying "I don't know" or some variation is appropriate, it is less inclined to make up answers.

In this example, we give the API examples of questions and answers it knows and then examples of things it wouldn't know and provide question marks. We also set the probability to zero so the API is more likely to respond with a "?" if there's any doubt.

```
Q: Who is Batman?
A: Batman is a fictional comic book character.

Q: What is torsalplexity?
A: ?

Q: What is Devz9?
A: ?

Q: Who is George Lucas?
A: George Lucas is American film director and producer famous for creating Star Wars.
```

## Summary

Azure OpenAI Service provides REST API access to OpenAI's powerful language models including the GPT-3, GPT-4, and ChatGPT model series. It also gives you the security and enterprise features you've come to rely from the Azure cloud.

One of the most useful features from the OpenAI language models is text completion. You pass in a **prompt** or a plain language description of what you want the model to do, and it can perform tasks such as text classification, text generation, or text summarization.

In the next unit, we'll create our .NET application, the Azure OpenAI resource, and complete our first text completion.
