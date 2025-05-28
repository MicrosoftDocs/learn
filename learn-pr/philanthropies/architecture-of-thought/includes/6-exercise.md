### Hands-On Activity: Build a Basic AI-Powered Chatbot with Azure OpenAI Studio  
**Time:** 15 min  

**Objective:**  
Use Azure OpenAI Studio to create a simple AI-powered chatbot that can handle basic user queries. This activity sets the foundation for building more advanced dialogue systems in later modules.

**Materials Needed:**  
- Laptop or desktop with internet access  
- Azure OpenAI Studio access  
- An Azure account with OpenAI resources enabled

### Part 1: Create a Prompt-Based Chatbot in Azure OpenAI Studio

1. **Log into Azure OpenAI Studio**  
   - Go to [Azure OpenAI Studio](https://oai.azure.com/) and sign in using your Azure credentials.

2. **Start a New Chat Deployment**  
   - Select a GPT model (such as `gpt-35-turbo`) and open a new chat playground session.

3. **Design Your Prompt Template**  
   - Enter a system message that guides the chatbot’s behavior.  
     Example:  
     *“You are a friendly customer support bot for a fictional online bookstore. Answer questions about orders, shipping times, and return policies.”*

4. **Test Basic Queries**  
   - Try 3–4 user prompts such as:  
     - “Where’s my order?”  
     - “How long does shipping take?”  
     - “Can I return a book I’ve already opened?”  
   - Refine your system prompt if the chatbot’s responses are too vague or stray off-topic.

### Part 2: Reflect and Extend

1. **Review Chat Flow and Output Quality**  
   - Does the chatbot give helpful, accurate, and relevant answers?  
   - How well does it stay in character (for example, friendly and professional)?  
   - What happens if the user asks an unexpected or off-topic question?

2. **Iterate on Your Prompt**  
   - Add follow-up instructions to adjust tone, set boundaries, or clarify scope.  
     Examples:  
     - “Make responses more concise.”  
     - “Avoid answering questions outside of bookstore topics.”  
     - “Add empathy if the user seems frustrated.”

3. **Optional: Add User Memory (Advanced Preview)**  
   - Experiment with short-term memory by summarizing user input or keeping context through prompt chaining (covered in later lessons).

**Expected Outcome:**  
Learners build a basic, prompt-driven chatbot using Azure OpenAI Studio. They learn how to guide tone and behavior through system prompts and test how the model responds to different user inputs. This hands-on experience lays the groundwork for developing more interactive and dynamic dialogue systems in upcoming modules.
