dHere, you learn the basic of Azure Web Application Firewall. This overview will help you evaluate whether Azure Web Application Firewall is a useful tool to add to Contoso's overall network security strategy.

## Overview of Azure Web Application Firewall

Security researchers have shown that new web apps are probed for weaknesses by bots or malicious users within minutes of being deployed. If you put an app on the web, it's prudent to assume that threat actors will test the app for vulnerabilities almost immediately. You can also assume that such probes will continue for the lifetime of the app.

Most malicious tests of web apps look for the presence of one or more common vulnerabilities, such as the following exploits:

- SQL injection
- Cross-site scripting
- HTTP request smuggling
- Remote file inclusion

You learn about these and other common attacks a bit later.

A common task in the web app development cycle involves writing code to close the most common security holes. Writing that security code requires time, expertise, and lots of testing.

Azure Web Application Firewall is an Azure service that provides centralized protection of Azure-hosted web apps. Azure Web Application Firewall is designed to protect web apps from common threats such as SQL injection and cross-site scripting.

You can deploy Azure Web Application Firewall in minutes. Your web apps are immediately protected from known threats, all without writing a single line of security code.

## Key features of Azure Web Application Firewall

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
|REQUEST-942-APPLICATION-ATTACK-SQLI     |Detects application exploits that use SQL-injection (SQLi)attacks         |
|REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION     |Detects application exploits that use session-fixation attacks         |
|REQUEST-944-APPLICATION-ATTACK-SESSION-JAVA     |Detects application exploits that use JAVA attacks         |

Each group is a collection of rules designed to detect and thwart a specific exploit. For example, the following table lists the specific rules tha comprise the REQUEST-942-APPLICATION-ATTACK-SQLI rule group in CRS 3.1.

|Rule Id     |Description   |
|---------|---------|
|942100     |SQL Injection Attack Detected via libinjection         |
|942110     |SQL Injection Attack: Common Injection Testing Detected         |
|942130     |SQL Injection Attack: SQL Tautology Detected.         |
|942140     |SQL Injection Attack = Common DB Names Detected         |
|942150     |SQL Injection Attack         |
|942160     |Detects blind SQLi tests using sleep() or benchmark()         |
|942170     |Detects SQL benchmark and sleep injection attempts including conditional queries         |
|942190     |Detects MSSQL code execution and information gathering attempts         |
|942200     |Detects MySQL comment-/space-obfuscated injections and backtick termination         |
|942230     |Detects conditional SQL injection attempts         |
|942260     |Detects basic SQL authentication bypass attempts 2/3         |
|942251     |Detects HAVING injections         |
|942270     |Looking for basic sql injection. Common attack string for mysql oracle and others.         |
|942290     |Finds basic MongoDB SQL injection attempts         |
|942300     |Detects MySQL comments, conditions and ch(a)r injections         |
|942310     |Detects chained SQL injection attempts 2/2         |
|942320     |Detects MySQL and PostgreSQL stored procedure/function injections         |
|942330     |Detects classic SQL injection probings 1/2         |
|942340     |Detects basic SQL authentication bypass attempts 3/3         |
|942350     |Detects MySQL UDF injection and other data/structure manipulation attempts         |
|942360     |Detects concatenated basic SQL injection and SQLLFI attempts         |
|942370     |Detects classic SQL injection probings 2/2         |
|942410     |SQL Injection Attack         |
|942430     |Restricted SQL Character Anomaly Detection (args): # of special characters exceeded (12)         |
|942440     |SQL Comment Sequence Detected.         |
|942450     |SQL Hex Encoding Identified         |
|942460     |Meta-Character Anomaly Detection Alert - Repetitive Non-Word Characters         |

SQL Injection (SQLi)
Cross Site Scripting (XSS)
Local File Inclusion (LFI)
Remote File Inclusion (RFI)
PHP Code Injection
Java Code Injection 	
HTTPoxy
Shellshock
Unix/Windows Shell Injection
Session Fixation
Scripting/Scanner/Bot Detection
Metadata/Error Leakages