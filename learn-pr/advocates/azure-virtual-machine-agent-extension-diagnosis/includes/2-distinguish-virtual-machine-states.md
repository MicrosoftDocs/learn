Each VM status answers a different question. You compare signals from Azure with evidence from inside the VM to distinguish a request that Azure accepted from a command that the guest actually ran. For example, Azure might accept an extension update for a Windows VM, but if the handler log for that update says PowerShell couldn't start, the setup script never ran. On Ubuntu, if the extension output contains `report-ready os=ubuntu` and the handler records a nonzero exit code for the same run, the report ran but the submitted command failed.

The Azure control plane is the part of Azure that handles requests to create, change, or delete resources. Seeing a VM resource there means Azure has a configuration record for it. The VM's *instance view* reports runtime information, including the last known power state and status reported by the agent and extensions. A power state of **Running** can be accurate even if Linux stopped during startup at an emergency shell, a command prompt for recovery.

On Windows, look for the Windows Azure Guest Agent service and its companion service, RdAgent. On Ubuntu, the Azure Linux Agent package supplies the `walinuxagent` service and the `waagent` command. Don't confuse the platform agent with Azure Monitor Agent (AMA), which collects monitoring data. An AMA heartbeat is a periodic message to the monitoring service. A recent heartbeat shows that AMA could send data, not that the platform agent could run a command.

:::image type="content" source="../media/agent-signals.svg" alt-text="Diagram that shows separate extension-execution and Azure Monitor Agent heartbeat paths.":::

The platform agent can download and start an extension handler successfully even when the command it runs returns a nonzero exit code. If the handler fails to start, the same command never gets a chance to run. Look for evidence of command execution before deciding which component to repair.

In the Contoso ticket, **Failed** describes the extension update. The line your teammate saw over SSH came from a separate run. Use the table to decide what each observation proves.

| Observation | Supported conclusion | Still unproved |
|---|---|---|
| VM resource exists | Resource configuration is present | Allocation, guest startup, application health |
| Power state Running | VM execution is active | Boot completion or responsive guest |
| VM provisioning Succeeded | That management operation completed | Later script or workload success |
| Platform agent Ready | Agent recently reported readiness | Every extension's command result |
| Custom Script update Failed | Azure recorded a failure for that update | Whether `vmops-report` started or what it printed |
| Extension Succeeded | Handler reported success for its operation | Application correctness beyond that command |
| AMA heartbeat current | A monitoring communication path worked | Platform-agent execution and target workload |
| Sample operation returns expected content | That specific workload check succeeded | All production functions |

Record the time and the Azure resource ID (the full Azure path for this VM) with each status. An old **Ready** report can coexist with a current connectivity failure. For a given extension on that VM, the *sequence number* identifies the configuration request the handler is processing. If sequence 7 succeeded but the failure concerns sequence 8, the output for 7 doesn't explain what happened to 8.

When the control plane accepts an extension update, it records the request. That doesn't prove the guest received it. A handler log that matches the current sequence and includes the command's output shows that the request reached the guest and the command ran.
