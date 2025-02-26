| :::image type="icon" source="../media/goal.svg"::: Shift left in operations to anticipate failure conditions. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Test failures early and often in the development lifecycle, and determine the impact of performance on reliability. For the sake of root cause analysis and postmortems, you need to have shared visibility, across teams, of dependency status and ongoing failures. Insights, diagnostics, and alerts from observable systems are fundamental to effective incident management and continuous improvement.

Contoso University runs a web app built on microservices that provides education services, like online classes, for Contoso's faculty and students. The workload is built on Azure App Service, Azure SQL Database, Microsoft Entra ID, Azure Key Vault, Azure Service Bus, Azure Monitor, and Azure DevOps.

## Implement robust monitoring

**Build observable systems that can correlate telemetry.**

Monitoring and diagnostics are crucial operations. If something fails, you need to know that it failed, when it failed, and why it failed. Observability at the component level is fundamental, but aggregated observability of components and correlated flows provides a holistic view of health status. This data is required to enable site-reliability engineers to prioritize their efforts for remediation.

*Contoso's challenge*

- The workload application is deployed as part of a suite of five decoupled services across multiple functional tiers.
- The team would like to be able to analyze transactions and users requests as they traverse the various tiers of the solution to identify bottlenecks that may lead to instability and perform more efficient troubleshooting when issues arise.

*Applying the approach and outcomes*

- The workload team instruments the components to capture logs and metrics with Application Insights and configures logging for all platform services. All logs are forwarded to the workload's Azure Monitor workspace.
- Data in the AzM Workspace can be used to analyze health of individual components of the solution and aggregated flows and solution health. 
- Correlating entries belonging to the same request across components and tiers helps the team determine the workload health and facilitates their troubleshooting processes.

## Predict potential malfunctions and anomalous behavior

**Make active reliability failures visible by using prioritized and actionable alerts. Invest in reliable processes and infrastructure that leads to quicker triage.**

Site reliability engineers can be notified immediately so that they can mitigate ongoing live site incidents and proactively mitigate potential failures identified by predictive alerts before they become live incidents.

*Contoso's challenge*

- The team is expecting a significant increase in traffic at the beginning of each term, as students register for classes, access syllabi, and purchase textbooks.
- During this critical period of the academic year, the team needs to ensure that enough capacity for the increase in expected load is available. The team also needs to be able to react quickly to other potential availability issues that may arise.

*Applying the approach and outcomes*

- The team configures the Web and Database tiers to automatically scale out to have extra capacity prior to the expected increase in demand and to continue to allocate capacity as load increases.
- The emergency response plan is adjusted to dictate that alerts related to the flows under stress during this period are prioritized by the incident response team.

## Test for reliability risks

**Simulate failures and run tests in production and pre-production environments.**

It's beneficial to experience failures in production so you can set realistic expectations for recovery. This allows you to make design choices that gracefully respond to failures. Also, it enables you to test the thresholds you set for business metrics.

*Contoso's challenge*

- Communication between the web tier and the student registration REST service in this workload relies on client certificates.
- Because the student registration functionality is not used much after the term begins, if the certificate used by the student registration service expires, the issue may go undetected for some time.
- In addition, during the last registration period there were several interruptions to the service due to the system incorrectly handling transient connectivity failures. The team has made some code improvements to handle transient failures but is uncertain of how the functionality will behave in real production scenarios.

*Applying the approach and outcomes*

- The team develops synthetic transaction testing that will be run in production on a monthly schedule to simulate several flows, including the registration flow.
- Alerting is configured for the synthetic transaction tests so the team will be notified will failures occur, covering the risk of expiring certificates.
- In addition, the team has invested in building chaos testing into their SDLC, performing routine chaos testing and capturing the results to both validate self-preservation techniques and to help uncover previously unknown reliability issues. 