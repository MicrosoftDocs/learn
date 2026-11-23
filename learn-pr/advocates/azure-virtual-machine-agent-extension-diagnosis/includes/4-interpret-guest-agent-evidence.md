To find out how far a request got, follow one operation through the Windows or Linux logs. Match timestamps and sequence numbers across records so that output from an earlier run doesn't lead you to the wrong conclusion. For example, in the Contoso ticket, the Linux agent asked the handler to start sequence 0 at 11:40:11 UTC. One second later, the handler recorded exit code `23` for sequence 0. Those entries show that the command ran and failed, not that the agent failed to deliver the request.

Collect log entries from just before the operation started through the time Azure reported its result. Record both the Azure resource ID and the guest's hostname (the name Windows or Linux reports for itself). To match a request to its guest log entries, compare their timestamps in Coordinated Universal Time (UTC). In the examples, a trailing `Z` means the timestamp is in UTC. If the guest clock is off, note the difference. Compare the agent and handler records for the same extension sequence.

Run these read-only commands inside Ubuntu. `systemctl` reports the current service state. `journalctl` reads the systemd journal, the timestamped history that can show a failure before a service restarted. `sudo` runs a command with administrator privileges when your guest account is authorized to do so.

```bash
date -u +%Y-%m-%dT%H:%M:%SZ
hostname
uname -r
cat /etc/os-release
waagent -version
systemctl is-active walinuxagent
sudo systemctl status walinuxagent --no-pager
sudo journalctl -u walinuxagent --since '-20 minutes' --utc --no-pager
cloud-init status --long
findmnt /
df -h /
df -i /
sudo tail -n 60 /var/log/waagent.log
```

On Ubuntu images that use `cloud-init`, it handles first-boot setup such as creating the initial account and configuring the network. The Linux agent handles extensions. If `cloud-init status` reports degraded completion, check which setup task failed before drawing a conclusion about an extension.

An active Linux agent service doesn't prove extension processing is enabled. In `/etc/waagent.conf`, `Extensions.Enabled=n` disables extension handling while the agent continues receiving Azure's requested configuration and reporting VM status less frequently. That control is different from using cloud-init for first-boot provisioning.

When a new extension request has no matching handler start, inspect the relevant configuration without changing it.

```bash
sudo grep -nE '^[[:space:]]*Extensions[.]Enabled[[:space:]]*=' /etc/waagent.conf
```

An explicit `n` is evidence to compare with the agent's loaded configuration, service history, and logs. A missing setting isn't proof of disablement: check the default for the installed agent version and whether the file has changed since the process loaded it. A grep result alone doesn't establish the effective runtime configuration. Record a read-permission error or missing file as a collection failure.

Determine whether the setting is intentional and who owns it before proposing a change. Don't enable extensions, change provisioning controls, or restart the agent automatically. A handler's matching command-start and exit records establish that extension execution reached the command for that attempt.

The root filesystem, `/`, is the top of the Linux directory tree. `df -h /` checks space for file contents. `df -i /` checks *inodes*, the records the filesystem needs for files and directories. With no free inodes, the handler can't create a file even if free space remains. `findmnt /` shows which filesystem is mounted (attached) at `/` and whether it's writable. A read-only mount can prevent the same write without either limit being reached.

If the handler's working directory is on another mount, check that path rather than `/`. The three rows below show alternative explanations for a failed write, not successive events.

:::image type="content" source="../media/filesystem-write-checks.svg" alt-text="Diagram that shows how exhausted blocks, exhausted inodes, or a read-only mount can prevent file creation.":::

In this healthy Linux example, *goal state* means the configuration Azure has asked the agent to apply. The command writes its normal output to *standard output* (`stdout`) and diagnostic messages to *standard error* (`stderr`). Read those streams alongside the exit code: a command can print the expected text and still report a failure.

```text
2026-11-14T11:00:02Z  hostname=vm-m02-linux
walinuxagent: active
cloud-init: status: done
root filesystem: rw, 18% used, 3% inodes used
11:00:08Z waagent: goal state received; extension sequence 4 enabled
11:00:10Z custom-script: sequence 4 command exited with code 0
stdout: report-ready os=ubuntu
```

In this healthy example, sequence 4 ties the report output to a command that exited with code 0. For the handover ticket, find those same two pieces of evidence for the failed update: what did the command print, and how did it exit? Free space and normal startup make some guest failures less likely, but neither tells you how that command ended.

On a newly provisioned VM, cloud-init's final configuration tasks can overlap extension execution. Both can try to install packages, but installation needs exclusive access to the package manager, the tool that installs or updates software. A handler can therefore start correctly and still return an error because another task owns a package-management lock.

The current cloud-init status alone doesn't establish the ordering during an earlier failure. This illustrative first-boot timeline is an alternative case, not another event in Contoso's read-only report incident.

```text
Alternative first-boot example, UTC:
12:00:01Z cloud-init final-stage task begins installing packages
12:00:03Z extension sequence 2 starts a package-install command
12:00:04Z command fails; stderr identifies a package-manager lock
12:00:30Z cloud-init final-stage task completes
12:02:00Z operator observes cloud-init status: done
```

Use `/var/log/cloud-init.log`, relevant `/var/log/cloud-init-output.log` output, the Ubuntu `cloud-final` service journal, and the matching handler sequence to compare activity at the failure time. Collect only the relevant private slices because provisioning output can contain secrets. If the dependency is still blocked, identify the process that owns it and whether that process is making progress. A status of `done` observed later doesn't disprove the overlap.

Don't delete package-manager lock files or kill the owning process as a shortcut. If approved initialization is still progressing, allow it to finish and assess whether the failed command left partial changes before approving a retry. If it's stuck, investigate the owning task rather than repeatedly submitting extension updates.

Where supported by the installed agent, `Extensions.WaitForCloudInit` can be part of a deliberately prepared image's startup sequencing. If the wait reaches its `Extensions.WaitForCloudInitTimeout` limit, the agent proceeds to extension processing; that doesn't prove cloud-init finished successfully or released a package-manager lock. Compare the agent's wait result with the cloud-init and handler timestamps. Verify the running agent version's timeout behavior before relying on a customized value.

This isn't a universal incident repair, a reason to restart provisioning, or a setting to toggle blindly on an already running VM. Keep sequencing changes in the owning deployment and follow its change procedure.

On Windows, open PowerShell with **Run as administrator** (an elevated session). Either Windows PowerShell 5.1 or PowerShell 7.x can run these checks. Use a named UTC field when collecting events for the shared timeline. This conversion changes the displayed representation, not the guest clock.

```powershell
(Get-Date).ToUniversalTime().ToString('o')
$env:COMPUTERNAME
Get-Service WindowsAzureGuestAgent,RdAgent
Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption,Version,LastBootUpTime
$start = (Get-Date).AddMinutes(-20)
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=$start} -MaxEvents 40 |
    Select-Object @{
        Name = 'TimeCreatedUtc'
        Expression = {
            if ($null -eq $_.TimeCreated) {
                'not recorded'
            } else {
                $_.TimeCreated.ToUniversalTime().ToString('o')
            }
        }
    },Id,ProviderName,LevelDisplayName,Message
Get-Content 'C:\WindowsAzure\Logs\WaAppAgent.log' -Tail 60
Get-Volume | Select-Object DriveLetter,FileSystemLabel,SizeRemaining,Size
```

`TimeCreatedUtc` is an ISO 8601 UTC timestamp when the event records a time. If you also copy `LastBootUpTime` into the timeline, explicitly convert it to UTC or retain its timezone offset. Don't append `Z` to an unconverted local timestamp. Keep the original records and note any measured clock skew separately.

The 20-minute window and 40-event limit are a starting slice, not proof that omitted events never occurred. Use the incident's actual time window and relevant providers when the first slice doesn't contain it.

In Windows Event Viewer, open the **System** log and filter by time and provider (the component that wrote the event). For example, Service Control Manager can report that the VM agent started. That event doesn't tell you whether the agent then reached Azure.

In these Windows examples, the *host plugin* is an Azure component on the VM host that helps the guest agent retrieve extension packages and report status. Compare what the service reports locally with what the agent log says about communication with the host.

```text
Healthy case, 11:10:00Z:
WindowsAzureGuestAgent Running; RdAgent Running
WaAppAgent: current goal state received; extension status reported
Custom handler sequence 7: exit code 0

Unhealthy case, 11:20:00Z:
WindowsAzureGuestAgent Running; RdAgent Running
WaAppAgent: unable to connect to host plugin; socket access forbidden
Instance view: agent Not ready, latest status 11:19:51Z
System event 7036: Windows Azure Guest Agent entered running state at 11:18:00Z
```

In the second Windows case, both services are running, but the agent log records a denied connection. Test the specific host-agent path before considering a restart. The Azure platform address `168.63.129.16` is the WireServer host. Run these commands in the elevated guest PowerShell session, not on the operator's workstation.

```powershell
$WireHost = '168.63.129.16'
Test-NetConnection -ComputerName $WireHost -Port 80
Test-NetConnection -ComputerName $WireHost -Port 32526
```

Transmission Control Protocol (TCP) establishes a connection to a numbered port on a host. Here, `TcpTestSucceeded : True` means the connection opened on that port, not that the agent exchanged a valid message.

The same Azure host address is relevant when Ubuntu's agent log reports that it can't retrieve goal state. Use SSH or an already authenticated serial shell. The following read-only example requires `curl` and the OpenBSD implementation of `nc` to be available on the Ubuntu guest. `curl` makes an HTTP (Hypertext Transfer Protocol) request; `nc` checks a TCP port. If either tool is unavailable, record that limitation and use approved equivalent tooling. A missing command isn't a connectivity failure.

```bash
sudo curl --noproxy '*' --connect-timeout 5 --max-time 10 \
  --fail --show-error --silent -H 'Metadata: true' \
  'http://168.63.129.16/?comp=versions'
printf '\nWireServer HTTP probe exit: %s\n' "$?"
sudo nc -n -z -v -w 5 168.63.129.16 32526
printf 'Host-plugin TCP probe exit: %s\n' "$?"
```

The first Linux test should return a versions XML response. It bypasses a proxy for this request only; it doesn't change the guest's proxy configuration. The second test checks whether a TCP connection to port 32526 opens, without a DNS lookup. Domain Name System (DNS) resolves names to addresses; this test already supplies the address. Capture the output and each exit code. A successful connection doesn't prove that the agent exchanged a valid goal state, downloaded a package, or completed the extension command. Compare these results with the agent log for the failed operation.

The platform address isn't subject to user-defined routes, and its agent traffic on TCP 80 and 32526 isn't governed by the VM's configured network security groups (NSGs). Inspect guest firewall rules, security software, proxy behavior, and relevant guest network configuration for the demonstrated failure. Don't add a broad NSG rule or disable protections as a generic repair.

Keep this host-agent path separate from an extension's own outbound dependencies. Supported Linux agents can relay extension package downloads and status reporting through the host. A script download from a private blob or an application request can still require separate routing, DNS, authentication, and firewall access. A successful host test doesn't prove those other paths work. Contoso's installed report doesn't need an external script download.

The following reference keeps evidence collection focused.

| Evidence | Windows location or command | Linux location or command |
|---|---|---|
| Platform-agent activity | `C:\WindowsAzure\Logs\WaAppAgent.log` | `/var/log/waagent.log` |
| Agent installation/update | `C:\WindowsAzure\Logs\TransparentInstaller.log` | Distribution package history and waagent log |
| Extension handler output | `C:\WindowsAzure\Logs\Plugins\<publisher.type>\` | `/var/log/azure/<extension>/` |
| Custom Script command output | Handler-specific plugin directory | `/var/lib/waagent/custom-script/download/<sequence>/stdout` and `stderr` |
| Startup evidence | System events, boot diagnostics, SAC | Boot diagnostics, `journalctl -b`, cloud-init logs |
| Capacity and mounts | `Get-Volume`, disk events | `df -h`, `df -i`, `findmnt` |

Versioned directories and sequence numbers vary. Read the directory for the current operation. *Protected settings* are extension inputs that Azure encrypts for the target VM. They can contain credentials, and that encryption doesn't protect the original file on your workstation. Collect only the required logs and status, not settings files, certificates, tokens, command-line secrets, or application data.
