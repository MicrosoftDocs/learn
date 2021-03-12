You're familiar with the basic features and benefits of Azure Web Application Firewall. Now let's examine how Azure Web Application Firewall works. In particular, let's consider how features such as core rule sets and rule groups allow Azure Web Application Firewall to help protect web apps from common exploits. This information will help you evaluate whether Azure Web Application Firewall is the right solution for your company.

## Sanitizing input

The threats faced by modern web apps are varied and sophisticated. However, in most cases the reason exploits are possible is that the web app implicitly trusts the input it receives.

For example, consider a web form that lets an authorized web app user sign in to the user's account. The form consists of just three elements:

- A **Username** text box
- A **Password** text box
- A **Sign In** button

When an authorized user fills in the form and selects **Sign In**, a web app script stores the username and password in variables. Suppose those variables are named `userName` and `userPassword`, respectively. The script would then execute the following statement:

`sql = "SELECT * FROM users WHERE username='" + userName + "' AND password='" + userPassword + "'"`

For example, if the username is `support` and the password is `1234ABCD`, then the `sql` variable will have the following value:

`SELECT * FROM users WHERE username='support' AND password='1234ABCD'`

The web app executes this SQL statement. If a record is returned from the query, the web app signs the user in.

Now suppose that an attacker enters `admin'--` in the **Username** field and leaves the **Password** field blank. In this case, here's the resulting SQL statement:

`SELECT * FROM users WHERE username='admin'--' AND password=''`

On many SQL systems, the double dashes (`--`) mark the start of a comment. Everything after `--` is ignored, so the previous statement is equivalent to the following code:

`SELECT * FROM users WHERE username='admin'`

Assuming there's a user named `admin`, this command will sign in the attacker as the admin user—a serious breach!

:::image type="content" source="../media/3-how-web-application-firewall-works.png" alt-text="Network diagram depicting two sign-in attempts, with Azure Web Application Firewall allowing the authorized sign-in and denying the unauthorized sign-in." border="false":::

The previous example is an instance of an exploit called *SQL injection*. Attackers can take advantage of SQL injection and other exploits in web apps that trust all input.

Azure Web Application Firewall creates a barrier of non-trust between a web app and its user input. Azure Web Application Firewall assumes that all input is potentially malicious, so it *sanitizes* that input.

Sanitizing the input means different things depending on the context. For example, sanitizing the input can mean removing clearly dangerous text elements, such as SQL comment indicators. However sanitization occurs, the result is input that can do no harm to the web app or its backend data.

## Rules, core rule sets, and rule groups

Azure Web Application Firewall thwarts known exploits by applying rules to an app's incoming HTTP/HTTPS requests. A *rule* is firewall code designed to recognize and prevent a particular threat.

The rules that Azure Web Application Firewall uses to detect and block common vulnerabilities are mostly *managed rules*. Microsoft's team of security experts codes, maintains, and updates managed rules. Managed rules are modified or added to as needed. When a managed rule changes, Microsoft updates Azure Web Application Firewall automatically and without app downtime.

Collections of related rules are gathered into a *core rule set* (CRS). These collections are based on the sets defined by the Open Web Application Security Project (OWASP). Currently there are three sets available when you deploy Azure Web Application Firewall: CRS 3.1, CRS 3.0, and CRS 2.2.9.

> [!IMPORTANT]
> The CRS 3 rule sets are a big improvement over CRS 2 because they reduce false positives by more than 90 percent and include many new exploits. Therefore, you should select a CRS 3 rule set when you deploy Azure Web Application Firewall.

The following table lists the groups in CRS 3.1. This table should give you a sense of the depth of protection offered by Azure Web Application Firewall.

|Rule group|Description|
|---------|---------|
|REQUEST-911-METHOD-ENFORCEMENT|Disables some request methods (for example, PUT and PATCH).|
|REQUEST-913-SCANNER-DETECTION|Detects security (port and environment) scanners, web crawlers, and bots.|
|REQUEST-920-PROTOCOL-ENFORCEMENT|Protects against protocol and encoding exploits by validating HTTP/HTTPS requests.|
|REQUEST-921-PROTOCOL-ATTACK|Detects protocol-related attacks, such as HTTP/HTTPS header injection, HTTP/HTTPS request smuggling, and HTTP/HTTPS response splitting.|
|REQUEST-930-APPLICATION-ATTACK-LFI|Detects application exploits that use local file inclusion (LFI) attacks.|
|REQUEST-931-APPLICATION-ATTACK-RFI|Detects application exploits that use remote file inclusion (RFI) attacks.|
|REQUEST-932-APPLICATION-ATTACK-RCE|Detects application exploits that use remote code execution (RCE) attacks.|
|REQUEST-933-APPLICATION-ATTACK-PHP|Detects application exploits that use PHP-injection attacks.|
|REQUEST-941-APPLICATION-ATTACK-XSS|Detects application exploits that use cross-site scripting (XSS) attacks.|
|REQUEST-942-APPLICATION-ATTACK-SQLI|Detects application exploits that use SQL-injection (SQLi) attacks.|
REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION|Detects application exploits that use session-fixation attacks.|
REQUEST-944-APPLICATION-ATTACK-SESSION-JAVA     |Detects application exploits that use JAVA attacks.|

Each group is a collection of rules designed to detect and thwart a specific exploit. For example, the REQUEST-942-APPLICATION-ATTACK-SQLI rule group of CRS 3.1 contains more than two dozen rules that enable Azure Web Application Firewall to detect and prevent various SQL injection exploits. Each of those rules are managed rules that Microsoft creates, maintains, and updates.

## Custom rules

The managed rules offered by Azure Web Application Firewall might not cover a specific threat that your web applications are experiencing. If so, you can create a custom rule. You build custom rules by creating conditions that include the following components:

- Variables such as RequestHeader or QueryString
- HTTP/HTTPS request methods such as POST or PUT
- Operators such as **Equal** or **Contains**
- An action such as **Allow** or **Block**

> [!TIP]
> Azure Web Application Firewall custom rules support a GeoMatch operator, which you can use to match the two-letter country/region code of the requesting entity.

## Detection mode vs prevention mode

Azure Web Application Firewall can operate in one of two modes. The mode you choose depends on how you want the firewall to deal with incoming HTTP/HTTPS requests that match one of its rules:

- Detection mode. Logs the request but allows the request to go through.
- Prevention mode. Logs the request but doesn't allow the request to go through.

A common scenario is to run Azure Web Application Firewall in detection mode when you're testing an app. In detection mode, you can check for two types of problems:

- False positives. Legitimate requests that the firewall flags as malicious.
- False negatives. Malicious requests that the firewall allows.

Once the app is ready to be deployed, you then switch to prevention mode.

## Deployment options

You deploy Azure Web Application Firewall as part of an Azure front-end solution for your web apps. You begin by creating an Azure Web Application Firewall policy, which includes the following settings:

- Which managed rule set you want to use.
- Which rules within that rule set you want to disable.
- Any custom rules you want to add.
- Which mode you want to use.

For deployment, you can use either of the services listed in the following table.

|Service  |Description  |
|---------|---------|
|Azure Front Door  |When you create your Azure Web Application Firewall policy, you associate it with an existing Azure Front Door profile.|
|Azure Application Gateway |You configure your application gateway to use Azure Web Application Firewall. You can choose a Web Application Firewall tier when you create your application gateway. Alternatively, you can upgrade an existing application gateway to use a Web Application Firewall tier. You then associate your Web Application Firewall policy with your application gateway.|
