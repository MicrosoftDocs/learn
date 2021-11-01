You just deployed a new BFF to the cluster. Now you'll learn how to make the Web Sales BFF available for clients outside the cluster.

You've seen how the API gateway and BFF patterns route requests and aggregate responses. This implementation still requires access from outside the cluster. You'll learn how you might use NGINX Ingress Controller. Then you'll reconfigure the cluster to use Azure Application Gateway Ingress Controller (AGIC) instead.

## Kubernetes ingress controllers

Kubernetes services are typically not accessible from outside the cluster. To implement an ingress, you need:

- At least one *ingress controller*, which is responsible for routing requests.
- One or more *ingress resources*, typically one per exposed service. Ingress resources represent configuration for the controller.

[NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) is the most widely used open-source ingress controller. NGINX is used in *eShopOnContainers* by default.

### Route configuration

Because the API gateway has a single entry point, each service is differentiated by the addition of a path element.

In the sample app, the routes are configured like this:

| External path                         | Destination                          |
|---------------------------------------|--------------------------------------|
| `https://<host-name>/identity/*`      | `http://identity/identity/*`         |
| `https://<host-name>/apigateway/c/*`  | `http://catalog-api/catalog-api/*`   |
| `https://<host-name>/apigateway/cp/*` | `http://coupon-api/coupon-api/*`     |
| `https://<host-name>/apigateway/o/*`  | `http://ordering-api/ordering-api/*` |

The preceding table shows two main entry routes to the cluster, `/identity` and `/apigateway`.

The `/identity` route is handled internally by the `identity` service, which uses a simple `http` termination and the internal service name.

The `/apigateway` route needs another path segment (`c`, `cp`, and `o`) so it can route the requests to the receiving service.

The ingress for the `identity` service is kept in the *deploy/k8s/helm-simple/identity/templates/ingress.yaml* file, as part of the **identity** Helm chart.

You can see the routes configuration for the API gateway in *deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml*. The file contains several ingresses that look like this:

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-gw-c
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /catalog-api/$2
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
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
          serviceName: catalog-api
          servicePort: 80
        path: /apigateway/c(/|$)(.*)
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-gw-b
...
```

The section delimited between `{{- if .Values.useHostName }}` and `{{- end }}` handles the option to deploy to an IP address, because IP addresses aren't valid host names in Kubernetes. For more about the manifest YAML, see [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).

## Cloud-managed load balancer: Azure Application Gateway

The API gateway used in *eShopOnContainers* is typical of many real-world scenarios. For some large-scale scenarios, you might need a more robust, full-featured solution. Azure Application Gateway is a managed solution that allows you to handle loads of any scale. Azure Application Gateway has several [key features](/azure/application-gateway/features) that help you tackle real-world scenarios, including:

- Secure Sockets Layer/Transport Layer Security (SSL/TLS) termination.
- Autoscaling.
- Web Application Firewall.
- HTTP header rewriting.

### Application Gateway Ingress Controller

AGIC integrates Application Gateway with your Kubernetes cluster. The following image shows the general architecture of the solution.

:::image type="content" source="../media/azure-application-gateway-ingress-controller-overview.png" alt-text="Diagram that provides an overview of Application Gateway Ingress Controller." lightbox="../media/azure-application-gateway-ingress-controller-overview.png":::

You can see that AGIC lives inside the Azure Kubernetes Service (AKS) cluster as an ingress controller, although it isn't really routing any traffic. AGIC monitors the cluster state by using the Kubernetes API. It applies the required configuration to Application Gateway, which can route traffic directly to the pods.

Application Gateway is a managed service outside the AKS cluster and can't usually access the pods directly. The AKS instance must be created with the *advanced networking* option. This setting makes the pods connect through a subnet that Application Gateway can access.

For more information, see the [Application Gateway Ingress Controller overview page](/azure/application-gateway/ingress-controller-overview).

### Difference between an in-cluster ingress controller and AGIC

AGIC has advantages over an in-cluster ingress controller:

- AGIC doesn't take any resources of from the Kubernetes cluster, because it runs outside the cluster.
- External traffic doesn't go through the extra hop of an ingress controller pod, which reduces latency.

The following image compares the two approaches.

:::image type="content" source="../media/incluster-vs-agic.png" alt-text="Diagram that compares in-cluster and A G I C ingress controllers." lightbox="../media/incluster-vs-agic.png":::

## Proposed solution

The following image shows the solution architecture of the *eShop* app that you'll deploy in the next unit.

:::image type="content" source="../media/app-gateway-ingress.png" alt-text="Diagram that shows the Azure Application Gateway solution architecture." lightbox="../media/app-gateway-ingress.png":::
