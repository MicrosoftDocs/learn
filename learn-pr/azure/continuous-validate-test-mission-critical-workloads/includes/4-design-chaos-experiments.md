List all the components that are relevant for a given user flow. 

Think of possible failures scenarios that each of these components could encounter. 

Pick a few of the previously identified failures cases for a chaos experiment.

The goal of the experiment is not to break the system, but to validate resiliency measures that we have implemented in our application.

Use Azure Chaos Studio to inject the faults into the relevant components. 

Run some load against the system at the same time to be able to observe the behavior.

Content base:
- /azure/chaos-studio/chaos-studio-fault-library 
- /azure/architecture/framework/resiliency/chaos-engineering?toc=%2Fazure%2Fchaos-studio%2Ftoc.json&bc=%2Fazure%2Fchaos-studio%2Fbreadcrumb%2Ftoc.json

 
