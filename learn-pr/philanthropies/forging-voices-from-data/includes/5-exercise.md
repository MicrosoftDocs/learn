### Hands-On Activity: Train and Customize a Dialogue Model in Azure OpenAI Studio  
**Time:** 20–25 min

---

**Objective:**  
Enhance the chatbot created in Module 1 by integrating a custom-trained dialogue model using Azure OpenAI Studio. Use domain-specific data to improve response accuracy, refine tone, and simulate memory through prompt engineering. Test and iterate on the chatbot’s performance in real time.

---

**Materials Needed:**  
- Laptop or desktop with internet access  
- Azure OpenAI Studio access  
- Dataset of sample dialogues or FAQs (provided or created by learner)

---

### Part 1: Upload and Train with Custom Data

1. **Prepare a Dataset**  
   - Use a collection of relevant user queries and ideal responses (such as customer FAQs, support logs, or product descriptions).  
   - Format the data in CSV or plain text, with clear input/output pairs.

2. **Upload the Dataset**  
   - In Azure OpenAI Studio, navigate to your chatbot project.  
   - Upload your dataset under the **Files** section and connect it to your deployment using the Playground.

3. **Apply Supervised Learning via Prompt Examples**  
   - Provide a few sample dialogues using system + user + assistant messages to demonstrate ideal behavior.  
     Example:
     ```
     User: "How do I reset my password?"  
     Assistant: "To reset your password, go to the login page and click 'Forgot Password.' Follow the instructions sent to your email."
     ```

---

### Part 2: Customize Tone and Interaction Style

1. **Set a System Prompt**  
   - Define the assistant’s role and tone.  
     Example:  
     *“You are a friendly and professional assistant for an online bookstore. Respond with clear, concise, and warm answers.”*

2. **Simulate Context Awareness**  
   - Create a prompt that includes conversation history, enabling the model to handle follow-up questions.  
     Example:  
     *“The user previously asked about shipping policies. Now they are asking, ‘How long does express shipping take?’”*

3. **Test and Iterate**  
   - Interact with your chatbot in the Playground.  
   - Ask questions covered in your dataset and test how it handles follow-ups.  
   - Tweak your examples or prompt instructions to improve continuity and engagement.

---

### Part 3: Evaluate and Improve

1. **Identify Strengths and Gaps**  
   - Does the chatbot handle follow-ups appropriately?  
   - Does it reflect the desired tone and style?  
   - Are any answers too vague, repetitive, or off-topic?

2. **Refine and Re-Test**  
   - Update the dataset, adjust the prompt, or provide additional sample dialogues.  
   - Test variations in the Playground until the responses align with expectations.

---

**Expected Outcome:**  
Learners will transform a basic chatbot into a refined, domain-specific assistant by uploading a custom dataset, configuring system prompts, and simulating context awareness. This activity demonstrates the power of Azure OpenAI Studio for training and fine-tuning dialogue behavior to better meet user needs and organizational goals.
