Traditional packet capture often observes traffic at a network adapter. Packet Monitor can also observe packets at packet-processing components between an application and an adapter. This cross-component view is its main diagnostic advantage.

:::image type="content" source="../media/network-adapter-and-cross-component-capture.svg" alt-text="Diagram that shows a packet captured only at a network adapter compared with the same packet captured across three networking components.":::

## What Packet Monitor collects

Packet Monitor provides three related forms of evidence:

| Evidence | Purpose | Main limit |
| --- | --- | --- |
| Packet counters | Confirm matching traffic and show which monitored components observed it | No packet bytes |
| Packet snapshots | Inspect headers and, when authorized, some payload bytes | Data can be truncated |
| Local drop reports | Identify drops reported by supported local components | Can't directly observe remote drops |

A packet snapshot is a copy made at one observation point. If one packet crosses several monitored components, the trace can contain several appearances of that packet.

Repeated appearances aren't automatically:

- Packets duplicated on the network.
- Transmission Control Protocol retransmissions.
- Separate requests.

Packet Monitor assigns packet identity fields that let you correlate these appearances. You inspect those fields later.

## Network-adapter-only and cross-component capture

When setting up a capture, choose the component scope that matches the question:

- **Network adapters only** provide a simpler trace with fewer repeated appearances. This scope is useful when you need to confirm arrival or departure at the host boundary or create a clean handoff for protocol analysis.
- **All components** provide more local-path visibility. This scope is useful when the question involves movement through the Windows networking stack, but it produces more data and repeated appearances.
- **Selected components** provide a precise view when you already know the relevant component identifiers.

Cross-component capture doesn't mean that every possible location is visible. Packet Monitor observes supported Windows packet-processing components. It doesn't inspect remote hosts, switches, routers, firewalls, or application internals.

## Interpret local evidence narrowly

An observation supports only the conclusion associated with that observation point.

For example:

- A packet observed at a target network adapter reached that local adapter.
- A packet observed at a protocol component reached that monitored part of the local stack.
- A local drop report shows that a supported local component reported a drop.

The same evidence doesn't prove that:

- A user-mode application accepted or processed the packet.
- A remote endpoint received a packet sent by the local host.
- A remote device dropped a missing packet.
- Encrypted application data is readable.

Packet Monitor doesn't decrypt Transport Layer Security or other encrypted payloads.

## When to use Packet Monitor

Use Packet Monitor to:

- Confirm whether expected traffic reaches or leaves a server.
- Reduce a capture to one endpoint or service.
- Compare observations at network adapters and other local components.
- Confirm traffic with counters before collecting packet bytes.
- Preserve an Event Trace Log (ETL) file for later text or protocol analysis.

Escalate when the evidence requires detailed drop attribution, application tracing, remote-path analysis, or reconstruction of a complex virtualized path.
