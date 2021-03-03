The init script has already created all the application resources, it's now up to you to define the scalability rules that will make it scale in or out.

## Create an HPA

To start the scalability process, you'll need to create a HorizontalPorAutoscaler resource in the cluster which will point to the website deployment.

> [!NOTE]
> **If your AKS cluster version is less than 1.10**, the required Metrics Server will not be installed by default. HPAs can only work if they have a valid Metrics Server installation, you can install the Metrics Server on your cluster by downloading the [`components.yaml` file on the latest release](https://github.com/kubernetes-sigs/metrics-server/releases/latest/components.yaml).
>
> Example installation:
>
> ```bash
> kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
> ```

As all Kubernetes resources, you can create a new HPA by writing an YAML file called `hpa.yaml`.

```yml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: contoso-website
```

Now you'll define the target to be scaled. Since you're scaling the deployment website, you'll define a `scaleTargetRef` key pointing to that resource:

```yml
apiVersion: autoscaling/v2beta2
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

Now it's time to define what metrics this HPA will listen to and how many replicas you want it to have. To do that you'll define a new key:

```yml
apiVersion: autoscaling/v2beta2
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

This HPA is configured to query the native CPU metric, if this metrics goes above it's average of 20% for a specified amount of time, then it will scale the deploy out in a unit. The algorithm used to calculate this metric is based on this mathematical equation:

```output
desiredReplicas = ceil[currentReplicas * ( currentMetricValue / desiredMetricValue )]
```

Since this is a website, it's a good practice to monitor the memory usage of the deployment. For this you'll need to add another item to the `metrics` array:

```yml
apiVersion: autoscaling/v2beta2
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

Now that the HPA is created, you can query it's metrics and usage by getting the HPA resource itself with `kubectl get hpa contoso-website`.

```output
NAME              REFERENCE                    TARGETS          MINPODS   MAXPODS   REPLICAS   AGE
contoso-website   Deployment/contoso-website   5%/50%, 0%/20%   1         10        1          49s
```

> [!NOTE]
> It's possible that the HPA shows `unknown` metrics for the first few seconds as it's trying to reach the metrics API to fetch those from the server.

If you generate enough web traffic, you'll be able to see the the scalability taking place when one of the metrics defined goes above the defined threshold.

For example, let's generate traffic using a tool called [hey](https://github.com/rakyll/hey), we'll run the command `hey -n 100000 -c 100 -m GET <your ingress URL>` to check the scalability, this will generate 100k requests from 100 different clients. If you monitor your HPA with `kubectl get hpa contoso-website -w` and do the same with the deployment with `kubectl get deploy contoso-website -w` you'll notice the fluctuation in CPU usage:

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
