Once the scans have completed, the Azure Pipelines release is updated with a report that includes the results and bugs are created in the team's backlog.

Resolved bugs will close if the vulnerability has been fixed and move back into in-progress if the vulnerability still exists.

The benefit of using this is that the vulnerabilities are created as bugs that provide actionable work that can be tracked and measured.

False positives can be suppressed using OWASP ZAP's context file, so only valid vulnerabilities are surfaced.

:::image type="content" source="../media/surfaced-vulnerabilities-ba44d18a.png" alt-text="Screenshot of OWASP surfaced vulnerabilities.":::


Even with continuous security validation running against every change to help ensure new vulnerabilities aren't introduced, hackers continuously change their approaches, and new vulnerabilities are being discovered.

Good monitoring tools allow you to help detect, prevent, and remediate issues discovered while your application runs in production.

Azure provides several tools that provide detection, prevention, and alerting using rules, such as [OWASP Top 10](https://owasp.org/www-project-top-ten/) and machine learning to detect anomalies and unusual behavior to help identify attackers.

Minimize security vulnerabilities by taking a holistic and layered approach to security, including secure infrastructure, application architecture, continuous validation, and monitoring.

DevSecOps practices enable your entire team to incorporate these security capabilities in the whole lifecycle of your application.

Establishing continuous security validation into your CI/CD pipeline can allow your application to stay secure while improving the deployment frequency to meet the needs of your business to stay ahead of the competition.
