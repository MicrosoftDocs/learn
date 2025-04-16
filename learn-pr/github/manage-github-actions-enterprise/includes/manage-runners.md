In this section, you'll explore the different tools and strategies available to you in GitHub Enterprise Cloud and GitHub Enterprise Server to manage the use of GitHub Actions runners in your enterprise.

## Choose an appropriate runner for your workload

Two types of runners can execute GitHub Actions workflows: GitHub-hosted runners or self-hosted runners.

> [!Note]
> GitHub-hosted runners are only available for Enterprise Cloud. If you have an Enterprise Server instance, this section does not apply to you.

GitHub-hosted runners offer a quicker and simpler way to run your workflows, while self-hosted runners are a highly configurable way to run workflows in your own custom environment. For example, if you need to use an IP address allowlist for your organization or a specialized hardware configuration for running your workflows, use a self-hosted runner.

The following table compares GitHub-hosted runners versus self-hosted runners. Use it to choose the appropriate runner for your workload.

| **GitHub-hosted runners**                                                                                                        | **Self-hosted runners**                                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Receive automatic updates for the operating system, preinstalled packages and tools, and the self-hosted runner application. | Receive automatic updates for the self-hosted runner application only. You're responsible for updating the operating system and all other software.             |
| GitHub managed and maintained.                                                                                        | Can use cloud services or local machines that you already pay for. Also are customizable to your hardware, operating system, software, and security requirements. |
| Provide a clean instance for every job execution.                                                                            | Don't need to have a clean instance for every job execution.                                                                                                     |
| Use free minutes on your GitHub plan, with per-minute rates applied after surpassing the free minutes.                       | Are free to use with GitHub Actions, but you're responsible for the cost of maintaining your runner machines.                                                   |

## Manage runners for the enterprise

Managing runners for the enterprise involves configuring and securing both GitHub-hosted and self-hosted runners to ensure efficient and secure CI/CD workflows. This includes setting up IP allow lists to control access, enhancing security by restricting runner access to specific IP addresses, and ensuring compliance with organizational policies. Proper configuration of IP allow lists for both GitHub-hosted and self-hosted runners is crucial for maintaining secure and reliable interactions between internal applications and GitHub Actions runners. Regular updates and reviews of these configurations are necessary to adapt to changes in IP address ranges and maintain optimal security.

### Configuring IP Allow Lists on GitHub-hosted and Self-hosted Runners

Configuring IP allow lists helps control access to runners by restricting them to specific IP addresses. This enhances security by preventing unauthorized access but may require additional network configurations.

| **This guide provides a detailed explanation of how** | **Self-hosted runners**                                                                 |
|-------------------------------------------------------|------------------------------------------------------------------------------------------|
| GitHub-hosted runners use dynamic IP addresses, making it challenging to whitelist specific IPs. | Use static or controlled IPs, allowing precise IP whitelisting.                         |
| Organizations must allow GitHub’s published IP ranges. | Can be placed behind firewalls or VPNs for added security.                              |
| GitHub-hosted runners can be restricted using GitHub’s enterprise security settings. | Require explicit configuration to communicate with external services, enhancing security. |


#### Allowed IP list

An **allowed IP list** is a security feature that restricts access to services or resources based on predefined IP addresses. By configuring an IP allow list, organizations can:

- **Enhance Security:** Prevent unauthorized access by allowing only trusted IP addresses.
- **Control Network Traffic:** Restrict inbound and outbound requests to known and verified IPs.
- **Improve Compliance:** Ensure regulatory compliance by limiting access to authorized networks.

| **This guide provides a detailed explanation of how**                                        | **Self-hosted runners**                                                                 |
|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| Organizations must allow GitHub's published IP ranges, which change periodically.            | Admins can define specific IP addresses that are allowed to access the runners.          |
| GitHub-hosted runners can be configured via GitHub’s security settings.                      | Self-hosted runners work well with firewalls, VPNs, or cloud security groups.            |


### Configuring IP Allow Lists for Internal Applications to Interact with GitHub-Hosted Runners

To configure IP allow lists for internal applications and systems to interact with GitHub-hosted runners, you can refer to the following official GitHub documentation:

#### 1. Understand GitHub's IP Address Ranges
GitHub-hosted runners operate within specific IP address ranges. To ensure your internal applications can communicate with these runners, you need to allow these IP ranges through your firewall. GitHub provides a meta API endpoint https://api.github.com/meta that lists all current IP address ranges used by GitHub services, including those for Actions runners. Regularly updating your allow lists based on this information is essential, as IP ranges can change.

![alt text](image-8.png)

#### 2. Configure Your Firewall

##### a. Obtain GitHub's IP Ranges:
- Use the meta API endpoint to retrieve the latest IP address ranges used by GitHub Actions runners.

##### b. Update Firewall Rules:
- Add rules to your firewall to permit inbound and outbound traffic to and from these IP ranges. This ensures that your internal systems can interact with GitHub-hosted runners without connectivity issues.

#### 3. Consider Using Self-Hosted Runners
If maintaining an IP allow list for GitHub-hosted runners is challenging due to frequent changes in IP ranges, consider setting up self-hosted runners within your network. This approach allows you to have more control over the runner environment and network configurations. However, be aware that using self-hosted runners requires additional maintenance and infrastructure management.

![alt text](image-5.png)

#### 4. Regularly Review and Update Allow Lists
Since GitHub's IP address ranges can change, it's crucial to periodically review and update your firewall's IP allow lists. Automating this process by scripting the retrieval of IP ranges from GitHub's meta API can help ensure your allow lists remain current without manual intervention.

----

### Effects and Potential Abuse Vectors of Enabling Self-Hosted Runners on Public Repositories  

### Effects of Enabling Self-Hosted Runners  
1. **Customization & Performance Optimization**  
   - Self-hosted runners allow control over hardware, installed software, and environment settings.  
   - Workflows can be optimized for performance by using dedicated, high-performance machines.  

2. **Cost Savings**  
   - Unlike GitHub-hosted runners (which have limited free usage), self-hosted runners run on your infrastructure, reducing cost constraints.  

3. **State Persistence**  
   - Self-hosted runners do **not** reset between jobs like GitHub-hosted runners.  
   - This allows **caching dependencies**, reusing large datasets, and maintaining persistent states.  

4. **Security & Maintenance Responsibility**  
   - **Security patches, dependency updates, and system monitoring** become the runner owner's responsibility.  
   - Misconfigurations could expose the runner to external threats.  

#### Potential Abuse Vectors of Self-Hosted Runners  
Enabling self-hosted runners on public repositories introduces significant security risks. Since **anyone** can trigger workflows by submitting a pull request, attackers can exploit this feature in various ways:

1. **Arbitrary Code Execution (RCE) by Malicious Actors**  
   - Attackers can submit pull requests containing **malicious scripts**, which the self-hosted runner executes automatically.  
   - If the runner has **elevated privileges**, the attacker gains **full system access**.  

2. **Cryptocurrency Mining & Resource Exploitation**  
   - Attackers may abuse self-hosted runners to mine cryptocurrency, causing **unexpected high CPU and GPU usage**.  
   - This increases **operational costs** and **reduces availability** for legitimate workflows.  

3. **Data Exfiltration & Credential Theft**  
   - If secrets (API keys, database credentials, SSH keys) are stored on the runner, attackers could extract them.  
   - **Example attack vector**: A malicious pull request could read and send stored environment variables to an external server.  

4. **Denial of Service (DoS) Attacks**  
   - Attackers can flood the repository with numerous pull requests to overload self-hosted runners.  
   - If runners are on shared infrastructure, other critical workflows may be disrupted.  

5. **Lateral Movement & Network Exploitation**  
   - If the self-hosted runner is inside a **corporate network**, an attacker could **pivot** into internal systems.  
   - This could lead to **data breaches**, **ransomware attacks**, or **persistent access** to private resources.  

#### Mitigation Strategies  
To reduce security risks, follow these best practices:

- Restrict self-hosted runners to **private repositories only**
- Require **workflow approval** for pull requests from external contributors
- Run self-hosted runners in a **secure, isolated environment** (e.g., containers, virtual machines)
- Use **firewalls and network rules** to block unauthorized access
- Limit access to **sensitive secrets** and store credentials securely
- **Monitor and log** runner activity to detect anomalies

### Selecting Appropriate Runners to Support Workloads  

#### Understanding GitHub Runners  
GitHub Actions supports two types of runners:  

1. **GitHub-Hosted Runners**  
   - Managed by GitHub, automatically provisioned and scaled.  
   - Includes **pre-installed software, tools, and dependencies** for common workflows.  
   - Available for **Windows, Linux, and macOS**.  
   - Recommended for **general automation, open-source projects, and quick setup**.  

2. **Self-Hosted Runners**  
   - Managed by the user, providing **full control over environment and resources**.  
   - Can be configured for **custom hardware, on-premises, or cloud infrastructure**.  
   - Supports **persistent states between jobs**, allowing better caching and custom dependencies.  
   - Recommended for **private repositories, enterprise workloads, and performance-intensive tasks**.  


#### Choosing Between GitHub-Hosted and Self-Hosted Runners  

Two types of runners can execute GitHub Actions workflows: GitHub-hosted runners or self-hosted runners.

> [!Note]
> GitHub-hosted runners are only available for Enterprise Cloud. If you have an Enterprise Server instance, this section does not apply to you.

GitHub-hosted runners offer a quicker and simpler way to run your workflows, while self-hosted runners are a highly configurable way to run workflows in your own custom environment. For example, if you need to use an IP address allowlist for your organization or a specialized hardware configuration for running your workflows, use a self-hosted runner.

The following table compares GitHub-hosted runners versus self-hosted runners. Use it to choose the appropriate runner for your workload.

| **GitHub-hosted runners**                                                                                                        | **Self-hosted runners**                                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Receive automatic updates for the operating system, preinstalled packages and tools, and the self-hosted runner application. | Receive automatic updates for the self-hosted runner application only. You're responsible for updating the operating system and all other software.             |
| GitHub managed and maintained.                                                                                        | Can use cloud services or local machines that you already pay for. Also are customizable to your hardware, operating system, software, and security requirements. |
| Provide a clean instance for every job execution.                                                                            | Don't need to have a clean instance for every job execution.                                                                                                     |
| Use free minutes on your GitHub plan, with per-minute rates applied after surpassing the free minutes.                       | Are free to use with GitHub Actions, but you're responsible for the cost of maintaining your runner machines.                                                   |


#### Choosing the Right Operating System for Runners
##### 1. Linux Runners (Default)  
Best for most workloads  
Fast, cost-effective, and widely supported  
Used in **CI/CD, scripting, Docker, and automation**  
Example: `ubuntu-latest`, `ubuntu-22.04`  

##### 2. Windows Runners 
Needed for **.NET, Windows-based software, and GUI apps**  
Supports **PowerShell, Windows-specific dependencies**  
Example: `windows-latest`, `windows-2022`  

##### 3. macOS Runners
Required for **iOS, macOS, Xcode, and Apple-specific builds**  
Supports **Swift, Objective-C, and macOS applications**  
Example: `macos-latest`, `macos-13`  

#### Best Practices for Selecting Runners
Use **GitHub-hosted runners** for general workflows and automation.  
se **self-hosted runners** for **custom environments, large workloads, or security-sensitive applications**.  
Choose **Linux runners** for most workloads due to performance and cost efficiency.  
Use **Windows or macOS runners** only when required for compatibility.  
**Regularly update and monitor self-hosted runners** to prevent security risks.  

### Contrast GitHub-Hosted and Self-Hosted Runners  

GitHub Actions supports two types of runners for executing workflows:  

1. **GitHub-Hosted Runners** – Managed by GitHub, automatically provisioned, and pre-configured with common development tools.  
2. **Self-Hosted Runners** – Managed by the user, allowing complete control over the environment, resources, and configurations.  

This section highlights the key differences between GitHub-hosted and self-hosted runners.

#### Comparison: GitHub-Hosted vs. Self-Hosted Runners

| Feature | GitHub-Hosted Runner | Self-Hosted Runner |
|---------|----------------------|--------------------|
| **Setup & Maintenance** | No setup required; GitHub manages everything | User must install, configure, and maintain |
| **Scalability** | Auto-scales dynamically | Must manually provision additional runners |
| **Security** | High security; fresh virtual environment for each job | Requires manual security hardening |
| **Customization** | Limited; pre-installed tools only | Fully customizable; user can install any dependencies |
| **Performance** | Standardized compute resources | Can use high-performance hardware |
| **State Persistence** | Resets after every job | Can persist data between jobs |
| **Cost** | Free for public repos; limited free usage for private repos | No GitHub costs, but requires infrastructure investment |
| **Network Access** | No direct access to internal networks | Can access internal/private networks |
| **Use Case** | Best for general CI/CD, automation, and open-source projects | Best for enterprise environments, secure builds, and large workloads |

#### Key Differences & Considerations 

##### 1. Setup & Maintenance 
- **GitHub-Hosted Runners** require **zero setup**; users can start running workflows immediately.  
- **Self-Hosted Runners** need **manual installation, configuration, updates, and security management**.  

##### 2. Security Risks
- GitHub-hosted runners **run in isolated virtual machines** that reset after each job, minimizing attack surfaces.  
- Self-hosted runners **persist across jobs**, meaning a compromised runner can be exploited across multiple workflow runs.  

##### 3. Performance & Cost Considerations
- GitHub-hosted runners **provide a standard environment** but have **usage limits** (e.g., free minutes per month for private repositories).  
- Self-hosted runners **allow better performance tuning** (e.g., running on high-end servers) but require **infrastructure and maintenance costs**.  

##### 4. Networking & Access
- GitHub-hosted runners **cannot access private/internal resources** without additional configurations.  
- Self-hosted runners **can access internal systems**, making them ideal for **private repositories, internal tools, and on-premises deployments**.  

#### When to Use Each Runner?

**Use GitHub-Hosted Runners If:**  
- You need a **quick and easy setup** without infrastructure management.  
- Your workflow **doesn’t require custom dependencies** beyond the pre-installed tools.  
- You're working on an **open-source or public repository** with **free hosted runner minutes**.  

**Use Self-Hosted Runners If:**  
- Your workflow requires **specific dependencies, configurations, or persistent states**.  
- You need to **access private network resources** (e.g., on-premises databases, internal services).  
- You require **higher performance machines** for **large-scale CI/CD pipelines**.  

