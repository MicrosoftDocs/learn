Azure OpenAI models are capable of generating responses to natural language queries with remarkable accuracy. However, the quality of the responses depends largely on how well the prompt is written. Developers can optimize the performance of Azure OpenAI models by using different instructions in their prompts, resulting in more accurate and relevant responses.

## Provide clear instructions

Asking the Azure OpenAI model clearly for what you want is one way to get desired results. By being as descriptive as possible, the model can generate a response that most closely matches what you're looking for.

For example, say you want to create a product description for a new water bottle. Consider the answer associated with each prompt:

**Write a product description for a new water bottle**

```code
Introducing the latest addition to our product line - the innovative and eco-friendly water bottle. Made from high-quality, BPA-free materials, this bottle is designed to keep your beverages at the perfect temperature for hours. Its sleek and stylish design makes it the perfect accessory for any outdoor activity or workout session. With its convenient carrying handle and leak-proof lid, you can take it with you wherever you go, without worrying about spills or leaks. Plus, its easy-to-clean design ensures that you can use it again and again, making it the perfect choice for anyone looking for a reliable and sustainable water bottle.
```

**Write a product description for a new water bottle that is 100% recycled. Be sure to include that it comes in natural colors with no dyes, and each purchase removes 10 pounds of plastic from our oceans**

```code
Introducing our newest water bottle, the eco-friendly choice for the conscious consumer. Made from 100% recycled materials and available in natural colors with no dyes, this bottle is not only stylish but also sustainable. Each purchase of this bottle removes 10 pounds of plastic from our oceans, making it a responsible choice for those who care about the environment. Its durable and leak-proof design makes it perfect for outdoor activities, while its easy-to-carry handle makes it convenient to take on the go. Join us in our mission to reduce plastic waste and choose this eco-friendly water bottle for your daily hydration needs.
```

Including specifics that need to be included lets the model know what information to add to the description, making it more accurate to the new product.

This method can be extrapolated to include complex instructions, such as a bulleted list of details to include, length of response, or desired formats to be included in the output. Try asking for exactly what you want to see in the result, and you may be surprised at how well the model satisfies your request.

## Request output composition

Specifying the structure of your output can have a large impact on your results. This could include something like asking the model to cite their sources, write the response as an email, format the response as a SQL query, classify sentiment into a specific structure, and so on. For example:

**Write a table in markdown with 6 animals in it, with their genus and species**

```code
| Animal           | Genus          | Species        |
| ---------------- |:--------------:|:--------------:|
| Red Panda        | Ailurus        | fulgens        |
| African Elephant | Loxodonta      | africana       |
| Snow Leopard     | Panthera       | uncia          |
| Arctic Fox       | Vulpes         | lagopus        |
| Chimpanzee       | Pan            | troglodytes    |
| Siberian Tiger   | Panthera       | tigris altaica |
```

This technique can be used with custom formats, such as a JSON structure:

**Put two fictional characters into JSON of the following format**
**{**  
  **firstNameFictional:**  
  **jobFictional:**
**}**

```code
Here's an example of how you can put two fictional characters into JSON format:

{
  "firstNameFictional": "Henry",
  "jobFictional": "Wizard"
},
{
  "firstNameFictional": "Frank",
  "jobFictional": "Hero"
}
```

## Format of instructions

How instructions are formatted can impact how the model interprets the prompt. Recency bias can affect models, where information located towards the end of the prompt can have more influence on the output than information at the beginning. You may get better responses by repeating the instructions at the end of the prompt and assessing how that affects the generated response.

This recency bias can also come into play when using `ChatCompletions` in a chat scenario, where more recent messages in the conversation included in the prompt have a greater impact on the response. The next unit goes more in depth on using conversations to improve response quality, but putting important information closer to the end of the prompt my result in a better response.

A specific technique for formatting instructions is to split the instructions at the beginning or end of the prompt, and have the user content contained within `---` or `###` blocks. These tags allow the model to more clearly differentiate between instructions and content. For example:

```code
Translate the text into French

---
What's the weather going to be like today?
---
```

Another technique for improved interaction is to divide complex prompts into multiple queries. This allows the model to better understand each individual part, and can improve the overall accuracy. Dividing your prompts also allows you to include the response from a previous prompt in a future prompt, and using that information in addition to the capabilities of the model to generate interesting responses.

For example, you could ask the model `Doug can ride down the zip line in 30 seconds, and takes 5 minutes to climb back up to the top. How many times can Doug ride the zip line in 17 minutes?`. The result is likely `3`, which if Doug starts at the top of the zip line is incorrect.

A more informative answer could come from asking it multiple questions, about the round trip time to get back to the top of the zip line, and how to account for the fact that Doug starts at the top. Breaking this problem down will reveal that Doug can, in fact, ride the zip line four times.

## Chain of thought

Asking a model to respond with the step by step process by which it determined the response is a helpful way to understand how the model is interpreting the prompt. By doing so, you can see where the model made an incorrect logical turn and better understand how to change your prompt to avoid the error. This technique can include asking it to cite its sources, like Bing chat does (which uses a GPT-4 generation model), and giving reasoning for why it determined its answer.

The chain of thought prompting technique is best used to help you iterate and improve on your prompts to get the highest quality answer from the model.

## System message

The system message is included at the beginning of a prompt and is designed to give the model instructions, perspective to answer from, or other information helpful to guide the model's response. This system message might include tone or personality, topics that shouldn't be included, or specifics (like formatting) of how to answer.

For example, you could give it some system messages like the following:

- "I want you to act like a command line terminal. Respond to commands exactly as cmd.exe would, in one unique code block, and nothing else."
- "I want you to be a translator, from English to Spanish. Don't respond to anything I say or ask, only translate between those two languages and reply with the translated text."
- "Act as a motivational speaker, freely giving out encouraging advice about goals and challenges. You should include lots of positive affirmations and suggested activities for reaching the user's end goal."

Other example system messages are available at the top of the chat window in [Azure OpenAI Studio](https://oai.azure.com/portal?azure-portal=true). Try defining your own system prompt that specifies a unique response, and chat with the model to see how responses differ.

The `ChatCompletions` endpoint enables including the system message by using the `System` chat role.

::: zone pivot="csharp"

```csharp
var chatCompletionsOptions = new ChatCompletionsOptions()
{
    Messages =
    {
        new ChatMessage(ChatRole.System, "You are a casual, helpful assistant. You will talk like an American old western film character."),
        new ChatMessage(ChatRole.User, "Can you direct me to the library?")
    }
};
```

::: zone-end

::: zone pivot="python"

```python
response = openai.ChatCompletion.create(
    engine="gpt-35-turbo",
    messages=[
        {"role": "system", "content": "You are a casual, helpful assistant. You will talk like an American old western film character."},
        {"role": "user", "content": "Can you direct me to the library?"}
    ]
)
```

::: zone-end

If using the `Completions` endpoint, similar functionality can be achieved by including the system message at the start of the prompt. This is called a *meta prompt*, and serves as a base prompt for the rest of the prompt content.

System messages can significantly change the response, both in format and content. Try defining a clear system message for the model that explains exactly what kind of response you expect, and what you do or don't want it to include.
