
How do you detect you've been breached?
How can you determine what steps did the attacker take to penetrate your system?

Without sufficient logging and monitoring, breaches can't be detected.
Logging and monitoring give us an opportunity to stop the attacker in their tracks. Telemetry, logging and monitoring enables digital forensics and post-mortem after a breach. Logging and monitoring are essential components in ensuring that any suspicious activity can be detected close to real-time, or diagnosed after the fact.
More importantly, collection of this data is useless without actively reviewing it or alerting rules in place.

Make sure to sanitize the data to prevent from over-logging or storing sensitive information as logs.

Establish effective monitoring and alerting mechanisms. Ensure login and access control failures can be logged with sufficient user context to identify suspicious or malicious accounts. Take advantage of different logging levels (Info, Warning, Error, etc.) and log destinations. Avoid server side error details from ever reaching client side, which may result in leak of implementation details of your system.

> [!IMPORTANT]
> Don't leave access to your logs unprotected.

Logging and monitoring allow teams to stop the attack before more damage can be done.

Make sure you have answers to the following questions:

* Is any logging configured and what can be logged?
* Who has viewed or downloaded a specific file?
* Have any incorrect authentication attempts occurred?
* Who has logged in recently?
* Have authentication events happened at unexpected times or for unexpected locations (Azure Active Directory Conditional Access)?

.NET comes with a LoggerFactory, which is in Microsoft.Extensions.Logging.

### Code review notes

In our scenario, your new DevOps team can prevent security logging and monitoring failures in their .NET applications by:

- Use a centralized logging framework (such as NLog) or service (such as Application Insights). ASP.NET Core provides native logging capabilities (through [ILogger](/dotnet/api/microsoft.extensions.logging.ilogger) or [LoggerFactory](/dotnet/api/microsoft.extensions.logging.loggerfactory) that can be easily added to your solutions.
- Log all relevant security events such as authentication failures, authorization failures, input validation failures.
- Monitor logs for anomalies and alerts using automation
- Perform dynamic application security testing (e.g with OWASP ZAP Scan GitHub Action or Azure DevOps Pipeline task).