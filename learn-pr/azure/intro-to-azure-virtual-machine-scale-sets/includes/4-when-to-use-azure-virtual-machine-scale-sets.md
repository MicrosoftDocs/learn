Azure Virtual Machine Scale Sets meet Adatum’s needs in the following application scenarios:

- **The application that regularly exceeds processor load.**\
For this scenario, you can add scale rules that monitor the CPU usage across the scale set. If the CPU usage exceeds the 75 percent threshold, the scale rule can increase the number of virtual machine (VM) instances. A second scale rule can also monitor CPU usage but reduce the number of virtual machine instances when usage falls below 50 percent.

- **The application that needs to deal with regular spikes in capacity on Friday evenings and downtime on Wednesday mornings.**\
In this case, you should use scheduled scaling.

- **To ensure that no application scale-out incurs unexpectedly large charges.**\
To handle this scenario, you can limit all scale-out operations to 50 instances.

Adatum might not choose to use a Virtual Machine Scale Set for the following applications:

- **The application that is hosted on a single VM that doesn't experience variance in utilization and doesn't have an architecture that lets it be load balanced.**\
In this case, just hosting the internet as a service (IaaS) VM normally in Azure is an appropriate option, though you should regularly check the VM to ensure that its performance profile is commensurate with the VM size assigned. However, if the single VM requires scaling at some point in time, Adatum could consider moving it into a scale set.

- **The application hosted on an IaaS VM that is only used several hours per day by a limited number of people shouldn't be configured to use Virtual Machine Scale Sets.**\
In this case, you could use scheduled VM startup and shutdown to optimize costs, ensuring that the VM was available during business hours and offline when no one is at work.
