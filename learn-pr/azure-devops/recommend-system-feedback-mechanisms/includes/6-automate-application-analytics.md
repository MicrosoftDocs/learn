The team is wrapping up their discussion about collecting customer feedback during the beta tests. Tim has one more topic.

**Tim:** I have something I've been thinking about for the future. I might as well bring it up now so you know where I want to go. Our infrastructure's only going to get more complex, which means figuring out what's going on is only going to get harder.

I've seen what automation can do, and I think it can help here, too. Have you ever heard of augmented search?

## Automate application analytics

Tim is thinking about the difficulty in troubleshooting complex infrastructures. It's a problem that's becoming more apparent, especially as Agile becomes more popular. In an Agile environment, you typically find multiple development teams that work simultaneously. Each team introduces new code or code changes at least daily, and sometimes several times a day. In such a rapidly changing environment, it's common for problems to "slip through the cracks," and to be discovered in production. By the time the team learns about the problem, the bugs have already affected end users, which mean the issues have to be resolved immediately.

Teams have to conduct a rapid investigation to identify the root cause of the problem. Identifying where the symptoms come from and then isolating the root cause is a challenging task. Symptoms can be found across various layers of a large hybrid IT environment, including the servers, the storage devices, the databases, all the way to the front-end and server-side code. Investigations that traditionally took hours or days to complete must be done within minutes.

Traditionally, teams examine the infrastructure and application logs as part of the investigation. However, the massive number of log records that are produced makes it impossible to do examination manually. It's similar to finding a needle in a haystack. 

In most cases, these investigations are conducted by using log management and analysis systems that collect and aggregate these logs. These systems will collect data from both infrastructure and from applications and centralize them in one place. Then they provide search capabilities to explore the data. These systems certainly help but they still rely completely on the investigative skills and the knowledge of the operator. The operator must know exactly what to search for and have a deep understanding of the environment in order to use these tools effectively.

Another complication is that the log files of applications are far less predictable than the log files of infrastructure. Application logs typically include error messages and error numbers that developers have added to the code over time, often inconsistently. In most cases, search queries produce thousands of results, many of them unimportant, even when the operator is skilled. That leaves the operator with the same "needle in the haystack" situation.

## Assisting DevOps with augmented search

A new type of log management and analysis technology has emerged to solve this challenge. This technology uses *augmented search* to expedite the investigation. Designed specifically to deal with the chaotic and unpredictable nature of application logs, augmented search takes into consideration that operators don't necessarily know what to search for.

The analysis algorithm automatically identifies errors, risk factors, and problem indicators, while analyzing their severity by combining semantic processing, statistical models, and machine learning to analyze and "understand" the events in the logs. These insights are displayed as intelligence layers on top of the search results, helping you to quickly discover the most relevant and important information.

Information layers helps operators focus on the important problems that occurred during the period of interest. The combination of the user's intellect, an understanding of the system's architecture, and augmented search machine learning capabilities makes it faster and easier to focus on the most relevant data.

By using augmented search, DevOps engineers can identify a problem and the root cause in a matter of seconds instead of examining thousands of log events or running multiple checks on the various servers. Adding this type of visibility to log analysis, and the ability to surface critical events out of tens of thousands - and often millions - of events, is essential in a fast paced environment, in which changes are constantly introduced.

## Recommend system and feature usage tracking tools

A key factor to automating feedback is telemetry. By inserting telemetric data into your production application and environment, a DevOps team can automate feedback mechanisms while monitoring applications in real time. DevOps teams use telemetry to discover and solve problems as they occur, but this data can also be useful to business users.

When properly instrumented, telemetry can help you understand, in real time, how customers are engaging with the application. This telemetry could contain critical information for product managers, marketing teams, and customer support. Therefore, it's important that feedback mechanisms share continuous intelligence with all stakeholders.

### What is telemetry and why should I care?

In the software development world, telemetry can offer insights on which features end users use most, detect bugs, and offer better visibility into performance, without the need to solicit feedback directly from users. In DevOps and the world of cloud applications, teams typically track the health and performance of an application. That telemetry data comes from application logs, infrastructure logs, metrics, and events. The measurements are metrics like memory consumption, CPU performance, and database response time. You can use events to measure everything else, such as when a user signed in, when an item is added to a basket, when a sale is made, and so on.

The concept of telemetry is often confused with logging. Logging is a tool that you use in the development process to diagnose errors. Logging focuses on the internal structure of a service or application. But logging only gives you a one-dimensional view. Telemetry, combined with insights from infrastructure and application logs, gives you a more complete view.

### What are the benefits of telemetry?

The primary benefit of telemetry is the ability to monitor the state of an object or environment while remaining removed from it physically. After you've shipped a product, you can't physically peer over the shoulders of thousands (or millions) of users as they engage with your product to find out what works, what's easy, and what's cumbersome. Thanks to telemetry, those insights can be delivered directly to a dashboard for you to analyze.

Because telemetry provides insights into how well your product is working for your end users as they use it, it's a valuable tool for ongoing performance monitoring and management. Plus, you can use the data you've gathered from version 1.0 to drive improvements and prioritize updates for your release of version 2.0.

Telemetry enables you to answer questions such as:

* Are your customers using the features you expect?
* How are they engaging with your product?
* How frequently are users engaging with your app, and for what duration?
* What settings or options do users select most?
* Do users prefer certain display types, input modalities, screen orientation, or other device configurations?
* What happens when crashes occur?
* Are crashes happening more frequently when certain features or functions are used?

The answers to these and many other questions enable you to make continuous improvements and to introduce new features. To your end users, it may seem as though you've been reading their minds – which you have been, thanks to telemetry.

### What are the challenges of telemetry?

Although telemetry provides many clear benefits, it comes with its own set of challenges. Perhaps its largest challenge – and a commonly occurring issue – is not with telemetry itself, but with your end users and their willingness to allow what some see as a violation of privacy. Some users immediately turn data collection off when they notice it. This means any data generated from their use of your product won't be gathered or reported.

Although this isn't necessarily a problem by itself, the issue is that users who tend to disallow these types of technologies can tend to fall into the more tech-savvy portion of your user base. This can result in the "dumbing-down" of software. Many users, however, take no notice of telemetry collection going on behind the scenes.

It's a problem without a clear solution; It certainly doesn't negate the overall power of telemetry for driving development. However, keep this limitation in mind as you analyze your data. When you design a strategy for how you use telemetry data, it's important to account for users who don't participate.

## Choose monitoring tools and technologies

Continuous monitoring of applications in production environments is typically implemented with application performance management (APM) solutions that intelligently monitor, analyze, and manage cloud, on-premises, and hybrid applications and IT infrastructure. APM solutions enable you to monitor your users' experience and improve the stability of your application infrastructure. It helps identify the root cause of issues quickly to proactively prevent outages and keep users satisfied.

With a DevOps approach, we are also seeing more customers broaden the scope of continuous monitoring into the staging, testing, and even development environments. This is possible because development and test teams that follow a DevOps approach strive to use production-like environments for testing as much as possible. By running APM solutions earlier in the lifecycle, development teams get feedback in advance of how applications will eventually perform in production and can take corrective action much earlier. In addition, operations teams that, because of DevOps, advise the development teams, get advance knowledge and experience to better prepare and tune the production environment. The result is far more stable releases to production.

When choosing a monitoring tool, look for these features:

* Synthetic monitoring

    _Synthetic monitoring_ uses a set of transactions to assess performance and availability. Synthetic transactions are predictable tests that have the advantage of allowing comparison from release to release in a highly predictable manner.

    Developers, testers, and operations staff all need to ensure that their internet and intranet mobile applications and web applications are tested and operate successfully from different points of presence around the world.
* Alert management

    Developers, testers, and operations teams all need the ability to send notifications through email, voice mail, text, mobile push notifications and instant messages when specific situations or events occur in development, testing, or production environments. This gets the right people's attention at the right times.
* Deployment automation

    Developers, testers, and operations staff use different tools to schedule and deploy complex applications and configure them in development, testing, and production environments.
* Analytics

    Developers need to be able to look for patterns in log messages to identify if there is a problem in the code. Operators need to perform root cause analysis across multiple log files to identify the source of the problem in complex applications and systems.

**Andy:** Thanks for bringing that up. I like that we're thinking ahead and not just reacting. But, speaking of reacting, let's get ready for beta!
