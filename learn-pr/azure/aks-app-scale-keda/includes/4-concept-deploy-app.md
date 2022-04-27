Before we discuss using KEDA to scale our service, let's first review how a deployment behaves and how with our scenario it will be difficult to process the increased number of events.

## What is Kubernetes Deployment and what's missing?

:::image type="content" source="../media/4-1-deployments-diagram.png" alt-text="A diagram that shows a Kubernetes Deployment with a label and three pods.":::

A Kubernetes Deployment is an evolution of pods. A Deployment wraps the pods into an intelligent object that allows them to *scale out*. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow users to update applications just by changing the image tag without downtime. When you update a Deployment, instead of deleting all apps and creating new ones, the Deployment turns off the online apps one by one and replaces them with the newest version. This aspect means any Deployment can update the pods inside it with no visible effect in availability.

While the above is all a benefit of a Deployment over using pods, it doesn't adequately handle our scenario.  

To review, in our use case the application is event driven and receives a significant number of events at various times.  

Without any Horizontal Pod Autoscaler (HPA) or KEDA Scaler Object, an engineer would manually adjust the number of replicas available to process sufficiently the number of events. They would also have to *scale down* the Deployment when the load returns to normal.

## Statically setting replicas

Here's a snippet of our Deployment manifest:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-microservice
spec:
  replicas: 10                     # Here we are telling K8S the number of pods to process the Redis list items
  selector:                         # Define the wrapping strategy
    matchLabels:                    # Match all pods with the defined labels
      app: contoso-microservice     # Labels follow the `name: value` template
  template:                         # This is the template of the pod inside the deployment
    metadata:
      labels:
        app: contoso-microservice
    spec:
      containers:
        - image: mcr.microsoft.com/mslearn/samples/redis-client:latest
          name: contoso-microservice
```

As you can see, `replicas` is set to 10, the ceiling of the number of necessary replicas available to process the peak number of events. However, during non-peak times, we're consuming too many resources, potentially starving other Deployments within the cluster.

One option would be to use a standalone HPA to monitor the CPU usage of the pods. Although this is a better option than manually scaling in both directions, using a HPA won't focus on the number of events received to the Redis list.

The best choice is to use KEDA and a Redis scaler to query the list and determine if more or less pods are needed to process the events.
