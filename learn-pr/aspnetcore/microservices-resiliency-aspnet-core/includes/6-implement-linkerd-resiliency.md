In the previous unit, you implemented resiliency by adding failure-handling code with Polly. This change only applies to the service you changed, however. Updating a large app with many services would be non-trivial.

This unit focuses on replacing the code-based resiliency. An infrastructure-based resiliency approach spanning the entire app will be used instead. You will:

* Redeploy the app without any resiliency.
* Deploy Linkerd in your AKS cluster.
* Configure the app to use Linkerd for resiliency.
* Explore the app behavior with Linkerd.

## Redeploy the app

Before applying Linkerd, let's revert the app to a state before we added code-based resiliency. To revert, redeploy the unmodified `webshoppingagg` image using the following command:

```bash
./deploy/k8s/deploy-application.sh --registry eshopdev --charts webshoppingagg
```

You may verify the app is again failing as expected using the same steps as before:

1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. Enter the discount code *:::no-loc text="FAIL 2 DISC-10":::* and select **:::no-loc text="APPLY":::**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::** twice.
1. Verify that you receive the message **:::no-loc text="ERROR: 500 - Internal Server Error!":::** immediately after selecting **:::no-loc text="APPLY":::** each time.

### Validate the AKS cluster

The setup script installed the Linkerd CLI. Run the following command to confirm that Linkerd prerequisites have been satisfied:

```bash
linkerd check --pre
```

You'll see a variation of the following output:

```console
kubernetes-api
--------------
√ can initialize the client
√ can query the Kubernetes API

kubernetes-version
------------------
√ is running the minimum Kubernetes API version
√ is running the minimum kubectl version

pre-kubernetes-setup
--------------------
√ control plane namespace does not already exist
√ can create non-namespaced resources
√ can create ServiceAccounts
√ can create Services
√ can create Deployments
√ can create CronJobs
√ can create ConfigMaps
√ can create Secrets
√ can read Secrets
√ can read extension-apiserver-authentication configmap
√ no clock skew detected

pre-kubernetes-capability
-------------------------
√ has NET_ADMIN capability
√ has NET_RAW capability

linkerd-version
---------------
√ can determine the latest version
√ cli is up-to-date

Status check results are √
```

### Deploy Linkerd to the cluster

Run the following command:

```bash
linkerd install | kubectl apply -f -
```

In the preceding command:

* `linkerd install` generates a Kubernetes manifest with the necessary control plane resources.
* The generated manifest is piped to `kubectl apply`, which installs those control plane resources in the AKS cluster.

The first line of the output shows that the control plane was installed in its own `linkerd` namespace. The remaining output represents the objects being created.

```console
namespace/linkerd created
clusterrole.rbac.authorization.k8s.io/linkerd-linkerd-identity created
clusterrolebinding.rbac.authorization.k8s.io/linkerd-linkerd-identity created
serviceaccount/linkerd-identity created
clusterrole.rbac.authorization.k8s.io/linkerd-linkerd-controller created
```

### Validate the Linkerd deployment

Run the following command:

```bash
linkerd check
```

The preceding command analyzes the configurations of the Linkerd CLI and control plane. If Linkerd is configured correctly, the following output is displayed:

```console
linkerd-version
---------------
√ can determine the latest version
√ cli is up-to-date

control-plane-version
---------------------
√ control plane is up-to-date
√ control plane and cli versions match

linkerd-addons
--------------
√ 'linkerd-config-addons' config map exists

linkerd-grafana
---------------
√ grafana add-on service account exists
√ grafana add-on config map exists
√ grafana pod is running

Status check results are √
```

> [!TIP]
> To see a list of Linkerd components that were installed, run the following command:
>
> ```bash
> kubectl -n linkerd get deploy
> ```

## Configure the app to use Linkerd

Linkerd has been deployed, but it hasn't been configured. The app's behavior is unchanged. Linkerd only retries routes configured in the `ServiceProfile` manifest. For brevity, you'll implement Linkerd on two services only: `webshoppingagg` and `coupon-api`. For each, you will:

* Modify the deployments so Linkerd creates its proxy container in the pods.
* Add a `ServiceProfile` object to the cluster to configure the retries on the selected route.
* Configure headers for the related Nginx ingress.

### Modify the `webshoppingagg` and `coupon` deployments

1. Add the highlighted annotations to the `coupon` chart *:::no-loc text="deployment.yaml":::* file (*:::no-loc text="deploy/k8s/helm-simple/coupon/templates/deployment.yaml":::*). Save your changes.

    :::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/6-deployment.yaml" highlight="18-19":::

    The `linkerd.io/inject: enabled` annotation instructs Linkerd to add the `linkerd-proxy` container when creating the pod.

    > [!IMPORTANT]
    > It's important to maintain correct indentation in YAML manifests.

1. In a similar way, add the highlighted annotations to the `webshoppingagg` chart *:::no-loc text="deployment.yaml":::* file (*:::no-loc text="deploy/k8s/helm-simple/webshoppingagg/templates/deployment.yaml":::*). Save your changes.

    :::code language="yml" source="../code/deploy/k8s/helm-simple/webshoppingagg/templates/6-deployment.yaml" highlight="18-19":::

### Add the ServiceProfile for the HTTP GET coupon route

The `ServiceProfile` manifest content is shown next and is already included in the *:::no-loc text="deploy/k8s/linkerd":::* directory. Run the following command:

```bash
kubectl apply -f ./deploy/k8s/linkerd/coupon-serviceprofile.yaml
```

The following output appears:

```console
serviceprofile.linkerd.io/coupon-api.default.svc.cluster.local created
```

### Configure headers for Nginx

Linkerd needs Nginx to provide additional information in the request headers to pass requests to the correct service. Consequently, annotations must be added to the ingress route.

Add the highlighted lines to the *:::no-loc text="deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml":::* file. Save your changes.

:::code language="yml" source="../code/deploy/k8s/helm-simple/apigateway/templates/6-ingress-gateway.yaml" highlight="13-15":::

The preceding change instructs Nginx to add a request header named `l5d-dst-override`. The header's value is set dynamically to the destination service's DNS name and port. The `proxy_set_header` and `grpc_set_header` directives are used for HTTP and gRPC requests, respectively.

> [!NOTE]
> The *:::no-loc text="eShopOnContainers":::* app uses gRPC for service-to-service communication. More specifically, this synchronous communication is upgraded from HTTP and occurs between the aggregator and the services. Externally accessible endpoints, on the other hand, are RESTful. gRPC is an RPC-based protocol characterized by its high performance and low bandwidth usage. These characteristics make gRPC the best candidate for internal services communication.

### Deploy the updated Helm charts

Use the following command to redeploy the updated charts:

```bash
./deploy/k8s/deploy-application.sh --registry eshopdev --charts apigateway,coupon,webshoppingagg
```

The updated pods each have two containers now (`0/2`). One is the service container and the other is `linkerd-proxy`:

:::image type="content" source="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png" alt-text="updated pods with two containers" border="true" lightbox="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png":::

## Test the app again

After the redeployed containers are healthy, test the app's behavior with Linkerd. Place an item in the shopping bag and begin the checkout procedure. Repeat the earlier steps to configure multiple failures from the coupon service. Complete the following steps to test the retry policy:

1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. Enter the discount code *:::no-loc text="FAIL 5 DISC-10":::* and select **:::no-loc text="APPLY":::**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::**.

    The correct response is received immediately. An error indicating that this coupon has already been redeemed is displayed.

1. Check the log traces for the following messages:

    :::image type="content" source="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png" alt-text="log traces with Linkerd" border="true" lightbox="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png":::

Linkerd follows a different approach to resiliency than what you saw with Polly. Linkerd transparently retried the operation multiple times in quick succession. The user didn't notice any failure.

## Additional information

For more information about Linkerd configuration, see the following resources:

* [Configuring Retries - Linkerd documentation](https://linkerd.io/2/tasks/configuring-retries)
* [Configuring Timeouts - Linkerd documentation](https://linkerd.io/2/tasks/configuring-timeouts)
* [How we designed retries in Linkerd 2.2 - Linkerd blog](https://linkerd.io/2019/02/22/how-we-designed-retries-in-linkerd-2-2)
