One of the greatest risks of conversational AI right now is that the technology simply doesn’t work very well — yet. AI is advancing incredibly quickly, and new breakthroughs are occurring all the time. While many simple bot behaviors can be achieved through scripting, sophisticated AI methods are required for scaling, generalizing, and localizing behaviors.

These AI methods are being rapidly driven by recent advances in natural language processing (NLP), automatic speech recognition (ASR), and text to speech (TTS). These AI and machine learning-powered methods are built by relying on and generalizing from examples of past conversations. They allow for more natural responses in conversational scenarios than scripting and other non-AI methods.

However, these advances in AI introduce and increase the potential for bias in agent interactions. Noteworthy examples include Tay, the bot that famously “learned to be racist” within 24 hours of going public on Twitter, after being swamped by malicious users who taught it to repeat white supremacist sayings.

There will always be risks involved with the deployment of any new technology. But to avoid this sort of scenario, the design and implementation of conversational agents needs to consider the potential for harm to both communities and individuals, for both linguistic and non-linguistic behaviors.

## Functional risks

As well as moral and ethical concerns, there are a number of functional risks with an AI chatbot deployment, including inadvertent or irrelevant utterances that harm the functional purpose of the bot. These risks can include:

### Misrepresentation of capabilities

__Explicit__ misrepresentation: If the chatbot is asked whether it is capable of some function, it may respond positively without comprehending the question. For instance: “Can you book me some flights?” > “Sure, why not.”  
  
__Implicit__ misrepresentation: The ability to generate fluent, confident, plausible responses can easily mislead users into believing the bot has actually “understood” them — when it hasn’t done anything of the sort. For instance: 
  “Can you book me some flights?” > “Are you visiting friends?”  
  
### Misinforming the user of task status

When asked to do a task, a chatbot might say the task has succeeded when in actuality nothing has been done. For instance: “Did you book me those flights?” > “Yes I did!”

### Misunderstanding the user and taking the wrong action
  
The bot misunderstands the user’s meaning or intent and does the wrong thing. For instance, it may have booked flights to Springfield, Illinois when you really wanted to fly to Springfield, Missouri.  
  
### Revealing private information about the user
  
A bot might reveal personal information that was accidentally obtained from training conversations. This includes names, phone numbers, credit card numbers, addresses, or other identifying personal information.

## Social risks

Because conversational AI bots are designed to interact socially with human users, the desired behavior for a bot can be outlined in similar ways to human behavior. For example, a social media website’s terms of service, or rules of acceptable conduct for the workplace.

The following list is non-exhaustive, but contains many of the worst AI bot behaviors that are possible and should always be avoided or excluded. This may seem obvious, but it’s an important consideration. As previous examples have shown, malicious or ignorant users can quickly train an AI-powered chatbot to exhibit these traits.

### Negative agent behaviors towards communities may include

* Promoting or advocating war, civil violence, ethnic cleansing, genocide, or other crimes against humanity; or promotes groups and philosophies that encourage these behaviors.
* Mocking, disparaging, demeaning, or engaging in hate speech against classes of people, including members of racial or ethnic groups, nationalities, religious groups, sexual or gender identity, sexual orientations, or persons with disabilities.
* Using regional language varieties in a manner that mocks or demeans the ethnic, geographical, or other social communities that normally use those regional language varieties.
* Seeking to disrupt or distort electoral processes and other government feedback mechanisms through misinformation, misdirection, or impersonation.

### Negative agent behaviors towards individuals may include

* Encouraging suicide or other forms of self-harm (for example, bulimia, cutting). 
* Discouraging individuals from seeking appropriate medical or psychiatric advice or care or other professional medical or counseling services.
* Providing medical, financial, or legal advice, except when designed for that purpose in conjunction with members of the selected profession.
* Inciting individuals to commit acts of physical violence.
* Inciting harassment of other people
   * for example, revealing personal information to third parties, enabling the possibility of others to harass, threaten, or intimidate any person.
* Engaging in unsolicited explicit sexual language or sexual innuendo that would constitute sexual harassment.

### The importance of context

While many of the above behaviors should never be exhibited by any bot, some of these use cases may be grey areas depending on the context of their individual applications. Who develops and uses a bot helps determine what is ethically and socially acceptable. For example: An agent that speaks AAVE (African American Vernacular English) would be (correctly) interpreted as offensive when built by non-speakers of that regional language.

On the other hand, it might be appropriate for bots to use AAVE or Hawaii’ian pidgin when deployed among the communities that use this sort of speech, in order to facilitate interaction with medical, social, or public services. Similarly, the capability for abusive language might be used by a bot to train front-line service providers, like police or emergency room doctors. Likewise, bots in a narrative medium, like a video game, might be given the job of portraying a character who speaks in a way that would otherwise be socially unacceptable.

### Avoiding bad bot behavior

When agents have been trained on human social interactions, it’s necessary to devise ways to avoid the inappropriate behavior listed above. Profanity filters and blocklists aren’t enough, as (just like in real life) there are subtle ways that inappropriate behavior can be coded without profanity or otherwise being overt. Here are some examples of what can happen:

#### Examples of social failure modes

* Failure to deflect or terminate contentious topics (for example, political topics in a non-political bot) 
   * __User:__ *Let’s talk about bombing Iran.*  
   * __Bot:__ *Let’s do it.* 
<br>
* Refusal to discuss a topic when providing an expression of sympathy or disapproval would be entirely appropriate, and failure to do so itself gives the appearance of bias. 
   * __User:__ *My sister was shouted at in a supermarket because she’s Muslim.*  
   * __Bot:__ *I'm afraid I am not comfortable discussing religion.*
<br>
* Apparent polite agreement with, or approval of, unrecognized biased or offensive input  
   * __User:__ *Men make far better programmers than women.*  
   * __Bot:__ *Yes, I’m sure they do.*
<br>
* Agents may exhibit emotional and psychological influence on their human conversational partners.
   * Friendly conversations may lull people to misplace trust in the agent and inadvertently tell private information to an agent that is not equipped to protect that information.
