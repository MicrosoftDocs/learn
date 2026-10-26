You're now ready to configure Azure policies and initiatives for your Azure Kubernetes Service (AKS) cluster. 

In this unit, you deploy a noncompliant pod and apply an Azure policy that enforces the use of only trusted registries. Then, you deploy another noncompliant pod to see the effect of the policy. You learn the steps to troubleshoot and see why the pods aren't being created. You also deploy the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative.

## Deploy a noncompliant pod into the cluster

We begin by deploying an image directly from Docker Hub into the cluster. Follow these steps to connect to the cluster and deploy the workload:

1. In Cloud Shell Bash, retrieve the lab cluster's credentials. If the session restarted, select the lab subscription again before running this command.

   ```azurecli
   az aks get-credentials -n videogamecluster -g videogamerg 
   ```

1. Confirm that the current context is the lab cluster before continuing.

   ```bash
   kubectl config current-context
   ```

1. Set the application namespace to `default` and confirm that the cluster's nodes are Ready.

   ```bash
   kubectl config set-context --current --namespace default
   kubectl get nodes
   ```

   Don't run the deployment or deletion examples against another cluster context.

1. Run the following code to create a **simple-nginx** pod from Docker Hub.

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

1. Run the following code to deploy the service to expose the deployment.

   ```bash
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

1. List all of the deployed services.

   ``` bash
   kubectl get services
   ```

1. Copy the *External-IP* of the **simple-nginx** service and paste it in your browser to see if the service runs as expected.

   If the external IP is listed as `<pending>`, rerun the command. It takes time to allocate a public IP address for your workload.

   :::image type="content" source="../media/5-nginx-dockerhub.png" alt-text="Screenshot of the nginx welcome page served by the original pod using an image from Docker Hub." lightbox="../media/5-nginx-dockerhub.png":::

## Apply Azure Policy to the AKS cluster

You deployed the original workload before assigning this exercise's allowed-images policy. Now you can add that policy and see how it affects new Pods. Any inherited organizational policies still apply.

### Create the approved container registry

Create the Azure Container Registry (ACR) before assigning the policy so that you can allow its exact login server.

1. Create a registry with a globally unique name. This exercise uses RBAC mode so that the later `--attach-acr` command can grant registry pull access.

   ```azurecli
   ACR_NAME="videogameacr$(printf '%05d%05d' "$RANDOM" "$RANDOM")"
   az acr create \
     --name "$ACR_NAME" \
     --resource-group videogamerg \
     --sku Premium \
     --role-assignment-mode rbac
   ```

   Confirm that creation succeeds before continuing. If the generated name is unavailable, choose another globally unique name and repeat creation. Premium is supported, but this image-import exercise doesn't require Premium-specific features.

1. Query the registry's actual login server and print the regex for the policy assignment.

   ```bash
   ACR_LOGIN_SERVER=$(az acr show \
     --name "$ACR_NAME" \
     --resource-group videogamerg \
     --query loginServer \
     --output tsv)
   printf 'Approved registry: %s\n' "$ACR_LOGIN_SERVER"
   printf 'Allowed image regex: ^%s/.+$\n' "${ACR_LOGIN_SERVER//./\\.}"
   ```

   Verify that the lookup succeeds and prints a nonempty hostname. Don't continue with an empty or incorrect hostname. For example, if the login server is `videogameacr123.azurecr.io`, the regex is `^videogameacr123\.azurecr\.io/.+$`. Use your returned hostname, not this example value. The start anchor, escaped dots, and slash restrict the match to that registry's hostname rather than a similar string in a repository path.

Run the remaining steps in the same Bash session. Record the created registry name. After a restart, restore `ACR_NAME` to that existing name and rerun the login-server lookup; don't generate a different registry name or create another registry. The login server can differ from the registry resource name; see Create an ACR using Azure CLI.

### Assign a policy

Select the existing **Kubernetes cluster containers should only use allowed images** built-in definition and create an assignment at the `videogamerg` resource-group scope. Configure that assignment's parameters to identify the approved registry. This exercise creates an assignment, not a custom policy definition.

Find the built-in policy definitions for managing your cluster using the Azure portal with the following steps. In this case, you're applying the "only allowed images" policy.

1. Go to the **Policy** page in the Azure portal.

1. In the left pane of the Azure Policy page, select **Definitions**.

1. From the **Category** dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**.

   :::image type="content" source="../media/5-filtering-for-kubernetes.png" alt-text="Screenshot of Azure Policy definitions with Kubernetes selected in the Category filter." lightbox="../media/5-filtering-for-kubernetes.png":::

1. Select the **Kubernetes cluster containers should only use allowed images** policy definition.

1. Select the **Assign** button.

1. Set the **Scope** to the resource group of the Kubernetes cluster you created, which in this case is the **videogamerg** resource group. Set **Policy enforcement** to **Enabled**.

   :::image type="content" source="../media/5-policy-assignment.png" alt-text="Screenshot of the Azure Policy assignment form with enforcement enabled and the Next button highlighted." lightbox="../media/5-policy-assignment.png":::

1. Open **Parameters** and set **Effect** to **Deny**. Paste the printed regex into **Allowed registry or registries regex**, whose parameter ID is `allowedContainerImagesRegex`.
1. Leave **Source** as **Original** so that this exercise evaluates Pod admission. Retain the system-namespace exclusions. Ensure that the `default` namespace and the example containers aren't excluded.
1. Select **Review + create**, review the values, and select **Create**.

Select **Assignments**, then select the assignment you created. Record its assignment ID so that you can identify the matching constraint later.

:::image type="content" source="../media/5-policy-assigned.png" alt-text="Screenshot of the Azure Policy Assignments page with the allowed-images assignment highlighted." lightbox="../media/5-policy-assigned.png":::

Verify the following settings rather than relying on a sample screenshot's registry value:

| Setting | Expected value |
| --- | --- |
| Scope | The lab cluster's resource group |
| Policy enforcement | Enabled |
| Effect | Deny |
| Source | Original |
| `allowedContainerImagesRegex` | The start-anchored regex printed for your actual registry login server |
| Namespace and container exclusions | Retain system exclusions; don't exclude `default` or the example containers |

> [!IMPORTANT]
> This allowlist permits image references from the selected registry for in-scope Pods. It doesn't inspect image contents, verify signatures, or establish that every image in that registry is safe. Only import approved images. System namespaces and any configured namespace, label, or container exclusions are outside the corresponding policy evaluation.

## Assign a policy initiative

Now that your policy is successfully assigned, you assign an initiative before you test the policies. An Azure Policy initiative is a collection of Azure Policy definitions, or rules, that are grouped together toward a specific goal or purpose. Azure initiatives simplify management of your policies by grouping a set of policies together, logically, as a single item.

Initiatives can be assigned the same way policies are assigned. Follow these steps to assign the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative:

1. Return to the **Policy** page in the Azure portal.
1. In the left pane of the Azure Policy page, select **Definitions**.
1. From the **Category** dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**.
1. Select the **Kubernetes cluster pod security restricted standards for Linux-based workloads** initiative definition. Take some time to review the various policies that are a part of the initiative.
1. Select the **Assign** button at the top-left corner of the screen.
1. Set the **Scope** to the `videogamerg` resource group. On **Parameters**, explicitly select **Audit** for **Effect** and retain the system-namespace exclusions. Don't copy the allowed-images assignment's Deny effect to this initiative.
1. Select **Review + create**.
1. Select the **Create** button.

Return to **Policy** > **Assignments** and confirm that the initiative's effect is **Audit**. The nginx example isn't hardened to meet all the restricted initiative's requirements; audit reports these violations without preventing the later registry-compliant Pod from being created.

## Test the Azure Policy

Before creating the second Deployment, verify that the intended assignment is enforcing the allowed-images rule.

> [!IMPORTANT]
> Assignment synchronization is asynchronous. Wait until the intended constraint is present and the server-side admission probe is denied by the allowed-images rule before running the second Deployment test. Waiting doesn't remove Pods admitted before enforcement started.

Azure Policy installs a constraint template and a parameterized constraint. A template alone doesn't prove that this assignment is enforcing the intended rule. For the current allowed-images built-in definition, version 9.3.0, the template name is `k8sazurev2containerallowedimages`.

```bash
kubectl get constrainttemplates
kubectl get constrainttemplate k8sazurev2containerallowedimages -o yaml
kubectl get k8sazurev2containerallowedimages -o yaml
```

Check the template's definition annotation and find the constraint whose `azure-policy-assignment-id` annotation matches the assignment ID you recorded. The expected definition ID ends in `febd0533-8e55-448f-b837-bd0e06f16469`. Confirm the constraint's `imageRegex`, namespace matching, container exclusions, and deny enforcement.

If your selected built-in definition references a different template, inspect its `templateInfo` and use the actual installed template name rather than assuming a name from sample output. Make changes through the Azure Policy assignment, not directly to add-on-managed templates or constraints. See the allowed-images policy definition and View Gatekeeper artifacts references in the summary unit's **More info** section.

Run a nonpersistent admission probe:

```bash
kubectl run policy-image-probe \
  --namespace default \
  --image=docker.io/library/nginx:stable \
  --restart=Never \
  --dry-run=server \
  -o yaml
```

The expected result is an admission denial identifying the allowed-images constraint. Server-side dry run sends the request through admission without persisting the Pod. Don't use `--dry-run=client`, which doesn't exercise server admission.

If the command returns Pod YAML, enforcement hasn't been demonstrated: check assignment synchronization, the effect, enforcement mode, and exclusions before continuing. A denial from another policy isn't proof that the allowed-images assignment is working.

### Create the second test workload

If an earlier attempt already created the second test workload, remove only those test objects before rerunning their creation steps. These commands tolerate names that don't exist. Don't remove `simple-nginx`, which is needed for the compliance exercise.

```bash
kubectl delete deployment second-simple-nginx \
  --namespace default --ignore-not-found=true --wait=true
kubectl delete service second-simple-nginx \
  --namespace default --ignore-not-found=true
```

Create the second workload and inspect its Pods:

1. Create another `nginx` deployment and service using the following code.

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

1. Create the service.

   ```bash
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

1. Now we can check to see if the pod is created.

   ```bash
   kubectl get pods
   ```

With this policy's **Original** source and Pod targeting, the Deployment, ReplicaSet, and Service can be created, but the ReplicaSet's requests to create noncompliant Pods are denied. Confirm the reason in the ReplicaSet's events in the next section. The first workload remains running because the assignment doesn't evict existing Pods. The second Service has no ready backend Pods; a browser failure alone isn't proof of policy enforcement.

```output
NAME                            READY   STATUS    RESTARTS   AGE
simple-nginx-66d884c498-msbpc   1/1     Running   0          63m
```

## Diagnose why the pod wasn't deployed

In the previous section, we noticed that the second pod wasn't deployed. In this section, we use the command line to diagnose why.

1. List the ReplicaSets. The second Deployment's ReplicaSet exists, but its Pods weren't created.

   ```bash
   kubectl get replicasets
   ```

   You should get an output similar to the following example:

   ```output
   NAME                             DESIRED   CURRENT   READY   AGE
   second-simple-nginx-64969b4566   1         0         0       8m45s
   simple-nginx-66d884c498          1         1         1       72m
   ```

1. Describe the failed ReplicaSet. Copy the name that starts with `second-simple-nginx`, replace `<replicaset-name>` with that value without the angle brackets, and run the command.

   ```bash
   kubectl describe replicaset "<replicaset-name>" --namespace default
   ```

1. Confirm that the events identify the allowed-images policy as the cause of failed Pod creation. The generated constraint name and exact message can differ from this example.

   ```output
   Warning  FailedCreate  3m9s (x18 over 14m)  replicaset-controller  Error creating: admission webhook "validation.gatekeeper.sh" denied the request: [azurepolicy-container-allowed-images-bcfbd5e1e78f7c8b4104] Container image docker.io/library/nginx:stable for container second-simple-nginx has not been allowed.
   ```

Delete only the second Deployment to prepare for the next step. Keep its Service for the ACR-backed Deployment; don't repeat the Service creation command later.

```bash
kubectl delete deployment second-simple-nginx --namespace default --wait=true
```

## Redeploying the pods using an Azure Container Registry image

The policy rejects new Pod image references from Docker Hub. Now import the nginx image into the approved ACR you already created, authorize the kubelet identity to pull it, and redeploy using that registry's login server.

If your Bash session restarted, select the lab subscription, retrieve the cluster credentials, confirm the context and `default` namespace, restore `ACR_NAME` to the existing registry's name, and query `ACR_LOGIN_SERVER` again. Don't create a new registry at this point.

Import the image and redeploy the workload:

1. Import the image from Docker Hub to your new container registry.

   ```azurecli
   az acr import \
     --name "$ACR_NAME" \
     --source docker.io/library/nginx:stable \
     --image nginx:v1
   ```

   If import fails because of Docker Hub authentication or rate limits, follow Import container images from Docker Hub in the summary unit's **More info** section. Don't continue until the image is available.

1. Check to ensure the image was imported. You should see nginx in the list of results.

   ```azurecli
   az acr repository list --name "$ACR_NAME"
   ```

1. Link your AKS cluster with the container registry you created.

   ```azurecli
   az aks update \
     --name videogamecluster \
     --resource-group videogamerg \
     --attach-acr "$ACR_NAME"
   ```

   This exercise uses an RBAC-mode registry. For an existing ABAC-enabled registry, `--attach-acr` isn't supported; follow the AKS-ACR integration guidance to grant the kubelet identity the appropriate repository-reader role instead. That's an alternative authorization path, not an additional step for this newly created RBAC registry.

1. Now create the deployment using your newly created container registry by running the following command.

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
            image: ${ACR_LOGIN_SERVER}/nginx:v1
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

   Keep the `EOF` delimiter unquoted so that Bash expands `ACR_LOGIN_SERVER` in the manifest.

1. Wait for the Deployment to become available, then get the **EXTERNAL-IP** of the existing `second-simple-nginx` Service.

   ```bash
   kubectl rollout status deployment/second-simple-nginx \
     --namespace default --timeout=180s
   kubectl get pods --namespace default
   kubectl get services --namespace default
   ```

   If the rollout times out, inspect the cause rather than assuming success. If no Pod exists, inspect ReplicaSet admission events. If a Pod exists but reports `ImagePullBackOff`, inspect its events and registry authorization or image availability; that isn't proof of policy denial.

   :::image type="content" source="../media/5-deployed-second-pod.png" alt-text="Screenshot of Cloud Shell showing both nginx pods running and their LoadBalancer services with external IP addresses." lightbox="../media/5-deployed-second-pod.png":::

   After the Deployment is ready, copy the external IP address and open it over HTTP in the browser. The page should now load.

   :::image type="content" source="../media/5-second-page-now-loads.png" alt-text="Screenshot of the nginx welcome page served by the pod deployed from the approved Azure container registry." lightbox="../media/5-second-page-now-loads.png":::

## Use policies to enforce standards

In this unit, you assigned a policy that restricts in-scope Pod image references to the approved registry, verified admission denial, and deployed an image from that registry after granting pull access. You also assigned the restricted initiative in Audit mode. The Pod created before the allowed-images assignment still runs. In the next unit, you check the compliance of Pods running on the cluster.
