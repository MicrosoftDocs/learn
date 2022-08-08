## Authentication

To register an agent, you need to be a member of the administrator role in the agent pool.

The identity of the agent pool administrator is only required at the time of registration. It's not persisted on the agent and isn't used in any following communication between the agent and Azure Pipelines.

Also, you must be a local administrator on the server to configure the agent.

Your agent can authenticate to Azure DevOps using one of the following methods:

## Personal access token (PAT)

Generate and use a PAT to connect an agent with Azure Pipelines. PAT is the only scheme that works with Azure Pipelines. Also, as explained above, this PAT is used only when registering the agent and not for succeeding communication.

## Interactive versus service

You can run your agent as either a service or an interactive process. Whether you run an agent as a service or interactively, you can choose which account you use to run the agent.

It's different from your credentials when registering the agent with Azure Pipelines. The choice of agent account depends solely on the needs of the tasks running in your build and deployment jobs.

For example, to run tasks that use Windows authentication to access an external service, you must run the agent using an account with access to that service.

However, if you're running UI tests such as Selenium or Coded UI tests that require a browser, the browser is launched in the context of the agent account.

After configuring the agent, we recommend you first try it in interactive mode to ensure it works. Then, we recommend running the agent in one of the following modes so that it reliably remains to run for production use. These modes also ensure that the agent starts automatically if the machine is restarted.

You can use the service manager of the operating system to manage the lifecycle of the agent. Also, the experience for auto-upgrading the agent is better when it's run as a service.

As an interactive process with autologon enabled. In some cases, you might need to run the agent interactively for production use, such as UI tests.

When the agent is configured to run in this mode, the screen saver is also disabled.

Some domain policies may prevent you from enabling autologon or disabling the screen saver.

In such cases, you may need to seek an exemption from the domain policy or run the agent on a workgroup computer where the domain policies don't apply.

> [!NOTE]
> There are security risks when you enable automatic login or disable the screen saver. You allow other users to walk up to the computer and use the account that automatically logs on. If you configure the agent to run in this way, you must ensure the computer is physically protected; for example, located in a secure facility. If you use Remote Desktop to access the computer on which an agent is running with autologon, simply closing the Remote Desktop causes the computer to be locked, and any UI tests that run on this agent may fail. To avoid this, use the tscon command to disconnect from Remote Desktop.

## Agent version and upgrades

Microsoft updates the agent software every few weeks in Azure Pipelines.

The agent version is indicated in the format \{major\}.\{minor\}. For instance, if the agent version is 2.1, the major version is 2, and the minor version is 1.

When a newer version of the agent is only different in minor versions, it's automatically upgraded by Azure Pipelines.

This upgrade happens when one of the tasks requires a newer version of the agent.

If you run the agent interactively or a newer major version of the agent is available, you must manually upgrade the agents. Also, you can do it from the agent pools tab under your project collection or organization.

You can view the version of an agent by navigating to Agent pools and selecting the Capabilities tab for the wanted agent.

```Cmd
Azure Pipelines: [https://dev.azure.com/{your_organization}/_admin/_AgentPool](https://dev.azure.com/{your_organization}/_admin/_AgentPool)

```

## Question and Answer

### Do self-hosted agents have any performance advantages over Microsoft-hosted agents?

In many cases, yes. Specifically:

 -  If you use a self-hosted agent, you can run incremental builds. For example, you define a CI build pipeline that doesn't clean the repo or do a clean build. Your builds will typically run faster.
     -  You don't get these benefits when using a Microsoft-hosted agent. The agent is destroyed after the build or release pipeline is completed.
 -  A Microsoft-hosted agent can take longer to start your build. While it often takes just a few seconds for your job to be assigned to a Microsoft-hosted agent, it can sometimes take several minutes for an agent to be allocated, depending on the load on our system.

### Can I install multiple self-hosted agents on the same machine?

Yes. This approach can work well for agents who run jobs that don't consume many shared resources. For example, you could try it for agents that run releases that mostly orchestrate deployments and don't do much work on the agent itself.

In other cases, you might find that you don't gain much efficiency by running multiple agents on the same machine.

For example, it might not be worthwhile for agents that run builds that consume many disks and I/O resources.

You might also have problems if parallel build jobs use the same singleton tool deployment, such as npm packages.

For example, one build might update a dependency while another build is in the middle of using it, which could cause unreliable results and errors.

Further instructions on how to set up self-hosted agents can be found at:

 -  [Self-hosted Windows agents](/azure/devops/pipelines/agents/v2-windows).
 -  [Run a self-hosted agent behind a web proxy.](/azure/devops/pipelines/agents/proxy)
