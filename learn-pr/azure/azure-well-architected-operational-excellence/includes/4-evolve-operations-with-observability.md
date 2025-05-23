| :::image type="icon" source="../media/goal.svg"::: Get a clear view into the system, get insight, and make data-driven decisions. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Build a culture where the team is always looking to improve quality by monitoring workloads and considering all pillars of the Azure Well-Architected Framework. Give the team and stakeholders the data that they need, like stats, trends, and insights, so they can make smart decisions, whether it's for quick fixes or long-term planning. Use what you learn from the data to keep getting better.

Operations that are designed for observability help you stay ahead of problems, maintain quality and security, plan for growth, and manage the product more effectively.

One key part of monitoring is health modeling, which helps you find problems before they turn into big incidents that affect customers. Efficient monitoring means less time reacting to problems and more time improving the experience.

**Example scenario**

Contoso built an internal web app called Contoso Real Estate to help new hires and employees who are relocating. It lets people search for and book short-term housing during their move. The HR team also uses the app to assist with the relocation process.

The app is live and fully hosted in Azure. It's built on microservices by using Azure Container Apps, and it also uses Azure Functions, Azure Database for PostgreSQL, Azure Blob Storage, and Azure Monitor.

## View your workload through telemetry

**Capture telemetry from application code that connects the key steps in how it runs, so you can see the full picture from high-level trends to detailed actions.**

Prioritize actions based on how serious the problem is, and understand the details to figure out the context. This information is crucial for troubleshooting purposes.

*Contoso's challenge*

- After a recent update to the Contoso Real Estate app, users are reporting that there's a problem where the search page sometimes shows a blank screen or a generic error message. It doesn't happen every time, and usually refreshing the page or trying the search again fixes it.

- When the team checked the logs for the search microservice, they noticed more errors, specifically timeouts when trying to connect to the Azure Database for PostgreSQL. But they can't tell if those errors are the same ones causing the problems that users are seeing on the front end.

*Applying the approach and outcomes*

- The development team decided to expand the logging in both the web app and the core microservices to figure out what's going wrong. For the search feature specifically, they're now logging the search terms, time of the request, client IP address, and the username tied to the search. This extra information should help them connect the dots across different parts of the system.

- This change helped the team confirm that the root cause of the user problems was database query timeouts that weren't being handled properly in the latest app update. After they figured that out, fixing it was pretty straightforward.
- The team is now designing a new approach, using OpenTelemetry, to build a more complete distributed tracing solution that covers all solution tiers.

## Visualize monitoring data in dashboards

**Gather and visualize data in dashboards to show monitoring data that's specific to your audience and keeps the bigger picture in mind. Use situational dashboards to highlight key information and give stakeholders insight. Use operational dashboards and workbooks that have drill-down capabilities for operator activities like incident response. Frequently refresh the dashboards and provide fine details.**

You can use visualizations to analyze trends, track against business targets, and manage incidents.

Dashboards that are tailored to the interest of the customer are easier to understand and help teams catch problems and take action faster.

*Contoso's challenge*

- The workload team gathers telemetry data from across all solution tiers into a single Log Analytics workspace that everyone can access, including development and operations teams and other stakeholders. But actually working with that data isn't easy. It's complicated and clunky, which makes it frustrating for team members who are trying to separate background noise from actionable data.

*Applying the approach and outcomes*

- The team embarks on an effort to gather and visualize data by using dashboards. Each dashboard is tailored to a specific audience:

  - For stakeholders, the dashboards focus more on the big picture, like overall solution health, number of users, searches, and reservations. It provides a clear view of how the solution performs from a business perspective.

  - For the operations team, the dashboards and workbooks go deeper, with more detailed data and the ability to drill down into specific areas. These dashboards help with troubleshooting, incident response, and day-to-day monitoring.

- The dashboards enable users to analyze trends, track business targets, and manage incidents more effectively. Each dashboard has data that's more relevant to its intended audience and is driven by their interests and needs.

## Design a robust alerting strategy

**Make alerts actionable by sending them to the right people, with clear descriptions and severity levels. Include information from different sources so it's all in one place, and track anything that doesn't align with business goals.**

Trigger alerts only for incidents that need action, and aim for proactive alerts that help you fix problems before they become a total failure. A good alert system should tell you what's wrong, how serious it is, and give just enough information to make things clear and actionable. Then the team can jump straight into fixing problems without wasting time.

*Contoso's challenge*

- Contoso uses Azure Monitor to send alerts to the operations team when something goes wrong. However, the team currently receives too many alerts that are irrelevant, unclear, or redundant. This causes alert fatigue. The team is missing important alerts and productivity is slowing down.

- There have also been some situations of outages that could have been prevented or minimized if an alert gave everyone a heads up. For example, there have been occasions in which gradual slow-downs in the database query processing time have resulted in outages. If the team had smarter alerts that flagged these slow-downs earlier, they might have been able to step in before the system failed.

*Applying the approach and outcomes*

- The operation team launches a cleanup effort to get rid of all the low-priority alerts that are just adding noise. Only critical and actionable alerts are allowed to remain active. They're also reviewing the remaining alerts to make sure they give enough context so that the team can fix the problem without needing more information.

- They take the opportunity to set up new proactive, actionable alerts that will enable them to take action before a failure happens. For example, they added a new alert to notify the database administrators as soon as a steady slowdown in database query performance appears.
- Next up, they're exploring ways to automate responses to common alerts, like the database slowdown.

