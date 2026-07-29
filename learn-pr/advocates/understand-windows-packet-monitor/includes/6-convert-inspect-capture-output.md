Packet Monitor writes packet logs as Event Trace Log (ETL) files. Keep the ETL file as the original evidence artifact. Convert it to other formats for inspection. As the ETL files are your source, don't replace them with converted files but keep them should you need to convert to different formats.

## Stop before conversion

Stop collection before performing a conversion:

```powershell
pktmon stop
```

Stopping doesn't remove active filters. Remove filters only during authorized cleanup.

To convert the ETL file to text:

```powershell
pktmon etl2txt C:\ApprovedCaptures\Service-20260728T161500.etl `
  --out C:\ApprovedCaptures\Service-20260728T161500.txt
```

To convert the ETL file to Packet Capture Next Generation (PCAPNG) format:

```powershell
pktmon etl2pcap C:\ApprovedCaptures\Service-20260728T161500.etl `
  --out C:\ApprovedCaptures\Service-20260728T161500.pcapng
```

## Correlate packet appearances

A representative text record contains fields similar to:

```text
PktGroupId 8444249301423149, PktNumber 1, Appearance 1,
Direction Rx, Component 12, OriginalSize 86, LoggedSize 86
```

Exact formatting varies by build.

:::image type="content" source="../media/packet-appearance-flow.svg" alt-text="Diagram that shows one packet group and packet number linking three appearances at a protocol component, filter driver, and network adapter.":::

Use these fields:

| Field | Meaning |
| --- | --- |
| Timestamp | Time of the recorded appearance |
| `PktGroupId` | Identifier for a related packet group |
| `PktNumber` | Packet number within that group |
| `Appearance` | Sequence of observations for the same captured packet |
| Direction | Transmit or receive relative to the component |
| Component | Packet Monitor component identifier |
| `OriginalSize` | Original packet size reported for the appearance |
| `LoggedSize` | Number of bytes retained in the snapshot |
| `DropReason` | Local drop information when a supported component reports it |

Use `PktGroupId` with `PktNumber` to correlate appearances of one packet. `Appearance` increases as that packet is recorded at successive locations.

Repeated appearances don't prove network duplication or retransmission.

## Resolve components and filters

With the default packet-capture flags, the text output includes component and filter information near the end of the file.

Use the component table to resolve a component identifier to a component name and type. Use the filter table to confirm which filters were active during the capture.

This metadata is one reason to preserve the ETL file and text conversion.

## Detect truncation

Compare the size fields:

- `OriginalSize` equals `LoggedSize`: the reported packet bytes fit within the configured snapshot.
- `OriginalSize` is greater than `LoggedSize`: the snapshot is truncated.

Truncation isn't packet loss. It means Packet Monitor retained only the configured number of bytes.

If a `DropReason` appears, treat it as an escalation clue. Detailed drop attribution is outside this module.

## Understand conversion limits

PCAPNG is useful for protocol analyzers, but it loses Packet Monitor-specific context:

- It doesn't preserve packet-flow context through Windows components.
- It doesn't preserve Packet Monitor drop-report semantics.
- It doesn't distinguish the components that produced each appearance.
- Dropped packets are excluded from conversion by default.

An all-component conversion can therefore contain repeated frames that look like duplicates after component context is lost.

For a clean protocol-analysis handoff, consider collecting from network adapters only. When cross-component evidence matters, provide the ETL file and text output with the PCAPNG file.

## Build an evidence handoff

Retain:

- Original ETL file.
- Text conversion.
- PCAPNG conversion when required.
- Operating system product and build.
- Active filter list.
- Component list and selected scope.
- Exact capture command.
- Start and stop timestamps with time-zone offset.
- Expected address, protocol, port, and direction.
- Notes about circular overwrite, truncation, or unexpected traffic.

Store and transfer the package only through approved locations.
