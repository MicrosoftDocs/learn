Here, you learn the basic of Azure Web Application Firewall. This overview will help you evaluate whether Azure Web Application Firewall is a useful tool to add to Contoso's overall network security strategy.

## Overview of Azure Web Application Firewall

Security researchers have shown that new web apps are probed for weaknesses by bots or malicious users within minutes of being deployed. If you put an app on the web, it's prudent to assume that threat actors will test the app for vulnerabilities almost immediately. You can also assume that such probes will continue for the lifetime of the app.

Most malicious tests of web apps look for the presence of one or more common vulnerabilities, such as the following exploits:

- SQL injection
- Cross-site scripting
- HTTP request smuggling
- Local and remote file inclusion

A common task in the web app development cycle involves writing code to close the most common security holes. Writing that security code requires time, expertise, and lots of testing.

Azure Web Application Firewall is an Azure service that provides centralized protection of Azure-hosted web apps. Azure Web Application Firewall is designed to protect web apps from common threats such as SQL injection and cross-site scripting.

:::image type="content" source="../media/2-web-application-firewall-description.png" alt-text="Network diagram showing an Azure virtual network that includes a web app and an instance of Azure Web Application Firewall. Bots and threats are blocked from the app, while legitimate requests are allowed.":::

You can deploy Azure Web Application Firewall in minutes. Your web apps are immediately protected from known threats, all without writing a single line of security code.

## Key features of Azure Web Application Firewall

To help you evaluate Azure Web Application Firewall, here are some of its important features:

- Managed rules. The rules that Azure Web Application Firewall uses to detect and prevent common exploits are created, maintained, and updated by Microsoft's security team. If a rule changes, or a rule set (described below) is modified, Microsoft updates Azure Web Application Firewall automatically and seamlessly.

> [!NOTE]
> You can't modify or delete the managed rules offered by Azure Web Application Firewall. However, if a particular rule is problematic for you—for example, it blocks legitimate traffic to your web app—you can disable the rule.

- Custom rules. If the managed rules offered by Azure Web Application Firewall don't cover a specific problem you're having, you can create a custom rule. You can build custom rules by creating conditions that include variables (such as RequestHeader or QueryString), HTTP request methods (such as POST or PUT), operators (such as Equal or Contains), and an action (such as Allow or Block).

> [!TIP]
> Azure Web Application Firewall custom rules support a GeoMatch operator, which you can use to match the two-letter country/region code of the requesting entity.

- Modes. You can configure Azure Web Application Firewall to operate in one of two modes:
    - Detection mode. Logs a request if the request matches one of Azure Web Application Firewall's rules. The request is allowed to proceed.
    - Prevention mode. Logs a request if the request matches one of Azure Web Application Firewall's rules and denies the request.
- Alerts. Azure Web Application Firewall is integrated with Azure Monitor, which enables you to get near-real-time alerts when a firewall threat is detected.

## Common attacks prevented by Azure Web Application Firewall

Azure Web Application Firewall protects web apps by using rules. Each rule is designed to prevent a particular threat. Collections of related rules are gathered into a *core rule set* (CRS). These collections are based on the sets defined by the Open Web Application Security Project (OWASP). Currently there are three sets available when you deploy Azure Web Application Firewall: CRS 3.1, CRS 3.0, and CRS 2.2.9.

> [!IMPORTANT]
> The CRS 3 rule sets are a big improvement over CRS 2 because they reduce false positives by more than 90 percent and include many new exploits. Therefore, you should select a CRS 3 set when you deploy Azure Web Application Firewall.

To help you get a sense of the depth of protection offered by Azure Web Application Firewall, the following table lists the groups that comprise CRS 3.1.

|Rule group  |Description  |
|---------|---------|
|General     |Rules that don't fit in any of the other groups         |
|REQUEST-911-METHOD-ENFORCEMENT     |Disables some request methods (for example, PUT and PATCH)         |
|REQUEST-913-SCANNER-DETECTION     |Detects security (port and environment) scanners, web crawlers, and bots         |
|REQUEST-920-PROTOCOL-ENFORCEMENT     |Protects against protocol and encoding exploits by validating HTTP requests         |
|REQUEST-921-PROTOCOL-ATTACK     |Detects protocol-related attacks, such as HTTP header injection, HTTP request smuggling, and HTTP response splitting         |
|REQUEST-930-APPLICATION-ATTACK-LFI     |Detects application exploits that use local file inclusion (LFI) attacks         |
|REQUEST-931-APPLICATION-ATTACK-RFI     |Detects application exploits that use remote file inclusion (RFI) attacks         |
|REQUEST-932-APPLICATION-ATTACK-RCE     |Detects application exploits that use remote code execution (RCE) attacks         |
|REQUEST-933-APPLICATION-ATTACK-PHP     |Detects application exploits that use PHP-injection attacks         |
|REQUEST-941-APPLICATION-ATTACK-XSS     |Detects application exploits that use cross-site scripting (XSS) attacks         |
|REQUEST-942-APPLICATION-ATTACK-SQLI     |Detects application exploits that use SQL-injection (SQLi) attacks         |
|REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION     |Detects application exploits that use session-fixation attacks         |
|REQUEST-944-APPLICATION-ATTACK-SESSION-JAVA     |Detects application exploits that use JAVA attacks         |

Each group is a collection of rules designed to detect and thwart a specific exploit. For example, the following table lists the specific rules tha comprise the REQUEST-942-APPLICATION-ATTACK-SQLI rule group in CRS 3.1.

|Rule ID     |Detects   |
|---------|---------|
|942100     |SQL injection attack using libinjection, an open-source SQL injection detection library         |
|942110     |SQL injection attack: common injection         |
|942130     |SQL injection attack: SQL tautology         |
|942140     |SQL injection attack: Common database names         |
|942150     |SQL injection attack         |
|942160     |Blind SQLi tests using sleep() or benchmark()         |
|942170     |SQL benchmark and sleep injection attempts including conditional queries         |
|942190     |MSSQL code execution and information gathering attempts         |
|942200     |MySQL comment-/space-obfuscated injections and backtick termination         |
|942230     |Conditional SQL injection attempts         |
|942260     |Basic SQL authentication bypass attempts 2/3         |
|942251     |HAVING injections         |
|942270     |Basic SQL injection: Common attack string for mysql oracle and others         |
|942290     |Basic MongoDB SQL injection attempts         |
|942300     |MySQL comments, conditions, and chr/char injections         |
|942310     |Chained SQL injection attempts 2/2         |
|942320     |MySQL and PostgreSQL stored procedure/function injections         |
|942330     |Classic SQL injection probings 1/2         |
|942340     |Basic SQL authentication bypass attempts 3/3         |
|942350     |MySQL UDF injection and other data/structure manipulation attempts         |
|942360     |Concatenated basic SQL injection and SQLLFI (SQL local file inclusion) attempts         |
|942370     |Classic SQL injection probings 2/2         |
|942410     |SQL injection attack         |
|942430     |Restricted SQL character anomaly (args): number of special characters exceeded (12)         |
|942440     |SQL comment sequence         |
|942450     |SQL hex encoding         |
|942460     |Meta-character anomaly-repetitive non-word characters         |
