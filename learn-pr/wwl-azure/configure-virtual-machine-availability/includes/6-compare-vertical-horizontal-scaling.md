Generally, there are two types of scaling: vertical scaling and horizontal scaling.

## Vertical scaling

:::image type="content" source="../media/vertical-scaling-cdafa792.png" alt-text="Vertical scaling shows a single VM getting larger.":::


Vertical scaling, also known as scale up and scale down, means increasing or decreasing virtual machine sizes in response to a workload. Vertical scaling makes the virtual machines more (scale up) or less (scale down) powerful. Vertical scaling can be useful when:

 -  A service built on virtual machines is under-utilized (for example at weekends). Reducing the virtual machine size can reduce monthly costs.
 -  Increasing virtual machine size to cope with larger demand without creating additional virtual machines.

## Horizontal scaling

:::image type="content" source="../media/horizontal-scaling-3e457e75.png" alt-text="Horizontal scaling shows more VMs being added.":::


Horizontal scaling, also referred to as scale out and scale in, where the number of VMs is altered depending on the workload. In this case, there is an increase (scale out) or decrease (scale in) in the number of virtual machine instances.

## Considerations

 -  Vertical scaling generally has more limitations. Vertical scaling dependent on the availability of larger hardware, which quickly hits an upper limit and can vary by region. Vertical scaling also usually requires a virtual machine to stop and restart.
 -  Horizontal scaling is more flexible in a cloud situation as it allows you to run potentially thousands of virtual machines to handle load.
 -  Reprovisioning means removing an existing virtual machine and replacing it with a new one. Do you need to retain your data?
