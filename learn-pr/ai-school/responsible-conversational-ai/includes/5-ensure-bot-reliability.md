If your bot is not reliable then your users will not trust it, or even avoid it completely. First impressions are important and once you’ve lost your user's confidence it can be hard to get it back.

For a bot to be useful, it must actually work. Humans are quick to discount experiences that don’t work, and our negativity bias will ensure that if a new experience is bad for us, we won't only avoid it in future - we’ll tell all our friends to avoid it as well! On the other hand, we have a strong tendency to repeat behaviors we find useful, and having a reliable bot will quickly build a habit of reuse among your users.

## Clearly define the actions that your bot is able to perform

As part of the design process, you need to build an understanding of the actions that your bot will be able to perform. Consider the questions that your bot will need to answer - and plan for the different ways that your users might ask for questions. Because AI systems are generally probabilistic, they will not always provide the correct answer, so, as discussed in the previous unit, you should allow for the probability of incorrect answers and provide the user with options should they be unsatisfied with the information the bot conveys. And if your bot is intended for deployment in a sensitive area, you should consider consulting a subject matter expert.

A sensitive area can be a number of things - it can include fraught or consequential applications like national/regional security, healthcare, finances, but it can extend to personal beliefs or cultural values. Sensitive areas can be anything relating to gender, sexuality, religion, politics, race, or other topics that relate to or evoke strong feelings.

## Establish reliability metrics

What is an acceptable rate of error for your bot? What is a desirable ratio of positive to negative interactions with users? Decide on these metrics early, and then build reviews into both the bot - it should be able to report on these metrics autonomously - and your own processes. Again, the domain of the bot will determine how much reliability it requires. A bot intended for use in army recruitment will need to have a much lower margin for error than one that, for example, helps users select new socks for purchase. Do bear in mind, though, that for all applications the ideal error rate is the one closest to zero.

## Design a two-way feedback mechanism

Users will be much more forgiving of your bot if it’s possible to give it - and its developers - feedback. And if something goes wrong, and the error isn’t otherwise obvious, the bot should be able to notify the user of the problem.

## Make sure your bot can ask a human for help

Inevitably, some (if not quite a few!) problems can’t be solved through user-bot interaction alone. The system, while not necessarily needing to immediately accommodate “I just want to talk to a human!”-type demands, should always be designed so a bot knows when it needs to hand off to a human operator. And this decision should be driven by respect for your user. Some users simply won’t want to talk to a bot, and this understandable sentiment should be accommodated in your design. Reliability signals can be developed to help drive these kind of decisions, so the handoff occurs at the appropriate time and in the smoothest possible way.

This is especially important for bots that work in sensitive or critical areas. Human users need to be assured that the bot can call for help, and the call will be answered. Users will feel much more comfortable with bots, and will have a much higher level of trust, if they know a human is just around the corner.

Being able to gauge a user’s sentiment from moment to moment is invaluable for good bot interaction. For sentiment analysis, feedback, and to identify human handoff points, you could integrate Azure Cognitive Services like [Text Analytics](/azure/bot-service/bot-service-design-pattern-handoff-human?view=azure-bot-service-4.0 "Text Analytics") or [Content Moderator](https://azure.microsoft.com/services/cognitive-services/content-moderator/ "Content Moderator").

## Build traceability into your bot

Once a bot is up and running, you need to make sure that its performance in set tasks is being tested regularly, and any issues are being addressed. When something goes wrong - and it will go wrong - this is where traceability is very important. Especially in a high-value interaction, which might include things like the transfer of personal details, or the taking of cash payments.

*Traceability can be implemented using a number of off-the-shelf frameworks, including [Azure Application Insights](/azure/azure-monitor/app/app-insights-overview "Azure Application Insights").*

With traceability implemented, you’ll need to have a support system where issues and limitations can be investigated and resolved. And make sure you consider the differences between your development, testing, and production environments when you’re testing new features. The “real world” of a production environment is always more fraught than the relatively safe haven of a dev environment. Even if you think you’re throwing every test and curveball at your bot a user could ever think of, this will often prove to be untrue very quickly - often within days if not minutes of deployment. Much like in Jurassic Park, life finds a way. In this case, it will find a way to break your software, so traceability and support are of paramount importance.

## Help the user understand how the bot can help them - and explain the bot’s limitations

If you tell the user up-front exactly how the bot is designed to help them, and explain the ways they can use it or things they can ask it for, they’re more likely to interact with it in a useful way. You should also let the user know the bot’s limitations. This step helps build trust with the user, and it will help them avoid behavior that would otherwise only result in frustration. Also consider where troubleshooting steps might benefit the user. For example, if they’re not getting what they need from the bot, the bot will need to explain how this can be fixed - which includes handing off to a human operator.

*Helping a user understand a bot’s capabilities could be in the form of a menu, or a text command, or a quick explanation of limitations when the user attempts something beyond the bot’s parameters.*

## Make sure your feedback mechanism is genuine

Users will feel a lot more comfortable with bots if they know that their feedback is genuinely valuable and will be acted upon. Conversely, they won’t give useful feedback, or any feedback at all, if they don’t feel it will be taken on board. The last thing you want is quiet users. To avoid this, set expectations about how feedback will be reviewed and received, and whether the user will get any response to feedback provided. Ideally, you’ll be able to let users know when their feedback was acted upon.