Prompt construction can be difficult. In practice, the prompt acts to configure the model weights to complete the desired task, but it's more of an art than a science, often requiring experience and intuition to craft a successful prompt.

In this unit we'll talk about the general concepts and patterns that can be used to construct prompts and look at some techniques that can be used to improve the quality of the completions.

## Basics

Text prompts are how users interact with GPT models. Generative language models attempt to produce the next series of words that are most likely to follow from the previous text. It's as if we're saying _What is the first thing that comes to your mind when I say <prompt>?_

As you develop complex prompts it's helpful to keep this fundamental behavior in mind. Regardless of the prompt, the model is simply responding with what it determines is most likely to follow from the prompt.

## Prompt components

When using the Completion API there's no differentiation between different parts of the prompt, but it's still useful to dissect the prompt into its component parts - as the goal is to think about prompt construction.

### Instructions

Instructions are likely the most commonly used prompt component. They are the part of the prompt that tells the model what to do and can range from simple to complex. For example, _Write an introduction for a weekly newsletter_ or _Write an introduction for a weekly newsletter to my company named Constoso. It should mention the great all hands meeting we had last week and thank the team for all their hard work over the past few months._.

### Primary content

Primary content refers to some sort of text that is being processed or transformed by the model. It is typically used in conjuction with instructions. For example, _Can you please tell me how to get to the museum? Translate to French:_.

Primary content can be much longer, such as asking the model to summarize a Wikipedia article.

### Examples

Successful prompts often rely on the practice of "one-shot" or "few-shot" learning. This refers to the inclusion of one or more examples of the desired behavior of the model, typically including input and output pairs. This is not learning in the sense that the model is permanently changed, but rather that the examples better condition the model to respond as desired for only the current inference.

The use of prompts with no examples is sometimes referred to as "zero-shot" learning.

```text
Example: This product worked well for my needs and my cat loved it.
Sentiment: Positive.

Example: My dog would not play with this toy.
Sentiment: Negative.

Example: My hamster ate the food but that's about it.
Sentiment:
```

### Cue

Cues act as the “jumpstart” for the output of the model, helping to direct the model to the desired output. It is often a prefix that the model can build onto. A cue can direct the completion to include key elements. They are often used along with instructions.

The following example shows a single cue to summarize an email message.

| Prompt | Completion |
| --- | --- |
| Performance reviews are a core component of our Performance & Development approach at Contoso.<br/>[...]<br/>Summarize the above email message:<br/>The key take away of the email message is: | that Contoso is improving the performance review experience by making it more focused on core priorities, expectations and impact. Additionally, they are upgrading the in-tool user experience with tips, resources and guidance. Finally, they are adding guidance on how to activate company-wide core priorities. |

### Supporting content

Supporting content is information that the model can utilize to influence the output in some way. It differs from primary content in that it is not the main target of task, but it is typically used along with primary content. Common examples include contextual information such as the current date, the name of the user, user preferences, and so on.

## Best practices

* **Be Specific.** Leave as little to interpretation as possible. Restrict the operational space.
* **Be Descriptive.** Use analogies.
* **Double Down.** Sometimes you may need to repeat yourself to the model. Give instructions before and after your primary content, use an instruction and a cue, etc.
* **Order Matters.** The order in which you present information to the model may impact the output. Whether you put instructions before your content (“summarize the following…”) or after (“summarize the above…”) can make a difference in output. Even the order of few-shot examples can matter. This is referred to as recency bias.
* **Prime the output.** Include a few words or phrases at the end of the prompt to obtain a model response that follows the desired form.
* **Give the model an “out”.** It can sometimes be helpful to give the model an alternative path if it is unable to complete the assigned task. For example, when asking a question over a piece of text you might include something like "respond with ‘not found’ if the answer is not present." This can help the model avoid generating false responses.
* **Chain of thought prompting.** The model is instructed to proceed step-by-step and present all the steps involved. Doing so reduces the possibility of inaccuracies of outcomes and makes assessing the model response easier.
