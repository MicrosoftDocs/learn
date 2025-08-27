| :::image type="icon" source="../media/goal.svg"::: Anticipate failures early. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Test failures early and often during development. Determine how performance problems affect reliability. For the sake of root cause analysis and postmortems, ensure that all teams can see the status of dependencies and ongoing failures. Use insights, diagnostics, and alerts from observable systems to manage incidents and improve continuously.

Contoso University runs a web app built on microservices that provides education services, like online classes, for Contoso's faculty and students. The workload is built on Azure App Service, Azure SQL Database, Microsoft Entra ID, Azure Key Vault, Azure Service Bus, Azure Monitor, and Azure DevOps.

## Add robust monitoring

**Build observable systems that can correlate telemetry.**

Monitoring and diagnostics are crucial operations. If something fails, you need to know that it failed, when it failed, and why it failed. Observability at the component level is fundamental, but overall monitoring of components and flows provides a holistic view of the health status. This data helps site-reliability engineers prioritize their efforts to fix problems.

*Contoso's challenge*

- The workload application is deployed as part of a suite of five decoupled services across multiple functional tiers.

- The team wants to be able to analyze transactions and users requests as they move through various tiers of the solution to identify bottlenecks that can cause instability and troubleshoot efficiently.

*Applying the approach and outcomes*

- The workload team uses Application Insights to capture logs and metrics and configures logging for all platform services. All logs are forwarded to the workload's Azure Monitor workspace.

- Data in the Azure Monitor workspace can be used to analyze the health of individual components and the overall solution. 
- Correlating entries that belong to the same request across components and tiers helps the team determine the workload health and troubleshoot problems more easily.

## Predict potential problems and unusual behavior

**Use prioritized and actionable alerts to make reliability problems visible.  Invest in reliable processes and infrastructure to speed up triage.**

Site reliability engineers can be notified of problems immediately. They can handle ongoing live site incidents and proactively address potential failures that predictive alerts identify before they become live incidents.

*Contoso's challenge*

- The team expects a traffic surge at the start of each term as students register for classes, access syllabi, and buy textbooks.

- During this critical period of the academic year, the team needs to ensure that there's enough capacity to handle the increased load. They must be able to react quickly to other potential availability problems that might come up.

*Applying the approach and outcomes*

- The team configures the web and database tiers to automatically scale out so there's extra capacity before the expected increase in demand and capacity is added as load increases.

- The emergency response plan is updated so that the incident response team prioritizes alerts related to the stressed flows during this period.

## Test for reliability risks

**Simulate failures and run tests in production and preproduction environments.**

It's helpful to experience failures in production so you can set realistic expectations for recovery. This practice allows you to make design choices that gracefully respond to failures. And you can test thresholds that you set for business metrics.

*Contoso's challenge*

- Communication between the web tier and the student registration REST service in this workload relies on client certificates.

- After the term begins, the student registration functionality isn't used much. So if that certificate expires, the problem might go undetected for some time.
- During the last registration period, there were several interruptions to the service because the system didn't handle transient connectivity failures well. The team made some code improvements to handle transient failures but doesn't know how the functionality will behave in real production scenarios.

*Applying the approach and outcomes*

- The team creates synthetic transaction testing to run in production monthly. This testing simulates several flows, including the registration flow.

- Alerting is set up for the synthetic transaction tests, so the team gets notified if there's a failure, like expiring certificates.
- The team adds chaos testing to their software development life cycle (SDLC). They do routine chaos testing and capture the results to validate self-preservation techniques and help uncover unknown reliability problems. 