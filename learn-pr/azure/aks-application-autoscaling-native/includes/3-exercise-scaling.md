The init script has already created all the application resources, it's now up to you to define the scalability rules to make it scale in or out.

## Create an HPA

To start the scalability process, create a HorizontalPorAutoscaler resource in the cluster, which points to the website deployment.

As all Kubernetes resources, you can create a new HPA by writing a YAML file called `hpa.yaml`.

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
```

Now you define the target to be scaled. Since you're scaling the deployment website, define a `scaleTargetRef` key pointing to that resource:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: contoso-website
```

It's important to point out that the `scaleTargetRef` keys need to be the same as the created deployment resource. In your case, the [created deployment](https://raw.githubusercontent.com/Azure-Samples/mslearn-aks-application-scalability/main/kubernetes/deployment.yaml) has the `apiVersion` as `apps/v1` and it's called `contoso-website`.

Now it's time to define what metrics this HPA listens to and how many replicas you want it to have. To do that, you define a new key:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: contoso-website
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 20
```

This HPA is configured to query the native CPU metric. If this metric goes above it's average of 20% for a specified amount of time, it scales the deploy out in a unit.

The algorithm used to calculate this metric is based on this mathematical equation:

```output
desiredReplicas = ceil[currentReplicas * ( currentMetricValue / desiredMetricValue )]
```

Since the application is a website, it's a good practice to monitor the memory usage of the deployment. To calculate these metrics, you need to add another item to the `metrics` array:

```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: contoso-website
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 20
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 50
```

Create the HPA by running `kubectl apply -f hpa.yaml` in the same directory as the file you created.

## Check the results

Now that the HPA is created, you can query its metrics and usage by getting the HPA resource itself with `kubectl get hpa contoso-website`.

```output
NAME              REFERENCE                    TARGETS          MINPODS   MAXPODS   REPLICAS   AGE
contoso-website   Deployment/contoso-website   5%/50%, 0%/20%   1         10        1          49s
```

> [!NOTE]
> It's possible that the HPA shows `unknown` metrics for the first few seconds as it's trying to reach the metrics API to fetch those from the server.

If you generate enough web traffic, you can see the scalability taking place when one of the metrics defined goes above the defined threshold.

For example, let's generate traffic using a tool called [hey](https://github.com/rakyll/hey). Run the command `hey -n 100000 -c 100 -m GET <your ingress URL>` to check the scalability. This tool generates 100k requests from 100 different clients. If you monitor your HPA with `kubectl get hpa contoso-website -w`, and do the same with the deployment with `kubectl get deploy contoso-website -w` you notice the fluctuation in CPU usage:

```output
NAME              REFERENCE                    TARGETS          MINPODS   MAXPODS   REPLICAS   AGE
contoso-website   Deployment/contoso-website   5%/50%, 1%/20%   1         10        1          4m4s
contoso-website   Deployment/contoso-website   5%/50%, 31%/20%  1         10        1          4m36s
contoso-website   Deployment/contoso-website   5%/50%, 31%/20%  1         10        2          4m51s
contoso-website   Deployment/contoso-website   3%/50%, 19%/20%  1         10        2          5m37s
```

Notice the `REPLICAS` column, and then query your deployment to check the scaled resource:

```output
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
contoso-website   2/2     2            2           5m40s
```
