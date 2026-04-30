This module covers how to scale applications in Azure Kubernetes Service (AKS). You learn when to scale workload replicas, when to scale AKS node pools, and how to use Azure Container Instances (ACI) for burst capacity. You also see where event-driven autoscaling and node auto-provisioning fit for scenarios beyond the core exercises.

## Scenario

Imagine you're a platform engineer for a retail company that runs its checkout service on AKS. During weekday lunchtimes and seasonal promotions, traffic to the checkout service can grow tenfold within minutes, while traffic at night drops to a small fraction of peak. Today, your team responds to spikes by leaving extra VM-backed nodes running around the clock, which inflates the cluster bill. During larger promotions, pods still spend several minutes in `Pending` while new VM-backed nodes provision, which puts checkout SLAs at risk.

Your goal is to use AKS scaling features so the cluster matches demand at each layer: the right number of pod replicas for the current load, the right number of nodes to host those replicas, and a fast path for short-lived bursts that can't wait for new VM-backed nodes. This module helps you compare the available AKS scaling options and choose the right one for each scenario.

## Learning objectives

After completing this module, you'll be able to:

- Manually scale workload replicas and AKS node pools
- Use the horizontal pod autoscaler (HPA) to scale workload replicas
- Use the cluster autoscaler to scale AKS node pools
- Use virtual nodes to run burst workloads in Azure Container Instances (ACI)
