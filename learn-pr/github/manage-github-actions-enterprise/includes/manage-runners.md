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

### Configure Self-Hosted Runners for Enterprise Use  

Self-hosted runners in GitHub Actions provide greater flexibility and control for enterprises that require **customized environments, network access, and security hardening**. This guide covers best practices for configuring self-hosted runners, including **proxies, labels, and networking** considerations.  

#### 1. Setting Up a Self-Hosted Runner 

##### Step 1: Create and Register a Self-Hosted Runner
1. Navigate to **GitHub Enterprise → Settings → Actions → Runners**.  
2. Click **New Runner** and select the desired OS (**Linux, Windows, or macOS**).  
3. Follow the provided commands to install and configure the runner on your machine.  

##### Step 2: Install & Start the Runner  
Run the following commands based on your OS:  

**Linux/macOS**
```sh
./config.sh --url https://github.com/<org-name> --token <generated-token>
./run.sh
```

**Windows (PowerShell)**
```
.\config.cmd --url https://github.com/<org-name> --token <generated-token>
.\run.cmd
```

#### 2. Configuring Proxies for Self-Hosted Runners
Enterprises often operate behind corporate firewalls and proxies that restrict internet access. To allow self-hosted runners to communicate with GitHub, configure proxy settings as follows:

##### Linux/macOS: Configure Proxy
Edit the environment file to define proxy settings:
```
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080
export no_proxy=localhost,127.0.0.1
```
Apply the settings:

```
source ~/.bashrc
```
##### Windows: Configure Proxy

Use the following PowerShell commands:

```
[System.Environment]::SetEnvironmentVariable("HTTP_PROXY", "http://proxy.company.com:8080", "Machine")
[System.Environment]::SetEnvironmentVariable("HTTPS_PROXY", "http://proxy.company.com:8080", "Machine")
```
#### 3.Using Labels for Runner Management

Labels help organize and route jobs to specific self-hosted runners based on OS, hardware, or project requirements.

![alt text](image-6.png)

##### Assigning Labels to a Runner

When configuring a runner, you can assign custom labels:

```
./config.sh --url https://github.com/<org-name> --token <generated-token> --labels "high-memory,gpu"
```

##### Targeting a Specific Runner in a Workflow
To run a job on a specific runner with labels, update the workflow .yml:
```
jobs:
  build:
    runs-on: [self-hosted, high-memory]
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
```

#### 4.Networking Considerations
##### Allowlist GitHub IPs

GitHub-hosted runners operate on dynamic IPs, but self-hosted runners need firewall rules to allow access. Retrieve the latest GitHub IP ranges:
```
curl -s https://api.github.com/meta | jq .actions
```
Whitelist these IPs in your firewall settings to ensure connectivity.

##### Private Network & VPN Access
For enterprise workloads requiring access to private systems, configure the runner to connect via VPN or an internal network.

#### 5. Security Best Practices for Enterprise Runners
Restrict runners to trusted workflows: Prevent untrusted code from executing on self-hosted runners.  
Use ephemeral runners: Automatically remove runners after jobs to prevent persistent threats.  
Monitor runner activity: Log all runner actions and audit access.  
Apply OS security patches: Regularly update and secure the runner machine.   

### Manage Self-Hosted Runners Using Groups  
Runner groups allow organizations to **manage access, control workload distribution, and enforce security policies** for self-hosted runners in GitHub Actions. This guide covers how to **create, manage, and move runners between groups** effectively.

#### 1. Understanding Runner Groups  
Runner groups help **organize and control** self-hosted runners within a **GitHub Enterprise or Organization**. They allow:  
- Restricting which repositories can use specific runners.  
- Controlling runner availability for different teams or workloads.  
- Managing permissions for **specific branches, workflows, or environments**.

##### Runner Group Availability  
| GitHub Plan | Runner Groups Available? |  
|-------------|--------------------------|  
| GitHub Free | ❌ Not Available |  
| GitHub Pro | ❌ Not Available |  
| GitHub Team | ✅ Available |  
| GitHub Enterprise | ✅ Available |  

#### 2. Creating a Runner Group 

1. Go to **GitHub → Organization Settings → Actions → Runners**.  
2. Click **"New group"** under **Self-Hosted Runners**.  
3. Provide a **name** for the group (e.g., "Linux-Runners", "High-Memory").  
4. Choose **who can access the group** (entire organization or specific repositories).  
5. Click **Save**.  

![alt text](image-7.png)

#### 3. Adding Runners to a Group 
Once the group is created, you can **add runners manually or during registration**.

##### Option 1: Assign During Registration 
When configuring a new runner, specify the group:  
```sh
./config.sh --url https://github.com/<org-name> --token <generated-token> --runnergroup "Linux-Runners"
```
##### Option 2: Move an Existing Runner
1. Navigate to **GitHub → Organization Settings → Actions → Runners.** 
2. Locate the **runner** and click **Edit.** 
3. Select a **new runner group** and save changes. 

#### 4. Managing Access and Permissions
#### Restricting Runner Group Access
**Organization-level runners:** Restrict usage to specific repositories. 
**Repository-level runners:** Only selected workflows can access the runner.

Example: Restrict Access to a Specific Repository
1. Navigate to **Runner Group Settings.**
2. Under **Repository Access**, select **"Only select repositories".**
3. Add the repositories that are allowed to use the runner group.

#### 5. Moving Runners Between Groups
To **reassign a runner** from one group to another:

1. Go to **GitHub → Organization Settings → Actions → Runners.**
2. Click on the **runner name.**
3. Select **Change group** → **Choose a new group.**
4. Click **Save.**
Alternatively, unregister and re-register the runner in a different group:
```
./config.sh remove
./config.sh --url https://github.com/<org-name> --token <generated-token> --runnergroup "New-Group"
```

- Create separate groups for different OS types (e.g., Windows, Linux, macOS).  
- Use labels to further classify runners (e.g., GPU, high-memory, ARM).  
- Limit runner access to trusted repositories only.  
- Regularly audit and update runner groups based on team requirements.  
- Monitor runner usage and performance to optimize CI/CD workloads.

### Monitor, Troubleshoot, and Update Self-Hosted Runners**  
Managing self-hosted runners effectively requires **continuous monitoring, proactive troubleshooting, and regular updates**. This guide covers best practices and GitHub-recommended methods for ensuring **high availability, security, and performance** of self-hosted runners.

#### 1. Monitoring Self-Hosted Runners 

##### Checking Runner Status
To monitor runner availability:  
1. Navigate to **GitHub → Organization Settings → Actions → Runners**.  
2. Review the status:  
   - ✅ **Idle** → Ready for workflows.  
   - 🔄 **Active** → Currently running a job.  
   - ❌ **Offline** → Runner is down or disconnected.  

##### Using GitHub API to Fetch Runner Status
You can programmatically check the status of self-hosted runners:  
```sh
curl -H "Authorization: token <your_github_token>" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/orgs/<org-name>/actions/runners
```
Response example:
```
{
  "total_count": 2,
  "runners": [
    {
      "id": 1,
      "name": "runner-1",
      "status": "online"
    },
    {
      "id": 2,
      "name": "runner-2",
      "status": "offline"
    }
  ]
}
```
#### Logging and Metrics

- **System Logs:** Check logs in the `_diag/` directory within the runner installation folder.
- **GitHub Actions Workflow Logs:** Navigate to Actions → Workflow Run → Logs to see runner execution details.
- **Monitoring via Prometheus/Grafana:** Configure Prometheus exporters to track CPU, memory, and job execution time.

#### 2. Troubleshooting Self-Hosted Runners

##### Common Issues and Fixes

| Issue                        | Possible Cause                        | Fix                                      |
|------------------------------|---------------------------------------|------------------------------------------|
| Runner shows Offline         | Network issue, token expired, or runner crashed | Restart runner: `./run.sh`               |
| Job stuck in Queued state    | No available runners with required labels | Add runners or update labels             |
| Job fails with permission errors | Incorrect runner permissions           | Ensure runner has the correct access     |
| Workflow execution is slow   | High CPU/memory usage                 | Monitor system metrics & scale runners   |

##### Restarting a Runner
If a runner is stuck or not responding, restart it:

```sh
./svc.sh stop
./svc.sh start
```
For systemd-based Linux runners:
```
sudo systemctl restart actions.runner.<org-name>.<runner-name>.service
```
##### Checking Logs for Errors
**Runner logs:** `<runner_dir>/_diag/Runner_<timestamp>.log`
**GitHub Actions logs:** Check workflow execution logs in the GitHub UI.

#### 3. Updating Self-Hosted Runners
##### Checking for Runner Updates
GitHub periodically updates runner binaries. To check for updates:

```sh
./config.sh --version
```

You can also check runner versions via API:
```
curl -H "Authorization: token <your_github_token>" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/actions/runner/releases/latest
```
##### Updating the Runner
**1. Manual Update**
Stop the runner
```
./svc.sh stop
```
**2. Download the latest runner:**
```
curl -o actions-runner-linux-x64.tar.gz -L \
     https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
```
**3.Extract and reconfigure:**
tar xzf ./actions-runner-linux-x64.tar.gz
./config.sh --url https://github.com/<org-name> --token <generated-token>
./svc.sh install
./svc.sh start

##### Automated Updates with GitHub Actions
To automatically check for and update runners:
```
name: Update Runners

on:
  schedule:
    - cron: '0 3 * * 1'  # Runs every Monday at 3 AM

jobs:
  update-runners:
    runs-on: self-hosted
    steps:
      - name: Download and update runner
        run: |
          ./svc.sh stop
          curl -o actions-runner.tar.gz -L \
          https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
          tar xzf actions-runner.tar.gz
          ./config.sh --url https://github.com/<org-name> --token <generated-token>
          ./svc.sh start
```


### Configure access to self-hosted runners

In Enterprise Cloud and Enterprise Server, self-hosted runner groups enable you to control access to self-hosted runners at the organization and enterprise level. This feature can come in handy for cases where you need to restrict access to self-hosted runners to specific organizations or users. For example, based on the level of trust for these organizations or users, or to mitigate security risks.

Let's say you want to authorize only specific organizations in your enterprise instance to deploy code to your production environment. You could create a group containing all the runners deploying code into production at enterprise level and restrict the group access to the specific organizations authorized to deploy code.

To create groups at enterprise level, navigate to your enterprise account and then to **Policies > Actions** in the sidebar. In the **Runner groups** tab, select **New runner group**. The screen that appears will enable you to specify a group name and an access policy for organizations.

:::image type="content" source="../media/create-group.png" alt-text="Screenshot of the New group screen with group name example for all organizations.":::

To create groups at organization level, navigate to your organization **Settings** and then to **Actions** in the sidebar. Select **Runner groups**, and then **New runner group**. The screen that appears enables you to specify a group name and an access policy for repositories.

:::image type="content" source="../media/create-group-2.png" alt-text="Screenshot of the New group screen with group name example for all repositories.":::

When new runners are created, they're automatically assigned to the default group within the enterprise or organization. Runners can only be in one group at a time, but both Enterprise Cloud and Enterprise Server give you the possibility to move runners from the default group to another group.

### Configure self-hosted runners for enterprise use

Enterprise Cloud and Enterprise Server offer multiple features enabling you to customize your self-hosted runners for your enterprise use. Some of these features include _labels_, _proxy servers_, and _IP allowlists_.

#### Labels

Self-hosted runners automatically receive default labels when they're added to GitHub Actions. These default labels indicate the operating system and hardware architecture of the runner as shown in the table:

|       **Default label**        |                    **Description**                    |
|--------------------------------|-------------------------------------------------------|
|         `self-hosted`          |   Default label applied to all self-hosted runners    |
| `linux`, `windows`, or `macOS` |   Applied depending on the runner's operating system.    |
|   `x64` , `ARM`, or `ARM64`    | Applied depending on the runner's hardware architecture. |

On top of these default labels, Enterprise Cloud and Enterprise Server allow you to create and add custom labels to your runners. Custom labels can come in handy when you need to run jobs on runners that have specific capabilities. For example, if a job in one of your workflows requires a specific type of graphics hardware, you could create a `gpu` custom label and assign it to the runners that have the hardware installed. All runners with the `gpu` label would then be eligible to run the job.

To add a label to a self-hosted runner, navigate to the GitHub Actions settings of the organization, repository, or enterprise where your self-hosted runner is registered (under **Actions** for an organization or repository, under **Policies > Actions** for an enterprise). When you're there:

1. Locate the list of runners under **Runners**. If your runner is in a group, locate the runner group and select the runner dropdown to view the list of runners.

    :::image type="content" source="../media/locate-runner.png" alt-text="Screenshot of an example runner group with dropdown highlighted.":::

1. Locate the runner you want to update and select the label dropdown to view the label-selection menu. This menu displays all the custom labels available to your self-hosted runner. Labels already assigned to your self-hosted runner have a tick next to them.

    :::image type="content" source="../media/show-labels.png" alt-text="Screenshot of an example runner with label menu displayed.":::

1. Select an existing label to add it to your runner, or type the name of your new label in the **Filter labels** field and select **Create new label**. The label is automatically added to your runner when you create it.

#### Proxy servers

If you need a self-hosted runner to communicate with GitHub via a proxy server, both Enterprise Cloud and Enterprise Server enable you to change proxy configurations using the following environment variables:

| **Environment variable** |                                                                                                   **Description**                                                                                                   |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      `https_proxy`       | Proxy URL for HTTPS traffic. You can also include basic authentication credentials, if necessary. For example: <br> `http://proxy.local` <br> `http://192.168.1.1:8080` <br> `http://username:password@proxy.local`  |
|       `http_proxy`       |  Proxy URL for HTTP traffic. You can also include basic authentication credentials, if necessary. For example: <br> `http://proxy.local` <br> `http://192.168.1.1:8080` <br> `http://username:password@proxy.local`  |
|        `no_proxy`        | Comma-separated list of hosts that should'nt use a proxy. Only hostnames are allowed in `no_proxy`. You can't use IP addresses. For example: <br> `example.com` <br> `example.com,myserver.local:443,example.org` |

> [!Note]
> Proxy environment variables are read when the self-hosted runner application starts, so you must set the environment variables before configuring or starting the application. If your proxy configuration changes, you must restart the self-hosted runner application.

On Windows, the proxy environment variable names are'nt case-sensitive. On Linux and macOS, we recommend that you use all lowercase environment variables. If you have an environment variable in both lowercase and uppercase on Linux or macOS (for example, `https_proxy` and `HTTPS_PROXY`) the self-hosted runner application uses the lowercase environment variable.

#### IP allowlists

If your Enterprise Cloud or Enterprise Server organization has configured IP allowlists, you must add the IP address or IP address range of your self-hosted runners to the IP allowlist in order for your self-hosted runners to communicate with GitHub.

To add the IP address or IP address range of your self-hosted runners to an organization IP allowlist, navigate to your organization **Settings** and select **Organization security** in the sidebar. Under **IP Address**, add the IP address or IP address range of your self-hosted runners in CIDR notation and select **+ Add**.

## Monitor and troubleshoot self-hosted runners

Both Enterprise Cloud and Enterprise Server offer tools enabling you to monitor, troubleshoot, and update your self-hosted runners. If your builds start to fail, some files in your repository get locked, or your workflow runs are stuck, troubleshooting the runner executing your workflow can help solve the issue.

The main steps you can take when troubleshooting a self-hosted runner are:

1. Check the status of the runner in the GitHub Actions settings of the organization, repository, or enterprise where your self-hosted runner is registered (under **Actions** for an organization or repository, under **Policies > Actions** for an enterprise).
1. Review the activities and automatic updates of the runner in the `Runner_` files in the `_diag` folder.
1. Review the status of the jobs the runner executed in the `Worker_` files in the `_diag` folder.

According to the operating system of your runner, you can take extra steps as shown in the table:

|                             **Mac**                              |                            **Windows**                            |                              **Linux**                              |
|----------------------------------------------------------------|-----------------------------------------------------------------|-------------------------------------------------------------------|
| Check the self-hosted runner application service using `launchd` | Check the self-hosted runner application service using PowerShell | - Check the self-hosted runner application service using `journalctl` <br> - If your jobs require containers, check that Docker is installed and running and the Docker permissions using `systemctl`   |
