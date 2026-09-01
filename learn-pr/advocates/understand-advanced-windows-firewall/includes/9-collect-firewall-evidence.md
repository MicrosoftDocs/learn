Firewall evidence supports policy discovery, fault isolation, incident response, and enforcement validation.

Windows Firewall can log:

- Dropped packets
- Successful connections

Configure each profile explicitly.

```powershell
Set-NetFirewallProfile `
  -Profile Domain,Private,Public `
  -LogFileName '%SystemRoot%\System32\LogFiles\Firewall\pfirewall.log' `
  -LogMaxSizeKilobytes 32767 `
  -LogBlocked True `
  -LogAllowed True
```

Confirm active settings:

```powershell
Get-NetFirewallProfile -PolicyStore ActiveStore |
  Select-Object Name, LogFileName, LogMaxSizeKilobytes, LogAllowed, LogBlocked
```

Size retention for the expected traffic volume. A busy server can overwrite a small local log quickly.

> [!NOTE]
> The default maximum size of the Windows Firewall log `pfirewall.log` is 4 megabytes. On most modern client and server computers you can increase this an order of magnitude without causing problems.

## Interpret records

The text log includes fields such as:

- Date and time
- Action
- Protocol
- Source address
- Destination address
- Source port
- Destination port
- Packet size
- Interface information
- Direction

Use Coordinated Universal Time consistently when correlating with endpoint, identity, network, and application logs.

## Use evidence for discovery

Before enforcement:

1. Enable logging.
1. Exercise normal business operations.
1. Include maintenance, failover, backup, recovery, and support periods.
1. Group flows by source, destination, protocol, port, and owner.
1. Remove broadcast noise and transient internet traffic from the application dependency set.
1. Convert approved flows into narrow rules.

Windows Firewall logging is disabled by default for both dropped packets and successful connections. The log file is populated only after enabling at least one logging option. You enable logging using the following PowerShell command:

```PowerShell
Set-NetFirewallProfile `
    -Profile Domain, Private, Public `
    -LogAllowed True `
    -LogBlocked True
```

Observed traffic is evidence, not automatic authorization. Malware traffic can also appear in a baseline.

## Use evidence for fault isolation

A dropped record on the destination proves that the packet reached the host firewall. It doesn't prove:

- The application was listening.
- Authentication succeeded.
- Response routing worked.
- The application accepted the request.

A successful-connection record proves firewall admission. Continue with application, identity, and response-path diagnostics.

## Forward important evidence

The local text file has limited retention. A local administrator has permission to modify this file. For high-value systems:

- Collect relevant Windows event channels.
- Forward logs to protected central storage.
- Normalize timestamps.
- Retain policy-change evidence.
- Correlate firewall events with process, sign-in, and network telemetry.

> [!IMPORTANT]
> Logging successful traffic can generate high volume. Measure collection capacity before broad deployment.
