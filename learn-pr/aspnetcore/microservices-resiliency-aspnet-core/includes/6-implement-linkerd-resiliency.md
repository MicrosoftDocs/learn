In the previous unit, you implemented resiliency by adding failure-handling code with Polly. This change only applies to the service you changed, however. Updating a large app with many services would be non-trivial. In this using, you'll implement an infrastructure-based resiliency approach spanning the entire app with Linkerd.

In this unit, you will:

* Return the app to the original version.
* Deploy Linkerd in your cluster.
* Configure the app to use Linkerd for resiliency.
* Explore the app behavior with Linkerd.

## Return the app to the initial version

To examine the effect of Linkerd on the app, revert to the original version of the app. As you recall, the original app didn't use Polly.

To revert, redeploy the modified service from the original repository, using the following command from the *deploy/k8s* directory:

```bash
./deploy-application.sh --registry eshopdev --charts webshoppingagg
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

You should get something like this:

:::image type="content" source="../media/6-implement-linkerd-resiliency/check-linkerd-pre.png" alt-text="check Linkerd prerequisites" border="true" lightbox="../media/6-implement-linkerd-resiliency/check-linkerd-pre.png":::

### Install Linkerd onto the cluster

Run the following command:

```bash
linkerd install | kubectl apply -f -
```

You should see the list of objects being created.

### Verify the Linkerd status in the cluster

Run the following command:

```bash
linkerd check
```

You should see a checklist similar to the pre-install one, but longer. It's also probable that the check pauses several times while waiting for the components to become ready. Eventually, you should get to something like this:

:::image type="content" source="../media/6-implement-linkerd-resiliency/linkerd-check.png" alt-text="Linkerd status check results" border="true" lightbox="../media/6-implement-linkerd-resiliency/linkerd-check.png":::

## Configure the app to use Linkerd

To keep the exercise short and focused, you'll implement Linkerd on two services only: `webshoppingagg` and `coupon-api`. You'll:

* Modify the deployments so Linkerd creates its proxy container in the pods.
* Add a `ServiceProfile` object to the cluster, to configure the retries on the selected route.
* Configure headers for the related Nginx ingress.

You could check the app behavior now, but it will be unchanged. Linkerd only retries on the routes configured in the `ServiceProfile`.

### Modify the `webshoppingagg` and `coupon` deployments

Edit the `coupon` chart *deployment.yaml* file (*deploy/k8s/helm-simple/coupon/templates/deployment.yaml*) and add the following annotations in line 20:

```yml
      annotations:
        linkerd.io/inject: enabled
```

The updated file must look like this:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: coupon
  labels:
    app: eshop
    type: application-service
    service: coupon
spec:
  replicas: 1
  selector:
    matchLabels:
      service: coupon
  template:
    metadata:
      labels:
        app: eshop
        type: application-service
        service: coupon
      annotations:
        linkerd.io/inject: enabled
    spec:
      ...
```

The `linkerd.io/inject: enabled` annotation instructs Linkerd to add the `linkerd-proxy` container when creating the pod.

> [!NOTE]
> It's important to maintain correct indentation in YAML manifests.

In a similar way, edit the `webshoppingagg` chart *deployment.yaml* file (*deploy/k8s/helm-simple/webshoppingagg/templates/deployment.yaml*) as shown next:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webshoppingagg
  labels:
    app: eshop
    type: application-service
    service: webshoppingagg
spec:
  replicas: 1
  selector:
    matchLabels:
      service: webshoppingagg
  template:
    metadata:
      labels:
        app: eshop
        type: application-service
        service: webshoppingagg
      annotations:
        linkerd.io/inject: enabled
    spec:
    ...
```

### Add the ServiceProfile for the GET coupon route

The `ServiceProfile` manifest content is shown next and it's already included in the *deploy/k8s/linkerd* directory, so you just have to run this command from the *deploy/k8s* directory:

```bash
kubectl apply -f linkerd/coupon-serviceprofile.yaml
```

### Configure headers for Nginx

Linkerd needs additional information in the request headers, so you have to add some annotations in the ingress route.

Edit the *deploy\k8s\helm-simple\apigateway\templates\ingress-gateway.yaml* file to insert the following lines in line 89:

```yml
    nginx.ingress.kubernetes.io/configuration-snippet: |
      proxy_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;
      grpc_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;
```

The updated file must look like this:

```yml
...
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-gw-cp
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /webshoppingagg/$2
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
    nginx.ingress.kubernetes.io/configuration-snippet: |
      proxy_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;
      grpc_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;
  labels:
    app: eshop
spec:
  rules:
{{- if .Values.useHostName }}
  - host: {{ .Values.host }}
    http:
{{- else }}
  - http:
{{- end }}
      paths:
      - backend:
          serviceName: webshoppingagg
          servicePort: 80
        path: /apigateway/cp(/|$)(.*)
---
...
```

### Deploy the updated Helm charts

Use the following command to redeploy the updated charts:

```bash
./deploy-application.sh --registry eshopdev --charts apigateway,coupon,webshoppingagg
```

You should see that the updated pods have two containers now (`0/2`). One is the service container and the other is `linkerd-proxy`:

:::image type="content" source="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png" alt-text="updated pods with two containers" border="true" lightbox="../media/6-implement-linkerd-resiliency/injecting-linkerd-proxies.png":::

## Explore the app behavior with Linkerd

Let's explore the app behavior now with a similar process:

* Log in to the app.
* Select the **.NET FOUNDATION PIN**.
* Select the basket icon at the top right of the page.
* Select **CHECKOUT**.
* Go to the **HAVE A DISCOUNT CODE?** input.
* Enter the code *:::no-loc text="FAIL 5 DISC-10":::* and select **APPLY**.
* Change the code to *:::no-loc text="DISC-10":::* and select **APPLY**.
* You'll notice that this time, you receive the correct response almost immediately.

If you check the log traces, you should see something like this:

:::image type="content" source="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png" alt-text="log traces with Linkerd" border="true" lightbox="../media/6-implement-linkerd-resiliency/log-traces-with-linkerd.png":::

As mentioned in the review unit, Linkerd follows a different approach to resiliency from what we saw with Polly. Linkerd retried five times in fast sequence so we didn't notice any failure at all.

For more information about Linkerd configuration, see the following resources:

* [Configuring Retries - Linkerd documentation](https://linkerd.io/2/tasks/configuring-retries)
* [Configuring Timeouts - Linkerd documentation](https://linkerd.io/2/tasks/configuring-timeouts)
* [How we designed retries in Linkerd 2.2 - Linkerd blog](https://linkerd.io/2019/02/22/how-we-designed-retries-in-linkerd-2-2)
