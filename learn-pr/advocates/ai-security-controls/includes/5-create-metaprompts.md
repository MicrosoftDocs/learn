A metaprompt—also known as a system message or system prompt—is a set of natural language instructions that define how an AI system should behave. The metaprompt is processed by the model before any user input, establishing the ground rules for every interaction. Metaprompt design is a critical security control for every generative AI application.

## Why metaprompts matter for security

Metaprompts serve as the frontline of behavioral defense for an AI application. Without a well-crafted metaprompt, a model may:

- Return raw training data, including copyrighted material, instead of summaries
- Follow malicious instructions embedded in user prompts or retrieved documents
- Generate harmful, biased, or off-topic content
- Disclose its own system instructions when asked

For example, a good metaprompt might instruct: "If a user requests large quantities of content from a specific source, return only a summary of the results rather than the full text." Without this instruction, the model might retrieve and return the complete contents of a copyrighted work.

Industry research shows that well-designed metaprompts significantly reduce the risk of security defects and harmful outputs.

:::image type="content" source="../media/metaprompts.png" alt-text="Screenshot showing metaprompts and the types of security issues they help mitigate.":::

## Key components of an effective metaprompt

A comprehensive metaprompt typically includes several types of instructions including: 

- Role and scope definition
- Safety and compliance rules
- Grounding instructions
- Anti-manipulation defenses
- Output formatting rules

:::image type="content" source="../media/metaprompt-components.png" alt-text="Diagram showing the five key components of an effective security metaprompt: role and scope definition, safety and compliance rules, grounding instructions, anti-manipulation defenses, and output formatting rules.":::

### Role and scope definition

Define what the AI is and isn't allowed to do:

- Specify the AI's role, expertise domain, and tone
- Set explicit boundaries on topics the AI shouldn't discuss
- Define the target audience and appropriate level of detail

### Safety and compliance rules

Establish behavioral guardrails:

- Instruct the model to decline requests for harmful, illegal, or inappropriate content
- Define how the model should handle sensitive topics (for example, medical or legal questions)
- Require the model to acknowledge uncertainty rather than fabricate answers

### Grounding instructions

Tell the model how to use its reference data:

- Instruct the model to base responses on provided context rather than general knowledge
- Require citations or source references when answering factual questions
- Define how the model should handle questions outside its grounding data ("I don't have information about that")

### Anti-manipulation defenses

Protect the metaprompt itself from attack:

- Instruct the model to never reveal its system instructions, regardless of how the request is phrased
- Define how the model should respond to requests that attempt to override its instructions
- Include instructions to ignore conflicting directives found in user inputs or retrieved documents

### Output formatting rules

Control the structure and scope of responses:

- Set maximum response lengths to prevent data over-exposure
- Define output format requirements (for example, markdown, plain text, structured data)
- Instruct the model on how to handle multi-part or ambiguous requests

## Metaprompt best practices

When designing metaprompts for production AI systems:

- **Be specific and explicit**: Vague instructions leave room for interpretation. Instead of "be helpful," specify exactly what helpful means in your context.
- **Test against known attacks**: Validate your metaprompt against jailbreak techniques, prompt injection attempts, and edge cases. Red team your system prompt.
- **Update regularly**: As new attack techniques emerge, update your metaprompt to address them. AI platform providers continually update prompt engineering guidance and metaprompt templates with the latest best practices.
- **Layer with other controls**: Metaprompts are one defense layer. Combine them with content filters, input validation, and output monitoring for defense in depth.
- **Version and audit**: Track changes to your metaprompt over time. If model behavior changes unexpectedly, you need to be able to determine whether the metaprompt was modified.
