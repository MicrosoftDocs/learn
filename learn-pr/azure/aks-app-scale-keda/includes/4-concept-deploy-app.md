Before you deploy your application to Kubernetes, let's review Kubernetes Deployments and discuss their limitations in our scenario.

## What are Kubernetes Deployments?

:::image type="content" source="../media/4-1-deployments-diagram.png" alt-text="A diagram that shows a Kubernetes Deployment with a label and three pods.":::

A Kubernetes Deployment is an evolution of pods. Deployments wrap pods into an intelligent object that allows them to *scale out*. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow you to update your applications without downtime just by changing the image tag. Updating a Deployment turns off the online apps one by one and replaces them with the newest version instead of deleting all apps and creating new ones, which means that Deployment can update the pods inside of it with no visible effect on availability.

While there are many benefits to using Deployments over pods, they aren't able to adequately handle our scenario.  

This scenario involves an event-driven application that receives a large number of events at various times. Without a KEDA Scaler object or HPA, you'd need to manually adjust the number of replicas to process the number of events and *scale down* the Deployment when the load returns to normal.

### Sample Deployment manifest

Here's a sample snippet of our Deployment manifest:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-microservice
spec:
  replicas: 10                      # Tells K8S the number of pods needed to process the Redis list items
  selector:                         # Define the wrapping strategy
    matchLabels:                    # Match all pods with the defined labels
      app: contoso-microservice     # Labels follow the `name: value` template
  template:                         # Template of the pod inside the deployment
    metadata:
      labels:
        app: contoso-microservice
    spec:
      containers:
        - image: mcr.microsoft.com/mslearn/samples/redis-client:latest
          name: contoso-microservice
```

In the sample manifest, `replicas` is set to 10, which is the highest number we can set for necessary replicas available for processing the peak number of events. However, this causes the application to consume too many resources during nonpeak times, which might starve other Deployments within the cluster.

One solution is to use a standalone HPA to monitor the CPU usage of the pods, which is a better option than manually scaling in both directions. However, the HPA doesn't focus on the number of events received to the Redis list.

The best solution is to **use KEDA and a Redis scaler** to query the list and determine if more or fewer pods are needed to process the events.
