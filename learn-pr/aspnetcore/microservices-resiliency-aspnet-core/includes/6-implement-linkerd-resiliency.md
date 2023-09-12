In the previous unit, you implemented resiliency by adding failure-handling code using Polly. However, this change only applies to the service that you changed. Updating a large app with many services would be non-trivial.

Instead of using *code-based* resiliency, this unit uses an approach called *infrastructure-based* resiliency that spans the entire app. You will:

* Redeploy the app without any resiliency.
* Deploy Linkerd in your Azure Kubernetes Service (AKS) cluster.
* Configure the app to use Linkerd for resiliency.
* Explore the app behavior with Linkerd.

## Redeploy the app

Before applying Linkerd, revert the app to a state before code-based resiliency was added. To revert, redeploy the unmodified `webshoppingagg` image by using the following command:

```bash
./deploy-application.sh --registry eshoplearn --charts webshoppingagg
```

[!INCLUDE[Wait for healthy services](../../includes/microservices/wait-for-healthy-services.md)]

### Verify failing behavior

You can verify that the app fails again, as expected, by using the same steps as before:

1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. Enter the discount code *:::no-loc text="FAIL 2 DISC-10":::* and select **:::no-loc text="APPLY":::**.

    The message **:::no-loc text="CONFIG: 2 failure(s) configured for code \"DISC-10\"!!":::** appears.
1. Change the discount code to *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::** twice.
1. Verify that you receive the message **:::no-loc text="ERROR: 500 - Internal Server Error!":::** immediately after selecting **:::no-loc text="APPLY":::** each time.

### Validate the AKS cluster

The dev container comes with the Linkerd CLI preinstalled. Run the following command to confirm that Linkerd prerequisites have been satisfied:

```bash
linkerd check --pre
```

A variation of the following output appears:

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

### Deploy Linkerd to the AKS cluster

First, run the following command to install the CRDs:

```bash
linkerd install --crds | kubectl apply -f -
```

Then, run the following command:

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
kubernetes-api
--------------
√ can initialize the client
√ can query the Kubernetes API

kubernetes-version
------------------
√ is running the minimum Kubernetes API version
√ is running the minimum kubectl version

linkerd-existence
-----------------
√ 'linkerd-config' config map exists
√ heartbeat ServiceAccount exist
√ control plane replica sets are ready
√ no unschedulable pods
√ controller pod is running
√ can initialize the client
√ can query the control plane API

linkerd-config
--------------
√ control plane Namespace exists
√ control plane ClusterRoles exist
√ control plane ClusterRoleBindings exist
√ control plane ServiceAccounts exist
√ control plane CustomResourceDefinitions exist
√ control plane MutatingWebhookConfigurations exist
√ control plane ValidatingWebhookConfigurations exist
√ control plane PodSecurityPolicies exist

linkerd-identity
----------------
√ certificate config is valid
√ trust anchors are using supported crypto algorithm
√ trust anchors are within their validity period
√ trust anchors are valid for at least 60 days
√ issuer cert is using supported crypto algorithm
√ issuer cert is within its validity period
√ issuer cert is valid for at least 60 days
√ issuer cert is issued by the trust anchor

linkerd-api
-----------
√ control plane pods are ready
√ control plane self-check
√ [kubernetes] control plane can talk to Kubernetes
√ [prometheus] control plane can talk to Prometheus
√ tap api service is running

linkerd-version
---------------
√ can determine the latest version
√ CLI is up to date

control-plane-version
---------------------
√ control plane is up to date
√ control plane and CLI versions match

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
> To see a list of Linkerd components that were installed, run this command: `kubectl -n linkerd get deploy`

## Configure the app to use Linkerd

Linkerd has been deployed, but it hasn't been configured. The app's behavior is unchanged.

Linkerd is unaware of service internals and can't determine whether it's appropriate to retry a failed request. For example, it would be a bad idea to retry a failed HTTP POST for a payment. A *service profile* is necessary for this reason. A service profile is a custom Kubernetes resource that defines routes for the service. It also enables per-route features, such as retries and timeouts. Linkerd only retries routes configured in the service profile manifest.

For brevity, implement Linkerd only on the aggregator and coupon services. To implement Linkerd for those two services, you will:

* Modify the aggregator and coupon deployments so Linkerd creates its proxy container in the pods.
* Configure headers for the related Nginx ingress.
* Add a service profile object to the cluster to configure retries on the coupon service's route.

### Modify the `webshoppingagg` and `coupon` deployments

The coupon and aggregator services must be configured to use Linkerd proxy containers.

1. Add the highlighted annotations to the `coupon` chart *:::no-loc text="deployment.yaml":::* file, located at *:::no-loc text="deploy/k8s/helm-simple/coupon/templates/deployment.yaml":::*. Save your changes.

    :::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/6-deployment.yaml" highlight="18-19":::

    The `linkerd.io/inject: enabled` annotation instructs Linkerd to add the `linkerd-proxy` container when creating the pod.

    > [!IMPORTANT]
    > It's critical to maintain correct indentation in YAML manifests.

1. In a similar way, add the highlighted annotations to the `webshoppingagg` chart in the file *deploy/k8s/helm-simple/webshoppingagg/templates/deployment.yaml*. Save your changes.

    :::code language="yml" source="../code/deploy/k8s/helm-simple/webshoppingagg/templates/6-deployment.yaml" highlight="18-19":::

### Apply the Linkerd service profile for the coupon service

The service profile manifest for the coupon service is provided in the *deploy/k8s/linkerd/coupon-serviceprofile.yaml* file:

:::code language="yml" source="../code/deploy/k8s/linkerd/6-coupon-serviceprofile.yaml":::

The preceding manifest is configured such that:

* Any idempotent HTTP GET route matching the pattern `/coupon-api/api/v1/coupon/{code}` can be retried.
* Retries can add no more than an extra 20 percent to the request load, plus an additional 10 "free" retries per second.

Run the following command to use the service profile in the AKS cluster:

```bash
kubectl apply -f ./linkerd/coupon-serviceprofile.yaml
```

The following output appears:

```console
serviceprofile.linkerd.io/coupon-api.default.svc.cluster.local created
```

### Configure headers for Nginx

Linkerd needs Nginx to provide additional information in the request headers to pass requests to the correct service. So annotations must be added to the ingress route.

Add the highlighted lines to the *deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml* file. Save your changes.

:::code language="yml" source="../code/deploy/k8s/helm-simple/apigateway/templates/6-ingress-gateway.yaml" highlight="13-15":::

The preceding change instructs Nginx to add a Linkerd destination override request header named `l5d-dst-override`. The header's value is set dynamically to the destination service's DNS name and port. The `proxy_set_header` and `grpc_set_header` directives are used for HTTP and gRPC requests, respectively.

> [!NOTE]
> The *:::no-loc text="eShopOnContainers":::* app uses gRPC for service-to-service communication. More specifically, this synchronous communication is upgraded from HTTP and occurs between the aggregator and the services. Externally accessible endpoints, on the other hand, are RESTful. gRPC is an RPC-based protocol characterized by its high performance and low bandwidth usage. These characteristics make gRPC the best candidate for internal services communication.

### Deploy the updated Helm charts

Save all your changes and run the following command to redeploy the updated charts:

```bash
./deploy-application.sh --registry eshoplearn --charts apigateway,coupon,webshoppingagg
```

The updated pods each have two containers now (`0/2`). One is the service container and the other is `linkerd-proxy`:

:::image type="content" source="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png" alt-text="Screenshot of updated pods with two containers." border="true" lightbox="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png":::

## Test the app again

[!INCLUDE[Wait for healthy services](../../includes/microservices/wait-for-healthy-services.md)]

### Test Linkerd resiliency

After the redeployed containers are healthy, use the following steps to test the app's behavior with Linkerd:

1. Place an item in the shopping bag and begin the checkout procedure.
1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. Enter the discount code *:::no-loc text="FAIL 5 DISC-10":::* and select **:::no-loc text="APPLY":::**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::**.

    The correct response is received immediately. An error indicating that this coupon has already been redeemed is displayed.
1. Check the log traces for the following messages:

    :::image type="content" source="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png" alt-text="Screenshot of log traces with Linkerd." border="true" lightbox="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png":::

Linkerd follows a different approach to resiliency than what you saw with Polly. Linkerd transparently retried the operation multiple times in quick succession. The user didn't notice any failure.

## Additional information

For more information about Linkerd configuration, see the following resources:

* [Configuring retries - Linkerd documentation](https://linkerd.io/2/tasks/configuring-retries)
* [Configuring timeouts - Linkerd documentation](https://linkerd.io/2/tasks/configuring-timeouts)
* [How we designed retries in Linkerd 2.2 - Linkerd blog](https://linkerd.io/2019/02/22/how-we-designed-retries-in-linkerd-2-2)
