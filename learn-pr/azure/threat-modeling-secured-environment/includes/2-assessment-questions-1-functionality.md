## Functionality

![Functionality category.](../media/supporting-icons/functionality.png)

### Why ask these questions

These questions allow you to:

- Understand if the application runs on the cloud or on-premises.
- Learn about the application, including features, use-case scenarios, and benefits.
- Understand how the application is used in the secured environment.
- Identify the application owner or company to hold potential security discussions.
- Access source code or security tooling scan reports to check out recent updates, issues, and fixes.
- Verify if the proposed version introduces the least possible amount of risk.
- Investigate malware and phishing susceptibility based on application category and requirements.
- Learn how the application recovers from critical failures.
- Uncover dependencies on administrative tasks that may cause system takeover.
- Understand authentication process to prevent spoofing scenarios.
- Gather insights into the password policy to protect against attacks.
- Understand the different authentication mechanisms used in the application to secure user identities.
- Check how the application uses logging and monitoring to find and prevent anomalous security events.
- Investigate if there are existing legal or regulatory issues with the application.
- Learn what happens when there's an incident with the application.
- Verify if the application owner has a risk management program or a set of security policies in place.

|Question|Areas to cover|
|--------|--------------|
|**Where does the application run?**|<ul><li>Client or online service</li><li>OS requirements</li><li>CLI or GUI</li></ul>|
|**What does the application do?**|<ul><li>Application main features</li><li>Benefits from using it in the secured environment</li><li>Understand how it works</li></ul>|
|**How will the application be used?**|<ul><li>Defined use-case scenarios</li><li>Integration requirements</li><li>Interactions with existing services</li><li>Access requirements</li></ul>|
|**Who owns the application?**|<ul><li>Open-sourced or company owned</li><li>Free or paid</li><li>Rule out ownership from nation states</li></ul>|
|**Is the source code available and regularly maintained?**|<ul><li>Link to source code repository</li><li>Contribution activity over time</li><li>Latest patches and updates</li></ul>|
|**Is there a recent security report available?**|<ul><li>Security issues in code</li><li>Public vulnerabilities and attack history</li><li>Attack surface information gathering</li></ul>|
|**Is the proposed version the most current?**|<ul><li>Issues with the proposed version</li><li>If it's a past version, then why use it?</li><li>Patches and updates required</li><li>Secure configuration options</li></ul>|
|**Is the application in the productivity category?**|<ul><li>Integration with productivity apps</li><li>Plugins or extensions</li><li>Authoring capabilities for email clients or document editors</li></ul>|
|**Does the application backup system data?**|<ul><li>Backup storage location</li><li>Third-party connections</li><li>Default backup and recovery options</li></ul>|
|**Do any of the basic functionalities require administrative privileges? If so, what are they?**|<ul><li>Actions requiring admin level privileges</li><li>Actions that lead to system settings access</li></ul>|
|**How are users authenticated to use the application?**|<ul><li>External identity providers vs. local authentication</li><li>Current state of security for identity provider</li><li>Enabled security controls (for example, ACL)</li></ul>|
|**What is the password policy for users? What about the main password (specific to this application)?**|<ul><li>Password requirements and change policies</li><li>Lost password workflow</li></ul>|
|**What are the security controls available for the application?**|<ul><li>2FA availability</li><li>Security logging and monitoring</li><li>Encryption</li><li>Tampering controls</li></ul>|
|**How does the application detect and prevent anomalous security events?**|<ul><li>Logging and monitoring functionality enabled by default</li></ul>|
|**Are there any legal implications with the application?**|<ul><li>International legal or regulatory issues</li><li>Current legal implications</li></ul>|
|**What happens if there's an incident with the application?**|<ul><li>Service level agreements</li><li>Patches and security updates</li><li>Notification workflows</li></ul>|
|**Does the application owner have a set of security policies or risk program?**|<ul><li>Established risk program</li><li>Set of security policies</li></ul>|