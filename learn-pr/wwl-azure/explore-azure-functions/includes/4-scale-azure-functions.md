The following table compares the scaling behaviors of the various hosting plans. Maximum instances are given on a per-function app (Consumption) or per-plan (Premium/Dedicated) basis, unless otherwise indicated.

| Plan | Scale out | Max # instances |
| --- | --- | --- |
| Consumption plan | Event driven. Scales out automatically, even during periods of high load. Functions infrastructure scales CPU and memory resources by adding more instances based on the number of incoming trigger events. | **Windows:** 200<br/>**Linux:** 100<sup>1</sup> |
| Flex Consumption plan | Per-function scaling. Event-driven scaling decisions are calculated on a per-function basis, which provides a more deterministic way of scaling the functions in your app. | Limited only by total memory usage of all instances across a given region. |
| Premium plan | Event driven. Scale out automatically based on the number of events that its functions are triggered on. | **Windows:** 100<br/>**Linux:** 20-100<sup>2</sup> |
| Dedicated plan<sup>3</sup> | Manual/autoscale | 10-30<br/>100 (ASE) |
| Container Apps | Event driven. Scale out automatically by adding more instances of the Functions host, based on the number of events that its functions are triggered on. | 10-300<sup>4</sup> | 

1. During scale-out, there's currently a limit of 500 instances per subscription per hour for Linux 1. apps on a Consumption plan.
1. In some regions, Linux apps on a Premium plan can scale to 100 instances.
1. For specific limits for the various App Service plan options, see the [App Service plan limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).
1. On Container Apps, you can set the maximum number of replicas, which is honored as long as there's enough cores quota available
