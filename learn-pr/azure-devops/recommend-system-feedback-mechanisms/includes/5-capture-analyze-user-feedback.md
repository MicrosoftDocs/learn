The team is still planning out their strategy for collecting feedback from their beta testers.

**Tim**: One thing we've overlooked is what our testers are going to be telling each other, and their friends, and any other gamer out there, on Twitter and Reddit and who knows where else. That could be more important than what they tell us.

**Mara**: Oh, good point.

**Andy**: And bad news travels fast. We could put some controls into the code that would let us shut off any problem areas. Something like a release gate.

## Capture and analyze user feedback

The team needs to collect data from many sources, including external ones and not just the sources they put in place themselves. Why? Because people are talking about you and your competitors constantly. They could be asking for help, complaining about a bug, or raving about how much they love you. And you want to stay on top of all those conversations. Your customers' opinions matter, not just to public relations and marketing, but to every team – from customer support to product development to sales.

But sifting through irrelevant posts on multiple channels is overwhelming and can be a huge time sink. Sometimes it's not even possible when people don't tag you or link to you.

That's where scanning tools come in. Scanning tools make it easy for you to find people who are talking about you but not necessarily to you. There are so many business opportunities to uncover if you know where to look.

Here are some pros and cons you might consider when deciding whether to use a scanning tool to gauge customer sentiment:

| Pros                                                                                     | Cons                                                                                               |
|------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| There's no pressure or burden on the customer to complete a survey. Feedback happens naturally.            | It can be difficult to measure and quantify, which makes it nearly impossible to track performance over time. |
| It provides a true measure of what customers think about you, as this method is entirely organic. | It can be challenging to tie social media comments back to a customer relationship management (CRM) system at scale.                            |

Startups thrive on feedback as their "north star", and are constantly evolving based on what their customers request and complain about. This also applies to enterprises, who know that customers are what make any company thrive, and are aware that, because of their size, they must often work harder than startups to stay relevant and to innovate.

If you're just collecting feedback when it comes in, you're missing data that's as important as page views or engagement. It's like deciding not to bother setting up Google Analytics on your homepage, or not properly configuring your CRM. In the end, you're deciding to not benefit from data that may have a transformative effect on your product strategy.

With a dataset of feedback – whether that's from customer reviews, support tickets, or social media – you can dig into the words your customers are using to describe certain parts of your product and get insights into what they like, and perhaps more importantly, what they don't like.

Here's a diagram that shows automated analysis category sentiment for Slack, the instant messaging platform developed by Slack Technologies.

![A bar chart showing customer sentiment for Slack, weighted by category](../media/5-feedback-results.png)

The categories on the left refer to different parts of Slack's product, and the bars represent how positively or negatively customers feel about each.

With the data, you can also build a summary that helps you focus on the most positive and the most negative parts of your product. You might summarize the Slack bar chart like this:

![A something here](../media/5-sentiment.png)

As the saying goes, "For every customer who bothers to complain, 20 other customers remain silent."

An excellent source of feedback is on other websites, such as online communities, blogs, local listings, and so on. If your customers aren't happy with the resolution to a negative experience, they're likely to vent their frustrations on these forums. A frustrated customer is more than a potentially lost customer. Studies have shown that each dissatisfied customer typically shares the unsatisfactory experience with eight to 10 (sometimes 20 or more) others. Now, with social media, it's not uncommon for negative feedback to go viral and hurt the credibility of a brand.

## Use release gates to validate your deployments

Any good DevOps practice uses techniques to limit the damage done by bugs that get deployed into production.

One common technique is to break up a production environment into a set of separate instances of an app and then configure deployments to only update one instance at a time, with a waiting period between them. During that waiting period, you watch for any signs (telemetry, customer complaints, and so on) that there is a problem. If a problem arises, you halt the deployment, fix the issue, and then continue the deployment. This way, any bug you deploy only affects a small portion of your customer base. Often, the first environment in your release pipeline is available only to people within your organization. This enables you to validate changes before they reach your customers.

_Release gates_ automate the waiting period between environments in release pipelines. They enable you to configure the conditions that cause the release to wait. For example, you can use Azure monitoring alerts to pause your release if monitoring alerts indicate that the environments you've deployed to are unhealthy. Or, you can use a work item query to automatically pause a release if anyone files a critical bug against the release.

However, one thing you'll quickly learn is that no amount of monitoring will catch every single problem. If you have a popular application, your users will know about a problem within seconds and turn quickly to Twitter to start asking about it. Twitter can be a wonderful "alert" to let you know something is wrong with your app.

You can use the [Twitter Sentiment Analysis](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.vss-services-twittersentimentanalysis?azure-portal=true) extension to create a release gate that calculates the average sentiment of tweets made for a given hashtag. This extension combines Azure DevOps, Azure functions, and Microsoft AI to analyze sentiment on your Twitter handle and gate your release progress based on sentiment. The analysis is relatively simple, but shows how easy it is to extend release gates in Azure DevOps to measure any signal you choose and use that signal to manage your release process.

## The decision

**Tim**: I'm happy to keep an eye on tweets, subreddits, and such. I enjoy lurking.

**Andy**: Thanks. Mara, you and I can think about release gates.

**Tim**: Since we're talking about data collection, there's one more point I want to bring up.