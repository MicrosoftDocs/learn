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
./create-application-gateway.sh
```

The script does the following tasks:

- Creates a virtual network for Application Gateway.
- Creates a subnet in the virtual network created in the previous step.
- Creates a public IP address.
- Creates the Application Gateway instance.

Note the displayed Application Gateway public IP address. You'll need it later.

> [!NOTE]
> The script takes several minutes to finish.

## Enable AGIC in the AKS cluster

You've created an instance of the Azure Application Gateway service. Now enable AGIC in the cluster by using the following command:

```bash
./enable-agic-addon.sh
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

Along with the *websalesagg* service, you need to update the NGINX configuration for each service to make it available for AGIC. All of the service configurations in the *helm-simple* directory require changes. For simplicity, you'll copy files from the *helm-ingress* folder. These files have been preconfigured for you.

Run the following command:

```bash
cp -r ./helm-ingress/* ./helm-simple
```

> [!NOTE]
> In the preceding step, a new ingress file is created for the *websalesagg* app because it was newly created. For other apps, the file will replace the existing ones.

## Clean up old ingress objects

You need to clean up the old ingress objects before deploying the newly annotated `azure/application-gateway` ingress object. Run the following command to delete the existing ingress objects:

```bash
kubectl delete ingress --all
```

## Deploy the application with the updated ingresses

Replace `{appgw-public-ip}` with the Application Gateway public IP address (from earlier) in the following command:

```bash
./deploy-application.sh --registry eshoplearn --hostip {appgw-public-ip}
```

You can now explore the app again using the URLs in *deployment-urls.txt*. The file has been updated to reflect the new IP address. When browsing the app, note there are no differences other than the IP address.

> [!NOTE]
> If you run `kubectl get pods`, you'll see the *websalesagg* pod ends up in a `ImagePullBackOff` status. That's because the public container registry doesn't contain a image of the Web Sales aggregator. You'll deploy that from your private Azure Container Registry instance in the next step. In an actual production scenario, you can avoid this extra step by deploying all the Docker images from the same container registry.

## Redeploy the affected apps to the cluster

Now you'll redeploy your local changes to the cluster with the public IP address of the Application Gateway instance. Replace `{appgw-public-ip}` with the Application Gateway public IP address, and then run the following command:

```bash
./deploy-affected-services.sh --ipAddress {appgw-public-ip}
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

1. Check the WebStatus app using the URL in *deployment-urls.txt* and verify that *websalesagg* is healthy. This address uses the new IP address.

    > [!NOTE]
    > As with the initial deployment, the health check dashboard might take a few minutes to come up.

1. Sign in to the *WebSPA* app by using the URL in *deployment-urls.txt*. Instead of using the demo user, sign in using the address `adminuser@microsoft.com`. Add an item to your shopping bag and checkout.
1. Access the *websalesagg* Swagger UI using the `http://{appgw-public-ip}/websalesagg/swagger/index.html` URL.
1. Select the **Authorize** button.
1. In the **Available authorizations** dialog, select all the scopes and select **Authorize**.
1. After being redirected to the eShop UI, select **YES, ALLOW**.
1. Back in the Swagger UI, expand the **GET** operation and select **Try it out**. Select the **Execute** button to send the authorized request.

    The response body resembles the following JSON:

    ```json
    [
      {
        "brandName": ".NET",
        "totalSales": 1
      }
    ]
    ```

Congratulations! You've created and configured an Azure Application Gateway Ingress Controller!
