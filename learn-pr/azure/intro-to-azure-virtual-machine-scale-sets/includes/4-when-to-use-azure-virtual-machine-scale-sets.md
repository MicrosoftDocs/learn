Azure Virtual Machine Scale Sets meet Adatum’s needs in the following application scenarios:

- **The application that regularly exceeds processor load.**\
For this scenario, you can add scale rules that monitor the CPU usage across the scale set. If the CPU usage exceeds the 75 percent threshold, the scale rule can increase the number of virtual machine (VM) instances. A second scale rule can also monitor CPU usage but reduce the number of virtual machine instances when usage falls below 50 percent.

- **The application that needs to deal with regular spikes in capacity on Friday evenings and downtime on Wednesday mornings.**\
In this case, you should use scheduled scaling.

- **To limit autoscale-driven expansion during a traffic surge.**\
Set the maximum instance count to 50 in every applicable autoscale profile. This bounds autoscale actions while each profile applies and helps control compute costs.

> [!NOTE]
> An autoscale maximum isn't a hard spending cap or a prevention of manual capacity changes. If a manual change puts capacity outside the profile's range, enabled autoscale adjusts it back on a subsequent evaluation. VM size, disks, networking, and other resources still affect charges. Limiting instance count also means the application might not have enough capacity for demand beyond that limit.

Adatum might not choose to use a Virtual Machine Scale Set for the following applications:

- **The application that's hosted on a single VM that doesn't experience variance in utilization and doesn't have an architecture that lets it be load balanced.**\
For this application, a standalone infrastructure as a service (IaaS) VM can be an appropriate choice. Review whether its size matches the workload. If the application later needs more capacity but still can't distribute work across instances, consider vertical scaling by increasing the VM's size. [Resizing a running Azure VM](/azure/virtual-machines/sizes/resize-vm) restarts it, and some size changes require deallocation first. Plan for a service interruption for this single-instance application. Moving the VM into a scale set doesn't by itself make the application horizontally scalable; first establish whether the application can use additional instances effectively.

- **The application hosted on an IaaS VM that's only used several hours per day by a limited number of people shouldn't be configured to use Virtual Machine Scale Sets.**\
For this application, schedule VM startup before business hours and deallocation after business hours, when the application can be unavailable.

> [!IMPORTANT]
> Shutting down only inside the guest operating system can leave the VM in the Stopped (allocated) state, which still incurs VM compute charges. Deallocate the VM to stop VM compute usage charges and confirm that it reaches Stopped (Deallocated). Retained disks and some networking resources can continue to incur charges.
