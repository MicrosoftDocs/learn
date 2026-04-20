The OpenAI *ChatCompletions* API is commonly used across generative AI models and platforms. Although the *Responses* API is recommended for new project development, it's likely that you'll encounter scenarios where the *ChatCompletions* API is useful for code maintenance or cross-platform compatibility.

## Submitting a prompt

The *ChatCompletions* API uses collections of *message* objects in JSON format to encapsulate prompts:

```python
completion = openai_client.chat.completions.create(
    model="gpt-4o",  # Your model deployment name
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "When was Microsoft founded?"}
    ]
)

print(completion.choices[0].message.content)
```

## Retaining conversational context

Unlike the *Responses* API, the *ChatCompletions* API doesn't provide a stateful response tracking feature. To retain conversational context, you must write code to manually track previous prompts and responses.

```python
# Initial messages
conversation_messages=[
    {
        "role": "system",
        "content": "You are a helpful AI assistant that answers questions and provides information."
    }
]

# Add the first user message
conversation_messages.append(
    {"role": "user",
    "content": "When was Microsoft founded?"}
)

# Get a completion
completion = openai_client.chat.completions.create(
    model="gpt-4o",
    messages=conversation_messages
)
assistant_message = completion.choices[0].message.content
print("Assistant:", assistant_text)

# Append the response to the conversation
conversation_messages.append(
    {"role": "assistant", "content": assistant_text}
)

# Add the next user message
conversation_messages.append(
    {"role": "user",
    "content": "Who founded it?"}
)

# Get a completion
completion = openai_client.chat.completions.create(
    model="gpt-4o",
    messages=conversation_messages
)
assistant_message = completion.choices[0].message.content
print("Assistant:", assistant_text)

# and so on...
```

In a real application, the conversation is likely to be implemented in a loop; like this:

```python
# Initial messages
conversation_messages=[
    {
        "role": "system",
        "content": "You are a helpful AI assistant that answers questions and provides information."
    }
]

# Loop until the user wants to quit
print("Assistant: Enter a prompt (or type 'quit' to exit)")
while True:
    input_text = input('\nYou: ')
    if input_text.lower() == "quit":
        print("Assistant: Goodbye!")
        break

    # Add the user message
    conversation_messages.append(
        {"role": "user",
        "content": input_text}
    )

    # Get a completion
    completion = openai_client.chat.completions.create(
        model="gpt-4o",
        messages=conversation_messages
    )
    assistant_message = completion.choices[0].message.content
    print("\nAssistant:", assistant_message)
    
    # Append the response to the conversation
    conversation_messages.append(
        {"role": "assistant", "content": assistant_message}
    )
```

The output from this example looks similar to this:

```text
Assistant: Enter a prompt (or type 'quit' to exit)

You: When was Microsoft founded?

Assistant: Microsoft was founded on April 4, 1975 in Albuquerque, New Mexico, USA.

You: Who founded it?

Assistant: Microsoft was founded by Bill Gates and Paul Allen.

You: quit

Assistant: Goodbye!
```

Each new user prompt and completion is added to the conversation, and the entire conversation history is submitted in each turn.

While not as fully featured as the *Responses* API, the *ChatCompletions* API is well established in the generative AI model ecosystem, so it's useful to be familiar with it.
