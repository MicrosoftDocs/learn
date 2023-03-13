Here, you'll learn the basics of Azure Web Application Firewall. This overview will help you evaluate whether Azure Web Application Firewall is a useful tool to add to Contoso's overall network-security strategy.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWCwkM]

## Overview of Azure Web Application Firewall

You might think malicious users won't bother with your web apps. However, tests have indicated that bots or malicious actors probe new web apps for weaknesses within minutes of deployment. If you put an app on the web, assume that threat actors will test the app for vulnerabilities almost immediately. You can also assume such probes will continue for the lifetime of the app.

Most malicious tests of web apps check for the presence of one or more common vulnerabilities. If found, a threat actor could use these vulnerabilities to run attacks like the following exploits:

- SQL injection
- Cross-site scripting
- Local and remote file inclusion
- HTTP/HTTPS floods
- Malicious bot attacks


A common task in the web app development cycle involves writing code to close the most common security holes. Writing the security code requires time, expertise, and testing.

Azure Web Application Firewall is an Azure service that provides centralized protection of Azure-hosted web apps. Azure Web Application Firewall protects web apps from common threats such as SQL injection and cross-site scripting.

:::image type="content" source="../media/2-web-application-firewall-description.png" alt-text="Diagram of an Azure virtual network with Azure Web Application Firewall. Bots and threats are blocked from a web app; legitimate requests are allowed." border="false":::

You can deploy Azure Web Application Firewall in minutes. Your web apps immediately get powerful protection from known threats, all without writing a single line of security code.

## Key features of Azure Web Application Firewall

To help you evaluate Azure Web Application Firewall, here are some of its important features:

- **Managed rules**: The rules that Azure Web Application Firewall uses to detect and prevent common exploits are created, maintained, and updated by Microsoft's security team. If a rule changes, or a rule set (refer to the following description) is modified, Microsoft updates Azure Web Application Firewall automatically and seamlessly.

    > [!NOTE]
    > You can't modify or delete the managed rules offered by Azure Web Application Firewall. However, if a particular rule is problematic for your environment (for example, it blocks legitimate traffic to your web app) you can create exclusions or disable the rule, or rule set. You can also create custom rules to overwrite the default behavior.

- **Bot rules**: The bot rules identify good bots and protects from bad bots. Bad bots are detected based on Microsoft Threat Intelligence.

- **Custom rules**: If the managed rules offered by Azure Web Application Firewall don't cover a specific threat to your web application, you can create a custom rule.
- **Modes**: Azure Web Application Firewall can operate in one of two modes: detection mode only logs requests that violate a rule, while prevention mode both logs and blocks requests that violate a rule.
- **Exclusion lists**: You can configure Azure Web Application Firewall to ignore specific attributes when it checks requests.
- **Policies**: You can combine a set of managed rules, custom rules, exclusions, and other Azure Web Application Firewall settings into a single element called an Azure Web Application Firewall policy. You can then apply that policy to multiple web apps for easy management and maintenance.
- **Request size limits**: You can configure Azure Web Application Firewall to flag requests that are either too small or too large.
- **Alerts**: Azure Web Application Firewall integrates with Azure Monitor. This integration gives you near-real-time alerts when the WAF detects a threat.

## Common attacks prevented by Azure Web Application Firewall

The following table describes the most common types of malicious threats that Azure Web Application Firewall helps protect against.

|Threat|Description|
|---------|---------|
|Cross-site scripting|A threat actor uses a web application to send malicious code to another user's web browser. The browser runs the code, which gives the script access to the user's session data, cookies, and other sensitive information.|
|Local file inclusion|An attacker exploits vulnerabilities in a server's handling of `include` statements, most often in PHP scripts. By passing specially configured text to a script's `include` statement, the attacker can include files that are locally present on the server. The attacker might then be able to access sensitive information and run server commands.|
|PHP injection|The attacker inserts text specially configured to trick the server into running PHP commands. These commands let the attacker run local or remote PHP code. The attacker might then be able to access sensitive data and run commands on the server.|
|Protocol attacks|An attacker inserts specially configured text into an HTTP/HTTPS request header. Depending on the specific text injected into the header, the attacker can deceive the server into displaying sensitive data or running code.|
|Remote command execution|The attacker tricks a server into running commands associated with the server's operating system. On a UNIX system, for example, the attacker might have the server run `ls` to get a directory listing.|
|Remote file inclusion   |The same as local file inclusion, except the attacker sends the server specially configured text that passes a remote file—that is, a file on a remote server controlled by the attacker—to a script's `include` statement.|
|Session fixation|An attacker exploits a web app vulnerability that allows the attacker to obtain a valid session ID. The attacker deceives a user into authenticating a new session with that ID. The attacker then hijacks this user-validated session.|
|SQL injection|In a web form field, the attacker inserts (or "injects") text specially configured to trick the server into running SQL commands. These commands allow the attacker to access sensitive data, insert, update, or delete data, or run SQL operations.|

All the exploits listed in the preceding table are only possible when the server trusts the input it receives. Writing code that checks for and sanitizes just these exploits would be difficult and time-consuming. Only a small fraction of the possible exploits a web app can face are represented in the previous table. Azure Web Application Firewall is designed to prevent these attacks and many more.

## Sanitizing input

The threats faced by modern web apps are varied and sophisticated. However, in most cases the reason exploits are possible is that the web app implicitly trusts the input it receives.

For example, consider a web form that lets an authorized web app user sign in to the user's account. The form consists of just three elements:

- A **Username** text box
- A **Password** text box
- A **Sign In** button

<!-- Insert concept video here -->
