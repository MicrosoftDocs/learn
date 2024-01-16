| :::image type="icon" source="../media/goal.svg"::: Gain visibility into the system, derive insight, and make data-driven decisions. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Build a culture that continuously improves quality by monitoring the workload and taking all the pillars of the Azure Well-Architected Framework into consideration. Enable the team and stakeholders to make both short-term and long-term decisions across many facets by providing the necessary data, statistics, and trends. Learn from your data and drive improvements.

Operations built for the purposes of observability are key in proactive maintenance of the application, quality and security assurance, capacity planning, and product management.

A crucial aspect of application monitoring is using health modeling to help you anticipate issues before they become incidents and affect customer experience. Efficient monitoring reduces reactive cycles spent on incident management.

## Example scenario

Contoso developed an app for internal use called Contoso Real Estate. This web app allows new hires or existing employees that are relocating to search for and reserve short-term housing to help with their relocation. Contoso's HR department also uses the app to assist with relocations. 

The app is in production and is deployed entirely in Azure. It’s built on micro-services using Azure Container Apps and also uses Azure Functions, Azure Database for PostrgreSQL, Azure Blob Storage, and Azure Monitor.

### Observe your workload through telemetry

**Emit telemetry from application code that correlates the key points of the execution flow and gives an end-to-end view at different levels of granularity.**

Prioritize actions based on the severity level, and understand the context given its verbosity. This information is crucial for troubleshooting purposes.

*Contoso's challenge*

- Users are reporting that, after a recent update to the Contoso Real Estate application, they're occasionally seeing a blank page or a generic error message on the search page of the Web App.  The errors seem random, and the search functionality usually works if the users just refresh the page or resubmit the search.
- Reviewing the logs on the search microservice, the team notices an increase in errors due to timeouts connecting to the Azure Database for PostgreSQL, but they currently have no way to tell whether an error they see in the search microservice logs corresponds to the error pages the users see or not.

*Applying the approach and outcomes*

- The development team has decided to expand on the information they log from both the web app and the core micro-services to dig deeper into the issue. For the search scenario, they’re making sure to capture the search terms along with other available transaction attributes like time, client ip, and the username associated with the search. This extra data should give them enough information to be able to correlate transactions across tiers.
- This change allowed the team to confirm that database query timeouts, which weren't being properly handled in the latest update of the app, were the root cause of the failures the users were experiencing. After finding the root cause, it was straightforward for the team to implement a fix. 
- The team is now designing a new approach, using OpenTelemetry, to implement a more comprehensive distributed tracing solution that covers all solution tiers.

### Visualize monitoring data in dashboards

**Aggregate and visualize data in dashboards to present monitoring data that's catered to audiences and keeps the business context in mind. Use situational dashboards for surfacing data to drive awareness among the stakeholders. Use operational dashboards and workbooks with drill-down capabilities for operator activities like incident response. Frequently refresh the dashboards and provide granular data.**

With visualizations, you can analyze trends, track against business targets, and manage incidents.

Dashboards that are tailored to the interest of the customer make interpretation relevant and accelerate time to detection and action.

*Contoso's challenge*

- The workload team aggregates telemetry data from across all solution tiers into a single Log Analytics Workspace, which can be accessed by the operation and development teams and other project stakeholders. However, interacting with the data is difficult and complex, which is frustrating to team members who need to discern background noise from actionable data.

*Applying the approach and outcomes*

- The team embarks on an effort to aggregate and visualize data using dashboards. Each dashboard will be tailored to a specific audience:
    - The solution stakeholder’s dashboards will be more business oriented, presenting a higher level overview of the overall health of the solution, along with business indicators like the number of users served, searches and reservations performed.
    - Operational dashboards and workbooks will have more detailed and granular data for the operations team. These dashboards will have drill-down capabilities that allow the users to explore the data at different levels of granularity. The users will be able to use these dashboards and workbooks to perform troubleshooting and other incident response tasks.
- The dashboards will enable users to analyze trends, track business targets, and manage incidents more effectively. The data presented on each dashboard will be more relevant to its intended audience and will be driven by their interests and needs.

### Design a robust alerting strategy

**Make alerts actionable by notifying the accountable roles with standardized descriptions and severity levels. Provide information that's collated from various sources and track deviations from business targets.**

Trigger alerts only for incidents that require action and strive for proactive and thought-provoking alerts that initiate actions before a degraded state becomes a failure. A good alert system identifies actions and severity and provides just enough data to drive clarity and purpose. Operators can start on remediation without delay.

*Contoso's challenge*

- Azure Monitor is used to send alerts to the operations team when something goes wrong. However, the team currently receives too many alerts that are irrelevant, unclear, or redundant. This causes alert  fatigue and is affecting the team’s productivity and causing some important alerts to go unnoticed.
- There have also been some situations of outages that could have been prevented or minimized if an alert was sent anticipating a failure. If the team had better alerting for degradation before outages occur, these situations might have been avoided. For example, there have been  occasions in which slow-downs in the database queries processing time have resulted in outages. While troubleshooting the outages, the team notices that the query processing performance decreases slowly over time, getting worse and worse until it causes a full-blown outage.

*Applying the approach and outcomes*

- The operation team launches an initiative to clean up all the low priority alerts causing alert fatigue. Only critical and actionable alerts are allowed to remain active. Also, the team reviews (and enhances as needed) the alerts that will remain active to make sure they contain enough context to enable them to take the necessary corrective action.
- They also take the opportunity to define new proactive, and actionable, alerts that will enable them to take action before a failure happens. For example, they generate a new alert to notify the DBAs as soon as a consistent slowdown in database query performance appears.
- As a next step, the team is looking into automating responses to common alerts, such as the situation with database query performance.
