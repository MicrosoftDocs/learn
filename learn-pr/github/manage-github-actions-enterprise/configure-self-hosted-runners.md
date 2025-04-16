In the previous unit, you explored the different tools and strategies available to manage the use of GitHub Actions runners in your enterprise. In this unit, you'll learn how to configure and monitor self-hosted runners for advanced enterprise use, including:

- Setting up self-hosted runners with proxy and network configurations  
- Using labels and runner groups to organize and control workflows  
- Monitoring runner health, usage, and performance  
- Troubleshooting and updating runners effectively  
- Managing secure access and enforcing policy-based controls  

## Configure Self-Hosted Runners for Enterprise Use  

Self-hosted runners in GitHub Actions provide greater flexibility and control for enterprises that require **customized environments, network access, and security hardening**. This guide covers best practices for configuring self-hosted runners, including **proxies, labels, and networking** considerations.  

### 1. Setting Up a Self-Hosted Runner 

#### Step 1: Create and Register a Self-Hosted Runner
1. Navigate to **GitHub Enterprise → Settings → Actions → Runners**.  
2. Click **New Runner** and select the desired OS (**Linux, Windows, or macOS**).  
3. Follow the provided commands to install and configure the runner on your machine.  

#### Step 2: Install & Start the Runner  
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

### 2. Configuring Proxies for Self-Hosted Runners
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
#### Windows: Configure Proxy

Use the following PowerShell commands:

```
[System.Environment]::SetEnvironmentVariable("HTTP_PROXY", "http://proxy.company.com:8080", "Machine")
[System.Environment]::SetEnvironmentVariable("HTTPS_PROXY", "http://proxy.company.com:8080", "Machine")
```
### 3.Using Labels for Runner Management

Labels help organize and route jobs to specific self-hosted runners based on OS, hardware, or project requirements.

![alt text](image-6.png)

#### Assigning Labels to a Runner

When configuring a runner, you can assign custom labels:

```
./config.sh --url https://github.com/<org-name> --token <generated-token> --labels "high-memory,gpu"
```

#### Targeting a Specific Runner in a Workflow
To run a job on a specific runner with labels, update the workflow .yml:
```
jobs:
  build:
    runs-on: [self-hosted, high-memory]
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
```

### 4.Networking Considerations
#### Allowlist GitHub IPs

GitHub-hosted runners operate on dynamic IPs, but self-hosted runners need firewall rules to allow access. Retrieve the latest GitHub IP ranges:
```
curl -s https://api.github.com/meta | jq .actions
```
Whitelist these IPs in your firewall settings to ensure connectivity.

#### Private Network & VPN Access
For enterprise workloads requiring access to private systems, configure the runner to connect via VPN or an internal network.

### 5. Security Best Practices for Enterprise Runners
Restrict runners to trusted workflows: Prevent untrusted code from executing on self-hosted runners.  
Use ephemeral runners: Automatically remove runners after jobs to prevent persistent threats.  
Monitor runner activity: Log all runner actions and audit access.  
Apply OS security patches: Regularly update and secure the runner machine.   

### Manage Self-Hosted Runners Using Groups  
Runner groups allow organizations to **manage access, control workload distribution, and enforce security policies** for self-hosted runners in GitHub Actions. This guide covers how to **create, manage, and move runners between groups** effectively.

### 1. Understanding Runner Groups  
Runner groups help **organize and control** self-hosted runners within a **GitHub Enterprise or Organization**. They allow:  
- Restricting which repositories can use specific runners.  
- Controlling runner availability for different teams or workloads.  
- Managing permissions for **specific branches, workflows, or environments**.

#### Runner Group Availability  
| GitHub Plan | Runner Groups Available? |  
|-------------|--------------------------|  
| GitHub Free | ❌ Not Available |  
| GitHub Pro | ❌ Not Available |  
| GitHub Team | ✅ Available |  
| GitHub Enterprise | ✅ Available |  

### 2. Creating a Runner Group 

1. Go to **GitHub → Organization Settings → Actions → Runners**.  
2. Click **"New group"** under **Self-Hosted Runners**.  
3. Provide a **name** for the group (e.g., "Linux-Runners", "High-Memory").  
4. Choose **who can access the group** (entire organization or specific repositories).  
5. Click **Save**.  

![alt text](image-7.png)

### 3. Adding Runners to a Group 
Once the group is created, you can **add runners manually or during registration**.

##### Option 1: Assign During Registration 
When configuring a new runner, specify the group:  
```sh
./config.sh --url https://github.com/<org-name> --token <generated-token> --runnergroup "Linux-Runners"
```
#### Option 2: Move an Existing Runner
1. Navigate to **GitHub → Organization Settings → Actions → Runners.** 
2. Locate the **runner** and click **Edit.** 
3. Select a **new runner group** and save changes. 

### 4. Managing Access and Permissions
#### Restricting Runner Group Access
**Organization-level runners:** Restrict usage to specific repositories. 
**Repository-level runners:** Only selected workflows can access the runner.

Example: Restrict Access to a Specific Repository
1. Navigate to **Runner Group Settings.**
2. Under **Repository Access**, select **"Only select repositories".**
3. Add the repositories that are allowed to use the runner group.

### 5. Moving Runners Between Groups
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

## Monitor, Troubleshoot, and Update Self-Hosted Runners**  
Managing self-hosted runners effectively requires **continuous monitoring, proactive troubleshooting, and regular updates**. This guide covers best practices and GitHub-recommended methods for ensuring **high availability, security, and performance** of self-hosted runners.

### 1. Monitoring Self-Hosted Runners 

#### Checking Runner Status
To monitor runner availability:  
1. Navigate to **GitHub → Organization Settings → Actions → Runners**.  
2. Review the status:  
   - ✅ **Idle** → Ready for workflows.  
   - 🔄 **Active** → Currently running a job.  
   - ❌ **Offline** → Runner is down or disconnected.  

#### Using GitHub API to Fetch Runner Status
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
### Logging and Metrics

- **System Logs:** Check logs in the `_diag/` directory within the runner installation folder.
- **GitHub Actions Workflow Logs:** Navigate to Actions → Workflow Run → Logs to see runner execution details.
- **Monitoring via Prometheus/Grafana:** Configure Prometheus exporters to track CPU, memory, and job execution time.

### 2. Troubleshooting Self-Hosted Runners

#### Common Issues and Fixes

| Issue                        | Possible Cause                        | Fix                                      |
|------------------------------|---------------------------------------|------------------------------------------|
| Runner shows Offline         | Network issue, token expired, or runner crashed | Restart runner: `./run.sh`               |
| Job stuck in Queued state    | No available runners with required labels | Add runners or update labels             |
| Job fails with permission errors | Incorrect runner permissions           | Ensure runner has the correct access     |
| Workflow execution is slow   | High CPU/memory usage                 | Monitor system metrics & scale runners   |

#### Restarting a Runner
If a runner is stuck or not responding, restart it:

```sh
./svc.sh stop
./svc.sh start
```
For systemd-based Linux runners:
```
sudo systemctl restart actions.runner.<org-name>.<runner-name>.service
```
#### Checking Logs for Errors
**Runner logs:** `<runner_dir>/_diag/Runner_<timestamp>.log`
**GitHub Actions logs:** Check workflow execution logs in the GitHub UI.

### 3. Updating Self-Hosted Runners
#### Checking for Runner Updates
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
#### Updating the Runner
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

#### Automated Updates with GitHub Actions
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

