In this exercise, you'll deploy an instance of Azure Application Gateway with an ingress controller to load balance traffic to the pods within `eShopOnContainer`.

In this exercise you will:

- Create an Azure Application Gateway instance.
- Enable the AGIC in the AKS cluster.
- Configure the existing ingresses to use the AGIC.
- Deploy the application with the updated ingresses.
- Redeploy the affected apps to the cluster.
- Add the *websalesagg* client redirect URIs in the `IdentityDb`.
- Test *websalesagg* using Swagger's UI.

## Create an Azure Application Gateway instance

To create a new instance of Azure Application Gateway, run the below command.

```bash
./deploy/k8s/create-application-gateway.sh
```

The script performs the following tasks:

- Creates a VNET for the Application Gateway.
- Creates a subnet in the VNET created in the previous step.
- Creates a public IP.
- Creates the Application Gateway.

The output resembles the following image:

:::image type="content" source="../media/create-application-gateway.png" alt-text="Output from the create-application-gateway script. Creates subnet, creates public IP, and creates Application Gateway" lightbox="../media/create-application-gateway.png":::

Note the Application Gateway public IP that is exported as `ESHOP_APPGATEWAYPUBLICIP`.

> [!NOTE]
> The script takes several minutes to complete.

## Enable the AGIC in the AKS cluster

You've created the Azure Application Gateway service. Now enable the AGIC in the cluster with the following command:

```bash
./deploy/k8s/enable-agic-adon.sh
```

The script performs the following tasks:

- Enables the AGIC as an add-on feature in the existing Kubernetes cluster.
- Enables bi-directional peering between the existing VNET network of the AKS cluster and the newly created VNET of the Application Gateway cluster.
## Configure the ingresses to use the AGIC

You need to include the `kubernetes.io/ingress.class: azure/application-gateway` annotation in your ingress manifest YAML files before the AGIC can use them. In some scenarios, if the ingress needs to perform URL rewriting, you must include the `appgw.ingress.kubernetes.io/backend-path-prefix` annotation.

>[!TIP]
> The ingress YAML for the `Seq` app is a good example of this. It's available under `/deploy/k8s/helm-ingress/seq/templates` directory.

Review the ingress manifest file of the *websalesagg* service.

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

In addition to the *websalesagg* service, you'll need to update the NGINX configuration for each service to make it available for the AGIC. You could update those files within the `helm-simple` directory one at a time. For simplicity, you will instead copy all files from the `helm-ingress` folder. These files have been preconfigured for you. Run the following command:

```bash
cp -r deploy/k8s/helm-ingress/* deploy/k8s/helm-simple
```

You can view this step with the below image.

:::image type="content" source="../media/helm-ingress-manifest-replace.png" alt-text="Helm ingress manifest update" lightbox="../media/helm-ingress-manifest-replace.png":::

> [!NOTE]
> In the above step, a new ingress file will be created for the `websalesagg` app because it was newly created. For others, it will replace the existing ones.

## Clean up old ingress objects

You'll need to clean up the old ingress objects before deploying the newly annotated `azure/application-gateway` ingress object. Run the following command:

```bash
kubectl delete ingress --all
```

The preceding command deletes the existing ingress objects.
## Deploy the application with the updated ingresses

Use the following command to display the public IP of the application gateway from earlier:

```bash
cat ~/clouddrive/aspnet-learn/create-application-gateway-exports.txt
```

Replace the `{appgw-public-ip}` with the value of the variable `ESHOP_APPGATEWAYPUBLICIP` in the following command:

```bash
deploy/k8s/deploy-application.sh --registry eshopdev --hostip {appgw-public-ip}
```

:::image type="content" source="../media/eshop-app-gateway-public-ip.png" alt-text="Fetch app gateway public ip" lightbox="../media/eshop-app-gateway-public-ip.png":::

The pods are all redeployed from the public container registry used in the beginning of this module. The following output appears:

:::image type="content" source="../media/deployed-eshop-app-app-gateway.png" alt-text="Deployed websalesagg to app gateway" lightbox="../media/deployed-eshop-app-app-gateway.png":::

You can now explore the app deployed onto the new AKS. Other than the IP address, you shouldn't see any difference.

> [!NOTE]
> In this step, you'll see an error related to the `websalesagg` pod. That's because the public container registry doesn't contain a image of the Web Sales Aggregator. You'll deploy that from your private ACR in the next step. In an actual production scenario, this extra step can be avoided by deploying all the docker images from the same container registry.

## Redeploy the affected apps to the cluster

Now you'll redeploy your local changes to the cluster with the public IP address of the Application Gateway. Replace `{appgw-public-ip}` with the public IP address in `ESHOP_APPGATEWAYPUBLICIP` and then run the below command.

```bash
./deploy/k8s/deploy-affected-services.sh --ipAddress {appgw-public-ip}
```

The script redeploys the following services from your private ACR:

- *WebStatus*
- *Identity.API*
- *WebSalesAgg*

## Add the *websalesagg* client redirect URIs to IdentityDb

The existing `[Microsoft.eShopOnContainers.Service.IdentityDb]` database in the `sqldata-*` pod will not have the necessary configuration for the `websalesagg` authorize. Accordingly, you'll need to repopulate the data in `IdentityDb`. Perform the following steps:

1. Delete the SQL pod with the following command:

    ```bash
    kubectl delete pods --selector service=sqldata
    ```

1. Wait a bit for the new SQL Server pod to be ready (as shown with `kubectl get pods`), and then restart all other pods:

    ```bash
    kubectl delete pods --selector service!=sqldata
    ```

    :::image type="content" source="../media/delete-all-pods-apart-from-sql.png" alt-text="Delete all pods" lightbox="../media/delete-all-pods-apart-from-sql.png":::

1. Check the *WebStatus* app using `http://{appgw-public-ip}/webstatus/hc-ui#/healthchecks` and verify *websalesagg* is healthy. Note that this address uses the **new** IP address.

    > [!NOTE]
    > As with the initial deployment, it may take a few minutes for the health check dashboard to come up.

1. Access the *websalesagg* Swagger UI by using the `http://{appgw-public-ip}/websalesagg/` URL.

## Test `websalesagg` using Swagger UI

### Create an order

Log in to the `WebSPA` app using `http://{appgw-public-ip}/` and create an order to create data for the Sales API.

:::image type="content" source="../media/list-of-orders.png" alt-text="List of orders" lightbox="../media/list-of-orders.png":::

### Fetch sales data

- Authorize the request with the `adminuser@microsoft.com` user.
- Select the *Sales API* to fetch the API data.

Output similar to the following appears. Note the aggregated sales unit per brand has been shown for those orders created today.

:::image type="content" source="../media/websales-agg-sales-api-data.png" alt-text="Sales API data" lightbox="../media/websales-agg-sales-api-data.png":::
