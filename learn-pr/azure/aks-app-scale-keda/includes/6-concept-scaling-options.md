Sometimes, scaling the number of pods to handle increased demand isn't enough. To adjust to changing application demands, such as between the workday and evening or on a weekend, clusters often need a way to automatically scale.

## Kubernetes scaling options

Kubernetes clusters can scale using one of the following components:

* The **Cluster Autoscaler**, which watches for pods that can't be scheduled on nodes because of resource constraints. The cluster automatically increases the number of nodes to meet the demand.
* The **Horizontal Pod Autoscaler (HPA)**, which uses the Metrics Server in a Kubernetes cluster to monitor the resource demand of pods. If an application needs more resources, the number of pods is automatically increased to meet the demand.

Both the HPA and Cluster Autoscaler can also decrease the number of pods and nodes as needed. The Cluster Autoscaler decreases the number of nodes when there's a period of time with unused capacity. Any pods on a node that the Cluster Autoscaler needs to remove are safely scheduled elsewhere in the cluster.

The Cluster Autoscaler might be unable to scale down in situations where the pods can't move, such as:

* A pod is directly created and isn't backed by a controller object, such as a Deployment or ReplicaSet.
* A pod disruption budget (PDB) is too restrictive and doesn't allow the number of pods to be fall below a certain threshold.
* A pod uses node selectors or anti-affinity that can't be honored if scheduled on a different node.

## Using KEDA with the HPA

KEDA acts as a *custom metrics API*, using scalers to expose metrics to the HPA, simplifying the process of developing a metrics server.

Scalers help provide metrics from various sources to the HPA. KEDA supports a wide variety of scalers, including:

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
* Google Cloud Platform Pub/Sub
* IBM MQ
* InfluxDB
* NATS Streaming
* OpenStack Swift
* PostgreSQL
* Prometheus
* RabbitMQ Queue
* Redis Lists

For the complete list, see [Currently available scalers for KEDA](https://keda.sh/docs/2.2/scalers/).
