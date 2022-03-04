An APM platform helps cloud administrators identify problems, but it doesn't solve those problems for them. If you know, for example, that a remote call to a database takes 10 times longer than it should, what happens next? Do you guide your software development colleagues towards a solution, or do you open a complaint ticket and expect them to work things out on their own?

*Remediation planning* is the process by which you define how problems uncovered by monitoring are mitigated and resolved. Remediation can be *responsive*, in which case it is triggered by events surfaced by an APM, or it can be *proactive*, in which case the goal is to continually make improvements to a system even in the absence of errors of other critical events. In a growing number of enterprises, remediation is no longer simply a response to a problem. Nothing has to go wrong in order for something to turn out right.

## Problem Ticketing

The work cycle of many IT departments revolves around *ticketing*. This is a system that automates the distribution of requests made of the IT department so that an administrator may oversee responses to all requests in accordance with priority, necessity, and available resources. Many organizations invest in a ticketing system that standardizes this process, often called *IT Operations Management* (ITOM). Such a suite often includes features for responding to alerts as they are generated, particularly by an APM platform. In some instances, an APM can trigger the generation of problem tickets.

An issue with any platform that enables alerts and notifications is how best to integrate the notification process into the administrator's work cycle. The whole point of being notified about a problem is to trigger a corrective action. Ideally, an alerting system triggers an automated reaction that applies policy - the appropriate response determined in advance - to the solution. Such policy may determine whether a detected issue warrants a problem ticket, and some automated systems may generate one automatically.

Ticketing is useful for applying as much automation as possible, and as much oversight as needed, to responding to problems in applications, the network, or in infrastructure as they occur. Ironically, ticketing may end up codifying the notion that all IT operations are focused on problem solving - on waiting until something goes wrong.

More recently, vendors and advocates of APM tools and platforms have developed a counter-argument, which moves the focus of IT operations away from problems and toward objectives. The argument goes like this: The end goal of APM is to represent the performance of the enterprise's IT systems with respect to its effect on business goals. When the executive overseeing a division or the manager in charge of a line of business sees how performance relates to revenue or production, he or she is more likely to support efforts and expenditures to maintain sustainable performance levels.

An administrator may find herself or himself explaining to a manager why part of a system should be redeveloped or improved, in terms hopefully that person will understand. That part of the job is often called "aligning" performance metrics with business goals, and there are entire business conferences devoted to this topic. But before alignment can take place, the monitoring process must reveal in a quantifiable way the dynamics of the cloud solution.

## Key Performance Indicators

APM vendors often advise their customers to adopt a handful of *key performance indicators* (KPI). These are individual metrics typically geared to trigger warnings or alerts when their values fall above or below predetermined levels. The objective with KPIs is to enable a custom dashboard to quickly convey the message that something's wrong, or about to go wrong.

Many APM platforms utilize metrics that they call KPIs, but which are actually, from the IT operator's perspective, just metrics. For enterprises that use it in performance monitoring, a KPI is a quantifiable value<sup>1</sup> that represents some aspect of performance as it pertains to at least two of the following:

- System health

- Relative progress in meeting business objectives

- End-user satisfaction with the system

- Efficiency of the IT department in resolving issues

Business managers may expect a KPI to take into account factors outside of IT, including business-operations data. Here are some example KPIs applicable to performance monitoring:

- **Time consumed in entering data into a form** - Once transaction and query-processing times are eliminated, what remains is how much time individual users spend ascertaining the meaning of the form (or getting bored and going out for a cup of coffee first)

- **Percentage of catalog listings resulting in orders**, which reveals the effectiveness of an e-commerce system in selling its products and services

- **Mean Time to Detection (MTTD)** - The interval between the time that an error or other system issue occurred, and the time it was detected

- **Mean Time to Resolution (MTTR)** - The interval between the time an issue was detected and the time it was resolved

- **Percentage of system change completions blocked by other issues** - An indicator of how deeply performance issues can impact other services, and the extent to which larger, more comprehensive, projects to alleviate issues should be considered

Notice that true KPIs tend to be more about user behavior than system behavior. This leads many to believe an analysis of the information system should not play a factor in determining KPIs. However, this ignores the fact that system behavior drives user behavior.

### Devising New KPIs

Some analysts have made the case that IT-centered APM tends to focus on metrics that are separate from those from which true KPIs would be based. These analysts have recommended certain KPI management packages to their clients on this basis. Their argument is that network performance metrics deal with workflow from an infrastructure perspective, which may or may not align with an end user's perspective.

The alternative point of view is that the organization itself is the best source of wisdom for which KPIs are most applicable to its business, since its leaders - not its software - are responsible for setting the business's objectives. To that end, a process emerges for any organization to develop KPIs for its own internal use:

1. **Gather disparate teams together.** No one team should be delegated the task of setting priorities and objectives without consulting the other teams.

2. **Collectively set business priorities.** "Really fast Web page load times" is a perennial goal for information systems, but this will always be the case. What are the most pertinent goals of the organization, to which its information system plays a directly contributing role?

3. **Quantify business objectives parameters.** Determine which of these priorities can be verifiably monitored and measured digitally.

4. **Establish business targets.** Write the formulas for the relationships between measurable, observable factors, and the optimum values for those formulas, in a simple, mathematical way that all stakeholders can understand.

5. **Integrate the ticketing system** or whatever automated functions are involved in addressing problem issues, so that system improvement projects for business objectives purposes may co-exist with performance and software problems.

6. **Dedicate the performance monitoring platform** to the task of gathering the pertinent metrics that pertain to the established business targets. Where applicable, enable dashboards to continually report these metrics in simple, graphical forms.

In a work environment where policy applications and ticket generation can be automatic, the purpose of the APM platform's dashboard changes. It becomes a summary of the active state of the remediation system, and a gauge of how quickly the system can recover from a performance issue.

## Everyday Remediation

The basic tenet of modern remediation planning in IT is that the state of the organization's infrastructure, services, and applications may all be continually improved in a process known as *everyday remediation* or *continuous remediation*. A number of principles follow from this tenet:

- **Nothing is "normal" anymore.** Just as people become healthy and stay healthy by tending to their own well-being every day, there ceases to be a permanent zone of normalcy that defines the behavior of a network if that network were never to change. The goal for service levels becomes a moving target. In nature, this concept is called "evolution."

- **Massive upheavals can be avoided** if small changes are being made all the time. Cloud-based application staging environments take place on software-defined networks. Their host platforms are capable of making, or suggesting, adjustments to those networks to improve their performance. Data from APM platforms give administrators guidance as to where communications and service interactions could be improved.

- **A working knowledge of the system is more deeply ingrained** in the minds of everyone assigned to its upkeep. Many APMs enable their operators to take the basic reports of system events and "drill down" to their underlying causes and effects. If people understand these interdependencies better before they go hunting for root causes of failures, they'll have a better idea of both what to look for and where to look for it when failures occur.

- **The security team and the operations team should work together on a permanent basis.** Performance issues are, at some level, security issues, especially to the extent that they can be exploited. A remediation approach to performance is like a resilience approach to security: Both are proactive as opposed to reactive, and both involve continual improvements to a solution.

A final benefit of everyday remediation is that executives and managers outside IT are more likely to buy in. People in charge appreciate it when the people they manage care about what they themselves care about. In many organizations, people in these positions are the ones charged with building success plans; IT professionals are the ones expected to respond to failures. Business conferences feature lectures on "business objectives alignment." Everyday remediation offers the opportunity to bring that about.

### References

1. _Many organizations also make use of the KPI concept in making objective measurements of business progress and employee efficiency, which lie outside the realm of APM._
