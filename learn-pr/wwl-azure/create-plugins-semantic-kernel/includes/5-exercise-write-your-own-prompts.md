For this exercise, you build a prompt that asks the large language model (LLM) to provide a list of helpful phrases in French. You can also test your code with different languages of your choice. Let's get started!

1. Open the Visual Studio Code project you created in the previous exercise.

1. Update your Program.cs file with the following code:

    ```c#
    using Microsoft.SemanticKernel;
    using Microsoft.SemanticKernel.Plugins.Core;

    var builder = Kernel.CreateBuilder();
    builder..AddAzureOpenAIChatCompletion(
        "your-deployment-name",
        "your-endpoint",
        "your-api-key",
        "deployment-model");

    var kernel = builder.Build();

    string language = "French";
    string prompt = @$"Create a list of helpful phrases and 
        words in ${language} a traveler would find useful.";

    var result = await kernel.InvokePromptAsync(prompt);
    Console.WriteLine(result);
    ```

1. Run the code by entering `dotnet run` in the terminal. 

    You should see a response similar to the following output:

    ```output
    1. Bonjour - Hello
    2. Merci - Thank you
    3. Oui - Yes
    4. Non - No
    5. S'il vous plaît - Please
    6. Excusez-moi - Excuse me
    7. Parlez-vous anglais? - Do you speak English?
    8. Je ne comprends pas - I don't understand
    9. Pouvez-vous m'aider? - Can you help me? 
    10. Combien ça coûte? - How much does it cost?
    11. Où est la gare? - Where is the train station?
    ```

    The response comes from the Azure OpenAI model you passed to the kernel. The Semantic Kernel SDK connects to the large language model (LLM) and runs the prompt. You can improve this prompt by adding more specific instructions.

1. Update your prompt to match the following text:

    ```c#
    string prompt = @$"Create a list of helpful phrases and 
        words in ${language} a traveler would find useful.

        Group phrases by category. Display the phrases in 
        the following format: Hello - Ciao [chow]";
    ```

    In this prompt, you provide the LLM with specific instructions to format the response. If you run the new prompt you should see a more detailed response, similar to the following output:

    ```output
    Restaurant Phrases:
    - Water, please - De l'eau, s'il vous plaît [duh loh, seel voo pleh]
    - Check, please - L'addition, s'il vous plaît [lah-di-syo(n), seel voo pleh]
    - Bon appétit - Bon appétit [bohn ah-peh-teet]

    Transportation Phrases:
    - Where is the train station? - Où est la gare? [oo-eh lah gahr]
    - How do I get to...? - Comment aller à...? [ko-mahn tah-lay ah]
    - I need a taxi - J'ai besoin d'un taxi [zhay buh-zwan dunn tah-xee]
    ```

    You can also prompt the LLM to include a specific category of phrases and to consider some background information about the traveler. Let's try it out!

1. Update your prompt to match the following text:

    ```c#
    string language = "French";
    string history = @"I'm traveling with my kids and one of them 
        has a peanut allergy.";

    string prompt = @$"Consider the traveler's background:
        ${history}

        Create a list of helpful phrases and words in 
        ${language} a traveler would find useful.

        Group phrases by category. Include common direction 
        words. Display the phrases in the following format: 
        Hello - Ciao [chow]";
    ```

    Now the LLM can consider the traveler's information when generating the list of phrases. You also added instructions to include common direction words.

    The output might look similar to the following response:

    ```output
    Phrases for dealing with peanut allergy:
    My child has a peanut allergy - Mon enfant a une allergie aux arachides [mon on-fon ah oon ah-lair-zhee oh a-rah-sheed]
    Is there a peanut-free option available? - Y a-t-il une option sans arachide? [ee ah-teel une oh-pee-syon sahn ah-rah-sheed]

    Phrases for directions:
    Turn left - Tournez à gauche [toor-nay ah gohsh]
    Turn right - Tournez à droite [toor-nay ah dwaht]
    ```

In the next exercise, you'll practice assigning personas to the LLM to improve the quality of the responses.

> [!IMPORTANT]
> Be sure not to delete any of the code you wrote so far, you need it for the next exercise.