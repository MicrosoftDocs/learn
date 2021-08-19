In this exercise, you'll deploy an instance of Azure Application Gateway with an ingress controller to load balance traffic to the pods within `eShopOnContainer`.

In this exercise, you will:

- Create an Azure Application Gateway instance.
- Enable Application Gateway Ingress Controller (AGIC) in the Azure Kubernetes Service (AKS) cluster.
- Configure the existing ingresses to use AGIC.
- Deploy the application with the updated ingresses.
- Redeploy the affected apps to the cluster.
- Add the *websalesagg* client redirect URIs in *IdentityDb*.
- Test *websalesagg* by using Swagger's UI.

## Create an Azure Application Gateway instance

To create a new instance of Azure Application Gateway, run the following command:

```bash
./deploy/k8s/create-application-gateway.sh
```

The script does the following tasks:

- Creates a virtual network for Application Gateway.
- Creates a subnet in the virtual network created in the previous step.
- Creates a public IP address.
- Creates the Application Gateway instance.

The output resembles the following image.

:::image type="content" source="../media/create-application-gateway.png" alt-text="Screenshot that shows output from the create-application-gateway script." lightbox="../media/create-application-gateway.png":::

Note the Application Gateway public IP address that's exported as `ESHOP_APPGATEWAYPUBLICIP`.

> [!NOTE]
> The script takes several minutes to finish.

## Enable AGIC in the AKS cluster

You've created an instance of the Azure Application Gateway service. Now enable AGIC in the cluster by using the following command:

```bash
./deploy/k8s/enable-agic-adon.sh
```

The script does the following tasks:

- Enables AGIC as an add-on feature in the existing Kubernetes cluster.
- Enables bidirectional peering. This peering connects the existing virtual network of the AKS cluster and the newly created virtual network of the Application Gateway cluster.

## Configure ingresses to use AGIC

The `kubernetes.io/ingress.class: azure/application-gateway` annotation must be included in your ingress manifest YAML files before AGIC can use them. In some scenarios, if the ingress needs to do URL rewriting, you must include the `appgw.ingress.kubernetes.io/backend-path-prefix` annotation.

>[!TIP]
> The ingress YAML for the *Seq* app is a good example of this. It's available under the */deploy/k8s/helm-ingress/seq/templates* directory.

Review the ingress manifest file of the *websalesagg* service:

```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: websalesagg
  labels:
    app: eshop
    service: websalesagg
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
spec:
  rules:
{{- if .Values.useHostName }}
  - host: {{ .Values.host }}
    http:
{{- else }}
  - http:
{{- end }}
      paths:
      - path: /websalesagg/*
        backend:
          serviceName: websalesagg
          servicePort: 80
```

Along with the *websalesagg* service, you need to update the NGINX configuration for each service to make it available for AGIC. All of the service configurations in the *helm-simple* directory require changes. For simplicity, you'll copy files from the *helm-ingress* folder. These files have been preconfigured for you. Run the following command:

```bash
cp -r deploy/k8s/helm-ingress/* deploy/k8s/helm-simple
```

You can view this step with the following image.

:::image type="content" source="../media/helm-ingress-manifest-replace.png" alt-text="Screenshot that shows the helm ingress manifest update." lightbox="../media/helm-ingress-manifest-replace.png":::

> [!NOTE]
> In the preceding step, a new ingress file is created for the *websalesagg* app because it was newly created. For other apps, the file will replace the existing ones.

## Clean up old ingress objects

You need to clean up the old ingress objects before deploying the newly annotated `azure/application-gateway` ingress object. Run the following command to delete the existing ingress objects:

```bash
kubectl delete ingress --all
```

## Deploy the application with the updated ingresses

Use the following command to display the public IP address of the Application Gateway instance from earlier:

```bash
cat ~/clouddrive/aspnet-learn/create-application-gateway-exports.txt
```

Replace `{appgw-public-ip}` with the value of the variable `ESHOP_APPGATEWAYPUBLICIP` in the following command:

```bash
deploy/k8s/deploy-application.sh --registry eshopdev --hostip {appgw-public-ip}
```

:::image type="content" source="../media/eshop-app-gateway-public-ip.png" alt-text="Screenshot that shows the gateway public I P address for the fetch app." lightbox="../media/eshop-app-gateway-public-ip.png":::

The pods redeploy from the public container registry that you used in the beginning of this module. The following output appears:

:::image type="content" source="../media/deployed-eshop-app-app-gateway.png" alt-text="Screenshot that shows the deployed websalesagg app to Application Gateway." lightbox="../media/deployed-eshop-app-app-gateway.png":::

You can now explore the app deployed onto the new AKS instance. Other than the IP address, you shouldn't see any difference.

> [!NOTE]
> In this step, you'll see an error related to the *websalesagg* pod. That's because the public container registry doesn't contain a image of the Web Sales aggregator. You'll deploy that from your private Azure Container Registry instance in the next step. In an actual production scenario, you can avoid this extra step by deploying all the Docker images from the same container registry.

## Redeploy the affected apps to the cluster

Now you'll redeploy your local changes to the cluster with the public IP address of the Application Gateway instance. Replace `{appgw-public-ip}` with the public IP address in `ESHOP_APPGATEWAYPUBLICIP`, and then run the following command:

```bash
./deploy/k8s/deploy-affected-services.sh --ipAddress {appgw-public-ip}
```

The script redeploys the following services from your private Azure Container Registry instance:

- *WebStatus*
- *Identity.API*
- *WebSalesAgg*

## Add the websalesagg client redirect URIs to IdentityDb

The existing `[Microsoft.eShopOnContainers.Service.IdentityDb]` database in the `sqldata-*` pod won't have the necessary configuration for *websalesagg* to authorize. You'll need to repopulate the data in *IdentityDb*. Use the following steps:

1. Delete the SQL Server pod by using the following command:

    ```bash
    kubectl delete pods --selector service=sqldata
    ```

1. Wait a bit for the new SQL Server pod to be ready (as shown with `kubectl get pods`), and then restart all other pods:

    ```bash
    kubectl delete pods --selector service!=sqldata
    ```

    :::image type="content" source="../media/delete-all-pods-apart-from-sql.png" alt-text="Screenshot that shows deleting all pods." lightbox="../media/delete-all-pods-apart-from-sql.png":::

1. Check the `WebStatus` app by using `http://{appgw-public-ip}/webstatus/hc-ui#/healthchecks` and verify that *websalesagg* is healthy. This address uses the new IP address.

    > [!NOTE]
    > As with the initial deployment, the health check dashboard might take a few minutes to come up.

1. Access the *websalesagg* Swagger UI by using the `http://{appgw-public-ip}/websalesagg/` URL.

## Test websalesagg by using the Swagger UI

### Create an order

Sign in to the *WebSPA* app by using `http://{appgw-public-ip}/` and create an order to create data for the Sales API.

:::image type="content" source="../media/list-of-orders.png" alt-text="Screenshot that shows a list of orders." lightbox="../media/list-of-orders.png":::

### Fetch sales data

Authorize the request with the `adminuser@microsoft.com` user. Then select the Sales API to fetch the API data.

Output similar to the following text appears. Note that the aggregated sales unit per brand is shown for orders created today.

:::image type="content" source="../media/websales-agg-sales-api-data.png" alt-text="Screenshot that shows Sales A P I data." lightbox="../media/websales-agg-sales-api-data.png":::
