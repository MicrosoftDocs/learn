**Objective:**  

Use Azure OpenAI Studio to create a simple AI-powered chatbot that can handle basic user queries. This activity sets the foundation for building more advanced dialogue systems in later modules.

**Materials needed:**

- Laptop or desktop with internet access  
- Azure OpenAI Studio access  
- An Azure account with OpenAI resources enabled

## Part 1: Create a prompt-based chatbot in Azure OpenAI Studio

1. **Log into Azure OpenAI Studio**  
   - Go to [Azure OpenAI Studio](https://oai.azure.com/) and sign in using your Azure credentials.

2. **Start a new chat deployment**  
   - Select a GPT model (such as `gpt-35-turbo`) and open a new chat playground session.

3. **Design your prompt template**  
   - Enter a system message that guides the chatbot's behavior.  
     Example:  
     *"You are a friendly customer support bot for a fictional online bookstore. Answer questions about orders, shipping times, and return policies."*

4. **Test basic queries**  
   - Try 3–4 user prompts such as:  
     - "Where's my order?"  
     - "How long does shipping take?"  
     - "Can I return a book I've already opened?"  
   - Refine your system prompt if the chatbot's responses are too vague or stray off-topic.

## Part 2: Reflect and extend

1. **Review chat flow and output quality**  
   - Does the chatbot give helpful, accurate, and relevant answers?  
   - How well does it stay in character (for example, friendly and professional)?  
   - What happens if the user asks an unexpected or off-topic question?

2. **Iterate on your prompt**  
   - Add follow-up instructions to adjust tone, set boundaries, or clarify scope.  
     Examples:  
     - "Make responses more concise."  
     - "Avoid answering questions outside of bookstore topics."  
     - "Add empathy if the user seems frustrated."

3. **Optional: Add user memory (advanced preview)**  
   - Experiment with short-term memory by summarizing user input or keeping context through prompt chaining (covered in later lessons).

## Expected outcome

Learners build a basic, prompt-driven chatbot using Azure OpenAI Studio. They learn how to guide tone and behavior through system prompts and test how the model responds to different user inputs. This hands-on experience lays the groundwork for developing more interactive and dynamic dialogue systems in upcoming modules.
