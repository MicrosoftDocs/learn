Before we discuss using KEDA to scale our service, let's first review how a `Deployment` behaves and how with our scenario it will be difficult to process the increased number of events.

## What is Kubernetes deployment and what's missing?

:::image type="content" source="../media/4-1-deployments-diagram.png" alt-text="A diagram that shows a Kubernetes deployment with a label and three pods.":::

A Kubernetes deployment is an evolution of pods. A deployment wraps the pods into an intelligent object that allows them to _scale out_. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow users to update applications just by changing the image tag without downtime. When you update a deployment, instead of deleting all apps and creating new ones, the deployment turns off the online apps one by one and replaces them with the newest version. This aspect means any deployment can update the pods inside it with no visible effect in availability.

While this is all a benefit of a `Deployment` over using `Pods`, it does not adequately handle our scenario.  

To review, in our use case the application is event driven and receives a significant number of events at various times.  

Without any HPA or KEDA Scaler Object, an engineer would manually have to adjust the number of replicas available to sufficiently process the number of events. He or she would also have to _scale down_ the `Deployment` when the load returns to normal.

## Statically Setting Replicas

Here is an snippet of our `Deployment` manifest:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-microservice
spec:
  selector: # Define the wrapping strategy
    matchLabels: # Match all pods with the defined labels
      app: contoso-microservice # Labels follow the `name: value` template
  template: # This is the template of the pod inside the deployment
    metadata:
      labels:
        app: contoso-microservice
    spec:
      replicas: 10 # here we are telling K8S the number of pods to process the Redis list items
      containers:
        - image: mcr.microsoft.com/mslearn/samples/redis-client:latest
          name: contoso-microservice
```

As you can see, replicas is set to 10. This is set to the ceiling of the number of necessary replicas available to process the peak number of events.  However, during non-peak times, we are consuming too many resources, potentially starving other `Deployments` within the cluster.

One option would be to use a standalone HPA to monitor the CPU usage of the `Pods`. Although this is a better option than manually scaling in both directions, using a HPA will not focus on the number of events received to the Redis list.

The best choice so to use KEDA and a Redis scaler to query the list and determine if more or less pods are needed to process the events.
