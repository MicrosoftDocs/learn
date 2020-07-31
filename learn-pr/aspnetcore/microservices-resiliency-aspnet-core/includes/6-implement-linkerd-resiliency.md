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

1. Sign in to the app.
1. Select the **.NET FOUNDATION PIN**.
1. Select the basket icon at the top right of the page.
1. Select **CHECKOUT**.
1. Enter the discount code *:::no-loc text="FAIL 2 DISC-10":::* and select **APPLY**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **APPLY** twice.
1. Verify that you receive the message **ERROR: 500 - Internal Server Error!** immediately after selecting **APPLY** each time.

### Validate your Kubernetes cluster

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

You'll see the list of objects being created:

```console
namespace/linkerd created
clusterrole.rbac.authorization.k8s.io/linkerd-linkerd-identity created
clusterrolebinding.rbac.authorization.k8s.io/linkerd-linkerd-identity created
serviceaccount/linkerd-identity created
clusterrole.rbac.authorization.k8s.io/linkerd-linkerd-controller created
```

### Verify Linkerd deployment

Run the following command:

```bash
linkerd check
```

The output is a checklist similar to that of the pre-install and will resemble the following text:

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

## Configure the app to use Linkerd

Linkerd has been deployed, but it hasn't been configured and app behavior is unchanged. Linkerd only retries routes configured in the `ServiceProfile` manifest. For brevity, you'll implement Linkerd on two services only: `webshoppingagg` and `coupon-api`. For each, you will:

* Modify the deployments so Linkerd creates its proxy container in the pods.
* Add a `ServiceProfile` object to the cluster to configure the retries on the selected route.
* Configure headers for the related Nginx ingress.

### Modify the `webshoppingagg` and `coupon` deployments

1. Add the highlighted annotations to the `coupon` chart *deployment.yaml* file (*deploy/k8s/helm-simple/coupon/templates/deployment.yaml*):

    :::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/6-deployment.yaml" highlight="18-19":::

    The `linkerd.io/inject: enabled` annotation instructs Linkerd to add the `linkerd-proxy` container when creating the pod.

    > [!NOTE]
    > It's important to maintain correct indentation in YAML manifests.

1. In a similar way, add the highlighted annotations to the `webshoppingagg` chart *deployment.yaml* file (*deploy/k8s/helm-simple/webshoppingagg/templates/deployment.yaml*):

    :::code language="yml" source="../code/deploy/k8s/helm-simple/webshoppingagg/templates/6-deployment.yaml" highlight="18-19":::

### Add the ServiceProfile for the HTTP GET coupon route

The `ServiceProfile` manifest content is shown next and is already included in the *deploy/k8s/linkerd* directory. Run the following command:

```bash
kubectl apply -f ./deploy/k8s/linkerd/coupon-serviceprofile.yaml
```

The following output appears:

```console
serviceprofile.linkerd.io/coupon-api.default.svc.cluster.local created
```

### Configure headers for Nginx

Linkerd needs additional information in the request headers, so you need to add annotations to the ingress route.

Add the highlighted lines to the *deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml* file:

:::code language="yml" source="../code/deploy/k8s/helm-simple/apigateway/templates/6-ingress-gateway.yaml" highlight="13-15":::

### Deploy the updated Helm charts

Use the following command to redeploy the updated charts:

```bash
./deploy/k8s/deploy-application.sh --registry eshopdev --charts apigateway,coupon,webshoppingagg
```

The updated pods each have two containers now (`0/2`). One is the service container and the other is `linkerd-proxy`:

:::image type="content" source="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png" alt-text="updated pods with two containers" border="true" lightbox="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png":::

## Explore the app with Linkerd

Test the app's behavior with Linkerd by completing the following steps:

1. Sign in to the app.
1. Select the **.NET FOUNDATION PIN**.
1. Select the basket icon.
1. Select **CHECKOUT**.
1. Go to the **HAVE A DISCOUNT CODE?** text box.
1. Enter the code *:::no-loc text="FAIL 5 DISC-10":::* and select **APPLY**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **APPLY**.

    This time, you receive the correct response almost immediately.

1. Check the log traces for the following messages:

    :::image type="content" source="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png" alt-text="log traces with Linkerd" border="true" lightbox="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png":::

Linkerd follows a different approach to resiliency than what you saw with Polly. Linkerd transparently retried the operation multiple times in quick succession. The user didn't notice any failure.

## Additional information

For more information about Linkerd configuration, see the following resources:

* [Configuring Retries - Linkerd documentation](https://linkerd.io/2/tasks/configuring-retries)
* [Configuring Timeouts - Linkerd documentation](https://linkerd.io/2/tasks/configuring-timeouts)
* [How we designed retries in Linkerd 2.2 - Linkerd blog](https://linkerd.io/2019/02/22/how-we-designed-retries-in-linkerd-2-2)
