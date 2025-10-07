**Configuration management** refers to automated, version-controlled management of application settings and the environments that support them. While Infrastructure as Code focuses on provisioning resources (creating virtual machines, networks, storage), configuration management focuses on configuring those resources after they're created.

Think of it this way:

- **Infrastructure as Code:** Creates a virtual machine
- **Configuration management:** Installs software, configures settings, and manages ongoing changes on that virtual machine

**Configuration as code** treats configuration files like source code—stored in version control, reviewed before changes, and deployed through automated pipelines. For example, adding a firewall rule becomes:

1. Edit the configuration file
2. Commit the change to version control
3. Run the deployment pipeline
4. The firewall rule applies automatically

No remote desktop sessions, no manual changes that might get forgotten or done inconsistently.

> [!NOTE]
> The terms _Infrastructure as Code_ and _Configuration as Code_ overlap significantly. Some people use IaC to cover both provisioning AND configuration. However, distinguishing between them helps clarify responsibilities—especially in teams where infrastructure engineers handle provisioning while application teams handle configuration.

## Manual configuration versus configuration as code

Managing configuration for even a single application can be challenging. You need to track settings across development, testing, and production environments. As you add more applications and servers, the complexity grows exponentially.

Manual configuration creates common problems:

- Settings documented in spreadsheets that quickly become outdated
- "Tribal knowledge" where only certain people know how things are configured
- Configuration drift where environments diverge over time
- Time-consuming manual processes that delay deployments

**Configuration as code solves these problems** by treating configuration like software.

**Comparison: Manual configuration versus Configuration as Code**

| **Manual configuration**                                                                | **Configuration as code**                                                          |
| --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| **Bugs are hard to reproduce:** "It works in test but not production—what's different?" | **Bugs are easily reproducible:** Same code produces same configuration every time |
| **Error-prone:** People make mistakes during manual steps                               | **Reliable:** Automation eliminates human error                                    |
| **Extensive verification:** Many manual checks before each deployment                   | **Fast deployments:** Automated tests catch issues earlier                         |
| **Documentation becomes outdated:** Changes bypass documentation                        | **Self-documenting:** Configuration files are the documentation                    |
| **Risky deployments:** Weekend windows to allow recovery time                           | **Deploy anytime:** Confidence enables frequent deployments                        |
| **Slow release cadence:** Fear of breaking things                                       | **Fast iteration:** Deploy changes quickly and safely                              |

## Benefits of configuration management

**Adopting configuration as code provides substantial benefits:**

- **Reproducible environments:** Create identical configurations on demand—no more "it works on my machine" problems
- **Environment parity:** Development, test, and production environments stay synchronized
- **Faster deployments:** Automated processes enable frequent, reliable deployments
- **Reduced documentation burden:** Configuration code serves as always-accurate documentation
- **Easy scaling:** Add capacity quickly by deploying more instances with the same configuration
- **Full change history:** Version control tracks every configuration change—who, what, when, why
- **Drift detection and correction:** Tools like Azure Automation State Configuration detect when configurations diverge and automatically fix them
- **Team collaboration:** Code reviews catch configuration errors before deployment
- **Compliance and auditing:** Complete audit trail of configuration changes helps meet regulatory requirements
- **Disaster recovery:** Quickly restore services by redeploying configurations from version control
- **Testing capabilities:** Test configuration changes in non-production environments before deploying to production
