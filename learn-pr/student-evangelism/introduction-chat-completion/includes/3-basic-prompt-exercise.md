In this exercise, you use basic prompts to interact with an Azure AI Studio deployment in the chat playground.

Prompts are inputs or queries that you write to get a specific response from a large language model (LLM).

To complete this exercise, you need:

- An Azure subscription. [Create one for free](https://azure.microsoft.com/free/ai-services).
- Access to Azure OpenAI Service in the desired Azure subscription. Currently, access to this service is granted only through applications. Apply for access to Azure OpenAI Service by completing [this form](https://aka.ms/oai/access).
- An Azure OpenAI resource with a model deployed. If you haven't created this resource yet, refer to the previous module before moving on.

In this exercise, you'll:

- Open the Azure AI Studio chat playground.
- Use basic prompts to interact with a deployment.

:::image type="content" source="../media/chat-playground.png" alt-text="Screenshot of Azure AI Studio chat playground with the deployment name highlighted.":::

Let's get started by opening the [Azure AI Studio chat playground](https://oai.azure.com/portal/chat) and selecting a model deployment.

## Explore the chat capabilities by using basic prompts

Here are some examples of prompts to try, but get creative with your own prompts and see what happens!

1. Copy the following text and paste it into the **Chat session** text box.

    ```text
    What is the capital of Australia?
    ```

1. Select the paper plane icon to send your message. You should see an output similar to this text:

    ```text
    The capital of Australia is Canberra.
    ```

1. Copy the following text and paste it into the **Chat session** text box.

    ```text
    A recipe for banana bread, and an itemized shopping list of the ingredients.
    ```

1. Select the paper plane icon to send your message. You should see an output like the following text, which is shortened for brevity:

    ```text
    Here is a recipe for banana bread along with an itemized shopping list of the ingredients:

    Banana Bread Recipe
    Ingredients:
    -   1 3/4 cups all-purpose flour
    -   1 teaspoon baking powder
    -   1/4 teaspoon baking soda
    -   1/2 teaspoon salt
    -   1/2 cup unsalted butter, at room temperature
    -   1 cup granulated sugar
    -   2 large eggs
    -   1/4 cup milk
    -   1 teaspoon vanilla extract
    -   3 ripe bananas, mashed
    -   1/2 cup chopped walnuts (optional)
    ```

1. Copy the following text and paste it into the **Chat session** text box.

    ```text
    What were the 10 top movies of 2001? Respond in the form of a table listing the movie name, the box office earnings, and the studio.
    ```

1. Select the paper plane icon to send your message. You should see an output like the following text, which is shortened for brevity:

    ```text
    Here are the top 10 movies of 2001 along with their box office earnings and studio:  
    | Movie Name           | Box Office Earnings | Studio            |  
    |----------------------|---------------------|-----------------|  
    | Harry Potter and the Philosopher's Stone | $974,755,371 | Warner Bros. |  
    | The Lord of the Rings: The Fellowship of the Ring | $871,530,324 | New Line Cinema |  
    | Monsters, Inc. | $577,425,734 | Disney/Pixar |  
    | Shrek | $484,409,218 | DreamWorks Animation |  
    | Ocean's Eleven | $450,717,150 | Warner Bros. | 
    ```

1. Copy the following text and paste it into the **Chat session** text box.

    ```text
    Write a Python function to calculate the nth prime number.
    ```

1. Select the paper plane icon to send your message. You should see an output similar to the following text, which is shortened for brevity:

    ```text
    Sure! Here's a Python function that uses trial division to calculate the nth prime number:  
    ```

    ```python  
    def nth_prime(n):  
        """  
        Returns the nth prime number using trial division.  
        """  
        primes = [2]  # Start with the first prime number  
        candidate = 3  # Start checking with the first odd number  
        while len(primes) < n:  
            is_prime = True  # Assume the candidate is prime  
            # Check if the candidate is divisible by any previous prime  
            for prime in primes:  
                if candidate % prime == 0:  
                    is_prime = False  # The candidate is not prime  
                    break 
            if is_prime:  
                primes.append(candidate)  # Add the candidate to the list of primes    
            candidate += 2  # Check the next odd number  
        return primes[-1]  # Return the nth prime number  
    ```  

## Vary the response predictability by using temperature

In this exercise, you use the temperature parameter to vary the model's output.

1. Select **Clear chat**, copy the following text, and paste it into the **Chat session** text box.

   ```text
    What is a unique and long name for a cat?
    ```

1. Select the paper plane icon to send your message. You should see an output like this text:

    ```text
    How about "Sylvester McFluffernutter III"? It's a fun and quirky name that's definitely unique and memorable!
    ```

1. Select **Parameters** from the **Configuration** tab, and set the temperature to `0`.

    :::image type="content" source="../media/change-temperature.png" alt-text="Screenshot of the Azure AI Studio chat playground with the parameters tab and the temperature bar highlighted.":::

1. Select the blue circular arrow icon from the **Chat session** tab to generate a new cat name.

    :::image type="content" source="../media/chat-session-reload.png" alt-text="Screenshot of the Azure AI Studio chat playground with the reload icon highlighted.":::

1. Repeat the previous step multiple times with different temperature values and notice how the generated content changes.

1. Reset the temperature to its default value of `0.7` before you continue.

## Simulate short-term memory by using the chat history

Now, we'll use the chat history to provide more context to the model.

1. Select **Clear chat**, copy the following text, and paste it into the **Chat session** text box.

    ```text
    How many neutrons are in a hydrogen nucleus?
    ```

1. Select the paper plane icon to send your message. You should see an output like this text:

    ```text
    A hydrogen nucleus, also known as a proton, has zero neutrons.
    ```

1. Copy the following text and paste it into the **Chat session** text box.

    ```text
    What about the isotopes?
    ```

1. Select the paper plane icon to send your message. You should see an output like this text:

    ```text
    Hydrogen has three isotopes:
    1. Protium: This is the most common isotope of hydrogen and it has 1 proton and no neutrons.  
    2. Deuterium: This is a stable isotope of hydrogen and it has 1 proton and 1 neutron.  
    3. Tritium: This is a radioactive isotope of hydrogen and it has 1 proton and 2 neutrons.
    ```

In this example, the model responds with an answer that involves isotopes of hydrogen even though your second prompt didn't mention hydrogen or neutrons. The response used the context of the chat to provide a more useful answer.

> [!NOTE]
> The key here is sending previous prompts back into the next request, which provides the model with more context to produce a more valuable answer.