The quality of responses that a generative AI application returns not only depends on the model itself, but on the types of prompts it is given. Both developers who design applications and consumers who use those applications can improve the quality of responses from generative AI by considering prompt structure. You will often hear of the term *prompt engineering* used to describe the process of prompt improvement. 

Prompts are ways we tell an application what we want it to do. An engineer can add instructions for what the program will do with prompts. For example, developers may build a generative AI application for teachers to create multiple-choice questions related to text students read. During the development of the application, developers can add additional rules for what the program should do with the prompts it receives. 

## System messages

Prompt engineering techniques include defining a system message that sets the context for the model by describing expectations and constraints (for example, “You are a helpful assistant that responds in a cheerful, friendly manner”). These system messages determine constraints and styles for the model's responses.

## Writing good prompts

You can get the most useful completions hy being explicit about the kind of response you want (for example, “Create a list of ten things to do in Edinburgh during August”). Submitting clear, specific prompts produces better results.

## Providing examples

While LLMs generally support *zero-shot learning* in which responses can be generated without prior examples, you can also provide *one-shot* learning prompts that include one (or a few) examples of the output you require (for example “Visit the castle in the morning before the crowds arrive”). The model can then generate further responses in the same style as the examples provided in the prompt.

## Grounding data

Prompts can include *grounding* data to provide context. You can use grounding data as a prompt engineering technique to gain many of the benefits of fine-tuning without having to train a custom model.

To apply this technique, include contextual data in the prompt so that the model can use it to generate an appropriate output. For example, suppose you want to use a large language model to generate a summary of an email. You can include the email text in the prompt with an instruction to summarize it.




