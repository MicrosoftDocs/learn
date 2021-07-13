You just deployed a new BFF to the cluster. Now you'll learn how to make the Web Sales BFF available for clients outside the cluster.

You've seen how the API Gateway and BFF patterns route requests and aggregate responses. This implementation still requires access from outside the cluster. You'll learn how you might use NGINX Ingress Controller. Then you'll reconfigure the cluster to use Azure Application Gateway Ingress Controller instead of the NGINX Ingress Controller.

## Kubernetes ingress controllers

Kubernetes services are typically not accessible from outside the cluster. To implement an ingress, you need:

- At least one **ingress controller**.
- One or more **ingress resources**, typically one per exposed service.

The ingress controller is responsible for routing requests, and the ingress resources represent configuration for the controller.

The [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) is the most widely used open-source ingress controller. This is the one used in eShopOnContainers by default.

### Routes configuration

Since the API Gateway has a single entry point, each service is differentiated by adding a path element.

In the sample app, the routes are configured like this:

| External path                         | Destination                          |
|---------------------------------------|--------------------------------------|
| `https://<host-name>/identity/*`      | `http://identity/identity/*`         |
| `https://<host-name>/apigateway/c/*`  | `http://catalog-api/catalog-api/*`   |
| `https://<host-name>/apigateway/cp/*` | `http://coupon-api/coupon-api/*`     |
| `https://<host-name>/apigateway/o/*`  | `http://ordering-api/ordering-api/*` |

The table above shows two main entry routes to the cluster, `/identity` and `/apigateway`.

The `/identity` route is handled internally by the `identity` service, using a simple `http` termination and using the internal service name.

The `/apigateway` route needs another path segment (`c`, `cp`, and `o`) so it can route the requests to the receiving service.

The ingress for the `identity` service is kept in the *deploy/k8s/helm-simple/identity/templates/ingress.yaml* file, as part of the **identity** Helm chart.

You can see the routes configuration for the API Gateway in *deploy/k8s/helm-simple/apigateway/templates/ingress-gateway.yaml*. In this case, the file contains several ingresses that look like this:

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

The section delimited between `{{- if .Values.useHostName }}` and `{{- end }}` handles the option to deploy to an IP address, as IP addresses aren't valid host names in Kubernetes. For more about the manifest yaml, see [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).

## Cloud-managed load balancer

### Azure Application Gateway

The API Gateway used in eShopOnContainers is typical of many real-world scenarios, but for some large-scale scenarios you may need a more robust, full-featured solution. Azure Application Gateway is a managed solution that allows you to handle loads of any scale. Azure Application Gateway has several [key features](/azure/application-gateway/features) that help you tackle real-world scenarios, including:

- Secure Sockets Layer (SSL/TLS) termination.
- Autoscaling.
- Web Application Firewall.
- HTTP headers rewriting, to name just a few.

#### Azure Application Gateway Ingress Controller (AGIC)

The Application Gateway Ingress Controller (AGIC) integrates the Application Gateway with your Kubernetes cluster. The following image shows the general architecture of the solution.

:::image type="content" source="../media/azure-application-gateway-ingress-controller-overview.png" alt-text="AGIC overview" lightbox="../media/azure-application-gateway-ingress-controller-overview.png":::

You can see that the AGIC lives inside the AKS cluster as an ingress controller, although it isn't really routing any traffic. The AGIC monitors the cluster state using the Kubernetes API. It applies the required configuration to the Application Gateway, so it can route traffic directly to the pods.

Since the Azure Application Gateway is a managed service outside the AKS cluster, and can't usually access the pods directly, the AKS has to be created with the "advanced networking" option. This setting makes the pods connect through a subnet that's accessible by the Application Gateway.

For more information, see the [Application Gateway Ingress Controller overview page](/azure/application-gateway/ingress-controller-overview)

#### Difference between In-Cluster Ingress Controller and AGIC

An AGIC ingress controller has many advantages over an in-cluster ingress controller.

- AGIC doesn't take any resources of from the Kubernetes cluster, as it runs outside of the cluster.
- External traffic doesn't go through the extra hop of an ingress controller pod, which reduces latency.

The following image compares the two approaches.

:::image type="content" source="../media/incluster-vs-agic.png" alt-text="in-cluster-vs-agic" lightbox="../media/incluster-vs-agic.png":::

## The proposed solution

The following image shows the solution architecture of the eShop app that you'll deploy in the next unit.

:::image type="content" source="../media/app-gateway-ingress.png" alt-text="Azure App Gateway Solution Architecture" lightbox="../media/app-gateway-ingress.png":::
