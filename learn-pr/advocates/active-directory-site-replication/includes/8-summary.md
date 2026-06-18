In this module, you learned the following principles and procedures about Active Directory sites and replication:

- **Topology mirrors the network.** Map every routed subnet to one site, keep two sites per link, and set costs so the least-cost path matches reality. Let the KCC and ISTG own connection objects unless you have a documented reason not to.
- **Intra-site favors freshness; inter-site favors efficiency.** Change notification and uncompressed traffic within a site; scheduled, compressed traffic between sites—optionally with inter-site change notification on fast links.
- **Windows Server 2025 makes DNS-based discovery mandatory in practice.** `BlockNetBIOSDiscovery` is enabled by default, removing the NetBIOS/mailslot fallback. Inventory legacy DC Locator dependencies and prove DNS-only discovery works before you rely on it.
- **Metadata is the source of truth.** USNs order changes; the high-watermark vector tracks progress with each partner; the up-to-dateness vector dampens redundant replication across the topology. Together they let you state exactly what each DC has received.
- **Deleted objects are replicated changes.** Tombstone lifetime, the AD Recycle Bin, and deleted-object metadata govern recovery and are how you detect and remove lingering objects—never reconnect a DC that's been offline past the tombstone lifetime.
- **Validate before you change.** A clean `repadmin /replsummary` and `dcdiag` run is the gate before raising a functional level or enforcing DNS-only discovery.
- **Replication Priority Boost is a precision tool.** Use `setPriorityBoost` (read back via the parameterized `msDS-PriorityBoost` RootDSE attribute) to favor a specific partner and NC—WAN promotions, functional primary/backup sites—after you've cleared real failures, not as a substitute for correct topology.

## Further reading

- [Active Directory Replication concepts](/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts)
- [Active Directory Domain Services Replication Priority Boost](/windows-server/identity/ad-ds/manage/replication-priority-boost)
- [Locating domain controllers (DC Locator)](/windows-server/identity/ad-ds/manage/dc-locator)
- [Monitoring and troubleshooting replication with Repadmin](/troubleshoot/windows-server/active-directory/troubleshoot-adreplication-guidance)
