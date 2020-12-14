Helm charts make it easy to install pre-configured cloud-native apps on a Kubernetes cluster. The DevOps team is already familiar with the installation steps to install apps using manifest files and kubectl. The team decides to install an ASP.NET Core Helm chart to test the Helm installation process.

In this exercise, you'll add a Helm repository to your Helm client and install an ASP.NET Core website onto your Azure Kubernetes Service cluster.

## Fetch a Helm chart

1. In the Azure Cloud Shell, add the Azure Marketplace Helm repository to the Helm client. This repository gives you access to a number pre-configured Helm charts.

    ```bash
    helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
    ```

    Run the helm repo list command to confirm the newly added repository.

    ```bash
    helm repo list
    ```

    The command should return a result similar to the following output.

    ```output
    NAME             	URL
    azure-marketplace	https://marketplace.azurecr.io/helm/v1/repo
    ```

1. Run the helm search repo command to search for the azure-marketplace/aspnet-core chart.

    ```bash
    helm search repo aspnet
    ```

    Here is an example of what the listing may look like.

    ```output
    NAME                         	CHART VERSION	APP VERSION	DESCRIPTION
    azure-marketplace/aspnet-core	0.2.0        	3.1.7      	ASP.NET Core is an open-source framework create...
    ```

## Deploy a Helm chart

1. Deploy the ASP.NET Core Helm chart by using the `helm install` command.

    ```bash
    helm install aspnet-webapp azure-marketplace/aspnet-core
    ```

    The command should return a result similar to the following output.

    ```output
    NAME: aspnet-webapp
    LAST DEPLOYED: Wed Sep  2 07:58:36 2020
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    ** Please be patient while the chart is being deployed **
    
    ASP.NET Core can be accessed through the following DNS name from within your cluster:
    
        aspnet-webapp-aspnet-core.default.svc.cluster.local (port 80)
    
    To access ASP.NET Core from outside the cluster execute the following commands:
    
    1. Get the ASP.NET Core URL by running these commands:
    
        export SERVICE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].port}" services aspnet-webapp-aspnet-core)
        kubectl port-forward --namespace default svc/aspnet-webapp-aspnet-core ${SERVICE_PORT}:${SERVICE_PORT} &
        echo "http://127.0.0.1:${SERVICE_PORT}"
    
    2. Access ASP.NET Core using the obtained URL.
    ```
    The above output is generated from the `templates/Notes.txt` file. The information displayed from the `Notes.txt` file is generated based on a template define in the file and values from the `values.yaml` file. 

    For example, notice how the name of the chart, `aspnet-webapp`, is used to create the DNS name, `aspnet-webapp-aspnet-core.default.svc.cluster.local`, for the web app. You'll also notice the notes displays information to access the app via a service. The default release doesn't include an Ingress as part of the install.

1. Helm allows you to query all the installed release on the cluster. Use the `helm list` command to list all Helm releases.

    ```bash
    helm list
    ```

    The command should return a result similar to the following output.

    ```bash
    NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
    aspnet-webapp   default         1               2020-09-02 07:58:36.017759374 +0000 UTC deployed        aspnet-core-0.2.0       3.1.7
    ```

    Notice the name of the release and its revision number. The name of the release is import, as you'll use the name to reference the release. The revision number increments each time you make a change to a release. In the next exercise, you'll see how the revision number is used to manage upgrades and rollbacks for a release.

1. Helm allows you to fetch manifest information related to each release by using the `helm get manifest` command.

    Use the `helm get manifest aspnet-webapp` command to get the manifest files for the release.

    ```bash
    helm get manifest aspnet-webapp
    ```

    The command should return a result similar to the following output. Here, the output is shortened for brevity.

    ```output
    ---
    # Source: aspnet-core/templates/serviceaccount.yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: aspnet-webapp-aspnet-core
    ...
    ---
    # Source: aspnet-core/templates/svc.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: aspnet-webapp-aspnet-core
    ...
    ---
    # Source: aspnet-core/templates/deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: aspnet-webapp-aspnet-core
    ...
    ```

    Notice the three YAML files from the templates folder in the chart.

    - ServiceAccount
    - Service
    - Deployment

    These files are rendered based on the combination of the chart's available templates and the values available in the `values.yaml` file. In the next exercise, you'll see how to generate an Ingress manifest to allow users from the internet access to the web app.

1. Validate that the pod is deployed by running by using the `kubectl get pods` command.

    ```bash
    kubectl get pods -o wide
    ```

    The command should return a result similar to the following output. Use `Ctrl+c` to exit the command once done.

    ```output
    NAME                                         READY   STATUS    RESTARTS   AGE     IP            NODE                                NOMINATED NODE   READINESS GATES
    aspnet-webapp-aspnet-core-7cb658b89d-9fxwj   1/1     Running   0          5m16s   10.244.0.10   aks-nodepool1-41833800-vmss000000   <none>           <none>
    ```

## Delete a Helm release

1. Delete the Helm release by using the helm delete command.

    ```bash
    helm delete aspnet-webapp
    ```

    The command should return a result similar to the following output.

    ```output
    release "aspnet-webapp" uninstalled
    ```

## Install a Helm chart with set values

You may override values for a Helm chart by passing either a value parameter or your own `values.yaml` file. 

1. For now, use the following command to see how to update a value using the `--set` parameter. You'll use a values file in the next exercise.

    Run the `helm install` with the `--set` parameter to set the `replicaCount` of the deployment template to five replicas.

    ``` bash
    helm install --set replicaCount=5 aspnet-webapp azure-marketplace/aspnet-core
    ```

    Validate that five pod replicas are deployed by running the kubectl get pods command.

    ```bash
    kubectl get pods -o wide -w
    ```

    The command should return a result similar to the following output. Use `Ctrl+c` to exit the command once done.

    ```output
    NAME                                         READY   STATUS     RESTARTS   AGE   IP            NODE                                NOMINATED NODE   READINESS GATES
    aspnet-webapp-aspnet-core-7cb658b89d-2q96n   0/1     Init:0/2   0          14s   10.244.0.14   aks-nodepool1-41833800-vmss000000   <none>           <none>
    aspnet-webapp-aspnet-core-7cb658b89d-469f2   0/1     Init:0/2   0          14s   10.244.0.15   aks-nodepool1-41833800-vmss000000   <none>           <none>
    aspnet-webapp-aspnet-core-7cb658b89d-bl9lc   0/1     Init:0/2   0          14s   10.244.0.12   aks-nodepool1-41833800-vmss000000   <none>           <none>
    aspnet-webapp-aspnet-core-7cb658b89d-tlv7r   0/1     Init:0/2   0          14s   10.244.0.13   aks-nodepool1-41833800-vmss000000   <none>           <none>
    aspnet-webapp-aspnet-core-7cb658b89d-zgsdp   0/1     Init:0/2   0          14s   10.244.0.16   aks-nodepool1-41833800-vmss000000   <none>           <none>
    ```

1. Delete the Helm chart by using the `helm delete` command. This command will delete the release and all replicas of the workload.

    ```bash
    helm delete aspnet-webapp
    ```
