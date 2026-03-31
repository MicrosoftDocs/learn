To register an agent, you must be a member of the administrator role in the agent pool. The administrator identity is only required during registration - it's not stored on the agent or used for ongoing communication with Azure Pipelines.

You must also be a local administrator on the server to configure the agent.

### Authentication methods

**Personal Access Token (PAT):** Generate and use a PAT to connect an agent with Azure Pipelines. This is the only authentication method that works with Azure Pipelines. The PAT is only used during agent registration, not for subsequent communication.

## Agent execution modes

You can run your agent as either a service or an interactive process. The account used to run the agent is separate from the credentials used when registering the agent with Azure Pipelines.

### Choosing the right account

The choice of agent account depends on the needs of your build and deployment tasks:

- **Windows authentication tasks:** Use an account with access to required external services
- **UI tests (Selenium, Coded UI):** The browser launches in the context of the agent account

### Recommended modes for production

**As a service:** Recommended for most scenarios

- Reliably continues running
- Starts automatically after machine restarts
- Better auto-upgrade experience
- Managed through the operating system's service manager

**As an interactive process with auto-logon:** Required for specific scenarios like UI tests

- Screen saver is automatically disabled
- May require domain policy exemptions
- Computer must be physically secured due to security risks

> [!NOTE]
> Enabling automatic login or disabling screen savers creates security risks. Ensure the computer is physically protected and located in a secure facility. When using Remote Desktop, use the `tscon` command to disconnect properly to avoid locking the computer.

## Agent versions and upgrades

Microsoft updates the agent software every few weeks in Azure Pipelines.

### Version format

Agent versions use the format `{major}.{minor}` (for example, 2.1 means major version 2, minor version 1).

### Automatic upgrades

- **Minor version updates:** Automatically upgraded by Azure Pipelines when tasks require newer versions
- **Major version updates:** Must be manually upgraded
- **Interactive agents:** Require manual upgrades regardless of version type

### Checking agent versions

View agent versions by navigating to:

```
Azure Pipelines: https://dev.azure.com/{your_organization}/_admin/_AgentPool
```

Select the Capabilities tab for the specific agent.

## Performance considerations

### Self-hosted agent advantages

**Faster builds:**

- Support for incremental builds (no repository cleaning)
- Preserved build artifacts and dependencies between runs
- No agent provisioning delays

**Immediate availability:**

- No wait time for agent allocation
- Consistent performance characteristics

### Microsoft-hosted agent limitations

**Clean environment:**

- Agent destroyed after each pipeline completion
- No incremental build benefits
- Fresh environment for each run

**Allocation delays:**

- Can take several minutes for agent assignment during high load periods
- Variable start times based on system demand

## Multiple agents per machine

Running multiple self-hosted agents on the same machine can be effective for:

- Release orchestration jobs with minimal resource consumption
- Lightweight deployment tasks

**Potential issues:**

- Disk and I/O resource contention for build-heavy jobs
- Conflicts with singleton tool deployments (like npm packages)
- Unreliable results when parallel jobs use shared dependencies

## Additional resources

For detailed setup instructions:

- [Self-hosted Windows agents](/azure/devops/pipelines/agents/v2-windows)
- [Run a self-hosted agent behind a web proxy](/azure/devops/pipelines/agents/proxy)
