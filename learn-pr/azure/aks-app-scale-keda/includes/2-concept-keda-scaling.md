The video editing company that you work for experiences workload peak at various times during a 24-hr period. Since the application is event driven and receives a significant number of events at various times; CPU and Memory based metrics aren't representative of pending work to scale properly. You discover that by deploying KEDA and a scaler object, you can be prepared for peak and non-peak situations.

We'll review why the native Horizontal Pod Autoscaler (HPA) resource isn't always the best choice to autoscale your services.

## Event driven autoscaling

Kubernetes does resource-based scaling on metrics defined by CPU and memory really well.  Event-driven applications require a more targeted solution to scale proactively. With KEDA, you can drive the scaling of any workload in Kubernetes based on the number of events needing to be processed.

KEDA is a single-purpose and lightweight component that can be added into any Kubernetes cluster. KEDA is an open source, CNCF solution. It works alongside standard Kubernetes components like the HPA and can extend its functionality. With KEDA, you can explicitly target the apps you want to use event-driven scale, with other apps continuing to function using other scaling methods. This makes KEDA a flexible and safe option to run alongside any number of any other Kubernetes applications or frameworks.

## KEDA explained

### Key roles

KEDA acts as an agent in Kubernetes.  It activates and deactivates Deployments and StatefulSets to scale to and from zero.

KEDA is also a Kubernetes metrics server. The metrics server exposes detailed event data from sources like messages in a Kafka topic, queue length of an AWS SQS Queue or number of events in an Azure event hub.

### Architecture

The diagram below shows how KEDA integrates with the Kubernetes HPA, external event sources, and Kubernetes’ API Server to provide autoscaling functionality.

:::image type="content" source="../media/2-1-keda-architecture.png" alt-text="A diagram that depicts the KEDA architecture in Kubernetes.":::

> [!TIP]
> For more detailed information, see the [official KEDA documentation](https://keda.sh/docs/2.2/concepts/).

### Event sources and scalers

KEDA scalers can both detect if a Deployment should be activated or deactivated, and feed custom metrics for a specific event source.

Deployments and StatefulSets are the most common way to scale workloads with KEDA.  Scaling custom resources is also possible as long as the custom resource implements the `/scale` subresource.

It allows you to define the Kubernetes Deployment or StatefulSet that you want KEDA to scale based on a scale trigger. KEDA will monitor that service and based on the events that occur it will automatically scale your resource out/in accordingly.

Behind the scenes, KEDA acts to monitor the event source and feed that data to Kubernetes and the HPA (Horizontal Pod Autoscaler) to drive rapid scale of a resource. Each replica of a resource is actively pulling items from the event source. With KEDA and scaling `Deployments/StatefulSets`, you can scale based on events while also preserving rich connection and processing semantics with the event source (for example, in-order processing, retries, deadletter, checkpointing).

#### Scaled object spec

```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: {scaled-object-name}
spec:
  scaleTargetRef:
    apiVersion:    {api-version-of-target-resource}  # Optional. Default: apps/v1
    kind:          {kind-of-target-resource}         # Optional. Default: Deployment
    name:          {name-of-target-resource}         # Mandatory. Must be in the same namespace as the ScaledObject
    envSourceContainerName: {container-name}         # Optional. Default: .spec.template.spec.containers[0]
  pollingInterval: 30                                # Optional. Default: 30 seconds
  cooldownPeriod:  300                               # Optional. Default: 300 seconds
  minReplicaCount: 0                                 # Optional. Default: 0
  maxReplicaCount: 100                               # Optional. Default: 100
  advanced:                                          # Optional. Section to specify advanced options
    restoreToOriginalReplicaCount: true/false        # Optional. Default: false
    horizontalPodAutoscalerConfig:                   # Optional. Section to specify HPA related options
      behavior:                                      # Optional. Use to modify HPA's scaling behavior
        scaleDown:
          stabilizationWindowSeconds: 300
          policies:
          - type: Percent
            value: 100
            periodSeconds: 15
  triggers:
  # {list of triggers to activate scaling of the target resource}
```

#### Scaling jobs

As an alternate to scaling event-driven code as Deployments you can also run and scale your code as Kubernetes Jobs. The primary reason to consider this option is to handle processing long running executions. Rather than processing multiple events within a Deployment, for each detected event a single Kubernetes job is scheduled. That job will initialize, pull a single event from the message source, and process to completion and terminate.

```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledJob
metadata:
  name: {scaled-job-name}
spec:
  jobTargetRef:
    parallelism: 1                            # [max number of desired pods](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#controlling-parallelism)
    completions: 1                            # [desired number of successfully finished pods](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#controlling-parallelism)
    activeDeadlineSeconds: 600                #  Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer
    backoffLimit: 6                           # Specifies the number of retries before marking this job failed. Defaults to 6
    template:
      # describes the [job template](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)
  pollingInterval: 30                         # Optional. Default: 30 seconds
  successfulJobsHistoryLimit: 5               # Optional. Default: 100. How many completed jobs should be kept.
  failedJobsHistoryLimit: 5                   # Optional. Default: 100. How many failed jobs should be kept.
  envSourceContainerName: {container-name}    # Optional. Default: .spec.JobTargetRef.template.spec.containers[0]
  maxReplicaCount: 100                        # Optional. Default: 100
  scalingStrategy:
    strategy: "custom"                        # Optional. Default: default. Which Scaling Strategy to use. 
    customScalingQueueLengthDeduction: 1      # Optional. A parameter to optimize custom ScalingStrategy.
    customScalingRunningJobPercentage: "0.5"  # Optional. A parameter to optimize custom ScalingStrategy.
  triggers:
  # {list of triggers to create jobs}
```
