Use the completed data-flow diagram and answers from the security assessment to identify potential solutions to each threat.

> [!TIP]
> Check out [Microsoft Security](https://www.microsoft.com/security/business) to learn more about tools and services you can use.

## Functionality & Integration

![Functionality category.](../media/supporting-icons/functionality.png)
![Integration category.](../media/supporting-icons/integration.png)

|Risk|Solution|
|----|--------|
|Sensitive corporate data stored in client application|Enable disk encryption and use an application monitoring service to detect anomalies.|
|No security scans available|As part of your security assessment, run different [security tools](https://docs.microsoft.com/azure/security/develop/security-code-analysis-overview) to help you identify security issues in code.|
|Outdated application version|Investigate the changes between the new version against the one proposed. Recommend the one with the least number of issues.|
|No backup, logging, or monitoring|Enable Azure Backup and Monitoring to prevent data loss. Visit the complete [list of services](https://docs.microsoft.com/azure/security/fundamentals/end-to-end).|
|No 2FA enforcement|As part of the installation exercise, enable 2FA in the application.|
|No password requirements|You can't make changes to the password policy, but you can require users to save their main passwords in [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/general/overview) to prevent accidental disclosure.|
|No vendor SLA|Develop a process to consistently check the application against potential threats that could put the PAW at risk.|
|No SDL process|Consider registering the application as a service in the organization. Create an open-source team to manage yearly SDL requirements.|