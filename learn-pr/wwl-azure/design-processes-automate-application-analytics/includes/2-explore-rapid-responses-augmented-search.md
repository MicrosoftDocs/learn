In an Agile environment, you may typically find multiple development teams that work simultaneously. Introducing new code or code changes daily and sometimes several times a day.

In such an immediate environment, it's prevalent to find problems that have "slipped through the cracks" to find themselves in the production environment. When these issues arise, they have probably already-impacted end users, requiring a speedy resolution. It means that teams must conduct a rapid investigation to identify the root cause of the problem.

Identifying where these symptoms are coming from and then isolating the root cause is a challenging task. Symptoms can be found across various layers of a large hybrid IT environment, such as different servers/VMs, storage devices, databases, to the front-end and server-side code. Investigations that traditionally would take hours or days to complete must be completed within minutes.

Teams must examine the infrastructure and application logs as part of this investigation process. However, the massive amount of log records produced in these environments makes it impossible to do this manually.

It's much like trying to find a needle in a haystack. In most cases, these investigations are conducted using log management and analysis systems that collect and aggregate these logs (from infrastructure elements and applications), centralizing them in a single place and then-providing search capabilities to explore the data.

These solutions make it possible to conduct the investigation, but they still rely entirely on investigation skills and user knowledge. The user must know exactly what to search for and have a deep understanding of the environment to use them effectively.

It's crucial to understand that the log files of applications are far less predictable than the log files of infrastructure elements. The errors are essentially messages and error numbers that have been introduced to the code by developers in a non-consistent manner.

So, search queries yield thousands of results in most cases and do not include important ones, even when the user is skilled. That leaves the user with the same "needle in the haystack" situation.

## Assisting DevOps with augmented Search

A new breed of log management and analysis technologies has evolved to solve this challenge. These technologies facilitate the identification and investigation processes using Augmented Search.

Explicitly designed to deal with application logs' chaotic and unpredictable nature, Augmented Search considers that users don't necessarily know what to search for, especially in the chaotic application layer environment.

The analysis algorithm automatically identifies errors, risk factors, and problem indicators while analyzing their severity by combining semantic processing, statistical models, and machine learning to analyze and "understand" the events in the logs. These insights are displayed as intelligence layers on top of the search results, helping the user quickly discover the most relevant and essential information.

Although DevOps engineers may be familiar with the infrastructure and system architecture, the data is constantly changing with continuous fast-paced deployment cycles and constant code changes. It means that DevOps teams can use their intuition and knowledge to start investigating each problem, but they have blind spots that consume time because of the dynamic nature of the log data.

Combining the decisions that DevOps engineers make during their investigation with the Augmented Search engine information layers on the critical problems that occurred during the period of interest can help guide them through these blind spots quickly.

Combining the user's intellect, acquaintance with the system's architecture, and Augmented Search machine-learning capabilities on the dynamic data makes it faster and easier to focus on the most relevant data. Here's how that works in practice: One of the servers went down, and any attempt to reinitiate the server has failed. However, since the process is running, the server seems to be up. In this case, end users are complaining that an application isn't responding.

This symptom could be related to many problems in a complex environment with many servers. Focusing on the server behind this problem can be difficult, as it seems to be up. But finding the root cause of the problem requires a lengthy investigation, even when you know which server is behind this problem.

Augmented Search will display a layer that highlights critical events during the specified period instead of going over thousands of search results. These highlights provide information about the sources of the events, assisting in the triage process.

At this point, DevOps engineers can understand the impact of the problem (for example, which servers are affected by it) and then continue the investigation to find the root cause of these problems. Using Augmented Search, DevOps engineers can identify a problem and the root cause in a matter of seconds instead of examining thousands of log events or running multiple checks on the various servers.

Adding this type of visibility to log analysis and the ability to surface critical events out of tens of thousands - and often millions - of events is essential in a fast-paced environment that constantly introduces changes.
