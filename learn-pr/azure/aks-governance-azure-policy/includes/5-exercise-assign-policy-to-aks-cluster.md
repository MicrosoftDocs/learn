You are now ready to configure Azure policies and initiatives for your AKS cluster. 

In this unit you'll deploy a non-compliant pod, apply the azure policies including the use of only trusted registries, deploy a non compliant pod to see the effect of the policy and troubleshoot steps to see why the pods are not being created. 

## Deploy a non-compliant pod into the cluster

We begin by deploying an image from dockerhub.com into the cluster. To do that we begin by logging into the cluster.

1. In Cloud Shell, log into the AKS cluster

   ```Azure CLI
   az aks get-credentials -n videogamecluster -g videogamerg
   ```

2. Create a kuberentes manifest file that file that will be used to deploy the pods into the cluster

   ```
   code nginxfromdocker.yaml
   ```

3. Enter the following yaml code into the newly created file and save it by typing ctrl+s

   ```yaml
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
           image: nginx
           resources:
             requests:
               cpu: 100m
               memory: 100Mi
             limits:
               cpu: 120m
               memory: 120Mi
           ports:
           - containerPort: 80
   ---
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
   ```

4. Deploy the nginx pod and service

   ```
   kubectl apply -f nginxfromdocker.yaml
   ```

5. Get the public IP address of the LoadBalancer service

   ``` bash
   kubectl get services
   ```

6. Copy the External-IP of the service and paste it in your browser to see if the service runs as expected

   ![nginx using dockerhub before application of the policy ](../media/5-nginx-dockerhub.png)

## Add Azure Policy to the AKS cluster
You have successfully deployed your workload on a cluster that doesn't have any policy enforcement on it. Now you will add a policy to the cluster and see how that affects it.

## What is Azure Policy?

Azure Policy is a service you can use to create, assign, and manage policies. These policies apply and enforce rules that your resources need to follow. These policies can enforce these rules when resources are created, and can be evaluated against existing resources to give visibility into compliance.

Policies can enforce things such as only allowing specific types of resources to be created, or only allowing resources in specific Azure regions. You can enforce naming conventions across your Azure environment. You can also enforce that specific tags are applied to resources. You'll take a look at how policies work.

## Create a policy

You'd like to ensure that all resources have the **Department** tag associated with them and block creation if it doesn't exist. You'll need to create a new policy definition and then assign it to a scope; in this case the scope will be our **videogamerg** resource group. Policies can be created and assigned through the Azure portal, Azure PowerShell, or Azure CLI. This exercise takes you through creating a policy in the portal.

Find the built-in policy definitions for managing your cluster using the Azure portal with the following steps. In this case we will be applying the "only trusted registry" policy.

1. Start the Azure Policy service in the Azure portal. Select All services in the left pane and then search for and select Policy.

1. In the left pane of the Azure Policy page, select Definitions.

1. From the Category dropdown list box, use Select all to clear the filter and then select Kubernetes.

1. Select the **Kubernetes cluster containers should only use allowed images** policy definition, then select the Assign button at the top left corner of the screen.

1. Set the Scope to the resource group of the Kubernetes cluster you just created, in this case, the **videogamerg** resource group and fill out the rest of the form as seen in the picture below and click **Next**.

   ![policy assigmnet](../media/5-policy-assignment.png)

1. Enter the following into the **Allowed container image regex** field and click the **Review + create** button

   ```
   .+azurecr.io/.+$
   ```

1. Click on the **Create** button

Now that the new policy has been enabled, you can click on **Assignments** to see the assigned policy and select the policy assignment you just created.

![Policy assigned](../media/5-policy-assigned.png)

Your policy assignment should look like the picture below. Note that effect is set to deny by default. This means that the cluster would not allow resources to be deployed from container registries other than those hosted on Azure Container Registry.

![Policy assigned](../media/5-policy-assignment-details.png)

## Test the Azure Policy

Now that you have assigned the restricting policy to the cluster, you will now run a test to see if the policy works. To do this, we will create a new deployment and see if the deployment works. We begin by creating a new kubernetes manifest file and deploying it. 
> [!IMPORTANT]
> Please note that the policy assignment may take up to 30 minutes to take effect. Because of this delay, in the following steps the policy validation may succeed but the deployment will still fail. If this happens, allow for additional time and retry your deployment.

1. Open a new file in your code editor

   ```bash
   code secondnginxfromdocker.yaml
   ```

2. Copy the following code into the new file and save it by typing *ctrl + s*

   ```yaml
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
           image: nginx
           resources:
             requests:
               cpu: 100m
               memory: 100Mi
             limits:
               cpu: 120m
               memory: 120Mi
           ports:
           - containerPort: 80
   ---
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
   ```

3. Close the code editor after saving it by entering *ctrl + q*

4. Deploy the new service and deployment by entering the following in the command line

   ```
   kubectl apply -f secondnginxfromdocker.yaml
   ```

5. Now we can check to see if the pod and service was created

   ```
   kubectl get pods
   kubectl get svc
   ```

As you can see in the picture below, even though it appeared the deployment was created, the pod was actually not created. The deployment was blocked by the policy you just created. The pod that was created before the policy was assigned was however not stopped. The policy also didn't prevent the service from getting created. If you try opening up the EXTERNAL-IP in a browser, you will get no response which further shows that the deployment was not successful. 

![Pod not deployed](../media/5-deployment-not-created.png)

Delete the deployment to prepare for the next step.

```
kubectl delete -f secondnginxfromdocker.yaml
```

## Assign a Policy Initiative

Now that you have successfully assigned your policy, you will now assign an initiative. An Azure Policy initiative is a collection of Azure Policy definitions, or rules, that are grouped together towards a specific goal or purpose. Azure initiatives simplify management of your policies by grouping a set of policies together, logically, as a single item.

Initiatives can be assigned the same way policies are assigned. Follow the steps below to assign the  "[Kubernetes cluster pod security restricted standards for Linux-based workloads](https://docs.microsoft.com/azure/aks/policy-reference#initiatives)" initiative.

1. Start the Azure Policy service in the Azure portal. Select All services in the left pane and then search for and select Policy.
1. In the left pane of the Azure Policy page, select Definitions.
1. From the Category dropdown list box, use Select all to clear the filter and then select Kubernetes.
1. Select the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative  definition. Take some time to review the various policies that are a part of the initiative.
1. Select the **Assign** button at the top left corner of the screen.
1. Set the Scope to the resource group of the Kubernetes cluster you just created, in this case, the **videogamerg** resource group and fill out the rest of the form as seen in the picture below and click **Next** to move on to the Parameters section
1. Click **Next** again to move on to the **Remediation** tab. Ensure **Create a Managed Identity** is not checked and click next again
1. Here you have the chance to add Non-compliance messages. You can add these messages to each policy by clicking on the ellipses next to each one and then selecting **Edit message**
1. Click **Next** then click **Create** at the bottom

Here you can find the policy assignment again by going to back to **Policy** and selecting **Assignments** in the left blade. Clicking on the policy assignment you just created will show that the effect was set to Audit in this case.

## Redeploying the pods using an Azure Container Registry Image

Now that you know that the policy prevents images from Dockerhub from being created in your cluster based on your policy, let us try redeploying the same workload using an image from ACR. In this section you will create an Azure Container Registry, copy the nginx image from Dockerhub to the new registry and attempt to redeploy the pod form your container registry. We will use Azure CLI to create the container registry.

1. Head back to **Cloud shell** on Azure Portal and enter the following command to create a new container registry. 

   ```bash
   ACR_NAME=videogameacr$RANDOM
   az acr create --name $ACR_NAME \
                 --resource-group videogamerg \
                 --sku Premium \
                 --default-action Allow
   ```

2. Import the image from Dockerhub to your new container registry

   ```bash
   az acr import --name $ACR_NAME --source docker.io/library/nginx:latest --image nginx:v1
   ```

3. After the command runs check to ensure the image was imported. You should see nginx in the list of results

   ```bash
   az acr repository list --name $ACR_NAME
   ```

4. Get the name of the container registry. You will need it to modify the manifest file to redeploy the pods

   ```bash
   echo $ACR_NAME
   ```

5. Modify the image parameter for your *secondnginxfromdocker.yaml* file so that it now points to your container registry. Change the *image: nginx*  in line 18 to *image: <acr name>.azurecr.io/nginx*. 

   ```bash
   code secondnginxfromdocker.yaml
   ```

   Your updated file should look like below. Save the file by typing *Ctrl+S* and close the editor by typing *Ctrl+Q*

   ```yaml
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
           image: <acr name>.azurecr.io/nginx:v1
           resources:
             requests:
               cpu: 100m
               memory: 100Mi
             limits:
               cpu: 120m
               memory: 120Mi
           ports:
           - containerPort: 80
   ---
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
   ```

6. Apply the deployment again and you will see that the new pod is now running

   ```bash
   kubectl apply -f secondnginxfromdocker.yaml
   ```

7. Get the **EXTERNAL-IP** so that you can test to see if the service is running in the cluster

   ```bash
   kubectl get pods
   kubectl get services
   ```

   ![second pod deployed](../media/5-deployed-second-pod.png)

   You can also copy the external IP address and paste it in the browser and you will see that the page now loads

   ![second pod deployed](../media/5-second-page-now-loads.png)

   

## Use policies to enforce standards

You've seen how you could use policies to ensure that your cluster only allows Images from Azure Container Registry to be deployed. You also saw how to add one of the build-in initiatives that can help easily govern your cluster and make it more secure. You however saw that the pod that was deployed before the policy was assigned is still running. In the next unit, we will see how we can check compliance of pods running on the cluster.