You should filter before you capture. A narrow filter reduces noise, file growth, analysis time, and exposure of unrelated traffic. It's always easier to find a needle in a haystack if you have a smaller haystack.

If no Packet Monitor filter is active, packet capture can report all traffic that reaches the selected components.

## Apply the matching rules

Packet Monitor applies two rules:

- Conditions in one filter use **AND**.
- Separate filters use **OR**.

:::image type="content" source="../media/packet-filter-logic.svg" alt-text="Diagram that shows conditions joined by AND within each packet filter and two separate filters joined by OR.":::

Suppose you create this filter:

```powershell
pktmon filter add UdpService -i 192.0.2.20 -p 50000 -t UDP
```

A reported packet must contain:

- Internet Protocol address `192.0.2.20`.
- User Datagram Protocol.
- Port `50000`.

All three conditions must match the same packet.

Now compare two separate filters:

```powershell
pktmon filter add ServerAddress -i 192.0.2.20
pktmon filter add ServicePort -p 50000
```

This design is broader. A packet is reported when it matches either filter. Unrelated traffic to or from `192.0.2.20` matches the first filter. Unrelated traffic that uses port `50000` matches the second.

## Understand direction-neutral matching

Address and port filters don't distinguish source from destination.

The `UdpService` filter matches:

- A request sent **to** `192.0.2.20:50000`.
- A reply sent **from** `192.0.2.20:50000`.

This behavior is useful for a request and response exchange. Don't describe the filter as inbound-only or outbound-only.

Direction in counters and trace output is relative to the displayed component. It isn't a filter direction.

## Create named filters

Names make active filters easier to recognize:

```powershell
pktmon filter add PingTest -i 192.0.2.20 -t ICMP
pktmon filter add WebTraffic -i 192.0.2.20 -p 443 -t TCP
pktmon filter add UdpService -i 192.0.2.20 -p 50000 -t UDP
pktmon filter list
```

Packet Monitor supports up to 32 active filters at once. Because Packet Monitor state is computer-wide, existing filters count toward this limit. Run `pktmon filter list` before adding a filter and when a new filter can't be added to inspect the active filter set.

The examples use documentation-only addresses. Replace them with authorized values for a real collection.

A filter name doesn't make removal selective. `pktmon filter remove` still removes all active filters.

## Check filter width

A filter is often too broad when it:

- Specifies only a common port.
- Specifies an entire busy server without a protocol or port.
- Uses several separate filters when one combined filter expresses the intended flow.

A filter is often too narrow when:

- The address is wrong or stale.
- The protocol doesn't match the service.
- The service uses a different port.
- The expected traffic never reaches the selected host.

Before collection, write down the expected address, protocol, port, direction, and time window. Then compare that tuple with `pktmon filter list`.

## Check your filter design

You need the request and reply for User Datagram Protocol service `192.0.2.20:50000`. Use one filter containing the address, protocol, and port. Because matching is source and destination neutral, the same filter reports both directions.

Advanced filter forms include two-address matching, two-port matching, subnets, Transmission Control Protocol flags, media access control addresses, virtual local area network identifiers, EtherType, and encapsulated packets. Use the [Packet Monitor filter command reference](/windows-server/administration/windows-commands/pktmon-filter-add) when a scenario requires them. They aren't required for this workflow.
