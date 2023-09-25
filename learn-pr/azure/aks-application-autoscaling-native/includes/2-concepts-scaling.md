To start with the scalability project your company wants to achieve, you first need to understand what scalability is and how it's applied to Kubernetes itself and its applications.

In this chapter, we review some scalability concepts.

## Scalability

Scalability is the word used to describe the ability of an application or system to handle an increasing amount of work by adding more resources to it.

For example, in this case, the amount of work being increased is the number of requests from the users, while the amount of resources added can be represented in two ways, *vertical scalability* and *horizontal scalability*.

### Vertical scalability

Vertical scalability is when a system is scaled by adding more physical resources to it, like memory or CPU power. For example, if the company's website is consuming too much memory, you could update your VM instance to include more memory while keeping the same underlying application.

:::image type="content" source="../media/1-vertical-scaling.png" alt-text="Vertical scaling diagram.":::

In short, scaling vertically is increasing the VM size while keeping the number of applications the same.

This approach is valuable when you're dealing with monolithic applications that require too much compute power but are too costly to break up into smaller parts.

These applications are mostly hosted in VMs as opposed to distributed systems as Kubernetes.

Despite the cost being manageable, huge VMs can be too expensive because the cost of adding more compute power is bigger comparable to the cost of duplicating small VMs.

Also, there's an upper limit to the number of resources you can add to a single VM, meaning that you must eventually duplicate the VM once you reach the upper bound.

### Horizontal scalability

Horizontal scalability is the most used type of scalability for distributed applications, such as those deployed in AKS. It consists of duplicating the whole application and balancing the load among the application instances.

:::image type="content" source="../media/2-horizontal-scaling.png" alt-text="Horizontal scaling diagram.":::

Scaling horizontally is called *scaling out*, it's widely used in stateless systems since you can spin up several containers with the same application in a single VM. Scaling out allows you to extract the most resources while you continue to pay for a single VM.

Since the company site is stateless, scaling out is the best course of action, also because Kubernetes provides out-of-the-box a resource called *HorizontalPodAutoscaler* that allows you to scale out your deployments.

## Manual scalability on Kubernetes

Before getting into the HPA (*HorizontalPodAutoscaler*) resource, you must know that it's possible to manually scale deployments in Kubernetes.

Every deployment is bound to another resource called *ReplicaSet*. This resource is responsible for maintaining a "desired replica state", and scaling the real application in or out to keep the desired state the same as the real state.

You can control the number of replicas in a deployment through the `spec.replicas` key in the deployment specification, this setting sets the number of desired replicas in the underlying ReplicaSet and forces the replication controller to keep this number of replicas at any given time.

You can also control the number of replicas in a deployment through the `kubectl scale deploy/contoso-website --replicas <number>` command. This command dynamically changes the number of desired replicas in a deployment and scales the application in or out.

## HorizontalPodAutoscaler

The HPA is the native Kubernetes 1.8+ resource that provides horizontal scalability to pods in the cluster. It monitors the metrics API every 30 seconds for any changes in the desired replica count.

If the desired replica count is different from the current replica count, then the controller manager, which manages HPA objects, scales the deployment in or out.

:::image type="content" source="../media/2-horizontal-pod-autoscaler-design.png" alt-text="HorizontalPodAutoscaling design diagram.":::

HPAs work with the `autoscaling` API group in Kubernetes. There are two versions to this API group. The `v1` version allows the deployment to scale based on CPU metrics only, while the `v2beta2` version (eventually becoming `v2`) allows native monitoring of both CPU and Memory. In this learn module we work with the `v2beta2` version.

Every HPA is attached to a *scale reference*, which is defined in the `spec.scaleTargetRef` key of the HPA manifest. This scale reference must have underlying pods to be scaled, otherwise the HPA doesn't work, since it's not possible to apply scaling to objects that can't be scaled, like DaemonSets.

It's important that each pod has a resource request set in its spec. The HPA algorithm can't correctly calculate the metrics and determine the resource utilization without this setting. You can set this limiting through the `spec.template.spec.containers[].resources` key in the deployment manifest, like so:

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

Here's an example of an HPA manifest:

```yml
apiVersion: autoscaling/v2beta2
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

The `v2beta2` version allows a fine-tuning of the scaling behavior, which allows you to control how your application behaves when scaled in or out. It also supports scaling through custom metrics, though this learning path doesn't provide instructions on how to do it.
