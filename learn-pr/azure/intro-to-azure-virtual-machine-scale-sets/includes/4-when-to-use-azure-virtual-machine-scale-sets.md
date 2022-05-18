Azure virtual machine scale sets meet Adatum’s needs in the following application scenarios:

- For the application that regularly exceeds processor load, you can add scale rules that monitor the CPU usage across the scale set. If the CPU usage exceeds the 75 percent threshold, the scale rule can increase the number of virtual machine instances.

   A second scale rule can also monitor CPU usage but reduce the number of virtual machine instances when usage falls below 50 percent.
- For the application that needs to deal with regular spikes in capacity on Friday evenings and downtime on Wednesday mornings, Adatum should use scheduled scaling.
- To ensure that no application scale-out incurs unexpectedly large charges, you can limit all scale-out operations to 50 instances.

Adatum wouldn't choose to use a virtual machine scale set for the following applications:

- **The application that is hosted on a single VM that doesn't experience variance in utilization and doesn't have an architecture that lets it be load balanced**\
In this case, just hosting the IaaS VM normally in Azure is an appropriate option, though the VM should regularly be checked to ensure that the VM’s performance profile is commensurate with the VM size assigned.

- **The application hosted on an IaaS VM that is only used several hours per day by a limited number of people shouldn't be configured to use virtual machine scale sets**\
In this case you could use scheduled VM startup and shutdown to optimize costs, ensuring that the VM was available during business hours and offline when no one is at work.

Eventually you should consider migrating existing applications hosted in IaaS VMs to be deployed as Azure Web App. Doing so is generally cheaper because web apps have lower cost than IaaS VMs and the underlying infrastructure is managed by Microsoft. From the perspective of fluctuating utilization, you can configure a form of web app scaling that doesn't involve virtual machine scale sets.
