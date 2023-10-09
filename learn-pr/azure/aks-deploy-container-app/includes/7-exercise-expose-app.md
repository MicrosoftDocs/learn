You successfully deployed the video rendering service website to your cluster. But you noticed that you couldn't access the website from any client external to the cluster. The problem is that you haven't exposed your application to the internet yet. By default, Kubernetes blocks all external traffic. You need to add an *ingress rule* to allow traffic into the cluster.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create the service manifest

Like all resources, services also have manifest files that describe how they should behave. Let's create a new service description.

1. Sign in to Azure Cloud Shell if you haven't done so already.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/bash?azure-portal=true)

1. In Cloud Shell, create a manifest file for the Kubernetes service called `service.yaml`.

    ```bash
    touch service.yaml
    ```

1. Open the integrated editor in Cloud Shell by entering `code .`

1. Open the `service.yaml` file, and add the following code section of YAML.

    ```yaml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    ```

    In this code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the service. Use it to identify and query the service information when you use `kubectl`.

1. You define how the service behaves in the specification section of the manifest file. The first behavior you need to add is the type of service. Set the `type` key to `clusterIP`.

    Update the `service.yaml` file to match the following YAML.

    ```yaml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: ClusterIP
    ```

1. You define the pods the service groups and provide coverage by adding a `selector` section to the manifest file. Add the `selector`, and set the `app` key value to the `contoso-website` label of your pods as specified in your earlier deployment's manifest file.

    Update the `service.yaml` file to match the following YAML.

      ```yaml
      #service.yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: contoso-website
      spec:
        type: ClusterIP
        selector:
          app: contoso-website
      ```

1. You define the port-forwarding rules by adding a `ports` section to the manifest file. The service must accept all TCP requests on port 80 and forward the request to the HTTP target port for all pods that match the selector value defined earlier.

    Update the `service.yaml` file to match the following YAML.

    ```yaml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: ClusterIP
      selector:
        app: contoso-website
      ports:
        - port: 80 # SERVICE exposed port
          name: http # SERVICE port name
          protocol: TCP # The protocol the SERVICE will listen to
          targetPort: http # Port to forward to in the POD
    ```

1. Save the manifest file by pressing <kbd>Ctrl-S</kbd>, and close the editor by pressing <kbd>Ctrl-Q</kbd>.

## Deploy the service

1. In Cloud Shell, run the `kubectl apply` command to submit the service manifest to your cluster.

    ```bash
    kubectl apply -f ./service.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    service/contoso-website created
    ```

1. Run the `kubectl get service` command to check if the deployment was successful.

    ```bash
    kubectl get service contoso-website
    ```

    The command should output a result similar to the following example. Make sure the column `CLUSTER-IP` is filled with an IP address and the column `EXTERNAL-IP` is `<none>`. Also, make sure the column `PORT(S)` is defined to `80/TCP`.

    ```output
    NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
    contoso-website   ClusterIP   10.0.158.189   <none>        80/TCP    42s
    ```

    With the external IP set to `<none>`, the application isn't available to external clients. The service is only accessible to the internal cluster.

## Create an ingress manifest

To expose your website to the world via DNS, you must create an ingress controller.

1. In Cloud Shell, create a manifest file for the Kubernetes service called `ingress.yaml`.

    ```bash
    touch ingress.yaml
    ```

1. Open the integrated editor in Cloud Shell by entering `code .`

1. Open the `ingress.yaml` file, and add the following code section of YAML.

    ```yaml
    #ingress.yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
    ```

    In this code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the ingress. Use it to identify and query the ingress information when you use `kubectl`.

1. Create an `annotations` key inside the `metadata` section of the manifest file called to use the :::no-loc text="HTTP application routing"::: add-on for this ingress. Set the key to `kubernetes.io/ingress.class` and a value of `addon-http-application-routing`.

    Update the `ingress.yaml` file to match the following YAML.

    ```yaml
    #ingress.yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    ```

1. Set the fully qualified domain name (FQDN) of the host allowed access to the cluster.

     In Cloud Shell, run the `az network dns zone list` command to query the Azure DNS zone list.

    ```bash
    az aks show \
      -g $RESOURCE_GROUP \
      -n $CLUSTER_NAME \
      -o tsv \
      --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

1. Copy the output, and update the `ingress.yaml` file to match the following YAML. Replace the `<zone-name>` placeholder value with the `ZoneName` value you copied.

    Update the `ingress.yaml` file to match the following YAML.

    ```yaml
    #ingress.yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.<zone-name> # Which host is allowed to enter the cluster
    ```

1. Next up, add the back-end configuration to your ingress rule. Create a key named `http` and allow the `http` protocol to pass through. Then, define the `paths` key that allows you to filter whether this rule applies to all paths of the website or only some of them.

    Update the `ingress.yaml` file to match the following YAML.

    ```yaml
    #ingress.yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.<uuid>.<region>.aksapp.io
          http:
            paths:
              - backend: # How the ingress will handle the requests
                  service:
                   name: contoso-website # Which service the request will be forwarded to
                   port:
                     name: http # Which port in that service
                path: / # Which path is this rule referring to
                pathType: Prefix # See more at https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types
    ```

1. Save the manifest file by pressing <kbd>Ctrl-S</kbd>, and close the editor by pressing <kbd>Ctrl-Q</kbd>.

## Deploy the ingress

Now we need to deploy the service for our changes to take effect.

1. In Cloud Shell, run the `kubectl apply` command to submit the ingress manifest to your cluster.

    ```bash
    kubectl apply -f ./ingress.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    ingress.extensions/contoso-website created
    ```

1. Run the ` kubectl get ingress` command to check if the deployment was successful.

    ```bash
    kubectl get ingress contoso-website
    ```

    The command should output a result similar to the following example.

    ```output
    NAME              HOSTS                                           ADDRESS        PORTS   AGE
    contoso-website   contoso.5cd29ec927f24764b052.eastus.aksapp.io   52.226.96.30   80      4m44s
    ```

    Make sure the `ADDRESS` column of the output is filled with an IP address. That's the address of your cluster.

    > [!NOTE]
    > There can be a delay between the creation of the ingress and the creation of the zone record. It can take up to five minutes for zone records to propagate.

1. Open your browser, and go to the FQDN described in the output. You should see a website that looks like the following example screenshot.

:::image type="content" source="../media/7-website-success.png" alt-text="Screenshot of the Contoso video rendering service website.":::