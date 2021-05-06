The video editing company that you work for experiences workload peak at various times during a 24-hr period. Since the application is event driven and receives a significant number of messages, CPU and Memory based metrics are not sufficient to scale properly. You discover that by deploying KEDA and a scaler object, you can be prepared for peak and non-peak situations.

Before we discuss using KEDA to scale our service, let's first review how to deploy the service and connect it to Azure Redis Cache.

Here you'll explore how to deploy a workload and expose it as a service.

## What is Kubernetes deployment?

:::image type="content" source="../media/4-1-deployments-diagram.png" alt-text="A diagram that shows a Kubernetes deployment with a label and three pods.":::

A Kubernetes deployment is an evolution of pods. A deployment wraps the pods into an intelligent object that allows them to _scale out_. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow users to update applications just by changing the image tag without downtime. When you update a deployment, instead of deleting all apps and creating new ones, the deployment turns off the online apps one by one and replaces them with the newest version. This aspect means any deployment can update the pods inside it with no visible effect in availability.

## Kubernetes manifest files

A Kubernetes manifest file allows you to describe your workloads in the YAML format declaratively and simplify Kubernetes object management.

Imagine you have to deploy a workload by hand. You need to think about and manage several aspects. You'd need to create a container, select a specific node, wrap it in a pod, run the pod, monitor execution, and so on.

Manifest files contain all the information that's needed to create and manage the described workload.

```yaml
apiVersion: apps/v1 # Where in the API it resides
kind: Deployment # The kind of workload we're creating
```

The `apiVersion` key defines the API server endpoint that manages the object you'll deploy.

The `kind` key defines the workload this deployment will create.

Other common keys for all the files are the `metadata` and `name` keys. All Kubernetes resources *must* have a name. This name goes inside the `metadata` key.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website # This will be the name of the deployment
```

## Group objects in a deployment

Deployments make use of a `label` to find and group pods. You define the label as part of your deployment's manifest file.

Here's an example. Notice the `matchLabels` value defined in the `selector` definition added to the `spec` definition.

```yaml
# deployment.yaml
# ...
spec:
  selector:
    matchLabels:
      app: contoso-website
# ...
```

From this point on, all files have different structures based on what kind of resource you're telling Kubernetes to create.

## Apply a deployment file

You deploy a Kubernetes deployment manifest file by using `kubectl`. Here's an example of the command.

```bash
kubectl apply -f ./deployment.yaml
```

## What is a Kubernetes service?

A Kubernetes service is a workload that abstracts the IP address for networked workloads. A Kubernetes service acts as a load balancer and redirects traffic to the specific ports of specified ports by using port-forwarding rules.

:::image type="content" source="../media/4-2-service-diagram.png" alt-text="A diagram that shows two Kubernetes services. The first service is applied to one pod. The second service is applied to two pods.":::

You define a service in the same way as a deployment using a YAML manifest file. The service uses the same `selector` key as deployments to select and group resources with matching labels into one single IP.

A Kubernetes service needs four pieces of information to route traffic.

| Information | Description |
| --- | --- |
| **Target resource** | The target resource is defined by the `selector` key in the service manifest file. This value selects all the resources with a given label onto a single IP address. |
| **Service port** | This port is the inbound port for your application. All the requests come to this port from where the service forwards the requests to the resource. |
| **Network protocol**| This value identifies the network protocol for which the service will forward network data. |
| **Resource port** | This value identifies the port on the target resource on which incoming requests are received. This port is defined by the `targetPort` key in the service manifest file.

## Kubernetes service types

Services can be of several types. Each type changes the behavior of the applications selected by the service.

- **ClusterIP**: This value exposes the applications internally only. This option allows the service to act as a port-forwarder and makes the service available within the cluster. This value is the default when omitted.

- **NodePort**: This value exposes the service externally. It assigns each node a static port that responds to that service. When accessed through `nodeIp:port`, the node automatically redirects the request to an internal service of the `ClusterIP` type. This service then forwards the request to the applications.

- **LoadBalancer**: This value exposes the service externally by using Azure's load-balancing solution. When created, this resource spins up an Azure Load Balancer resource within your Azure subscription. Also, this type automatically creates a `NodePort` service to which the load balancer's traffic is redirected and a `ClusterIP` service to forward internally.

- **ExternalName**: This value maps the service by using a DNS resolution through a CNAME record. You use this service type to direct traffic to services that exist outside the Kubernetes cluster.
