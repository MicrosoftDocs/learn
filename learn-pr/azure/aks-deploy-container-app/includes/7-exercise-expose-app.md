[//]: # (Here you want to lead the unit with your example of deploying the custom website. This is a continuation.)

[//]: # (You're touching on a number of new concepts in the exercise. For example, "annotations" and the whole "rules" structure for deploying ingress. Remember that you've only discussed the structure of a deployment manifest file, Service and Ingress are completely new.)

Next, let's expose Contoso's website to the world.

## Create the service manifest

Like all resources, services also have manifest files describing how they should behave. Let's create our service description.

> [!NOTE]
> You can check the example service file in the [official repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/blob/master/kubernetes/service.yaml)

1. Create a new `service.yaml` file
1. Like the :::no-loc text="deployment":::, the first two steps in creating a manifest file is defining the `apiVersion` and the `kind` keys

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    ```

1. We also define the name through the `metadata.name` key

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    ```

1. In the `spec` key, we'll define how the service will behave

    The first behavior we need to add is the type of service it's going to be. We'll create a `clusterIP` service:

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: clusterIP
    ```

    Then, we'll define which pods this service will wrap and provide coverage to. We can do that by the same `selector` key as the :::no-loc text="deployment":::, but now we can only match labels, so it's simpler:

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: clusterIP
      selector:
        app: contoso-website
    ```

    We're telling the service to wrap all apps with the label `app` set to `contoso-website`.

    Next up, we need to define the port-forwarding rules. We exposed port 80 on our :::no-loc text="deployment"::: and called that port `http`. Let's make all requests that come to this service on port 80 be redirected to the same 80 port on the deployment via the `spec.ports` key:

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: clusterIP
      selector:
        app: contoso-website
      ports:
        - port: 80 # SERVICE exposed port
          name: http # SERVICE port name
          protocol: TCP # The protocol the SERVICE will listen to
          targetPort: http # Port to forward to in the POD
    ```

    The configuration follows the phrase: "Take all requests that arrive on `spec.ports[0].port` via the `spec.ports[0].protocol` protocol, named as `spec.ports[0].name`, and redirect to the port `spec.ports[0].targetPort` in the pod.

Save your manifest file.

## Deploy the service

To deploy the service, we need to follow the same steps as the :::no-loc text="deployment":::.

1. Open a terminal in the same directory as the file
1. Run the following command:

    ```bash
    kubectl apply -f ./service.yaml
    ```

1. Check if the service has been deployed by running the command:

    ```bash
    kubectl get svc contoso-website
    ```

    The command output should be a table with some service data. Make sure the column `CLUSTER-IP` is filled with an IP address and the column `EXTERNAL-IP` is `<none>`. Also make sure the column `PORT(S)` is defined to `80/TCP`.

As you'll notice, there's no exposing to the Internet yet. The service is only accessible to the Internal cluster, so we need to create our Ingress manifest and deploy it

## Create an Ingress manifest

To expose our website to the world via DNS, we need a new file called, which will contain the definition of our ingress resource.

> [!NOTE]
> You can check the example service file in the [official repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/blob/master/kubernetes/ingress.yaml)

1. Create a new file called `ingress.yaml` and open a terminal in the same directory.
1. Like the others, the first two steps in creating a manifest file are defining the `apiVersion` and the `kind` keys

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    ```

1. We also define the name through the `metadata.name` key

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
    ```

1. To tell the :::no-loc text="HTTP Application Routing"::: addon to listen to this ingress, we need to create another key inside `metadata` called `annotations`. Annotations are like internal labels that Kubernetes plugins or addons uses to identify resources. The annotation we want to create is `kubernetes.io/ingress.class` with a value of `addon-http-application-routing`.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    ```

1. Now, we move over to the specification on the `spec` key

    The first specification we need to write is the DNS allowed to access the cluster. In other words, the domain name our site will have.

    Since we're using the HTTP Application Routing addon, our domain name will be something like `contoso.<uuid>.<region>.aksapp.io`. To get this information, let's query Azure to list all DNS zones we have via terminal:

    ```bash
    az network dns zone list --output table
    ```

    The command will output a table containing a column named `ZoneName`. Copy this value. Now create a `spec` key in the same indentation level as `metadata`:

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
    ```

    Inside this `spec` there will be all the ingress rules of our cluster, so create a new array key named `rules` inside `spec`. Create a new key named `host` inside rules, this key will have the DNS zone we copied.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.<uuid>.<region>.aksapp.io # Which host is allowed to enter the cluster
    ```

    Now our ingress will allow any requests from that host to enter the cluster.

1. Next up, let's add the backend configuration that will tell our rule where it should forward the traffic to

    Inside `rules`, in the same object as `host`, we'll create a key named `http`. This states we'll allow the `http` protocol to pass through. Inside the  key, we'll define the `paths` key that will allow us to filter whether this rule applies to all paths of the website or only some of them. And how the ingress will handle those requests:

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
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
                  serviceName: contoso-website # Which service the request will be forwarded to
                  servicePort: http # Which port in that service
                path: / # Which path is this rule referring to
    ```

Save the file and that is enough to describe our ingress workload.

## Deploy the ingress

Now we need to deploy the service for our changes to take effect.

1. Open a terminal in the same directory as the `ingress.yaml` file
1. Run the `apply` command:

    ```bash
    kubectl apply -f ./ingress.yaml
    ```

1. To test if everything worked, let's check if the ingress resource was created

    ```bash
    kubectl get ingress contoso-website
    ```

    Make sure the `ADDRESS` column of the output is filled with an IP address. That's the address of you cluster.

1. There could be a small delay between the creation of the ingress and the creation of the zone record. Let's query Azure to find out if our DNS has been created and we can access the website already:

    Run the `list` command to list all DNS zones again:

    ```bash
    az network dns zone list --output table
    ```

    Copy the `ZoneName` and `ResourceGroup` columns. Now run:

    ```bash
    az network dns record-set list -g <resource-group-name> -z <zone-name> --output table
    ```

    Make sure there are two new records at the bottom of the list with the host we created in the `specs.rules[0].host` key. And the `ProvisioningState` is `Succeeded`. If they're not there yet, wait a few moments and run this command again. It can take up to two minutes for Zone Records to propagate.

1. Open your browser and go to the DNS described in the zone (the same one we put into `spec.rules[0].host`). You'll access the website:

:::image type="content" source="../media/7-website-success.png" alt-text="We can access our website":::

