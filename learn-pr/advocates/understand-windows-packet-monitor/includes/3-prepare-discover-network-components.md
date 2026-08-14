Prepare the host before you add a filter or start a collection. Packet Monitor state is computer-wide. An active collection or filter set might belong to another administrator.

## Open an elevated command session

To add a filter, run Windows PowerShell or Command Prompt as an administrator. Use built-in help before you copy a switch from another Windows build:

```powershell
pktmon /?
pktmon start help
pktmon filter add help
```

Confirm the target build during technical validation. For a collection record, capture the product and build:

```powershell
Get-ComputerInfo -Property WindowsProductName, WindowsVersion, OsBuildNumber
Get-Date -Format o
```

The round-trip timestamp format produced by `Get-Date -Format o` includes the local time-zone offset.

## Inspect existing state

To inspect an existing state, run the following commands:

```powershell
pktmon status
pktmon filter list
```

`pktmon status` shows whether Packet Monitor is collecting. `pktmon filter list` shows every active packet filter.

> [!CAUTION]
> Don't stop an active collection or remove filters on a shared server until you identify the owner and coordinate the change. `pktmon filter remove` removes every active Packet Monitor filter. It doesn't remove only a named filter.

The following commands establish a known state only after you confirm that all Packet Monitor state belongs to your collection:

```powershell
pktmon stop
pktmon filter remove
pktmon reset
```

`pktmon stop` stops collection. `pktmon filter remove` removes all filters. `pktmon reset` resets packet counters.

## Prepare the output location

For a real collection:

1. Use an approved local path.
1. Confirm enough free space.
1. Choose a new filename.
1. Record the planned packet size, file-size limit, component scope, and time window.

Don't overwrite an existing capture. Use a unique filename for every real collection.

## Discover network components

List the default component view:

```powershell
pktmon list
```

This view shows network adapters. Include other visible packet-processing components:

```powershell
pktmon list --all
```

Recognize these component types:

| Component type | Role |
| --- | --- |
| Network adapter | Connects the host to a physical or virtual network |
| Protocol driver | Processes protocols such as Internet Protocol |
| Filter driver | Inspects or modifies traffic between bound components |

Each component has a Packet Monitor component identifier. Use an identifier to restrict collection to a selected component.

Component identifiers aren't persistent. They can change after a restart of Windows or the Packet Monitor driver. Discover them at collection time. Don't place a fixed identifier in reusable instructions.

## Record the precapture context

Before collection, retain:

- Operating system product and build.
- Current date, time, and time-zone offset.
- `pktmon status` output.
- `pktmon filter list` output.
- `pktmon list --all` output.
- Planned capture command and output path.

This context makes the trace reproducible and prevents another engineer from guessing which components, filters, or defaults produced it.
