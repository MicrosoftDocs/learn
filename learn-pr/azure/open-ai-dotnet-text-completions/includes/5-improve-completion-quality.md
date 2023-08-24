Prompt construction can be difficult. In practice, the prompt acts to configure the model weights to complete the desired task, but it's more of an art than a science, often requiring experience and intuition to craft a successful prompt.

When you send well-constructed prompts to the model, the model returns better completions.

In our hiking recommendation bot, a great system prompt helps the model get ready to recommend appropriate hikes. And good user prompts further refine the recommendations the model will return.

In this unit, we'll talk about the general concepts and patterns that can be used to construct prompts and look at some techniques that can be used to improve the quality of the completions.

## Basics

Text prompts are how users interact with GPT models. Generative language models attempt to produce the next series of words that are most likely to follow from the previous text. It's as if we're saying _What is the first thing that comes to your mind when I say &lt;prompt&gt;?_

As you develop complex prompts, it's helpful to keep this fundamental behavior in mind. Regardless of the prompt, the model is simply responding with what it determines is most likely to follow from the prompt.

## Prompt components

When using the Completion API there's no differentiation between different parts of the prompt, but it's still useful to dissect the prompt into its component parts - as the goal is to think about prompt construction.

### Instructions

Instructions are likely the most commonly used prompt component. They're the part of the prompt that tells the model what to do and can range from simple to complex. For example, _Recommend hikes_ or _You are a hiking enthusiast who helps people discover fun hikes in their area. You are upbeat and friendly. You introduce yourself when first saying hello. When helping people out, you always ask them where they are located and the hiking intensity desired to inform the hiking recommendation you provide_.

### Primary content

Primary content refers to some sort of text that is being processed or transformed by the model. It's typically used in conjunction with instructions. For example, _You will then provide three suggestions for nearby hikes that vary in length after you get that information._.

Primary content can be much longer, such as asking the model to summarize a Wikipedia article.

### Examples

Successful prompts often rely on the practice of "one-shot" or "few-shot" learning. This refers to the inclusion of one or more examples of the desired behavior of the model, typically including input and output pairs. This isn't learning in the sense that the model is permanently changed, but rather that the examples better condition the model to respond as desired for only the current inference.

The use of prompts with no examples is sometimes referred to as "zero-shot" learning.

```text
Hike request: I live near Seattle and would like an easy hike.
Recommendation: That's great to hear, the Seattle area has some of the best hikes in the nation! You should try Little Si, you'll love it.

Hike request: I want to go on a hike in the North Cascades that will blow my mind.
Recommendation: You won't find a bad hike in the North Cascades. However, I hear the Sahale Arm stops people in their tracks with its beauty.

Hike request: I'd like to find a strenuous hike that's just like the Enchantments, but without as many people.
Recommendation:
```

### Cue

Cues act as the “jumpstart” for the output of the model, helping to direct the model to the desired output. It's often a prefix that the model can build onto. A cue can direct the completion to include key elements. They're often used along with instructions.

The following example shows a single cue to summarize many trail reviews.

| Prompt | Completion |
| --- | --- |
| Trail reviews are an important consideration on whether hikers go on a hike because the review lists the current conditions of the trail.<br/>[...]<br/>Summarize the above trails review:<br/>The key take away of the trail reviews are: | that the Mailbox Peak trail is muddy right now and the mosquitos are bad once you get above the tree line. There are also a lot of people on the trail starting mid-morning. |

### Supporting content

Supporting content is information that the model can utilize to influence the output in some way. It differs from primary content in that it isn't the main target or task, but it's typically used along with primary content. Common examples include contextual information such as the current date, the name of the user, user preferences, and so on.

## Best practices

* **Be Specific.** Leave as little to interpretation as possible. Restrict the operational space.
* **Be Descriptive.** Use analogies.
* **Double Down.** Sometimes you may need to repeat yourself to the model. Give instructions before and after your primary content, use an instruction and a cue, etc.
* **Order Matters.** The order in which you present information to the model may affect the output. Whether you put instructions before your content (“summarize the following…”) or after (“summarize the above…”) can make a difference in output. Even the order of few-shot examples can matter. This technique is referred to as recency bias.
* **Prime the output.** Include a few words or phrases at the end of the prompt to obtain a model response that follows the desired form.
* **Give the model an “out”.** It can sometimes be helpful to give the model an alternative path if it's unable to complete the assigned task. For example, when asking a question over a piece of text you might include something like "respond with ‘not found’ if the answer isn't present." This technique helps the model avoid generating false responses.
* **Chain of thought prompting.** The model is instructed to proceed step-by-step and present all the steps involved. Doing so reduces the possibility of inaccuracies of outcomes and makes assessing the model response easier.
