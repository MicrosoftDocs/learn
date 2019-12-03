Copied from ILT

## Design a process to automate application analytics

In an Agile environment, you may typically find multiple development teams that work simultaneously, introducing new code or code changes on a daily basis, and sometimes several times a day. In such a rapid environment it is extremely common to find problems that have “slipped through the cracks” to find themselves in the production environment. When these issues arise they have probably already impacted end-users, requiring a speedy resolution.

This means that teams have to conduct an extremely rapid investigation to identify the root cause of the problem. Identifying where these symptoms are coming from and then isolating the root cause is a challenging task. Symptoms can be found across various layers of a large hybrid IT environment, such as different servers/VMs, storage devices, databases, to the front-end and server side code. Investigations that traditionally would take hours or days to complete must be completed within minutes.

Teams must examine the infrastructure and application logs as part of this investigation process. However, the massive amount of log records that are produced in these environments makes it virtually impossible to do this manually. It's much like trying to find a needle in a haystack. In most cases these investigations are conducted through the use of log management and analysis systems that collect and aggregate these logs (from infrastructure elements and applications), centralizing them in a single place and then providing search capabilities to explore the data. These solutions make it possible to conduct the investigation, but they still rely completely on the investigation skills and the knowledge of the user. The user must know exactly what to search for, and have a deep understanding of the environment in order to use them effectively.

It's important to understand that the log files of applications are far less predictable than the log files of infrastructure elements. The errors are essentially messages and error numbers that have been introduced to the code by developers in a non-consistent manner. Consequently, in most cases search queries yield thousands of results and do not include important ones, even when the user is skilled. That leaves the user with the same “needle in the haystack” situation.

As they say, “the best place to hide a dead body is page 2 of Google's search results”, and this is not very different. This process fails in light of the fast-paced reality of the DevOps activity.

Assisting DevOps with Augmented Search

A new breed of log management and analysis technologies has evolved to solve this challenge. These technologies expedite the identification and investigation processes through the use of Augmented Search. Designed specifically to deal with the chaotic and unpredictable nature of application logs, Augmented Search takes into consideration that users don't necessarily know what to search for, especially in the chaotic application layer environment.

The analysis algorithm automatically identifies errors, risk factors, and problem indicators, while analyzing their severity by combining semantic processing, statistical models, and machine learning to analyze and “understand” the events in the logs. These insights are displayed as intelligence layers on top of the search results, helping the user to quickly discover the most relevant and important information.

Although, DevOps engineers may be familiar with the infrastructure and system architecture the data is constantly changing with continuous fast pace deployment cycles and constant code changes. This means that DevOps teams can use their intuition and knowledge to start investigating each problem, but they have blind spots that consume time due to dynamic nature of the log data.

Combining the decisions that DevOps engineers makes during their investigation with the Augmented Search engine information layers on the important problems that occurred during the period of interest can help guide them through these blind spots quickly. The combination of the user's intellect, acquaintance with the system's architecture, and Augmented Search machine learning capabilities on the dynamic data makes it faster and easier to focus on the most relevant data. Here's how that works in practice:

One of the servers went down and any attempt to reinitiate the server has failed., However, since the process is running, the server seems to be up. In this case, end-users are complaining that an application is not responding. This symptom could be related to many problems in a complex environment with a large number of servers.

Focusing on the server that is behind this problem can be difficult, as it seems to be up. But finding the root cause of the problem requires a lengthy investigation even when you know which server is behind this problem.

Augmented Search will display a layer which highlights critical events that occurred during the specified time period instead of going over thousands of search results. These highlights provide information regarding the sources of the events, assisting in the triage process. At this point, DevOps enginners can understand the impact of the problem (e.g. which servers are affected by it) and then continue the investigation to find the root cause of these problems.

Using Augmented Search, DevOps engineers can identify a problem and the root cause in a matter of seconds instead of examining thousands of log events or running multiple checks on the various servers. Adding this type of visibility to log analysis, and the ability to surface critical events out of tens of thousands - and often millions - of events, is essential in a fast paced environment, in which changes are constantly introduced.

## Recommend system and feature usage tracking tools

A key factor to automating feedback is telemetry. By inserting telemetric data into your production application and environment, the DevOps team can automate feedback mechanisms while monitoring applications in real-time. DevOps teams use telemetry to see and solve problems as they occur, but this data can be useful to both technical and business users.

When properly instrumented, telemetry can also be used to see and understand in real time how customers are engaging with the application. This could be critical information for product managers, marketing teams, and customer support. Thus it’s important that feedback mechanisms share continuous intelligence with all stakeholders.

What is Telemetry and Why Should I Care?

In the software development world, telemetry can offer insights on which features end users use most, detection of bugs and issues, and offering better visibility into performance without the need to solicit feedback directly from users. In DevOps and the world of modern cloud apps, we are tracking the health and performance of an application. That telemetry data comes from application logs, infrastructure logs, metrics and events. The measurements are things like memory consumption, CPU performance, and database response time, events can be used to measure everything else such as when a user logged in, when an item is added to a basket, when a sale is made, etc.

The concept of telemetry is often confused with just logging. But logging is a tool used in the development process to diagnose errors and code flows, and it’s focused on the internal structure of a website, app, or another development project. But logging only gives you a single dimension view, combined with insights of infrastructure logs, metrics and events you have a 360 degree view to understand user intend and behaviour. Once a project is released, telemetry is what you’re looking for to enable automatic collection of data from real-world use. Telemetry is what makes it possible to collect all that raw data that becomes valuable, actionable analytics.

Benefits of Telemetry

The primary benefit of telemetry is the ability of an end user to monitor the state of an object or environment while physically far removed from it. Once you’ve shipped a product, you can’t be physically present, peering over the shoulders of thousands (or millions) of users as they engage with your product to find out what works, what’s easy, and what’s cumbersome. Thanks to telemetry, those insights can be delivered directly into a dashboard for you to analyze and act on.

Because telemetry provides insights into how well your product is working for your end users – as they use it – it’s an incredibly valuable tool for ongoing performance monitoring and management. Plus, you can use the data you’ve gathered from version 1.0 to drive improvements and prioritize updates for your release of version 2.0.

Telemetry enables you to answer questions such as:

Are your customers using the features you expect? How are they engaging with your product?
How frequently are users engaging with your app, and for what duration?
What settings options to users select most? Do they prefer certain display types, input modalities, screen orientation, or other device configurations?
What happens when crashes occur? Are crashes happening more frequently when certain features or functions are used? What’s the context surrounding a crash?
Obviously, the answers to these and the many other questions that can be answered with telemetry are invaluable to the development process, enabling you to make continuous improvements and introduce new features that, to your end users, may seem as though you’ve been reading their minds – which you have been, thanks to telemetry.

Challenges of Telemetry

Telemetry is clearly a fantastic technology, but it’s not without its challenges. The most prominent challenge – and a commonly occurring issue – is not with telemetry itself, but with your end users and their willingness to allow what some see as Big Brother-esque spying. In short, some users immediately turn it off when they notice it, meaning any data generated from their use of your product won’t be gathered or reported.

That means the experience of those users won’t be accounted for when it comes to planning your future roadmap, fixing bugs, or addressing other issues in your app. Although this isn’t necessarily a problem by itself, the issue is that users who tend to disallow these types of technologies can tend to fall into the more tech-savvy portion of your user base. This can result in the dumbing-down of software. Other users, on the other hand, take no notice to telemetry happening behind the scenes or simply ignore it if they do.

It’s a problem without a clear solution — and it doesn’t negate the overall power of telemetry for driving development — but one to keep in mind as you analyze your data. Therefore when designing a strategy for how you consider the feedback from application telemetry it's important to account for users who don't participate in providing the telemetry.

## Recommend monitoring tools and technologies

Continuous monitoring of applications in production environments is typically implemented with application performance management (APM) solutions that intelligently monitor, analyze and manage cloud, on-premise and hybrid applications and IT infrastructure. These APM solutions enable you to monitor your users’ experience and improve the stability of your application infrastructure. It helps identify the root cause of issues quickly to proactively prevent outages and keep users satisfied.

With a DevOps approach, we are also seeing more customers broaden the scope of continuous monitoring into the staging, testing and even development environments. This is possible because development and test teams that are following a DevOps approach are striving to use production-like environments for testing as much as possible. By running APM solutions earlier in the life cycle, development teams get feedback in advance of how applications will eventually perform in production and can take corrective action much earlier. In addition, operations teams that now are advising the development teams get advance knowledge and experience to better prepare and tune the production environment, resulting in far more stable releases into production.

Applications are more business critical than ever. They must be always up, always fast and always improving. Embracing a DevOps approach will allow you to reduce your cycle times to hours instead of months, but you have to keep ensuring a great user experience! Continuous monitoring of your entire DevOps life cycle will ensure development and operations teams collaborate to optimize the user experience every step of the way, leaving more time for your next big innovation.

When shortlisting a monitoring tool, you should seek the following advanced features:

Synthetic Monitoring: Developers, testers and operations staff all need to ensure that their internet and intranet mobile applications and web applications are tested and operate successfully from different points of presence around the world.

Alert Management: Developers, testers and operations staff all need to send notifications via email, voice mail, text, mobile push notifications and Slack messages when specific situations or events occur in development, testing or production environments, to get the right people’s attention and to manage their response.

Deployment Automation: Developers, testers and operations staff use different tools to schedule and deploy complex applications and configure them in development, testing and production environments. We will discuss the best practices for these teams to collaborate effectively and efficiently and avoid potential duplication and erroneous information.

Analytics: Developers need to be able to look for patterns in log messages to identify if there is a problem in the code. Operations need to do root cause analysis across multiple log files to identify the source of the problem in complex application and systems.
