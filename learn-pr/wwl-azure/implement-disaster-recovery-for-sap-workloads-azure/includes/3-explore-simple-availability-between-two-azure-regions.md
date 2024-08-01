You might choose not to put any availability configuration in place within a single region, but still have demand for the workload served if a disaster occurs. Typical cases for such scenarios are nonproduction systems. Although having the system down for half a day or even a day is sustainable, you can't allow the system to be unavailable for 48 hours or more. To make the setup less costly, run another system that's even less important in the virtual machine. The other system functions as a destination. You can also size the virtual machine in the secondary region to be smaller and choose not to preload the data. Because the failover is manual and entails many more steps to fail over the complete application stack, the extra time to shut down the virtual machine, resize it, and then restart the virtual machine is acceptable.

If you're using the scenario of sharing the DR target with a QA system in one virtual machine, you need to take these considerations into account:

- There are two operation modes with `delta_datashipping` and `logreplay`, which are available for such a scenario.
- Both operation modes have different memory requirements without preloading data.
- `delta_datashipping` might require drastically less memory without the preload option than `logreplay` could require.
- The memory requirement of `logreplay` operation mode without preload isn't deterministic and depends on the columnstore structures loaded. In extreme cases, you might require 50% of the memory of the primary instance. The memory for `logreplay` operation mode is independent of whether you chose to have the data preloaded set or not.

:::image border="false" type="content" source="../media/two-vms-over-two-regions-e9400b16.png" alt-text="Diagram showing two virtual machines over two regions.":::

In this configuration, you can't provide an RPO = 0 because your HANA system replication mode is asynchronous. If you need to provide an RPO = 0, this configuration isn't the configuration of choice.

A small change that you can make in the configuration might be to configure data preload. However, given the manual nature of failover, and the fact that application layers also need to move to the second region, it might not make sense to preload data.
