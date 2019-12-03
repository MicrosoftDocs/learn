Copied from ILT

## Design a process to capture and analyze user feedback

“People are talking about you and your competitors constantly. They could be asking for help, complaining about a bug, or raving about how much they love you. And you want to stay on top of all those conversations. Your customers' opinions matter, not just to PR & marketing, but to every team – from customer support to product development to sales. But sifting through irrelevant posts on multiple channels is overwhelming and can be a huge time drain. Sometimes it's not even possible when they don't tag or link to you. That’s where scanning tools comes in. Scanning tools make it easy for you to find people talking about you, but not necessarily to you (when they don't @mention your account) - and reach out or take notes when necessary. There are so many business opportunities to uncover if you know where to look.”

Although there isn’t a specific survey question you can ask … it’s important to get a general pulse on what your customers are saying over time about your company. Here’s the pros and cons:

Pros	Cons
No burden on the customer to complete a survey. In their natural environment.	Difficult to measure and quantify which makes it nearly impossible to track performance over time.
Get a true measure of what customers think about you as this method is entirely organic.	Challenging to tie social media comments back to a CRM system at scale.
Customer feedback doesn’t just come in through your site’s contact form – it’s everywhere. You only have to search the Twitter handle of any product with more than a few hundred users to see that customers love to offer their opinion – positive and negative. It’s useful to be monitoring this and learning from it, but casually collecting feedback on an ad-hoc basis isn’t enough.

Startups thrive on feedback as their ‘North star’, and are constantly evolving based on what their customers request, break, and complain about. Enterprises also can’t overlook the fact that customers are what make any company tick, and must struggle harder than startups to stay relevant and innovate.

So, if you’re just collecting feedback ‘as and when’ it comes in, you’re missing out on data that’s just as important as page views or engagement. It’s like deciding not to bother setting up Google Analytics on your homepage, or not properly configuring your CRM; in the end, you’re deciding to not benefit from data that will have a transformative effect on your product strategy. With a dataset of feedback – whether that’s from customer reviews, support tickets, or social media – you can dig into the words your customers are using to describe certain parts of your product and get insights into what they like, and what they don’t like.

Here’s the kind of end result you can get with this

![A something here](../media/4-feedback-results.png)

The outcome of AI analysis on Slack reviews. The categories on the left refer to different parts of Slack’s product, and the bars represent how positively or negatively customers feel about each.

![A something here](../media/4-sentiment.png)

As the saying goes, “For every customer who bothers to complain, 20 other customers remain silent.”

Unless the experience is really bad, customers usually don’t bother to share feedback about an experience that didn’t meet their expectations. Instead, they decide never to do business with the service provider again. That’s a high price to pay for lost feedback.

An excellent source of feedback is on other websites, such as online communities, blogs, local listings, and so on. If your customers are not happy with the resolution to a negative experience, they are likely to vent their ire on these forums. The lost customer is not the only casualty. Studies have shown that each dissatisfied customer typically shares the unsatisfactory experience with 8 to 10 (sometimes even 20) others. With the growing use of social media, it’s not uncommon for negative feedback to go viral and hurt the credibility of a brand.

## Release Gates

Any responsible DevOps practice uses techniques to limit the damage done by bugs that get deployed into production. One of the common techniques is to break up a production environment into a set of separate instances of an app and then configure deployments to only update one instance at a time, with a waiting period between them. During that waiting period, you watch for any signs (telemetry, customer complaints, etc.) that there is a problem and if so, halt the deployment, fix the issue and then continue the deployment. This way, any bug you deploy only affects a small fraction of your user base. In fact, often, the first product environment in the sequence is often one only available to internal people in your organization so you can validate the changes before they hit “real” customers. None-the-less, sometimes issues make it through.

Release gates automate the waiting period between environments in release pipelines. They enable you to configure conditions that will cause the release wait. Out of the box, a few conditions are supported namely Azure monitoring alerts and Work item queries. Using the first, you can have your release hold if your monitoring alerts are indicating that the environments you’ve already deployed to are unhealthy. And the second allows you to automatically pause releases if anyone files a “blocking bug” against the release.

However, one of the things you'll quickly learn is that no amount of monitoring will catch every single problem and, particularly, if you have a popular application, your users will know within seconds and turn very quickly to Twitter to start asking about the problem. Twitter can be a wonderful “alert” to let you know something is wrong with your app.

The Twitter sentiment release gate that can be downloaded from the Visual Studio Marketplace enables exactly this. It leverages Azure DevOps, Azure functions and Microsoft AI to analyze sentiment on your Twitter handle and gate your release progress based on it. The current implementation of the analysis is relatively simple and serves as a sample as much as anything else. It shows how easy it is to extend Azure DevOps release gates to measure any signal you choose and use that signal to manage your release process.

Once you install the Twitter sentiment extension from the marketplace, you’ll need to follow the instructions to configure an Azure function to measure and analyze your sentiment. Then you can go into your Azure DevOps release pipelines and you will find a new release gate enabled.

Start by clicking on Post-deployment conditions on one of your environments.

(This is using the old release pipeline)

(Able Wang Video - Deploy with RM greenlight capabilities)
