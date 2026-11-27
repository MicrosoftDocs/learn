For the invoice processor, a successful maintenance response means accounting for each invoice, not just bringing both VMs back online. Scheduled Events identifies which VMs to prepare; the coordinator approves only when every named VM is ready. After the interruption, use the job ledger to decide which invoices are complete, which can safely resume, and which need investigation. Resume queue acquisition only when the guest and application are healthy and unresolved invoices can't be picked up again.

Before deleting a disk, public IP address, or other resource, identify its owner and confirm that no other workload still uses it. Budget compute, managed disks and snapshots, public addresses, Bastion, and diagnostic retention separately. Deallocation stops most compute charges; it doesn't remove disk or network charges.

## More information

These official resources explain the maintenance behavior, application patterns, and operational tools used in this module:

- [Scheduled Events for Linux](/azure/virtual-machines/linux/scheduled-events)
- [Start an event and coordinate resource-wide approval](/azure/virtual-machines/linux/scheduled-events#start-an-event)
- [Scheduled Events for Windows](/azure/virtual-machines/windows/scheduled-events)
- [Scheduled Events endpoints and their delivery differences](/azure/virtual-machines/scheduled-events-overview)
- [Scheduled Events publishing through Event Grid (preview)](/azure/virtual-machines/scheduled-events-event-grid)
- [Azure Resource Notifications: subscription-wide access prerequisites](/azure/event-grid/event-schema-resource-notifications#rbac-for-arn-system-topics)
- [Event Grid delivery and retry behavior](/azure/event-grid/delivery-and-retry)
- [Event Grid trigger for Azure Functions](/azure/azure-functions/functions-bindings-event-grid-trigger)
- [Azure Functions as Event Grid handlers](/azure/event-grid/handler-functions)
- [Azure Queue Storage trigger for Azure Functions](/azure/azure-functions/functions-bindings-storage-queue-trigger)
- [Leader Election pattern: leases and stale-owner writes](/azure/architecture/patterns/leader-election)
- [Idempotent Consumer pattern: transactions and external side effects](/azure/architecture/patterns/idempotent-consumer)
- [Spot VM eviction policy](/azure/virtual-machines/spot-vms#eviction-policy)
- [Terminate notifications for Virtual Machine Scale Set instances](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-terminate-notification)
- [Maintenance and updates](/azure/virtual-machines/maintenance-and-updates)
- [Maintenance notifications and self-service eligibility](/azure/virtual-machines/maintenance-notifications)
- [Read maintenance information with Azure CLI](/azure/virtual-machines/maintenance-notifications-cli)
- [Availability-set fault and update domains](/azure/virtual-machines/availability-set-overview#how-do-availability-sets-work)
- [Maintenance Configuration scopes](/azure/virtual-machines/maintenance-configurations#scopes)
- [Instance Metadata Service: access and networking requirements](/azure/virtual-machines/instance-metadata-service#access-azure-instance-metadata-service)
- [Instance Metadata Service: security and authentication](/azure/virtual-machines/instance-metadata-service#security-and-authentication)
- [Configure virtual machine availability](/training/modules/configure-virtual-machine-availability/)
- [Plan for maintenance downtime](/training/modules/configure-virtual-machine-availability/2-plan-for-maintenance-downtime)
