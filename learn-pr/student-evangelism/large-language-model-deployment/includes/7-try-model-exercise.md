In this exercise, you use natural language to interact with an Azure OpenAI deployment in the completions playground. 

You might be familiar with natural language generative AI from applications like ChatGPT, but you can use these models for more than chatbots. Let's explore other useful applications of these models.

> [!NOTE]
> To complete this exercise, you need the following:
>
> - An Azure subscription. [Create one for free](https://azure.microsoft.com/free/ai-services).
> - Access to Azure OpenAI in the desired Azure subscription. Currently, access to this service is granted only through applications. Apply for access to Azure OpenAI by completing this form: [https://aka.ms/oai/access](https://aka.ms/oai/access).
> - An Azure OpenAI resource with a model deployed. For more information about model deployment, see [Create and deploy an Azure OpenAI Service resource](/azure/ai-services/openai/how-to/create-resource).
>

Let's get started by opening the [Azure OpenAI completions playground](https://oai.azure.com/portal/playground) and selecting a model deployment.

:::image type="content" source="../media/completions-playground-2.png" alt-text="Screenshot of Azure OpenAI completions playground with the deployment name highlighted in a red box." lightbox="../media/completions-playground-2.png":::

## Extract information

In this example, you'll learn how to extract information by using a prompt that consists of both a sample text and an instruction.

1. Copy and paste the following text into the completions text box:

    ```text
    Extract the person's name, company name, location, and phone number from the text below.

    Hello. My name is Robert Smith. I'm calling from Contoso Insurance, Delaware. My colleague mentioned that you are interested in learning about our comprehensive benefits policy. Could you give me a call back at (555) 346-9322 when you get a chance so we can go over the benefits?
    
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```text
    
    Person: Robert Smith
    Company: Contoso Insurance
    Location: Delaware
    Phone: (555) 346-9322
    
    ```

In this example, you combined a prompt with data to extract information using natural-language instructions. The model extracted the name, company, location, and phone number from the text.

> [!NOTE]
> You can modify the prompt and the source data to extract different information.

## Extract input and format the output

In this next exercise, you'll ask your LLM to organize your text as a table, which shows that LLMs are capable of generating *and* formatting text.

1. Clear the completions text box. Then paste the following text:

    ```text
    
    There are many fruits that were found on the recently discovered planet Goocrux. There are neoskizzles that grow there, which are purple and taste like candy. There are also loheckles, which are a grayish blue fruit and are very tart, a little bit like a lemon. Pounits are a bright green color and are more savory than sweet. There are also plenty of loopnovas which are a neon pink flavor and taste like cotton candy. Finally, there are fruits called glowls, which have a very sour and bitter taste which is acidic and caustic, and a pale orange tinge to them.
    
    Please make a table summarizing the fruits from Goocrux
    
    | Fruit | Color | Flavor |
    | Neoskizzles | Purple | Sweet |
    | Loheckles | Grayish blue | Tart |
    
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```text
    
    | Fruit | Color | Flavor |
    | Neoskizzles | Purple | Sweet |
    | Loheckles | Grayish blue | Tart |
    | Pounits | Bright green | Savory |
    | Loopnovas | Neon pink | Cotton candy |
    | Glowls | Pale orange | Sour/Bitter |
    
    ```

In this example, the model is primed with the desired output format: a header row and a couple of examples.

### Try different formatting: JSON

An LLM can produce a table if you give it some text, but you can also ask an LLM to return the data in JSON format.

1. Clear the completions text box. Then paste the following text:

    ```text
    
    There are many fruits that were found on the recently discovered planet Goocrux. There are neoskizzles that grow there, which are purple and taste like candy. There are also loheckles, which are a grayish blue fruit and are very tart, a little bit like a lemon. Pounits are a bright green color and are more savory than sweet. There are also plenty of loopnovas which are a neon pink flavor and taste like cotton candy. Finally, there are fruits called glowls, which have a very sour and bitter taste which is acidic and caustic, and a pale orange tinge to them.
    
    Please make a table summarizing the fruits from Goocrux, Also make a JSON array summarizing the fruits from Goocrux.
    
    | Fruit | Color | Flavor |
    | Neoskizzles | Purple | Sweet |
    | Loheckles | Grayish blue | Tart |
    
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```json
    
    | Loopnovas | Neon pink | Cotton candy | 
    | Glowls | Pale orange | Sour/Bitter | 
    
    ` { "fruits": [ { "fruit": "Neoskizzles", "color": "Purple", "flavor": "Sweet" }, { "fruit": "Loheckles", "color": "Grayish blue", "flavor": "Tart" }, { "fruit": "Pounits", "color": "Bright green", "flavor": "Savory" }, { "fruit": "Loopnovas", "color": "Neon pink", "flavor": "Cotton candy" }, { "fruit": "Glowls", "color": "Pale orange", "flavor": "Sour/Bitter" } ]
    
    ```

In this example, the model returned a JSON array of the fruits and their attributes in a JSON format. Remember that an LLM can give you both *what* you want and *how* you want it.

## Classify content

In this exercise, you'll use an LLM to sort your content into different categories.

1. Clear the completions text box. Then paste the following text:

    ```text
    
    Classify the following news headline into 1 of the following categories: Business, Tech, Politics, Sport, Entertainment
    
    Headline 1: Donna Steffensen Is Cooking Up a New Kind of Perfection. The internet's most beloved cooking guru has a buzzy new book and a fresh new perspective.
    Category: Entertainment
    
    Headline 2: Major Retailer Announces Plans to Close Over 100 Stores.
    Category:
    
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```text
    
    Headline 2: Major Retailer Announces Plans to Close Over 100 Stores
    Category: Business
    
    ```

In this example, you provided one example of a headline and a category and asked the model to classify a second example. This is an example of "one-shot learning": with just one example, the model can generalize to classify a new example.

> [!NOTE]
> You can change the second headline to generate different categories.
> Here are some example headlines you can try:
>
> - Jets lose, again!
> - Obama announces re-election bid
> - Microsoft up in after-hours trading
> - 20nm process offers more density and better power value
>

## Summarize content

Summarized content can be helpful if you want to quickly understand what a longer block of text says. This capability is built into the LLM.

1. Clear the completions text box. Then paste the following text:

    ```text
    
    At Microsoft, we have been on a quest to advance AI beyond existing techniques, by taking a more holistic, human-centric approach to learning and understanding. As Chief Technology Officer of Azure AI Services, I have been working with a team of amazing scientists and engineers to turn this quest into a reality. In my role, I enjoy a unique perspective in viewing the relationship among three attributes of human cognition: monolingual text (X), audio or visual sensory signals, (Y) and multilingual (Z). At the intersection of all three, there's magic—what we call XYZ-code as illustrated in Figure 1—a joint representation to create more powerful AI that can speak, hear, see, and understand humans better.
    
    We believe XYZ-code will enable us to fulfill our long-term vision: cross-domain transfer learning, spanning modalities and languages. The goal is to have pre-trained models that can jointly learn representations to support a broad range of downstream AI tasks, much in the way humans do today. Over the past five years, we have achieved human performance on benchmarks in conversational speech recognition, machine translation, conversational question answering, machine reading comprehension, and image captioning. These five breakthroughs provided us with strong signals toward our more ambitious aspiration to produce a leap in AI capabilities, achieving multi-sensory and multilingual learning that is closer in line with how humans learn and understand. I believe the joint XYZ-code is a foundational component of this aspiration, if grounded with external knowledge sources in the downstream AI tasks.
    
    TL;DR
    
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```text
    
    At the intersection of monolingual text, audio or visual sensory signals, and multilingual capabilities lies the "XYZ-code," a joint representation allowing for the transfer of learning in AI systems, according to Microsoft's Xuedong Huang. The CTO of Azure AI Services said the company's aim is to create pre-trained models that will enable machines to jointly learn representations and support a broad range of downstream AI tasks.
    
    ```

In this example, you used TL; DR (too long; didn't read) to make the model create a short summary of a larger piece of text.

## Generate novel content

Even though the outputs are generated based on frequency of similar content in the training data, generative AI models are capable of generating novel content that doesn't exist.

1. Clear the completions text box. Then paste the following text:

    ```text
    Write a limerick about the Python programming language
    ```

1. Select **Generate**. Your output should resemble the following text:

    ```text
    There once was a language named Python
    Whose syntax was easy and quite fun
    It could handle big data
    And was used by NASA
    So learn it and you'll be second to none!
    ```

How was the limerick? If you don't like it, you can always ask the completions playground to generate a new limerick by using the blue circular arrow icon.
