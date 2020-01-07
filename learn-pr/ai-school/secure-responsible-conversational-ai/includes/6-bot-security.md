Data and security breaches are all too common, and this creates huge problems for technology users. A security breach can often directly result in further problems for users, like identity theft. Severe consequences besides loss of trust can follow from security breaches, no matter the cause — and this is particularly true when those who were meant to be safeguarding the data are found to have been negligent in their duty of care. 

Users have every right to expect that their data is handled securely by your bot. As such, the success of your bot depends on deservedly keeping your users trust. 

## Designing for security

Consider security a key feature of your bot’s design. Create a threat model for your system, to identify attack vectors and simulate responses.

Consider using [Microsoft’s Threat Model Tool](https://docs.microsoft.com/en-us/azure/security/azure-security-threat-modeling-tool-getting-started "Microsoft's Threat Model Tool") to aid in developing this for your bot. 

When it comes to cybersecurity, the best offense is often to have nothing, or very little, to defend. When you’re taking or storing user information, design your system to store only key information to reduce the risk from attack. 

## Establish secure development and operations foundations

Working within the framework of established secure software development principles is vitally important. As with any AI system, your bot should ensure proper authentication, separation of duty, input validation and mitigations for denial-of-service attacks.  If available, work with the appropriate security team within your organization to conduct a security review on your bot and supporting services. Given the close relationship of security and privacy in this space, a joint security/privacy review is recommended to ensure the best depth and breadth of coverage.

## Implement systems to detect abnormal behaviors, and prevent manipulation

Semi-autonomous systems can identify users that deviate from norms, including bots that exhibit behavior that might indicate they’re a non-human actor. These might include strange activity patterns like responding too fast, or being active at unusual times, or triggering parts of your application in a way that normal users don’t. 

## Ensure the integrity of your training data

This step is particularly important for systems that employ automatic, or unsupervised, training techniques. If your system can’t distinguish between maliciously introduced data and rare but valid data, your bot has a serious problem.

### Data sources
Neural models for conversational AI  typically need to be trained on a dataset of around 5 million conversations. Common data sources include: 
* Hand-written rules
* Existing conversational data (whether large-scale or small-scale)
* New online conversations.
Naturally occurring conversational data is hard to obtain, for reasons of privacy. However, conversations on public social media sites (for example, from Twitter and Reddit) are one common source of training data. Bear in mind that conversational types vary by the social medium they appear in - for instance, Twitter conversations tend to be conversation-like and interactive; Reddit exchanges are more like a roundtable where individuals contribute a statement to a discussion.

Sources that are intrinsically private in nature, such as customer and service interaction data, may come under significant restrictions. They’ll require anonymization, and may only be subject to machine learning under eyes-off processes that don’t include personal information.

### Cleaning training data

No matter where your training data is sourced from, it will need to be cleaned before it’s usable. This helps make sure that it conforms to social norms, is grammatically correct, that it conforms to the persona required for your chatbot, and that it doesn’t include personal or identifying information. Special attention should go towards removing or completely anonymize personal information, such as phone numbers, email addresses, zip codes. If this isn’t done, sensitive data like credit card numbers and social security numbers may end up being transmitted naively or maliciously in open conversations. Developers should always consider the possibility that machine learned generative models are capable of accidentally exposing such information given the right inputs.

Although social media itself is notoriously noisy, extended conversations tend to be relatively clean. Once the data is scrubbed, it can produce models that usually conform to social norms. However, to protect against bad inputs, your training data should include and allow for malformed utterances - spelling mistakes, emotional outbursts, and the like.

Bear in mind that potentially offensive terms have different meanings depending on context. This means that using text-matching methods for identifying text to be deleted must be done carefully. For instance, if you don’t want to talk about “weed”, you could potentially flag this word for deletion, but if your chatbot is for a gardening business you’ll probably want “weed” to stay in!

It’s generally not a good idea to remove all offensive material from training data. In fact, you’ll actually need to train your model on what to do with offensive inputs and how to handle them appropriately. This means that targeted outputs should be what’s moderated to conform with community standards. But, as mentioned, it’s not enough just to block individual words. In AI, the Jurassic Park principle (“Life finds a way”) always applies. Blocking the word “hate” to avoid generating “I hate \[ethnic group]” may result in the model surfacing the semantically similar “I am not a fan of \[ethnic group]” instead.

In summary - until models can be fully grounded in an understanding of their social environments, it’s probably inevitable that malicious adversaries will continue to probe the boundaries of chatbot deployments. To stay one step ahead, you should ensure that you secure the data necessary to anticipate and thwart such attacks.

# You are responsible for your bot

At the end of the day, you are responsible for what your bot does and says. This article talks about guidelines to ensure that you can detect and remedy issues in your bot.

Modern bots are incredibly useful, and they are only becoming more so. However, at this point in time, they are still a long way from fully autonomous. AI experts disagree on when full AI autonomy will appear — if it ever does. Even the most optimistic estimates predict true autonomy / machine sentience will not arrive for another 50 years. Until, and if, that ever occurs, human designers will always bear the ultimate moral and ethical burden of what they create.

## Build human supervision feedback loops into they system by design

Your bot shouldn’t be able to run away with you. Building human feedback loops into your autonomous system prevents the law of unintended consequences from getting away from you. It’s a very simple lesson, but it’s still true: one of the most important functions of any machine is a working “off” switch. 

## Determine roles within your organization that clearly define who is responsible for what

Every organization, even organizations of one, have someone to whom ultimate responsibility for your bot can be assigned. Before your bot is deployed, your organization needs to decide who that is for you. If you are developing a bot that your organization will deploy, you should recognize that you are fully responsible for its operation and how it affects people. If you are designing a bot to be deployed by a third party, come to a shared understanding with them of who is ultimately responsible for the bot and document that understanding.

## Monitoring and automated controls

__Ensure that monitoring is tied into an automated alert system__, and dedicate resources and time to monitoring and assessing your bots performance.

Truly autonomous AI may still be hypothetical, but until (or if) it does arise, one thing remains true: The developers of bots have responsibility, and are accountable, for their operations. As bots become more and more powerful, this will only become more true. This course has shown you how to take real responsibility for your bot. It’s not an easy task, but it is worth it. Ethical AI development will ensure that AI becomes a trusted tool to help all of humanity, and bots will go on to assist us in ways that we currently can barely dream of.

The Ten Bot Commandments

1. Make sure you understand why your bot exists — and that you, and your users, understand the consequences of using it. 
2. Make sure your users know they’re working with a bot. 
3. Make sure your bot can ask a human for help
4. Make sure your bot isn’t accidentally evil - and make doubly sure that users can’t make it evil. 
5. Make sure your bot works, and that it will keep working. 
6. Make sure your bot treats all users fairly. 
7. Make sure your bot respects users privacy. 
8. Make sure your bot handles data safely. 
9. Make sure your bot can be used by the widest range of people possible. 
10. You are responsible for your bot’s actions. 
