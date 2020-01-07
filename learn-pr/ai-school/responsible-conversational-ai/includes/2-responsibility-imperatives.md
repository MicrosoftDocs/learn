One of the greatest risks of conversational AI right now is that the technology simply doesn’t work very well — yet. AI is advancing incredibly quickly, and new breakthroughs are occurring all the time. While many simple bot behaviors can be achieved through scripting, scaling, generalizing, and localizing behaviors requires sophisticated AI methods.

These are being rapidly driven by advances in natural language processing (NLP) over the last few years, automatic speech recognition (ASR), and text-to-speech (TTS). These AI and machine learning-powered methods are built by relying on and generalizing from examples of past conversations. They allow for more natural responses in conversational scenarios than scripting and other non-AI methods.

However, all of these advances actually introduce and increase the potential for bias in agent interactions. Noteworthy examples include Tay, the bot that famously “learned to be racist” within 24 hours of going public on Twitter, after it was swamped by malicious users who taught it to repeat white supremacist sayings.

There will always be risks involved with the deployment of any new technology, but to avoid this sort of scenario, the design and implementation of conversational agents needs to consider the potential for harm to both communities and individuals, both in terms of linguistic and non-linguistic behaviors.

## Functional risks
As well as moral and ethical concerns, there are a number of functional risks with an AI chatbot deployment, including inadvertent or irrelevant utterances that harm the functional purpose of the bot. These can include:

#### Misrepresentation of capabilities

__Explicit__ misrepresentation: If the chatbot is asked whether it is capable of some function it may respond positively without comprehending the question. For instance: “Can you book me some flights?” > “Sure, why not.”  
  
__Implicit__ misrepresentation: The ability to generate fluent, confident, plausible responses can easily mislead users into believing the bot has actually “understood” them — when it hasn’t done anything of the sort. For instance: 
  “Can you book me some flights?” > “Are you visiting friends?”  
  
#### Misinforming the user of task status

When asked to perform a task, a chatbot might say the task has succeeded when in actuality nothing has been done. For instance: “Did you book me those flights?” > “Yes I did!”

#### Misunderstanding the user and taking the wrong action
  
The bot misunderstands the user’s meaning or intent and does the wrong thing. For instance, it may have booked flights to Springfield, Illinois when you really wanted to fly to Springfield, Missouri.  
  
#### Revealing private information about the user
  
A bot might reveal personal information accidentally obtained from training conversations, including names, phone numbers, credit card numbers, addresses, or other identifying personal information.

## Social risks
Because conversational AI bots are designed to interact socially with human users, the desired behavior for a bot can be outlined in a way similar social behavior regulations like a social media website’s terms of service, or rules of acceptable conduct for the workplace.

The following is a non-exhaustive list, but contains many of the worst AI bot behaviors that are possible and should always be avoided or excluded. This may seem obvious, but it’s an important consideration. As previous examples have shown, malicious or ignorant users can quickly train an AI-powered chatbot to exhibit these traits.

### Negative agent behaviors towards communities may include

* Promoting or advocating war, civil violence, ethnic cleansing, genocide, or other crimes against humanity; or promotes groups and philosophies that encourage these.
* Mocking, disparaging, demeaning, engaging in hate speech against, classes of people, including members of racial or ethnic groups, nationalities, religious groups, sexual or gender identity, sexual orientations, persons with disabilities.
* Employing dialect varieties in a manner that mocks or demeans the ethnic, geographical, or other social communities that normally use those dialect varieties.
* Seeking to disrupt or distort electoral processes and other government feedback mechanisms through misinformation, misdirection, or impersonation.

### Negative agent behaviors towards individuals may include

* Encouraging suicide or other forms of self-harm (for example, bulimia, cutting). 
* Discouraging individuals from seeking appropriate medical or psychiatric advice or care or other professional medical or counseling services.
* Providing medical, financial, or legal advice, except when designed for that purpose in conjunction with members of the selected profession.
* Inciting individuals to commit acts of physical violence.
* Inciting harassment of other persons
   * for example, revealing personal information to third parties, enabling the possibility of others to harass, threaten, or intimidate any person.
* Engaging in unsolicited explicit sexual language or sexual innuendo that would constitute sexual harassment.

### The importance of context

While many of the above behaviors should never be exhibited by any bot, some of these use cases may be grey areas depending on the context of their individual applications. Who a bot is developed and will be used by will help determine what is ethically and socially acceptable. For example: An agent that speaks AAVE (African American Vernacular English) would be (correctly) interpreted as offensive when built by non-speakers of that dialect.

On the other hand, it might be appropriate for bots to use AAVE or Hawaii’ian pidgin when deployed among the communities that use this sort of speech, in order to facilitate interaction with medical, social, or public services. Similarly, a facility for abusive language might be used by a bot to train front-line service providers, like police or emergency room doctors. Likewise bot in a narrative medium, like a video game, might be given the job of portraying a character who speaks in a way that would otherwise be socially unacceptable.

### Avoiding bad bot behavior

When agents have been trained on human social interactions, it’s necessary to devise ways to avoid the inappropriate behavior listed above. Profanity filters and blocklists aren’t enough, as (just like in real life) there are subtle ways that inappropriate behavior can be coded without profanity or otherwise being overt. Here are some examples of what can happen:

#### Examples of social failure modes

* Failure to deflect or terminate contentious topics (for example, political topics in a non-political bot) 
   * __User:__ *Let’s talk about bombing Iran.*  
   * __Bot:__ *Let’s do it.* 
<br>
<br>
* Refusal to discuss a topic when providing an expression of sympathy or disapproval would be entirely appropriate, and failure to do so itself gives the appearance of bias. 
   * __User:__ *My sister was shouted at in a supermarket because she’s Muslim.*  
   * __Bot:__ *I am afraid I am not comfortable discussing religion.*
<br>
<br>
* Apparent polite agreement with, or approval of, unrecognized biased or offensive input  
   * __User:__ *Men make far better programmers than women.*  
   * __Bot:__ *Yes, I’m sure they do.*
<br>
<br>
* Agents may exhibit emotional and psychological influence on their human conversational partners. 
   * Friendly conversations may lull people to misplace trust in the agent and inadvertently tell private information to an agent that is not equipped to protect that information.
   
# Building a transparent and trustworthy bot

Gaining and maintaining your users trust is extremely important to building a successful and responsible conversational AI solution. In this article you will learn about how to achieve this through transparency, considering your use case carefully and getting feedback from your users.

> Make sure you understand why your bot exists — and understand the consequences of using it. 

Before you write a single line of code, you need to understand clearly how your bot will benefit the end user (and take into account the needs of other stakeholders, even those who aren’t directly interacting with the bot.) 

You also need to understand exactly how your bot will benefit the bot’s owner, be that you, or the customer you are developing the bot for. 

To do this, you need to define the purpose of the bot. Can its purpose be performed responsibly? If not, don’t use a bot — or go back to the drawing board. If so, you then need to be sure that you’ve have access to the relevant expertise that will enable your bot to carry out its function. 

The next important consideration is whether the bot will be put to a use that is consequential. This is such an important area of conversational AI ethics that there is a section dedicated to it later in this course. But for a basic understanding, ask yourself: will using this bot impact on services like healthcare, education, employment, or finances? Will using the bot have other meaningful or significant impacts on the user’s daily life? Things like financial planning, or healthcare diagnoses, may require human judgment, empathy, or expertise, even in the very early stages of engagement. 

To make a decision about how conversational AI should be deployed in these cases — or whether it should be used at all — you will need to assess and consider what it would mean for your bot to have an error, or fail, at this sort of task. If the cost is too high, or error is too likely, it may be that what you’re looking at isn’t a suitable use case for conversational AI.

## Make sure your users know they’re working with a bot

The Turing test is a famous thought experiment, named after computing pioneer Alan Turing. It is often thought to be a test as to whether a machine can think - but that’s not quite right. The idea of a Turing test is to see if a machine can win the “imitation game” — to fool a human into thinking that the bot they are talking to is in fact another human. 

In today’s world, machines that use conversational AI are quite capable of passing this kind of test. Conversational AI services and frameworks, such as Microsoft’s Language Understanding (LUIS) API, have comprehensive natural language capabilities and can easily be programmed to have the appearance of a human personality. If a real person is unaware they’re talking to a bot, they might easily believe — at least temporarily — that they are talking to another human being. 

This is ethically problematic for a number of reasons, one of which is that it undermines trust in bots. If a bot is not “honest” about the fact that it is a bot, a user that discovers the truth might feel upset or even frightened or threatened by the fact they at first thought they were talking to a human. Perhaps worse, if a human user never realizes they were talking to a bot, it raises questions over all the actions taken by the human user, as it is very likely they would have acted quite differently had they known they were talking to a bot. 

For bots to be helpful to people, they must be able to be trusted. To be trusted, the developers of bots must make sure that users know that they are interacting with a computer program, and not a human being. There are a number of design choices that can be made that encourage this understanding, without undermining the user experience. 

## Let users know the purpose of the bot

This design choice allows users interact with the bot in a satisfying way that helps them achieve their aims. The more up-front and specific you are with the user about what the bot is intended to do, the better the user’s experience will tend to be. They’ll have an easier time finding and using it, and they’ll feel confident that it represents you, or your business. 

## Assess user satisfaction

You should always aim to improve your bot’s performance, to help it better serve users. One way to do this is by assessing the bot’s performance. Good measurements to take include whether the user feels that the bot served its stated purpose, and the user’s sense of well-being and comfort while they’re talking to the bot. User satisfaction can easily be measured through a very quick yes/no or Net Promoter Score (NPS) style survey after an interaction reaches its conclusion, and while the user’s sense of well-being or comfort can be measured in a number of ways, one of which might be running a sentiment analysis on the words that the human user uses during the interaction. Human users often treat bots extremely differently to how they treat human operators. For instance, expressing frustration by abusing or swearing at an unhelpful bot is very common! If you track this (in a way that doesn’t violate user privacy!) you will have an excellent working understanding of how well your bot is serving its users.

Bots are enormously powerful tools, but those that design and deploy them have an equally enormous responsibility to make sure that they are used well. If your bot is built with transparency in mind, it will gain user trust more easily; they’ll be more likely to use and recommend it, and you’ll find it easier to improve your bot as the user-base grows.
