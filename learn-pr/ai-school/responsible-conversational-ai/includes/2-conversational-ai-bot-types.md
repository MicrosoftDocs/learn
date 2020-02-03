There are, roughly, four different types of Conversational AI bots. Most bots will actually mix these characteristics in any given implementation, as all four are required for a reasonably realistic simulacra of human conversation. A bot that can’t engage in light conversation will come off as, well, robotic. 

1. The first category is casual conversation engagement. This sort of bot’s purpose is to facilitate __social engagement__ - either with the bot itself, or other users. User inputs would look something like this:
  
   * What’s your favorite type of pizza?
   * I hope the Giants win tonight.
<br>
2. The second category is __information consumption__, where the bot tries to assist the user by answering user questions. This might look like:
  
   * What room is the project review meeting in?
   * When is the ACL 2018 conference?
<br>
3. The third category is __task completion__. The aim here is to assist the user by helping them get tasks done. User inputs for this category might be as follows:
  
   * Book me the biz trip to San Francisco
   * Reserve a table at Kisaku for 5 people at 7 tonight.
<br>
4. The fourth category is __decision support__. The goal for this bot category is to help the user come to a decision. Questions a user might ask include:
  
   * Why are sales in China so far behind forecast?
   * What is the optimal treatment plan for this patient?  
  
To be trusted, bots need to be convincing, so mixing goal-oriented behavior and social elements (in a way that respects the user’s context and needs) is a vitally important consideration.

## Common stakeholders

In any interaction with a bot, there are far more stakeholders than just users, bots, and developers. Here’s a list of stakeholders and the considerations that come out of their relationship with the bot, broken down by category:

1. __The user__ - the human interacting with the bot. Users are the stakeholder that requires the most immediate attention, as non-ideal bot behavior may:
   * __Social engagement__ - negative interactions can affect the user emotionally
   * __Information consumption__ - poor-quality replies or incorrect information may misinform the user
   * __Task completion__ - tasks can’t get done, and productivity is harmed, if the bot isn’t able to understand requests or function as instructed
   * __Decision support__ - it’s all too easy for poor implementation to lead the user into making a (literally) ill-advised decision
<br>
2. __The entity represented by the bot.__ This stakeholder is the brand, business, person, or other entity that the chatbot represents. Unintended consequences may affect the business practices and reputation of the chatbot owner.
<br>
3. __Third parties mentioned in, or listening to, a conversation.__ Mentioning a third party in conversation can inadvertently make them stakeholders. Then there’s people who may not be named, but can still be listening in. Both of these stakeholders are commonly overlooked, but they’re very important to consider. A bot deployment will often involve people listening in by design - for instance, all social media bot deployments have multiple third parties. Even for bots that are designed to be one-on-one with the user, users can still take screenshots. It’s very easy for bot interactions to be amplified beyond the original intended users, and in some scenarios this means exposure to the general public, amplified through viral social and traditional media. However, this problem also presents an opportunity - it can be useful to have a large user base that can potentially sound the alarm about bad bot behavior.  
