## A09 - Security Logging and Monitoring

How will you detect you've been breached? Without sufficient logging and monitoring, breaches can not be detected.
Logging and monitoring gives us an opportunity to stop the attacker in their tracks. Telemetry, logging and monitoring enables digital forensics and post mortem after a breach. Logging and monitoring are essential components in ensuring that any suspicious activity can be detected close to real-time, or diagnosed after the fact.
More importantly, collection of this data this useless without actively reviewing it or alerting rules in place.

> [!CAUTION]
> Make sure to sanitize the the data to prevent from over-logging or storing  sensitive information as logs.

Best practices suggest establishing effective monitoring and alerting mechanisms, ensuring  all logins, access control failures and server-side input validation failures can be logged with sufficient user context to identify suspicious or malicious accounts. Take advantage of different logging levels (i.e. Info, Warning, Error, etc.) and log destinations. Ensure the server side errors don't 'bubble up' to the client side which may result in information disclosure on the internals of your system.

> [!CAUTION]
> Don't leave access to your logs unprotected.

Logging and monitoring allows teams to stop the attack before more damage can be done

Make sure you have answers to the following questions:

* What can we log?
* Checking who has viewed or downloaded a specific file
* Have any incorrect authentication attempts occurred
* Who has logged in recently
* Have authentication events happened at unexpected times or for unexpected locations (AAD Conditional access)

.NET Core come with a LoggerFactory, which is in Microsoft.Extensions.Logging.

> [!TIP]
> .NET provides native logging capabilities (through [ILogger](/dotnet/api/microsoft.extensions.logging.ilogger) or [LoggerFactory](/dotnet/api/microsoft.extensions.logging.loggerfactory) that can be easily added to your solutions.
