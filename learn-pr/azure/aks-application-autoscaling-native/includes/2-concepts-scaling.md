Before finding a scaling solution, you need to understand what scalability is and how it applies to Kubernetes applications.

In this unit, we review some scalability concepts.

## Scalability

*Scalability* describes an application's or system's ability to handle an increasing amount of work by adding more resources to it.

In our example scenario, the amount of work experiencing an increase is the number of customer requests. The amount of added resources can be represented in two ways: *vertical scalability* and *horizontal scalability*.

### Vertical scalability

Vertical scalability, or *scaling up*, refers to scaling a system by adding more physical resources, like memory or CPU power. For example, if your company's website consumes too much memory, you could update your VM instance to include more memory while keeping the same underlying application.

:::image type="content" source="../media/1-vertical-scaling.png" alt-text="Vertical scaling diagram.":::

In short, scaling vertically involves increasing the VM size while keeping the number of applications the same. This approach is valuable if you have ***monolithic applications that require a lot of compute power but are too costly to break up into smaller parts***. These applications are mostly hosted in VMs as opposed to distributed systems.

Despite a more manageable cost, very large VMs can become very expensive. The cost of adding more compute power is higher than the cost of duplicating small VMs. There's an upper limit to the number of resources you can add to a single VM, meaning that you must eventually duplicate the VM once you reach the upper bound.

### Horizontal scalability

Horizontal scalability, or *scaling out*, refers to scaling a system by duplicating the application and balancing the load across the application instances.

:::image type="content" source="../media/2-horizontal-scaling.png" alt-text="Horizontal scaling diagram.":::

Scaling horizontally is valuable for ***distributed applications, such as those deployed in AKS, and stateless systems since you can spin up several containers with the same application in a single VM***. Scaling out allows you to extract the most resources while paying for a single VM.

In our example scenario, your company site is stateless. This means that scaling out is the best course of action. Kubernetes provides out-of-the-box a resource called the *HorizontalPodAutoscaler* (HPA) that allows you to scale out your deployments.

## Manual scalability on Kubernetes

Before we cover the HPA, let's review how to scale a Kubernetes application manually.

Every deployment is bound to another resource called a *ReplicaSet*. A ReplicaSet is responsible for maintaining a "desired replica state" and scaling the real application in or out to keep the desired state the same as the real state. You can control the number of replicas in a deployment through the `spec.replicas` key in the deployment specification. This key sets the number of desired replicas in the underlying ReplicaSet and forces the replication controller to keep this number of replicas at any given time.

You can also control the number of replicas in a deployment with the `kubectl scale deploy/contoso-website --replicas <number>` command. This command dynamically changes the number of desired replicas in a deployment and scales the application in or out.

## HorizontalPodAutoscaler (HPA)

The HPA is the native Kubernetes 1.8+ resource that provides horizontal scalability to pods in the cluster. It monitors the metrics API every 30 seconds for any changes in the desired replica count. If the desired replica count is different from the current replica count, the controller manager, which manages HPA objects, scales the deployment in or out.

:::image type="content" source="../media/2-horizontal-pod-autoscaler-design.png" alt-text="HorizontalPodAutoscaling design diagram.":::

HPAs work with the `autoscaling` API group in Kubernetes. There are two versions to this API group: `v1` and `v2`. The `v1` version allows the deployment to scale based on CPU metrics only. The `v2` version allows native monitoring of both CPU and memory. In this module, we use the `v2` version.

Every HPA is attached to a *scale reference*, which is defined in the `spec.scaleTargetRef` key of the HPA manifest. This scale reference must have underlying pods to be scaled, otherwise the HPA doesn't work, since it's not possible to apply scaling to objects that can't be scaled, like DaemonSets.

It's important that each pod has a resource request set in its spec. The HPA algorithm can't correctly calculate the metrics and determine the resource utilization without this setting. You can set this limiting through the `spec.template.spec.containers[].resources` key in the deployment manifest, as shown in the following example:

```yml
spec:
  template:
    spec:
      containers:
        - resources:
            requests:
              cpu: 250m
              memory: 256M
            limits:
              cpu: 500m
              memory: 512M
```

### Example HPA manifest

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```
