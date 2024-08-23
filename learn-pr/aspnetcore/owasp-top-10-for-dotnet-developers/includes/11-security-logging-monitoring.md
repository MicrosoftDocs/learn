How do you detect you've been breached? How can you determine what steps the attacker took to penetrate your system?

Without sufficient logging and monitoring, you can't detect breaches. Logging and monitoring give us an opportunity to stop an attacker in their tracks. Telemetry, logging, and monitoring enables digital forensics and post-mortem after a breach. Logging and monitoring are essential components in ensuring that you can detect any suspicious activity in close to real time, or diagnosed after the fact.

More importantly, collecting this data is useless without actively reviewing it or having alerting rules in place.

Make sure to sanitize the data to prevent from over-logging or storing sensitive information as logs.

Establish effective monitoring and alerting mechanisms. Ensure login and access-control failures are logged with sufficient user context to identify suspicious or malicious accounts. Take advantage of different logging levels (Info, Warning, Error, and so on) and log destinations. Avoid server-side error details from ever reaching client side, which can result in leaking your system's implementation details.

> [!IMPORTANT]
> Don't leave access to your logs unprotected.

Logging and monitoring allow teams to stop an attack before more damage can be done.

Make sure you have answers to the following questions:

* Is any logging configured, and what can be logged?
* Who has viewed or downloaded a specific file?
* Have any incorrect authentication attempts occurred?
* Who has logged in recently?
* Have authentication events happened at unexpected times or for unexpected locations (Microsoft Entra Conditional Access)?

.NET comes with a LoggerFactory, which is in Microsoft.Extensions.Logging.

### Code review notes

In our scenario, your new DevOps team can prevent security logging and monitoring failures in their .NET applications by:

* Using a centralized logging framework (such as NLog) or service (such as Application Insights). ASP.NET Core provides native logging capabilities through [ILogger](/dotnet/api/microsoft.extensions.logging.ilogger) or [LoggerFactory](/dotnet/api/microsoft.extensions.logging.loggerfactory) that you can easily add to your solutions.
* Log all relevant security events such as authentication failures, authorization failures, and input validation failures.
* Monitor logs for anomalies and alerts using automation.
* Perform dynamic application security testing (for example, with OWASP ZAP Scan, GitHub Actions, or Azure DevOps Pipeline tasks).
