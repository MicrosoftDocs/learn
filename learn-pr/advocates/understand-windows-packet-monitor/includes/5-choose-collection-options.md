Limit packet collection so that you don't collect more information than you need to address the diagnostic question you're attempting to answer. Start with counters when traffic presence is uncertain. Log packet bytes only when counters aren't enough to help you resolve your issue.

:::image type="content" source="../media/collection-workflow.svg" alt-text="Diagram that shows an eight-step Packet Monitor workflow from defining traffic through capture, validation, conversion, retention, and cleanup.":::

## Choose counters or packet logging

| Choice | Use when | Output |
| --- | --- | --- |
| Counters-only | You need to confirm matching traffic or see which components observed it | Counters, no packet log |
| Packet logging | You need packet headers, selected payload bytes, conversion, or detailed inspection | Event Trace Log plus counters |

Start counters-only collection:

```powershell
pktmon start --capture --counters-only --comp all
pktmon status
pktmon counters
pktmon stop
```

Start bounded packet logging:

```powershell
pktmon start --capture --comp all --pkt-size 128 `
  --file-name C:\ApprovedCaptures\CrossComponent-20260728T161500.etl `
  --file-size 128 --log-mode circular
```

Confirm the active configuration:

```powershell
pktmon status
```

## Confirm build-specific defaults

Windows Server 2025 uses these defaults:

| Setting | Default | Effect |
| --- | --- | --- |
| Component scope | All components | More local-path visibility and repeated appearances |
| Packet type | Flowing and dropped packets | Includes supported local drop reports |
| Logged packet bytes | 128 bytes | Usually includes common headers |
| Maximum file size | 512 megabytes | Bounds one circular file |
| Logging mode | Circular | Overwrites the oldest events when full |

Defaults can change with new versions and updates. Confirm them with `pktmon start help` on the target host.

## Choose component scope

| Scope | Use when | Tradeoff |
| --- | --- | --- |
| `--comp nics` | Confirm host-boundary traffic or create a cleaner protocol-analysis handoff | Less local-stack visibility |
| `--comp all` | Inspect traffic across visible local components | More volume and repeated appearances |
| `--comp <selector>` | Focus on a component discovered with `pktmon list --all` | Identifier must be discovered at collection time |

Use all components only when the question requires cross-component visibility. For a busy production host, network adapters or selected components often produce a cleaner result.

## Choose packet size

`--pkt-size` specifies how many bytes Packet Monitor logs from each packet.

- `--pkt-size 128` usually retains Ethernet, Internet Protocol, and transport headers.
- A larger value might be required for encapsulated headers or selected application data.
- `--pkt-size 0` logs the complete packet.

> [!CAUTION]
> Complete-packet logging increases file growth and disclosure risk. Use it only when required, approved, and protected by a narrow filter and short time window.

Later, compare `OriginalSize` and `LoggedSize`. A smaller logged size means the packet snapshot is truncated.

## Choose file and logging limits

Set an explicit path, unique filename, file-size limit, and circular mode:

```powershell
pktmon start --capture --comp nics --pkt-size 128 `
  --file-name C:\ApprovedCaptures\Service-20260728T161500.etl `
  --file-size 128 --log-mode circular
```

Circular logging bounds file size. When the file reaches the limit, new events overwrite the oldest events. Use the shortest practical collection interval and stop soon after reproducing the traffic.

Other logging modes are specialized:

- **Multi-file** creates successive files and doesn't bound total disk use by file count.
- **Real-time** displays events and creates no ETL file.
- **Memory** keeps a high-rate circular buffer in memory until collection stops.

This module uses circular logging only.

## Interpret counters correctly

Query counters while collection is active:

```powershell
pktmon counters
```

Use counters to answer:

- Did the active filter match traffic?
- Which monitored components observed it?

Transmit and receive directions are relative to each displayed component. Don't automatically equate them with client-to-server and server-to-client directions.

A nonzero counter proves observation at that component. It doesn't prove application-level success.

Reset counters only when you own the Packet Monitor state:

```powershell
pktmon reset
```

## Check your option choice

If you only need to know whether a service flow is present, start with counters-only collection. If you must hand packet headers to another engineer, use packet logging with the narrowest useful component scope, the smallest useful packet size, a unique filename, a bounded file size, and circular logging.
