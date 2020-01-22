As the popularity of our application grows, the application needs to scale appropriately to manage demand changes. In our example, we have to ensure that our application remains responsive as the number of order submissions increases.

In this exercise, we'll explore the AKS Horizontal Pod Autoscaler (HPA) capabilities. First, we'll deploy our pre-built load test application to Azure Container Instances. The application will inject a large amount of traffic to the capture order API.

We'll configure our deployed Container Instance not to restart once it's finished running. We'll also set an environmental variable that points to the service endpoint of our capture orders service. The load test will give us a baseline on the performance of our order API.

We'll then configure an HPA and rerun our load test. Finally, we'll optimize the number of resources that we'll give to the HPA.

## Run a baseline load test

We'll use a pre-built image called `azch/loadtest` that is available on Dockerhub to create our baseline load test. The image contains an application that uses a tool called ‘hey’ to inject a large amount of traffic to the capture order API. [Azure Container Instances](https://docs.microsoft.com/azure/container-instances) can be used to run this image as a container.

When running as a Container Instance set, we don’t want it to restart once it has finished. We'll use the `--restart-policy` parameter and set the value to `Never` to prevent the restart.

We'll provide the endpoint of our capture orders service in a SERVICE_ENDPOINT environmental variable. This variable allows for the 'hey' tool to interact with our order API. For example, `-e SERVICE_ENDPOINT=https://orders.{ingress-ip}.nip.io`

Once the Container Instance is running, we can watch the orders come in with the frontend page and view the detailed output of the load test with the `az container logs` command.

1. In the Cloud Shell, create an Azure Container Instances running the command below. Make sure to use the same resource group from earlier, for example, **aksworkshop**. Replace `https://<hostname order capture service>` with the address of your service, for example, **http://frontend.13-68-177-68.nip.io**.

    ```bash
    az container create \
        -g aksworkshop \
        -n loadtest \
        --image azch/loadtest \
        --restart-policy Never \
        -e SERVICE_ENDPOINT=https://<hostname order capture service>
    ```

    This command will fire off a series of increasing loads of concurrent users (100, 400, 1600, 3200, 6400) POSTing requests to our Order Capture API endpoint with some wait time in between to simulate an increased pressure on our application.

1. View the logs of the Azure Container Instance streaming logs by running the command below. Keep in mind that the logs take a few minutes to get full.

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

1. We can also use Azure Monitor to view the logs and figure out where we can increase the throughput (requests/sec), reduce the average latency, and error count for our deployed application.

    [![](../media/10-captureorder-loadtest-log.png "Screenshot showing cluster metrics collected for an AKS cluster under load")](../media/10-captureorder-loadtest-log.png#lightbox)

1. When done, delete the container by running the next command. Make sure to use the same resource group from earlier, for example, **aksworkshop**.

    ```bash
    az container delete -g aksworkshop -n loadtest
    ```

## Create Horizontal Pod Autoscaler

In our example, we notice that the `captureorder` container is the bottleneck in our deployment. To fix the bottleneck, we can deploy more instances of our order API container.

We have two options we can choose from when we need to scale out container instances in AKS. We can either manually increase the number of replicas in the deployment, or use the Horizontal Pod Autoscaler (HPA).

HPA allows Kubernetes to detect when our deployed pods need more resources based on metrics such as CPU. HPA can then schedule more pods onto the cluster to cope with the demand. We can configure HPA using the `kubectl autoscale` command, or we can define the HPA object in a YAML file.

We'll use the `kubectl get hpa` to confirm that the HPA configuration is correct, and the targets column isn't showing `<unknown>`.

> [!NOTE]
> There are two versions of the HPA object v1 and v2beta2. We'll work with the v1 version.

1. In Cloud Shell, save the YAML below in a file named `captureorder-hpa.yaml`. This file contains the instructions to create the HPA.

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

1. Deploy the `captureorder-hpa.yaml` configuration using `kubectl`.

    ```bash
    kubectl apply -f captureorder-hpa.yaml
    ```

    > [!IMPORTANT]
    > For the Horizontal Pod Autoscaler to work, we __must__ remove the explicit `replicas: 2` count from our `captureorder` deployment and define resource requests and resource limits. Good values to use are CPU:  *500m* (which is equivalent to half a CPU core), and for memory specify memory: *256Mi*. Keep in mind that we need to redeploy our deployment when we make any changes.

## Run a load test with Horizontal Pod Autoscaler enabled

Let's rerun our load test from earlier to see what effect the configured HPA has on our results. We'll have to delete our load test container and re-create it to run another test using the same parameters as before.

We'll monitor the behavior of the HPA with `kubectl get hpa` and use `kubectl get pod` to see the new `captureorder` pods start, as autoscaling triggers more replicas.

1. Delete the load testing Azure Container Instance, if it wasn't deleted earlier. Make sure to use the same resource group from earlier, for example, **aksworkshop**.

    ```bash
    az container delete -g aksworkshop -n loadtest
    ```

1. Rerun the load test using the command below. Make sure to use the same resource group from earlier, for example, **aksworkshop**. Replace `https://<hostname order capture service>` with the address of your service, for example, **http://frontend.13-68-177-68.nip.io**

    ```bash
    az container create \
        -g aksworkshop \
        -n loadtest \
        --image azch/loadtest \
        --restart-policy Never \
        -e SERVICE_ENDPOINT=https://<hostname order capture service>
    ```

1. Observe how our Kubernetes cluster reacts to the load by running the command below.

    ```bash
    kubectl get pods -l app=captureorder
    ```

## How to scale a cluster

HPA will scale out with new pods as required. However, eventually, the cluster will run out of resources, and we'll see scheduled pods in a pending state.

To solve the pending pod problem, we can enable the cluster autoscaler to scale the cluster automatically.

> [!NOTE]
> You may have to force this situation by artificially increasing the resource `request` and `limit` for memory in the `captureorder `deployment to `memory: "4G"` or even `memory: "2G"` (and redeploy/apply the deployment).

1. If our AKS cluster isn't configured with the cluster autoscaler, scale the cluster nodes using the command below to the required number of nodes. Make sure to use the same resource group from earlier, for example, **aksworkshop**.

    ```bash
    az aks scale \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME  \
        --node-count 4
    ```

1. Otherwise, if our AKS cluster is configured with cluster autoscaler, we should see it dynamically adding and removing nodes based on the cluster utilization. To change the node count, use the `az aks update` command and specify a minimum and maximum value. Make sure to use the same resource group from earlier, for example, **aksworkshop**.

    The following example sets the `--min-count` to _1_ and the `--max-count` to _5_:

    ```bash
    az aks update \
    --resource-group aksworkshop\
    --name $AKS_CLUSTER_NAME  \
    --update-cluster-autoscaler \
    --min-count 1 \
    --max-count 5
    ```
