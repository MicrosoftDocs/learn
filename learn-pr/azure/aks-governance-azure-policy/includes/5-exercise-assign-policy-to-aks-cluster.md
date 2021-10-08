You are now ready to configure Azure policies and initiatives for your AKS cluster. 

In this unit, you'll deploy a non-compliant pod, apply an Azure Policy that enforces the use of only trusted registries and then deploy another non-compliant pod to see the effect of the Policy. You will also learn troubleshooting steps to see why the pods are not being created. You will also deploy the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative.

## Deploy a non-compliant pod into the cluster

We begin by deploying an image from directly from Docker Hub into the cluster. The first step would be to log into the cluster.

1. In Cloud Shell, log into the AKS cluster

   ```azurecli-interactive
   az aks get-credentials -n videogamecluster -g videogamerg 
   ```

1. Run the following code to create a simple nginx pod from Docker Hub.

   ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: simple-nginx
      labels:
        app: nginx
    spec:
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: simple-nginx
            image: docker.io/library/nginx:stable
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
              limits:
                cpu: 120m
                memory: 120Mi
            ports:
            - containerPort: 80
   EOF
   ```
   
1. Run the code below to deploy the service to expose the deployment

   ```
   cat <<EOF | kubectl create -f -
    apiVersion: v1
    kind: Service
    metadata:
      name: simple-nginx
      labels:
        app: nginx
    spec:
      type: LoadBalancer
      ports:
      - port: 80
      selector:
        app: nginx
   EOF
   ```

   

1. List all of the deployed services

   ``` bash
   kubectl get services
   ```

1. Copy the _External-IP_ of the **simple-nginx** service and paste it in your browser to see if the service runs as expected.

   If the external IP is listed as `<pending>` simply re-run the command. It takes time to allocate a public IP address for your workload.

   ![A screenshot showing nginx running, which came from Docker Hub](../media/5-nginx-dockerhub.png)

## Apply Azure Policy to the AKS cluster

You have successfully deployed your workload on a cluster that doesn't have any policy enforcement on it. Now you will add a Policy to the cluster and see how that affects it.

### Assign a Policy

You'd like to ensure that only images from certain registries are allowed in the cluster. You'll need to create a new policy definition and then assign it to a scope; in this case the scope will be our **videogamerg** resource group. Policies can be created and assigned through the Azure portal, Azure PowerShell, or Azure CLI. This exercise takes you through creating a policy in the portal.

Find the built-in policy definitions for managing your cluster using the Azure portal with the following steps. In this case we will be applying the "only allowed images" Policy.

1. Go to the [Policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Overview) page in **Azure Portal**.

1. In the left pane of the Azure Policy page, select Definitions.

1. From the Category dropdown list box, use Select all to clear the filter and then select Kubernetes.

   ![Screenshot showing kubernetes selected for category](../media/5-filtering-for-kubernetes.png)

1. Select the **Kubernetes cluster containers should only use allowed images** Policy definition.

1. Click the **Assign** button.

1. Set the Scope to the resource group of the Kubernetes cluster you just created, which in this case is the **videogamerg** resource group.

   ![Screenshot showing policy assignment view](../media/5-policy-assignment.png)

1. Enter the following into the **Allowed container image regex** field and click the **Review + create** button

   ```
   .+\.azurecr\.io/.+$
   ```

1. Click on the **Create** button

Now that the new Policy has been enabled, you can click on **Assignments** to see the assigned Policy and select the Policy assignment you just created.

![Policy assigned](../media/5-policy-assigned.png)

Your Policy assignment should look like the picture below. Note that effect is set to deny by default. This means that the cluster would not allow resources to be deployed from container registries other than those hosted on Azure Container Registry.

![Policy assigned](../media/5-policy-assignment-details.png)

## Assign a Policy Initiative

Now that you have successfully assigned your policy, you will now assign an initiative before you test the policies. An Azure Policy initiative is a collection of Azure Policy definitions, or rules, that are grouped together towards a specific goal or purpose. Azure initiatives simplify management of your policies by grouping a set of policies together, logically, as a single item.

Initiatives can be assigned the same way policies are assigned. Follow the steps below to assign the  "[Kubernetes cluster pod security restricted standards for Linux-based workloads](/azure/aks/policy-reference#initiatives)" initiative.

1. Return to the [Policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Overview) page in **Azure Portal**.
1. In the left pane of the Azure Policy page, select Definitions.
1. From the Category dropdown list box, use Select all to clear the filter and then select Kubernetes.
1. Select the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative  definition. Take some time to review the various policies that are a part of the initiative.
1. Select the **Assign** button at the top left corner of the screen.
1. Set the Scope to the resource group of the Kubernetes cluster you just created, which in this case is the **videogamerg**. Fill out the rest of the form as you did in the previous step and click **Review + create**.
1. Click the **Create** button.

Here you can find the Policy assignment again by clicking on **Policy** and selecting **Assignments** in the left blade. Clicking on the Policy assignment you just created will show that the effect was set to Audit in this case.

## Test the Azure Policy

Now that you have assigned the restricting Policy to the cluster, you will now run a test to see if the Policy works. To do this, you will create a new deployment and see if the deployment works. We begin by creating a new kubernetes manifest file and deploying it. 
> [!IMPORTANT]
> Please note that the Policy assignments may take up to 30 minutes to take effect. Because of this delay, in the following steps the Policy validation may succeed and the deployment will not fail. If this happens, allow for additional time and retry your deployment.

1. Create another nginx deployment and service using the code below

   ```bash
   cat <<EOF | kubectl create -f -
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: second-simple-nginx
     labels:
       app: second-nginx
   spec:
     selector:
       matchLabels:
         app: second-nginx
     template:
       metadata:
         labels:
           app: second-nginx
       spec:
         containers:
         - name: second-simple-nginx
           image: docker.io/library/nginx:stable
           resources:
             requests:
               cpu: 100m
               memory: 100Mi
             limits:
               cpu: 120m
               memory: 120Mi
           ports:
           - containerPort: 80
   EOF
   ```
   
1. Create the service

   ```
   cat <<EOF | kubectl create -f -
    apiVersion: v1
    kind: Service
    metadata:
      name: second-simple-nginx
      labels:
        app: second-nginx
    spec:
      type: LoadBalancer
      ports:
      - port: 80
      selector:
        app: second-nginx
   EOF
   ```
   
   
   
1. Now we can check to see if the pod was created

   ```bash
   kubectl get pods
   ```

As you can see in the picture below, even though it appeared the deployment was created, the pod was actually not created. The deployment was blocked by the Policy you just created. The pod that was created before the Policy was assigned was however not stopped. The Policy also didn't prevent the service from getting created. If you try opening up the EXTERNAL-IP in a browser, you will get no response which further shows that the deployment was not successful. 

![screenshot showing that the pod was not deployed](../media/5-deployment-not-created.png)



## Diagnose why the Pod was not deployed

In the previous section we noticed that the second pod was not deployed. In this section, we will use the command line to diagnose why.

1. First, let us describe the deployment. We see that the ReplicaSet was created but the replicas failed to create

   ```bash
   kubectl describe deployment second-simple-nginx
   ```

   ![screenshot showing the failed deployment](../media/5-describing-failed-deployment.png)

1. Next we will describe the failed ReplicaSet. Copy the name of the ReplicaSet highlighted in the picture above and replace the placeholder with the copied name. Run the command

   ```bash
   kubectl describe replicaset <ReplicaSet name>
   ```

1. Here you will see that the replicas failed because of the Policy

   ![screenshot showing the reason why the pod failed](../media/5-reason-replicaset-failure.png)

Delete the deployment to prepare for the next step.

```bash
kubectl delete deployment second-simple-nginx
```

## Redeploying the pods using an Azure Container Registry Image

Now that you know that the Policy prevents images from Dockerhub from being created in your cluster based on your Policy, let us try redeploying the same workload using an image from ACR. In this section you will create an Azure Container Registry, copy the nginx image from Dockerhub to the new registry and attempt to redeploy the pod form your container registry. We will use Azure CLI to create the container registry.

1. Head back to **Cloud shell** on Azure Portal and enter the following commands to create a new container registry

   ```azurecli-interactive
   ACR_NAME=videogameacr$RANDOM
   az acr create --name $ACR_NAME \
                 --resource-group videogamerg \
                 --sku Premium
   ```

1. Import the image from Docker Hub to your new container registry

   ```azurecli-interactive
   az acr import --name $ACR_NAME --source docker.io/library/nginx:stable --image nginx:v1
   ```

1. Check to ensure the image was imported. You should see nginx in the list of results

   ```azurecli-interactive
   az acr repository list --name $ACR_NAME
   ```

1. Link your AKS cluster with the container registry you just created

   ```
   az aks update -n videogamecluster -g videogamerg --attach-acr $ACR_NAME
   ```

1. Recreate the deployment now using your newly created container registry by running the command below

   ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: second-simple-nginx
      labels:
        app: second-nginx
    spec:
      selector:
        matchLabels:
          app: second-nginx
      template:
        metadata:
          labels:
            app: second-nginx
        spec:
          containers:
          - name: second-simple-nginx
            image: ${ACR_NAME}.azurecr.io/nginx:v1
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
              limits:
                cpu: 120m
                memory: 120Mi
            ports:
            - containerPort: 80
   EOF
   ```
   
1. Get the **EXTERNAL-IP** so that you can test to see if the service is running in the cluster

   ```bash
   kubectl get pods
   kubectl get services
   ```

   ![screenshot showing that the pods got deployed this time](../media/5-deployed-second-pod.png)

   Copy the external IP address and paste it in the browser and you will see that the page now loads.

   ![Screenshot showing that the pod was now successfully deployed on the web browser](../media/5-second-page-now-loads.png)

   

## Use policies to enforce standards

You've seen how you could use policies to ensure that your cluster only allows Images from Azure Container Registry to be deployed. You also saw how to add one of the build-in initiatives that can help easily govern your cluster and make it more secure. You however saw that the pod that was deployed before the Policy was assigned is still running. In the next unit, we will see how we can check compliance of pods running on the cluster.
