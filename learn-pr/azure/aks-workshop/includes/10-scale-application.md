As the popularity of our application grows, the application needs to scale appropriately to manage demand changes. In our example, we have to ensure that our application remains responsive as the number of order submissions increases.

In this exercise, we'll explore the AKS Horizontal Pod Autoscaler (HPA) capabilities. First, we'll deploy our pre-built load test application to Azure Container Instances. The application will inject a large amount of traffic to the capture order API.

We'll configure our deployed Container Instance to not restart once it's finished running. We'll also set an environmental variable that points to the service endpoint of our capture orders service on our AKS cluster. The load test will give us a baseline on the performance of our order API.

We'll then configure a HPA and re-run our load test. Finally, will optimize the amount of resources that we'll allocate to the HPA.

## Run a baseline load test

We'll use a pre-built image called `azch/loadtest` that is available on Dockerhub to create our baseline load test. The image contains an application that uses a tool called ‘hey’ to inject a large amount of traffic to the capture order API. [Azure Container Instances](https://docs.microsoft.com/azure/container-instances) can be used to run this image as a container.

When running as a Container Instance set we don’t want it to restart once it has finished. To do this, we'll use the `--restart-policy` parameter and set the value to `Never`.

We'll provide the endpoint of our capture orders service in SERVICE_ENDPOINT environmental variable For the 'hey' tool to interact with the order API Provide. For example, -`e SERVICE_ENDPOINT=https://orders.{ingress-ip}.nip.io`

Once the Container Instance is running we can watch the orders come in with the frontend page, and view the detailed output of the load test with the `az container logs` command.

1. In the CLoud Shell, create an Azure Container Instances running the command below. Replace `https://<hostname order capture service>` with the address of your service, for example **http://frontend.13-68-177-68.nip.io**

    ```bash
    az container create \
        -g <resource-group> \
        -n loadtest \
        --image azch/loadtest \
        --restart-policy Never \
        -e SERVICE_ENDPOINT=https://<hostname order capture service>
    ```

    This will fire off a series of increasing loads of concurrent users (100, 400, 1600, 3200, 6400) POSTing requests to our Order Capture API endpoint with some wait time in between to simulate an increased pressure on our application.

1. View the logs of the Azure Container Instance streaming logs by running the command below. Keep in mind that the logs take a few minutes to get the full.

    ```bash
    az container logs -g <resource-group> -n loadtest
    ```

1. Make a note of the log results. This information will help us figure out what the breaking point on our service is for the number of user requests.

    ```output
    Phase 5: Load test - 30 seconds, 6400 users.

    Summary:
    Total:  41.1741 secs
    Slowest:    23.7166 secs
    Fastest:    0.8882 secs
    Average:    9.7952 secs
    Requests/sec:   569.1929

    Total data: 1003620 bytes
    Size/request:   43 bytes

    Response time histogram:
    0.888 [1]   |
    3.171 [1669]    |■■■■■■■■■■■■■■
    5.454 [1967]    |■■■■■■■■■■■■■■■■■
    7.737 [4741]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    10.020 [3660]   |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    12.302 [3786]   |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    14.585 [4189]   |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    16.868 [2583]   |■■■■■■■■■■■■■■■■■■■■■■
    19.151 [586]    |■■■■■
    21.434 [151]    |■
    23.717 [7]  |

    Status code distribution:
    [200]   23340 responses

    Error distribution:
    [96]    Post http://23.96.91.35/v1/order: net/http: request canceled (Client.Timeout exceeded while awaiting headers)
    ```

1. We can also use the Azure Monitor to view the logs and figure out where we need to optimize to increase the throughput (requests/sec), reduce the average latency, and error count.

    [![](../media/10-captureorder-loadtest-log.png "Screenshot showing cluster metrics collected for an AKS cluster under load")](../media/10-captureorder-loadtest-log.png#lightbox)

1. When done, delete the container by running the next command.

    ```bash
    az container delete -g <resource-group> -n loadtest
    ```

## Create Horizontal Pod Autoscaler

Most likely in our initial test, the `captureorder` container was the bottleneck. The first step is to scale out the container. Scaling out the container there are two ways to do so, you can either manually increase the number of replicas in the deployment, or use Horizontal Pod Autoscaler.

Horizontal Pod Autoscaler allows Kubernetes to detect when your deployed pods need more resources and then it schedules more pods onto the cluster to cope with the demand.

- The Horizontal Pod Autoscaler (or HPA) is a way for deployments to scale their pods out automatically based on metrics such as CPU.
- There are two versions of the HPA object v1 and v2beta2, for this workshop you can work with the v1 version.
- The kubectl autoscale command can easily set up a HPA for any deployment, this walkthrough guide has an example you can re-use.
- Alternatively you can define the HPA object in a YAML file.
For the HPA to work, you must add resource limits to your captureorder deployment, if you haven’t already done so. Good values to use are cpu: "500m" (which is equivalent to half a CPU core), and for memory specify memory: "256Mi".
- Validate the HPA with kubectl get hpa and make sure the targets column is not showing <unknown>.

1. Save the YAML below as captureorder-hpa.yaml or download it from captureorder-hpa.yaml

    ```yaml
    apiVersion: autoscaling/v1
    kind: HorizontalPodAutoscaler
    metadata:
      name: captureorder
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: captureorder
      minReplicas: 4
      maxReplicas: 10
      targetCPUUtilizationPercentage: 50
    ```

1. And deploy it using

    ```bash
    kubectl apply -f captureorder-hpa.yaml
    ```

    >[!IMPORTANT]
    >For the Horizontal Pod Autoscaler to work, you __must__ remove the explicit `replicas: 2` count from your captureorder deployment and redeploy it and your pods must define resource requests and resource limits.

## Run a load test again after applying Horizontal Pod Autoscaler

- Delete your load test container instance (az container delete) and re-create it to run another test, with the same parameters as before
- Watch the behavior of the HPA with `kubectl get hpa` and use `kubectl get pod` to see the new captureorder pods start, when auto-scaling triggers more replicas
- Observe the change in load test results

1. If you didn’t delete the load testing Azure Container Instance, delete it now

    ```bash
    az container delete -g <resource-group> -n loadtest
    ```

1. Running the load test again

    ```bash
    az container create \
        -g <resource-group> \
        -n loadtest \
        --image azch/loadtest \
        --restart-policy Never \
        -e SERVICE_ENDPOINT=https://<hostname order capture service>
    ```

1. Observe your Kubernetes cluster reacting to the load by running

```bash
kubectl get pods -l app=captureorder
```

## Check if your cluster nodes needs to scale/autoscale

- As the HPA scales out with more & more pods, eventually the cluster will run out of resources. You will see pods in pending state.
- You may have to artificially force this situation by increasing the resource `request` and `limit` for memory in the captureorder deployment to `memory: "4G"` or even `memory: "2G"` (and re-deploy/apply the deployment).
- If you enabled the cluster autoscaler, you might be able to get the cluster to scale automatically, check with the node count with `kubectl get nodes`.
- You didn’t enable the autoscaler you can try manually scaling with the `az aks scale` command and the `--node-count` parameter.

1. If your AKS cluster is not configured with the cluster autoscaler, scale the cluster nodes using the command below to the required number of nodes

    ```bash
    az aks scale \
        --resource-group <resource-group> \
        --name <unique-aks-cluster-name> \
        --node-count 4
    ```

1. Otherwise, if you configured your AKS cluster with cluster autoscaler, you should see it dynamically adding and removing nodes based on the cluster utilization. To change the node count, use the `az aks update` command and specify a minimum and maximum value. The following example sets the `--min-count` to _1_ and the `--max-count` to _5_:

    ```bash
    az aks update \
        --resource-group <resource-group> \
        --name <unique-aks-cluster-name> \
        --update-cluster-autoscaler \
        --min-count 1 \
        --max-count 5
    ```