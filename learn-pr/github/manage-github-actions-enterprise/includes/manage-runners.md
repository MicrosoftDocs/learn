In this section, you'll explore the different tools and strategies available to you in GitHub Enterprise Cloud and GitHub Enterprise Server to manage the use of GitHub Actions runners in your enterprise.

## Choose an appropriate runner for your workload

GitHub Actions workflows can be executed by two types of runners: GitHub-hosted runners or self-hosted runners.

> [!Note]
> GitHub-hosted runners are only available for Enterprise Cloud. If you have an Enterprise Server instance, this section does not apply to you.

GitHub-hosted runners offer a quicker, simpler way to run your workflows, while self-hosted runners are a highly configurable way to run workflows in your own custom environment. For example, if you need to use an IP address allowlist for your organization or a specialized hardware configuration for running your workflows, use a self-hosted runner.

The following table compares GitHub-hosted runners versus self-hosted runners. Use it to choose the appropriate runner for your workload.

| **GitHub-hosted runners**                                                                                                        | **Self-hosted runners**                                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Receive automatic updates for the operating system, preinstalled packages and tools, and the self-hosted runner application. | Receive automatic updates for the self-hosted runner application only. You're responsible for updating the operating system and all other software.             |
| Are managed and maintained by GitHub.                                                                                        | Can use cloud services or local machines that you already pay for. <br> Are customizable to your hardware, operating system, software, and security requirements. |
| Provide a clean instance for every job execution.                                                                            | Don't need to have a clean instance for every job execution.                                                                                                     |
| Use free minutes on your GitHub plan, with per-minute rates applied after surpassing the free minutes.                       | Are free to use with GitHub Actions, but you are responsible for the cost of maintaining your runner machines.                                                   |

## Configure access to self-hosted runners

In Enterprise Cloud and Enterprise Server, self-hosted runner groups enable you to control access to self-hosted runners at the organization and enterprise level. This feature can come in handy for cases where you need to restrict access to self-hosted runners to specific organizations or users; for example, based on the level of trust for these organizations or users, or to mitigate security risks.

Let's say you want to authorize only specific organizations in your enterprise instance to deploy code to your production environment. You could create a group containing all the runners deploying code into production at enterprise level and restrict the group access to the specific organizations authorized to deploy code.

To create groups at enterprise level, navigate to your enterprise account and then to **Policies > Actions** in the sidebar. In the **Self-hosted runners** tab, select **Add new > New group**. The screen that appears will enable you to specify a group name and an access policy for organizations.

:::image type="content" source="../media/create-group.png" alt-text="Screenshot of the New group screen with group name example for all organizations.":::

To create groups at organization level, navigate to your organization **Settings** and then to **Actions** in the sidebar. In the **Self-hosted runners** section, select **Add new > New group**. The screen that appears enables you to specify a group name and an access policy for repositories.

:::image type="content" source="../media/create-group-2.png" alt-text="Screenshot of the New group screen with group name example for all repositories.":::

When new runners are created, they are automatically assigned to the default group within the enterprise or organization. Runners can only be in one group at a time, however, both Enterprise Cloud and Enterprise Server give you the possibility to move runners from the default group to another group.

## Configure self-hosted runners for enterprise use

Enterprise Cloud and Enterprise Server offer multiple features enabling you to customize your self-hosted runners for your enterprise use. Some of these features include _labels, proxy servers, and IP allowlists_.

### Labels

Self-hosted runners automatically receive default labels when they are added to GitHub Actions. These default labels indicate the operating system and hardware architecture of the runner as shown in the table below:

|       **Default label**        |                    **Description**                    |
|--------------------------------|-------------------------------------------------------|
|         `self-hosted`          |   Default label applied to all self-hosted runners    |
| `linux`, `windows`, or `macOS` |   Applied depending on the runner's operating system.    |
|   `x64` , `ARM`, or `ARM64`    | Applied depending on the runner's hardware architecture. |

On top of these default labels, Enterprise Cloud and Enterprise Server allow you to create and add custom labels to your runners. Custom labels can come in handy when you need to run jobs on runners that have specific capabilities. For example, if a job in one of your workflows requires a specific type of graphics hardware, you could create a `gpu` custom label and assign it to the runners that have the hardware installed. All runners with the `gpu` label would then be eligible to run the job.

To add a label to a self-hosted runner, navigate to the GitHub Actions settings of the organization, repository, or enterprise where your self-hosted runner is registered (under **Actions** for an organization or repository, under **Policies > Actions** for an enterprise). When you're there:

1. Locate the list of runners under **Self-hosted runners**. If your runner is in a group, locate the runner group and select the runner dropdown to view the list of runners.

    :::image type="content" source="../media/locate-runner.png" alt-text="Screenshot of an example runner group with dropdown highlighted.":::

1. Locate the runner you want to update and select the label dropdown to view the label-selection menu. This menu displays all the custom labels available to your self-hosted runner. Labels already assigned to your self-hosted runner have a tick next to them.

    :::image type="content" source="../media/show-labels.png" alt-text="Screenshot of an example runner with label menu displayed.":::

1. Select an existing label to add it to your runner, or type the name of your new label in the **Filter labels** field and select **Create new label**. The label is automatically added to your runner when you create it.

### Proxy servers

If you need a self-hosted runner to communicate with GitHub via a proxy server, both Enterprise Cloud and Enterprise Server enable you to change proxy configurations using the following environment variables:

| **Environment variable** |                                                                                                   **Description**                                                                                                   |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      `https_proxy`       | Proxy URL for HTTPS traffic. You can also include basic authentication credentials, if necessary. For example: <br> `http://proxy.local` <br> `http://192.168.1.1:8080` <br> `http://username:password@proxy.local`  |
|       `http_proxy`       |  Proxy URL for HTTP traffic. You can also include basic authentication credentials, if necessary. For example: <br> `http://proxy.local` <br> `http://192.168.1.1:8080` <br> `http://username:password@proxy.local`  |
|        `no_proxy`        | Comma-separated list of hosts that should not use a proxy. Only hostnames are allowed in `no_proxy`, you cannot use IP addresses. For example: <br> `example.com` <br> `example.com,myserver.local:443,example.org` |

> [!Note]
> Proxy environment variables are read when the self-hosted runner application starts, so you must set the environment variables before configuring or starting the application. If your proxy configuration changes, you must restart the self-hosted runner application.

On Windows, the proxy environment variable names are not case-sensitive. On Linux and macOS, we recommend that you use all lowercase environment variables. If you have an environment variable in both lowercase and uppercase on Linux or macOS (for example, `https_proxy` and `HTTPS_PROXY`) the self-hosted runner application uses the lowercase environment variable.

### IP allowlists

If your Enterprise Cloud or Enterprise Server organization has configured IP allowlists, you must add the IP address or IP address range of your self-hosted runners to the IP allowlist in order for your self-hosted runners to communicate with GitHub.

To add the IP address or IP address range of your self-hosted runners to an organization IP allowlist, navigate to your organization **Settings** and select **Organization security** in the sidebar. Under **IP Address**, add the IP address or IP address range of your self-hosted runners in CIDR notation and select **+ Add**.

## Monitor and troubleshoot self-hosted runners

Both Enterprise Cloud and Enterprise Server offer tools enabling you to monitor, troubleshoot and update your self-hosted runners. If your builds start to fail, some files in your repository get locked, or your workflow runs are stuck, troubleshooting the runner executing your workflow can help solve the issue.

The main steps you can take when troubleshooting a self-hosted runner are:

1. Check the status of the runner in the GitHub Actions settings of the organization, repository, or enterprise where your self-hosted runner is registered (under **Actions** for an organization or repository, under **Policies > Actions** for an enterprise).
1. Review the activities and automatic updates of the runner in the `Runner_` files in the `_diag` folder.
1. Review the status of the jobs the runner executed in the `Worker_` files in the `_diag` folder.

According to the operating system of your runner, you can take extra steps as shown in the table below:

|                             **Mac**                              |                            **Windows**                            |                              **Linux**                              |
|----------------------------------------------------------------|-----------------------------------------------------------------|-------------------------------------------------------------------|
| Check the self-hosted runner application service using `launchd` | Check the self-hosted runner application service using PowerShell | - Check the self-hosted runner application service using `journalctl` <br> - If your jobs require containers, check that Docker is installed and running and the Docker permissions using `systemctl`   |
