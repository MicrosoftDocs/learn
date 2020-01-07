Ethical design is always important, for any application, but it becomes even more so when there is a particularly consequential purpose to your bot - including healthcare, education, finance, or security applications. 

A consequential use case may be defined as one that involves a service that, if denied, would  have meaningful and significant impacts on someone’s daily life. 

If your bot includes any of these applications or might have consequential impacts, it’s important to design for them, which includes making sure a human handoff is always and immediately available to the user — and could include choosing not to employ a bot at all, at this time.

## Designing for consequential use cases

Before beginning any work on your bot, design or otherwise, first consider if your bot has the capability to affect the well-being of your user, or if there are any legal requirements to consider. Some actions may ethically and/or legally require human judgment or approval. 
Common instances include financial or healthcare systems.

For example, many countries have strict rules around  which institutions and individuals can hand out financial advice, and there are further rules around what information actually is financial advice. In a jurisdiction like this, a bot operating in the fin-web space must be programmed carefully to make sure it does not stray into accidentally handing out legally fraught information. If a bot breaks the law, liability can be many pronged - but legal responsibility will almost always begin and end with the developer.

## Is the use case suitable for automation at all?

Some use cases, particularly in those industries where human health is at stake or threatened, are currently too important or too fraught for automation. Some things are simply too critical to be left to machines. However, simply because a use case is consequential, doesn’t mean it isn’t suitable to automation. In fact, many life-saving technologies would never have been deployed at all if their developers had stopped at the fact that their use involves great risks.

What does this mean for bot deployment and automation? While “gut feeling” may be a useful guide, it can often be misleading. When use cases are consequential, it’s vitally important to consult with a wide range of experts in the domain to ensure that your application isn’t going to cause serious adverse impacts if it doesn’t work as expected.

> “The first rule of any technology used in a business is that automation applied to an efficient operation will magnify the efficiency. The second is that automation applied to an inefficient operation will magnify the inefficiency” — Bill Gates. 

We might well extend Gates’ maxim on automation to consequential use cases. If the automation is applied poorly, it will exacerbate adverse effects. But if automation is applied well, conversational AI bots may be able to help preserve or extend human life, magnify and protect wealth, and increase education. Just because a use case is consequential doesn’t mean it shouldn’t have automation applied - however, it does require that the question of whether automation should be applied, and if so, how it should be done, be taken very seriously and with all due care.

# Ensuring your bot is respectful and protects against misuse

It’s important that your conversational AI is respectful of your users needs as well as protects against misuse. In this section, you will learn how to safeguard your bot to ensure that it respects your users needs and is protected from misuse.

Since bots are most often designed to appear like humans, it’s important that they are respectful of human needs, and that they have built-in safeguards to defend against and handle misuse and abuse. This is doubly important because if human history in the time of the internet has taught us anything, it is that Murphy’s Law holds true for information systems — especially those populated by myriad, malicious, anonymous actors. Anything that can go wrong will go wrong, and any system that can be exploited will be exploited.

## Design your bot so that it respects relevant cultural norms and practices

Limiting the actions of a bot to the actions it’s actually designed to do will reduce (but not eliminate) the chances that it will violate cultural norms. For example, if your bot is designed to order pizza, you can design the interface so conversations are limited to that topic. More open conversations can be considered high-risk, as they will require much up-front investment in content, as well as substantial monitoring.

## Create a code of conduct, make it available to your users, and enforce it

Making a code of conduct that is expected to be followed is especially important if the bot allows your users to interact with each other in any way. Common and important provisions of codes of conduct include prohibitions on things like hate speech and bullying, as well as positive instructions on how to interact with the bot and other users on the platform. 

Codes of conduct are not laws, but they can and should be enforced. While there are grey areas on the borders of any set of guidelines, beware of users who seek to weaponize these. For example, while free speech is an incredibly important moral and ethical consideration, malicious actors who seek to hide behind a facade of free speech to make hateful attacks or to peddle a racist agenda need not be permitted continued access to a bot. This is where the flexibility of guidelines cuts both ways, allowing for human operators to make edge-case decisions. (This is one reason why moderation should never be left entirely to bots.).

## Consider the locales and cultures your bot will operate in

Deploying a bot for an audience of people that does not look like its developers is one area where assumption can be extremely problematic. Large, diverse audiences for your product are one reason to have a diverse team who can raise any potential issues prior to production. 

Moreover, if your bot is to be deployed in a culture or locale markedly different to the one it is developed in, it will often be necessary to invest in a translator. A good translator or translation service will translate not only language but will identify and help solve issues around cultural practice.

## Design a feedback mechanism so users can report misuse

As part of its feedback processes, your users should be able to identify and report instances of abuse, and your bot should be able to learn from reports that are flagged as positives.  Like all feedback, the understanding that it will be taken seriously and followed through will help ensure users are engaged and acting in good faith.

## Apply language and content filters, erring on the side of caution

Filters and content should be applied more broadly and then altered to suit the working environment as the bot and developers learn from users. The implementation should be two-way, including responses made by the bot as well as users. In other words: a user shouldn’t be able to swear at a bot without seeing it censored, and the bot shouldn’t be able to swear back!

The Microsoft Bot Framework includes offensive text classifiers, and can help protect your bot and its users from abuse. 

It’s recommended to avoid controversial topics as entirely as possible. Truly controversial topics, or those that can cause offense or distress along the lines of race, gender, sexuality, politics, and the like, all fall under the category of consequential use cases, and should be treated with the same ethical gravity and care. Other common sensitive topics include adult content, extremism, drugs, alcohol, tobacco, vulgarity, harassment, bullying, violence and gore, and hate speech. Any conversational AI bot implementation in these areas or dealing with these topics needs extremely careful implementation - or, often, no implementation at all. 

## Public facing bot APIs need to be carefully monitored

If you have or intend to have a publicly accessible bot API, this is a consequential use case. A conversational AI bot, maliciously deployed or used, can do emotional or cultural damage analogous to a computer virus. This can be extremely fraught for organizations and their customers. Appropriate safeguards need to be put in place to prevent malicious use, and APIs should be reviewed to make sure they cannot be used by people outside your organization in a way that would reflect poorly on you.

If a bot’s use case doesn’t call for it to engage with culturally sensitive or potentially offensive content, don’t give it the ability to do so. A bot should only do its job; nothing more. However, this doesn’t mean these concerns aren’t of importance even in the most mundane use cases. Make sure they’re always top of mind for any bot deployment.
