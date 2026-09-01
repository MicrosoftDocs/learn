Packet Monitor is a cross-component network diagnostics tool included with Windows 11 and windows Server. Its command-line program is `pktmon.exe`, commonly called Pktmon. It can filter and count packets, capture packet snapshots at several points in the local networking stack, and report some locally detected drops.

By the end of the module, you're able to:

- Explain when Packet Monitor is useful and what local packet evidence can prove.
- Discover local packet-processing components.
- Create a narrow filter for an address, protocol, and port.
- Choose counters-only or packet logging and set a practical component scope, packet size, file size, and logging mode.
- Validate, convert, retain, and safely clean up a focused collection.

## Scope and safety

This module teaches routine host-local collection. It doesn't teach networking fundamentals, advanced packet-loss attribution, virtualized data-path reconstruction, detailed drop-reason analysis, or protocol analysis with Wireshark.

> [!CAUTION]
> Capture only traffic that you're authorized to inspect. Packet data can expose addresses, hostnames, credentials, tokens, personal data, and proprietary payloads. Use synthetic traffic when practicing. For real collections, follow your organization's storage, transfer, retention, redaction, and disposal requirements.

Packet Monitor is included in Windows Server 2019, version 1809, and later. Commands, defaults, and output can vary by build. The required commands are intended for Windows Server 2022 and Windows Server 2025. Always compare published syntax with built-in help on the target host.
