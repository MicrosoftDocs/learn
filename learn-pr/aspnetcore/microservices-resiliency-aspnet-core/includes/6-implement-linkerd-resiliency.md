In the previous unit, you implemented resiliency by adding failure-handling code with Polly. This change only applies to the service you changed, however. Updating a large app with many services would be non-trivial. In this using, you'll implement an infrastructure-based resiliency approach spanning the entire app with Linkerd.

In this unit, you will:

* Return the app to the original version.
* Deploy Linkerd in your cluster.
* Configure the app to use Linkerd for resiliency.
* Explore the app behavior with Linkerd.

## Return the app to the initial version

To examine the effect of Linkerd on the app, revert to the original version of the app. As you recall, the original app didn't use Polly.

To revert, redeploy the modified service from the original repository, using the following command:

```bash
./deploy/k8s/deploy-application.sh --registry eshopdev --charts webshoppingagg
```

You can explore the app when it becomes fully available again to verify it's failing immediately on the configured discount code, as you just did in the previous exercise. As a refresher, complete the following tasks:

* Log in to the app.
* Select the **.NET FOUNDATION PIN**.
* Select the basket icon at the top right of the page.
* Select **CHECKOUT**.
* Go to the **HAVE A DISCOUNT CODE?** input.
* Enter the code *:::no-loc text="FAIL 2 DISC-10":::* and select **APPLY**.
* Change the code to *:::no-loc text="DISC-10":::* and select **APPLY** twice.
* Verify that you receive the message **ERROR: 500 - Internal Server Error!** immediately after select **APPLY** each time.

## Install Linkerd

As you recall, the Linkerd CLI was installed as part of the module setup. To finish configuration, complete the following steps.

### Validate your Kubernetes cluster

Run the following command to confirm that Linkerd prerequisites have been satisfied:

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

### Install Linkerd onto the cluster

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

### Verify the Linkerd status in the cluster

Run the following command:

```bash
linkerd check
```

You'll see a checklist similar to the pre-install one, but longer. It's also probable that the check pauses several times while waiting for the components to become ready. Eventually, you'll get to something like this:

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

To keep the exercise short and focused, you'll implement Linkerd on two services only: `webshoppingagg` and `coupon-api`. You'll:

* Modify the deployments so Linkerd creates its proxy container in the pods.
* Add a `ServiceProfile` object to the cluster, to configure the retries on the selected route.
* Configure headers for the related Nginx ingress.

You could check the app behavior now, but it will be unchanged. Linkerd only retries on the routes configured in the `ServiceProfile`.

### Modify the `webshoppingagg` and `coupon` deployments

1. Add the highlighted annotations to the `coupon` chart *deployment.yaml* file (*deploy/k8s/helm-simple/coupon/templates/deployment.yaml*):

    :::code language="yml" source="../code/deploy/k8s/helm-simple/coupon/templates/6-deployment.yaml" highlight="18-19":::

    The `linkerd.io/inject: enabled` annotation instructs Linkerd to add the `linkerd-proxy` container when creating the pod.

    > [!NOTE]
    > It's important to maintain correct indentation in YAML manifests.

1. In a similar way, add the highlighted annotations to the `webshoppingagg` chart *deployment.yaml* file (*deploy/k8s/helm-simple/webshoppingagg/templates/deployment.yaml*):

    :::code language="yml" source="../code/deploy/k8s/helm-simple/webshoppingagg/templates/6-deployment.yaml" highlight="18-19":::

### Add the ServiceProfile for the HTTP GET coupon route

The `ServiceProfile` manifest content is shown next and is already included in the *deploy/k8s/linkerd* directory. Run the following command from the *deploy/k8s* directory:

```bash
kubectl apply -f linkerd/coupon-serviceprofile.yaml
```

The following output appears:

```console
serviceprofile.linkerd.io/coupon-api.default.svc.cluster.local created
```

### Configure headers for Nginx

Linkerd needs additional information in the request headers. You must add some annotations in the ingress route.

Add the highlighted lines to the *deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml* file:

:::code language="yml" source="../code/deploy/k8s/helm-simple/apigateway/templates/6-ingress-gateway.yaml" highlight="13-15":::

### Deploy the updated Helm charts

Use the following command to redeploy the updated charts:

```bash
./deploy-application.sh --registry eshopdev --charts apigateway,coupon,webshoppingagg
```

You'll see that the updated pods have two containers now (`0/2`). One is the service container and the other is `linkerd-proxy`:

:::image type="content" source="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png" alt-text="updated pods with two containers" border="true" lightbox="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png":::

## Explore the app behavior with Linkerd

Let's explore the app behavior now with a similar process:

1. Log in to the app.
1. Select the **.NET FOUNDATION PIN**.
1. Select the basket icon at the top right of the page.
1. Select **CHECKOUT**.
1. Go to the **HAVE A DISCOUNT CODE?** text box.
1. Enter the code *:::no-loc text="FAIL 5 DISC-10":::* and select **APPLY**.
1. Change the code to *:::no-loc text="DISC-10":::* and select **APPLY**.

    You'll notice that this time, you receive the correct response almost immediately.

1. Check the log traces. You'll see something like this:

    :::image type="content" source="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png" alt-text="log traces with Linkerd" border="true" lightbox="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png":::

As mentioned in the review unit, Linkerd follows a different approach to resiliency from what you saw with Polly. Linkerd retried five times in fast sequence so you didn't notice any failure.

For more information about Linkerd configuration, see the following resources:

* [Configuring Retries - Linkerd documentation](https://linkerd.io/2/tasks/configuring-retries)
* [Configuring Timeouts - Linkerd documentation](https://linkerd.io/2/tasks/configuring-timeouts)
* [How we designed retries in Linkerd 2.2 - Linkerd blog](https://linkerd.io/2019/02/22/how-we-designed-retries-in-linkerd-2-2)
