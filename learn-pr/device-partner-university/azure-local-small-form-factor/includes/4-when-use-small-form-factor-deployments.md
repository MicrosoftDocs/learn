Small form factor deployments of Azure Local (preview) are designed for scenarios where workloads must run close to physical systems while still benefiting from centralized cloud management.

To determine whether this approach is the right fit, use the following checklist. If most of the core criteria apply to your scenario, small form factor deployments are likely a strong match.

## Core criteria (strong indicators)

Use small form factor deployments of Azure Local (preview) when **most of the following are true**:

### Need for local processing and low latency

Your applications must process data and respond quickly near the source.

In Contoso's factories, production-line cameras detect defects as products are assembled. If analysis is delayed, defective products might continue through the line, increasing waste and rework.

Local processing enables:

- Immediate detection of defects
- Faster operator response
- Reduced waste and rework

### Distributed operations across multiple sites

You operate across multiple locations and need a consistent way to deploy and manage infrastructure.

Contoso runs several factories with similar production processes. Without a standardized approach, each site might manage infrastructure differently, increasing complexity.

Small form factor deployments allow organizations to:

- Deploy consistent infrastructure across locations
- Apply the same policies and configurations everywhere
- Simplify management of distributed systems

### Intermittent or limited connectivity

Your systems must continue operating even when connectivity is unreliable or inconsistent.

In industrial environments, connectivity might be affected by network conditions, physical layout, or environmental factors.

Local processing ensures that:

- Production systems continue functioning
- Data can still be analyzed in real time
- Operations aren't disrupted by connectivity interruptions

## Supporting signals

The following factors further reinforce that this approach is a good fit:

### Space-constrained deployment environments

Your infrastructure must fit within compact or operationally constrained environments.

Factory floors often have limited available space, and systems must be installed near equipment. Compact deployments make it possible for Contoso to place compute capabilities where they're needed without large infrastructure footprints.

### Integration with physical systems and workflows

Your workloads must interact directly with physical systems such as sensors, cameras, or machines.

In Contoso's case, this includes:

- Sensors monitoring equipment health
- Cameras inspecting products
- Systems triggering alerts or automated actions

Local deployment enables tighter integration and faster response to these real-world events.

## Choose a cloud-only or alternative approach when…

Small form factor deployments might not be the best fit in the following scenarios:

- **Cloud-only workloads:** If your applications don't require local execution—for example, batch analytics or reporting workloads—centralized cloud infrastructure might be simpler and more cost-effective.
- **Single-location environments:** If infrastructure is confined to one site, the benefits of distributed management and consistent deployment might not be as impactful.
- **Low sensitivity to latency:** If delays in processing don't affect outcomes, local execution might not provide meaningful value beyond cloud-based processing.

## Putting it together

For Contoso Manufacturing, this approach is a strong fit because the company needs to combine:

- Real-time processing on the factory floor
- Centralized management across multiple sites
- A scalable and repeatable deployment model

If your scenario shares these characteristics—particularly the need for low latency, distributed operations, and operational resilience—small form factor deployments of Azure Local (preview) can significantly improve responsiveness, consistency, and efficiency.
