# Exercise - Scaling an application

## Create an AKS cluster

Before you can start scaling your application, you need to create an AKS cluster with the required resources.

1. Sign in to the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with the account you want to deploy resources into and select **Bash** as the running shell.
2. Create a resource group using the `az group create` command. The following example creates a resource group named `myResourceGroup` in the `eastus` location:

    ```bash
    az group create --name myResourceGroup --location eastus
    ```

3. Create an AKS cluster using the `az aks create` command. The following example creates a cluster named `myAKSCluster` in the `myResourceGroup` resource group. The cluster has one node and uses the `Standard_DS2_v2` VM size.

    ```bash
    az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 1 --node-vm-size Standard_DS2_v2 --enable-app-routing --generate-ssh-keys
    ```

    The command takes a few minutes to complete.

4. Get the credentials for the cluster using the `az aks get-credentials` command.

    ```bash
    az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
    ```

5. Verify that the cluster is running and that you can connect to it using the `kubectl get nodes` command.

    ```bash
    kubectl get nodes
    ```

    The command should return one node with a status of `Ready`.

## Deploy the application resources

Now that you have a cluster, you can deploy the application to it.

### Deploy the application

1. Create the application namespace using the `kubectl create namespace` command.

    ```bash
    kubectl create namespace hpa-contoso
    ```

2. Create a new file named `deployment.yml` in the Cloud Shell editor and paste the following YAML code into it:

    ```yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
      namespace: hpa-contoso
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: contoso-website
      template:
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - name: contoso-website
              image: mcr.microsoft.com/mslearn/samples/contoso-website
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80
    ```

3. Save the file.
4. Deploy the application to the cluster using the `kubectl apply` command.

    ```bash
    kubectl apply -f deployment.yml
    ```

    Your output should look similar to the following example output:

    ```output
    deployment.apps/contoso-website created
    ```

### Create a DNS zone and deploy the ingress resource

1. Create an Azure DNS zone using the `az network dns zone create` command. The following example creates a DNS zone named *contoso-website.com*:

    ```bash
    az network dns zone create --resource-group myResourceGroup --name contoso-website.com
    ```

2. Get the resource ID for your DNS zone using the `az network dns zone show` command and save the output to a variable named *DNS_ZONE_ID*.

    ```bash
    DNS_ZONE_ID=$(az network dns zone show --resource-group myResourceGroup --name contoso-website.com --query id --output tsv)
    ```

3. Update the application routing cluster add-on to enable Azure DNS integration using the `az aks approuting zone` command.

    ```bash
    az aks approuting zone add --resource-group myResourceGroup --name myAKSCluster --ids=${DNS_ZONE_ID} --attach-zones
    ```

4. Create a file named `ingress.yml` in the Cloud Shell editor and paste the following YAML code into it. Make sure you replace the `<dns-zone-name>` placeholder with the name of your DNS zone.

    ```yml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
      namespace: hpa-contoso
      annotations:
    spec:
      ingressClassName: webapprouting.kubernetes.azure.com
      rules:
      - host: <dns-zone-name>
        http:
          paths:
          - backend:
              service:
                name: contoso-website
                port:
                  number: 80
            path: /
            pathType: Prefix
    ```

5. Save the file.
6. Deploy the ingress resource to the cluster using the `kubectl apply` command.

    ```bash
    kubectl apply -f ingress.yml
    ```

    Your output should look similar to the following example output:

    ```output
    ingress.networking.k8s.io/contoso-website created
    ```

### Create the service resource

1. Create a file named `service.yml` in the Cloud Shell editor and paste the following YAML code into it:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
      namespace: hpa-contoso
    spec:
      type: ClusterIP
      ports:
        - port: 80
          targetPort: 80
      selector:
        app: contoso-website
    ```

2. Save the file.
3. Deploy the service resource to the cluster using the `kubectl apply` command.

    ```bash
    kubectl apply -f service.yml
    ```

    Your output should look similar to the following example output:

    ```output
    service/contoso-website created
    ```

## Create a HorizontalPodAutoscaler

1. Create a file named `hpa.yml` in the Cloud Shell editor and paste the following YAML code into it:

    ```yml
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
      name: contoso-website
      namespace: hpa-contoso
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

    It's important to point out that the `scaleTargetRef` keys need to be the same as the created deployment resource. In your case, the deployment you created has the `apiVersion` as `apps/v1` and it's called `contoso-website`. This HPA is configured to query the native CPU metric. If this metric goes above its average of 20% for a specified amount of time, it scales the deploy out in a unit. The algorithm used to calculate this metric is based on this mathematical equation:

      ```bash
      desiredReplicas = ceil[currentReplicas * ( currentMetricValue / desiredMetricValue )]
      ```

    The `minReplicas` and `maxReplicas` keys define the minimum and maximum number of replicas the deployment can have. The `metrics` key defines the metrics the HPA queries to scale the deployment. In this case, the HPA queries the CPU and memory metrics. If the CPU metric goes above 20% or the memory metric goes above 50%, the HPA scales the deployment out.

2. Save the file.
3. Create the HPA using the `kubectl apply` command.

    ```bash
    kubectl apply -f hpa.yml
    ```

    Your output should look similar to the following example output:

    ```output
    horizontalpodautoscaler.autoscaling/contoso-website created
    ```

## Check the results

1. Query the metrics and usage of the HPA using the `kubectl get hpa` command.

    ```bash
    kubectl get hpa --namespace hpa-contoso
    ```

    Your output should look similar to the following example output:

    ```output
    NAME              REFERENCE                    TARGETS          MINPODS   MAXPODS   REPLICAS   AGE
    contoso-website   Deployment/contoso-website   0%/20%, 0%/50%   1         10        1          83s
    ```

    Notice the `TARGETS` column. It shows the current usage of the metrics defined in the HPA. In this case, the CPU usage is 0% and the memory usage is 0%. This is because the application is not receiving any traffic.

    > [!NOTE]
    > It's possible that the HPA shows `unknown` metrics for the first few seconds as it's trying to reach the metrics API to fetch those from the server.
