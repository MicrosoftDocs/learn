Sometimes scaling the number of pods to handle increased demand isn't enough. To adjust to changing application demands, such as between the workday and evening or on a weekend, clusters often need a way to automatically scale.

## Review of Available Scaling Options

Kubernetes clusters can scale in one of two ways:

* The cluster autoscaler watches for pods that can't be scheduled on nodes because of resource constraints. The cluster then automatically increases the number of nodes.
* The horizontal pod autoscaler uses the Metrics Server in a Kubernetes cluster to monitor the resource demand of pods. If an application needs more resources, the number of pods is automatically increased to meet the demand.

Both the horizontal pod autoscaler and cluster autoscaler can also decrease the number of pods and nodes as needed. The cluster autoscaler decreases the number of nodes when there has been unused capacity for a period of time. Pods on a node to be removed by the cluster autoscaler are safely scheduled elsewhere in the cluster. The cluster autoscaler may be unable to scale down if pods can't move, such as in the following situations:

* A pod is directly created and isn't backed by a controller object, such as a deployment or replica set.
* A pod disruption budget (PDB) is too restrictive and doesn't allow the number of pods to be fall below a certain threshold.
* A pod uses node selectors or anti-affinity that can't be honored if scheduled on a different node.

## KEDA's Relationship with HPA

KEDA acts as a “Custom Metrics API” for exposing metrics to the Horizontal Pod Autoscaler.  KEDA cannot do it's job without the HPA.  The complexity of developing a metrics server is abstracted away by using KEDA.

Scalers are the glue that provides the metrics from various sources to the HPA.  Here's a list of some of the most widely used scalers:

* Apache Kafka
* AWS CloudWatch
* AWS Kinesis Stream
* AWS SQS Queue
* Azure Blob Storage
* Azure Event Hubs
* Azure Log Analytics
* Azure Monitor
* Azure Service Bus
* Azure Storage Queue
* Google Cloud Platform‎ Pub/Sub
* IBM MQ
* InfluxDB
* NATS Streaming
* OpenStack Swift
* PostgreSQL
* Prometheus
* RabbitMQ Queue
* Redis Lists

For a complete list view the [scalers](https://keda.sh/docs/2.2/scalers/) section on the KEDA site.

A common question is when should one use a HPA and when to enlist KEDA.  If the workload is memory or cpu intensive, and has a well defined metric that can be measured then using a HPA is sufficient. When dealing with a workload that is event driven or relies upon a custom metric, then using KEDA should be the first choice.
