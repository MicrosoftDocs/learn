In this module you will learn about Microsoft's guidelines for responsibly building conversational AI such as chat bots and voice-controlled systems.

*When famed sci-fi writer Isaac Asimov developed his Four Laws of Robotics, AI was still fiction. Now AI is a daily reality, and new rules are needed to make sure that it — and its creators — behave responsibly.*

AI is rapidly becoming normalized. In fact, it’s more correct to say that AI is already normalized, and has been for some time. Even the least tech-savvy consumers make use of AI daily, often hourly, and usually without realizing. AI-augmented image searches are commonplace; your friends are tagged in your photos thanks to machine learning; and even your Netflix recommendations are curated by AI-powered analytics with access to vast troves of viewer data. 

But this kind of AI tends to be invisible to the user. Conversational AI is different. With conversational AI, users know that they are interacting with an artificial intelligence. These services are now commonplace. Cortana, Siri, and Google Assistant live in your smartphones, and Amazon Echo sits on the kitchen bench. As well as smartphones, PCs, and other specialist devices, conversational AI is now enabled in cars, TVs and on the world wide web, often through consumer devices. If you’ve used a chat window to speak to a customer service representative online, chances are you’ve spoken to an AI before being put through to a human being — assuming the AI didn’t solve the problem for you without ever requiring human assistance. Rapid and continual advances in conversational AI mean that AI is increasingly able to solve problems on its own, and the line between human and AI help is fast blurring into a grey area. 

Although AI is still very far from being able to “think” as humans do, its ubiquity and the rapidly increasing capability of conversational AI creates special ethical challenges. We are only just starting to realize the capabilities of conversational AI bots, and for this technology to reach its full potential to help society, conversational AI must be developed in a way that earns and deserves society’s full trust. 

Microsoft has created special guidelines for the development of responsible conversational AI. It’s important to remember that, while AI bots may appear to be intelligent, the real intelligence comes from the developers who put these smart programs together — and so the responsibility to create ethically rests with them. It’s perhaps best summed up by the mantra made famous by Spider-Man: with great power, comes great responsibility.

# Background

An introduction to the different types of conversational AI bots and common stakeholders we must take into account when designing a bot.

There are, roughly, four different types of conversational AI bots. Most bots will actually mix these characteristics in any given implementation, as all four are required for a reasonably realistic simulacra of human conversation, and a bot that can’t engage in light conversation will come off as, well, robotic.  

1. The first category is casual conversation engagement. This sort of bot’s purpose is to facilitate __social engagement__ - either with the bot itself, or other users. User inputs would look something like this: 
  
   * What’s your favorite type of pizza?
   * I hope the Giants win tonight.
<br>
<br>
2. The second category is __information consumption.__ This sort of bot tries to assist the user by answering user questions, which might look like: 
  
   * What room is the project review meeting in? 
   * When is the ACL 2018 conference?
<br>
<br>
3. The third category is __task completion.__ The aim here is to assist the user by helping them get tasks done. User inputs for this category might be as follows: 
  
   * Book me the biz trip to San Francisco 
   * Reserve a table at Kisaku for 5 people at 7 tonight.
<br>
<br>
4. The fourth category is __decision support.__ The goal for this bot category is to help the user come to a decision. Questions a user might ask include: 
  
   * Why are sales in China so far behind forecast?
   * What is the optimal treatment plan for this patient?  
  
To be trusted, bots need to be convincing, so being able to mix goal-oriented behavior and social elements (in a way that respects the user’s context and needs) is actually a vitally important consideration.

## Common stakeholders
In any interaction with a bot, there are far more stakeholders than just users, bots, and developers. Here’s a list of stakeholders and the considerations that come out of their relationship with the bot, broken down by category: 

1. __The user__ - the human speaking with the bot. This is the stakeholder that requires the most immediate attention, as non-ideal bot behavior may: 
   * __Social engagement__ - negative interactions can affect the user emotionally
   * __Information consumption__ - poor-quality replies or incorrect information may misinform the user
   * __Task completion__ - tasks can’t get done, and productivity is harmed, if the bot isn’t able to understand requests or perform according to instructions
   * __Decision support__ - it’s all too easy for poor implementation to lead the user into making a (literally) ill-advised decision
<br>
<br>
2. __The entity represented by the agent.__ This stakeholder is the brand, business, person, or other entity that the chatbot represents. Unintended consequences may affect the business practices and reputation of the chatbot owner.
<br>
<br>
3. __Third parties mentioned in, or listening to, a conversation.__ Mentioning a third party in conversation can inadvertently make them stakeholders. Then there’s people who may not be named, but can still be listening in. Both of these stakeholders are commonly overlooked, but they’re very important to consider. A bot deployment will often involve people listening in by design - for instance, all social media bot deployments have multiple third parties. Even for bots that are designed to be one-on-one with the user, users can still take screenshots. It’s very easy for bot interactions to be amplified beyond the original intended users, and in some scenarios this means exposure to the general public, amplified through viral social and traditional media. However, this problem also presents an opportunity - it can be useful to have a large user base that can potentially sound the alarm about bad bot behavior.  

