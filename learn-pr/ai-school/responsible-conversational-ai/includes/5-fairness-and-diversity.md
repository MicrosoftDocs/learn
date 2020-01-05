The possibility that AI-based systems will perpetuate existing societal biases, or introduce new biases, is one of the top concerns identified by the AI community. This is a very valid concern. Many instances of machine learning and other tools in the AI stable perpetuating societal issues have already been identified, and more appear in the news almost daily. A bot will not earn trust by mimicking or adopting humanity’s worst traits, or participating in behaviour that perpetuates problems. 

A recent example is that of a  machine learning bot used in recruitment that was found to be copying and expanding upon a particular societal issue - that female and “foreign”-sounding names on resumes tended to be discounted by recruiters. The bot, which was meant to have learned from human recruiting best practice, inadvertently perpetuated and magnified existing biases. 

This has been allowed to happen so far because (in addition to a number of social issues that are beyond the scope of this content) AI has often been seen to be inherently without bias, as it has no true mind of its own and is based on mathematical functions. While it is entirely technically correct that mathematical functions on their own lack bias, this is a specious argument, as the application of any function by humans can certainly be discriminatory, and if the application is assumed not to be discriminatory because of its mathematical origins, this actually increases the likelihood that discrimination will sneak in the back door. The fact that algorithmic bias is usually not intentional is in itself the problem. Most people are not intentionally biased; and blind spots are invisible to everyone who has them by their very nature of blind spots! In software, as in life, it’s only by careful reflection and examination that these blind spots can be revealed, and corrected for. 

## Consider the potential biases that your bot may - and probably does - contain

The best way to identify these biases before deployment is to include fairness and diversity at every level of the ideation and creation process. It’s important too to explicitly include diversity in the design of your feedback mechanisms to encourage representation and avoid alienation of groups that would otherwise not be well represented.

## Continually monitor and assess the data used, consumed and produced by your bot and its AI systems

An old adage is just as true for AI as it is for people and is easily adapted to fit: Bias in, bias out. If your bot is consuming a biased dataset, it will produce the same bias in its results. Wherever possible, create monitoring systems to ensure that your bot has appropriate representativeness and quality. Make sure you do your best to understand the lineage and the relevant attributes of your training data. Bias detection tools are now beginning to appear; you should adopt them as they become available. 

Another powerful tool against bias is for development teams to commit to the ideal of treating all people fairly. This needs to start at the team level on up. Strive for diversity in your teams - this will help ensure that you account for different perspectives and backgrounds while building your bot.

Perfection is impossible, but that shouldn’t stop us striving to make our bots the best they can be. While the nature of humanity may prevent bias from being eliminated altogether, being conscious of the likely presence of bias, and taking steps to curb its worst effects, will help prevent your bot from creating more problems than it solves. It’ll also allows you to learn quickly once your bot is deployed, and to correct for instances of bias that do get in to production environments.

# Make sure your bot respects users' privacy

When building your bot you need to consider the privacy of your users. In this article you will learn about how to build privacy into your bot and other considerations to ensure your bot is handling your user’s data responsibly.

Privacy considerations are important with any software application, but this is extremely so with bots. Bots are a unique interface that can learn a great deal of particularly personal information from users. Due in large part to the trust that bot creators should always be trying hard to create, users may share more information with bots than they would with other services. The legislative world is well aware of this, and legal frameworks are keeping pace with bot development and are demanding user privacy be respected. We have included a subsection on the European Union’s landmark privacy legislation, GDPR, below. 

As a matter of ethical and sound legal principle, you should be very careful with any information that your bot collects from users. 

## Your bot should only collect information from users that it needs to perform its job

It’s also important to design user privacy controls into the bot. Users should be able to find out, easily and without having to jump through hoops, all the information that the bot knows about them, so design this right into the bot. You should also obtain and privacy reviews before going too far into development to ensure your bot is compliant with relevant laws in your own jurisdiction, as well as any locale that users will be operating in.

## Implementation

Inform users up-front about what data is being collected, and what it’s being used for. 
Always give your users the option of which external services to share your data with and an option to opt-out where possible. And don’t make a bot that’s dependent on sharing data with outside services where you can’t verify data security or user privacy. 

As mentioned above in “Design”, you should include in your deployment the opportunity to share with users all the data that the bot has collected on them. This might be best implemented as a “profile page” which includes the ability to manage privacy settings, plus any relevant legal information pertaining to their data. 

As well as giving users the option to see what personal data the bot collects, you should also make it possible for the bot to forget about any information that the user has entered erroneously, or simply wants to be forgotten. 

## Privacy in the European Union

> The EU General Data Protection Regulation (GDPR) is the most important change in data privacy regulation in 20 years.

If the users of your bot are located in the European Union you will be subject to the The EU General Data Protection Regulation known as GDPR. It doesn’t matter where your company based out of, if you have users who live in an EU country then you will need to consider this regulation.

GDPR grants users four main rights which are referred to as Data Subject Rights:

- __Breach Notification__ - Breach notifications must be made within 72 hours of the company becoming aware of the breach.
- __Right to access__ - Users have the right get confirmation of whether or not personal data concerning them is being processed, where and for what purpose
- __Right to be forgotten__ - Also known as Data Erasure, users have the right to delete any information that is held on them
- __Data portability__ - Users have the right to get access to the data held on them in plain and machine readable format.

A key tenet is not to store any more information that you need to perform the function of the bot. If you are concerned about whether or not your are compliant it’s advised to get a GDPR expert involved in your project.

Sometimes, a user’s desire for privacy will conflict with the ability for your bot to provide a service to them. If that happens, that’s OK. It’s better for your bot to be upfront and transparent with privacy and personal information, and offer the user complete (secure) control over what to do with that information. In the long run, this will build trust and help prevent abuse.

