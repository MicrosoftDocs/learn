As the popularity of our application grows, the application needs to scale appropriately to manage demand changes. In our example, we have to ensure that our application remains responsive as the number of ratings  increases.

In this exercise, we'll explore the AKS Horizontal Pod Autoscaler (HPA) capabilities.

## Create Horizontal Pod Autoscaler

In our example, it seems like the `ratings-api` container is unable to cope with the number of requests coming through. To fix the bottleneck, we can deploy more instances of that container.

We have two options we can choose from when we need to scale out container instances in AKS. We can either manually increase the number of replicas in the deployment, or use the Horizontal Pod Autoscaler (HPA).

HPA allows Kubernetes to detect when our deployed pods need more resources based on metrics such as CPU. HPA can then schedule more pods onto the cluster to cope with the demand. We can configure HPA using the `kubectl autoscale` command, or we can define the HPA object in a YAML file.

1. Create a file called `ratings-api-hpa.yaml` using the integrated editor.

    ```bash
    code ratings-api-hpa.yaml
    ```

1. Paste the following text in the file:

    ```yaml
    apiVersion: autoscaling/v2beta2
    kind: HorizontalPodAutoscaler
    metadata:
      name: ratings-api
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: ratings-api
      minReplicas: 1
      maxReplicas: 10
      metrics:
      - type: Resource
        resource:
          name: cpu
          target:
            type: Utilization
            averageUtilization: 30
    ```

1. Review the file and note the following points:

    - **Scale target**

    The target for scaling would be the **ratings-api** deployment.

    - **Min and max replicas**

    The minimum and maximum number of replicas to be deployed.

    - **Metrics**

    The autoscaling metric monitored is the CPU utilization, set at 30%. When the utilization goes above that level, the HPA will create more replicas.

1. To save and close the editor, open the ``...`` action panel in the top right of the editor and select **Save**, then select **Close editor**. We can also use <kbd>Ctrl-s</kbd> to save, and <kbd>Ctrl-q</kbd> to close the editor.

1. Apply the configuration using the `kubectl apply` command. We'll deploy the HPA object in the **ratingsapp** namespace.

    ```bash
    kubectl apply \
    --namespace ratingsapp \
    -f ratings-api-hpa.yaml
    ```

    We'll get an output similar to the example below.

    ```output
    horizontalpodautoscaler.autoscaling/ratings-api created
    ```

    > [!IMPORTANT]
    > For the Horizontal Pod Autoscaler to work, we __must__ remove any explicit replica count from our `ratings-api` deployment. Keep in mind that we need to redeploy our deployment when we make any changes.

## Run a load test with Horizontal Pod Autoscaler enabled

We'll use a pre-built image called `azch/artillery` that is available on Docker hub to create our  load test. The image contains a tool called [artillery](https://artillery.io) that will be used to send traffic to the API. [Azure Container Instances](https://docs.microsoft.com/azure/container-instances) can be used to run this image as a container.

When running as a Container Instance set, we don’t want it to restart once it has finished. We'll use the `--restart-policy` parameter and set the value to `Never` to prevent the restart.

1. In the Cloud Shell, store the frontend API load test endpoint in a Bash variable, replacing **`<frontend hostname>`** with our exposed Ingress hostname, for example, **https://frontend.13-68-177-68.nip.io**.

    ```bash
    LOADTEST_API_ENDPOINT=https://<frontend hostname>/api/loadtest

Let's run a load test to see how the HPA will scale our deployment.

1. Run the load test using the command below, setting the duration of the test to 120 seconds, simulating up to 500 requests per second.

    ```bash
    az container create \
        -g aksworkshop \
        -n loadtest \
        --cpu 4 \
        --memory 1 \
        --image azch/artillery \
        --restart-policy Never \
        --command-line "artillery quick -r 500 -d 120 $LOADTEST_API_ENDPOINT"
    ```

    We may need to run this command a few times.

 1. Watch the Horizontal Pod Autoscaler working.

    ```bash
    kubectl get hpa \
      --namespace ratingsapp -w
    ```

    In a few seconds, we'll see the HPA transition to deploying more replicas, scaling up from 1 to 10 to accommodate the load. Use `CTRL+C` to stop watching.

    ```output
    NAME          REFERENCE                TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
    ratings-api   Deployment/ratings-api   0%/30%     1         10        1          19m
    ratings-api   Deployment/ratings-api   46%/30%    1         10        1          20m
    ratings-api   Deployment/ratings-api   46%/30%    1         10        2          20m
    ratings-api   Deployment/ratings-api   120%/30%   1         10        2          21m
    ratings-api   Deployment/ratings-api   120%/30%   1         10        4          21m
    ratings-api   Deployment/ratings-api   93%/30%    1         10        4          22m
    ratings-api   Deployment/ratings-api   93%/30%    1         10        8          22m
    ratings-api   Deployment/ratings-api   93%/30%    1         10        10         22m
    ratings-api   Deployment/ratings-api   0%/30%     1         10        10         23m
    ```

## Autoscale the cluster

HPA will scale out with new pods as required. However, eventually, the cluster will run out of resources, and we'll see scheduled pods in a pending state.

We may have to force this situation by artificially increasing the resource `request` and `limit` for CPU in the `ratings-api ` deployment to `cpu: "1000m"` (and redeploy/apply the deployment).

1. Edit the file called `ratings-api-deployment.yaml` using the integrated editor.

    ```bash
    code ratings-api-deployment.yaml
    ```

1. Change the `resources.requests` and `resources.limits` for the container to be 1000m, meaning one core. The section should now look like this.

    ```yaml
    resources:
      requests: # minimum resources required
        cpu: 1000m
        memory: 64Mi
      limits: # maximum resources allocated
        cpu: 1000m
        memory: 256Mi
    ```

1. Apply the configuration using the `kubectl apply` command. We'll deploy the resource update in the **ratingsapp** namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-api-deployment.yaml
    ```

   We'll get an output similar to the example below.

    ```output
    deployment.apps/ratings-api configured
    ``` 

1. Review the new pods rolling out. We'll query for pods in the **ratingsapp** namespace, which are labeled with **app=ratings-api**.

    ```bash
    kubectl get pods \
        --namespace ratingsapp \
        -l app=ratings-api -w
    ```

    We'll now see multiple pods stuck in the **Pending** state because there isn't enough capacity on the cluster to schedule those new pods.

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    ratings-api-7746bb6444-4k24p       0/1     Pending   0          5m42s
    ratings-api-7746bb6444-brkd8       0/1     Pending   0          5m42s
    ratings-api-7746bb6444-l7fdq       0/1     Pending   0          5m42s
    ratings-api-7746bb6444-nfbfd       0/1     Pending   0          5m42s
    ratings-api-7746bb6444-rmvb2       0/1     Pending   0          5m42s
    ratings-api-7cf598d48-7wmml        1/1     Running   0          35m
    ratings-api-7cf598d48-98mwd        1/1     Running   0          12m
    ratings-api-7cf598d48-clnbq        1/1     Running   0          11m
    ratings-api-7cf598d48-cmhk5        1/1     Running   0          10m
    ratings-api-7cf598d48-t6xtk        1/1     Running   0          10m
    ratings-api-7cf598d48-vs44s        1/1     Running   0          10m
    ratings-api-7cf598d48-xxhxs        1/1     Running   0          11m
    ratings-api-7cf598d48-z9klk        1/1     Running   0          10m
    ratings-mongodb-5c8f57ff58-k6qcd   1/1     Running   0          16d
    ratings-web-7bc649bccb-bwjfc       1/1     Running   0          99m
    ratings-web-7bc649bccb-gshn7       1/1     Running   0          99m
    ```

To solve the pending pod problem, we can enable the cluster autoscaler to scale the cluster automatically.

1. Configure the cluster autoscaler, we should see it dynamically adding and removing nodes based on the cluster utilization. Use the `az aks update` command to enable the cluster autoscaler and specify a minimum and maximum value for the number of nodes. Make sure to use the same resource group from earlier, for example, **aksworkshop**.

    The following example sets the `--min-count` to _3_ and the `--max-count` to _5_:

    ```bash
    az aks update \
    --resource-group aksworkshop \
    --name $AKS_CLUSTER_NAME  \
    --enable-cluster-autoscaler \
    --min-count 3 \
    --max-count 5
    ```

    In a few minutes, the cluster should be configured with the cluster autoscaler, and we'll see the number of nodes increase.

1. Verify the number of nodes has increased.

    ```bash
    kubectl get nodes -w
    ```

    In a few minutes, we'll see some new nodes popping up and transition to the `Ready` state. Use `CTRL+C` to stop watching.

    ```output
    NAME                                STATUS   ROLES   AGE   VERSION
    aks-nodepool1-24503160-vmss000000   Ready    agent   50m   v1.15.7
    aks-nodepool1-24503160-vmss000001   Ready    agent   50m   v1.15.7
    aks-nodepool1-24503160-vmss000002   Ready    agent   50m   v1.15.7
    aks-nodepool1-24503160-vmss000003   Ready    agent   14s   v1.15.7
    aks-nodepool1-24503160-vmss000004   Ready    agent   21s   v1.15.7
    ```
