# Exercise - Implement load balancer with Azure Application Gateway

## Overview

In this exercise you'll deploy an instance of Azure Application Gateway with ingress controller to load balance the traffic to different pods directly of `eShopOnContainer` services. Further to that, you'll also enable TLS configuration in Application Gateway to use HTTPS instead of HTTP.

For that, you'll deploy another AKS cluster to the resource group you already created. You can't configure an Application Gateway for the cluster you created in the initial deployment, because it doesn't have the advanced networking option.

In this exercise you will:

- Create an Azure Application Gateway instance.
- Enable the AGIC in the AKS cluster.
- Configure the existing ingresses to use the AGIC.
- Deploy the application with the updated ingresses.
- Clean up old ingress objects.
- Redeploy the affected apps to the cluster.
- Add the `websalesagg` client redirect uris in the `IdentityDb`.
- Test `websalesagg` using Swagger UI.

## Create an Azure Application Gateway instance

Run the script:

```bash
./create-application-gateway.sh
```

The script will perform the following tasks:

- Create a VNET for the Application Gateway
- Create a subnet in the VNET created in the previous step.
- Create a public IP.
- Create the Application Gateway.

You should get something like this:

![Output from the create-application-gateway script. Creates subnet, creates public IP, and creates Application Gateway.](media/create-application-gateway.png)

This script will also take a while, so in the meantime you can continue checking out the [ingresses configuration](#configure-the-existing-ingresses).

## Enable the AGIC in the AKS cluster

Run the script:

```bash
./enable-agic-adon.sh
```

As there is already an existing cluster running, you'll not create a new cluster and configure application gateway with advance networking. Instead you'll follow a brownfield approach and enable the AGIC as an feature on the existing AKS instance.

The script will perform the following tasks:

- Enable the AGIC as an adon feature in the existing Kubernetes cluster.
- Enable the bi-directional peering between the existing VNET network of AKS cluster and the newly created VNET of the Application Gateway cluster.

![Initial output from the enable-agic-adon.sh script.](media/enable-adon.png)

And ends like this:

![Final output from the enable-agic-adon.sh.](media/enable-adon-last.png)

## Configure the existing ingresses

There are a couple of changes that have to be made on the ingresses for the AGIC to use them:

- Change the annotations
- Change the path definitions

Regarding annotations there are also a couple of changes.

- First, all ingresses must include the `kubernetes.io/ingress.class: azure/application-gateway` annotation for the AGIC to watch for changes in them.
- Then, if the ingress needs to change the url before routing to the backend, you have to include the `appgw.ingress.kubernetes.io/backend-path-prefix` annotation to implement the url rewriting.

You can see the change details in the next sample:

- NGINX configuration <br><br>

    ```yml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
    name: seq
    labels:
      app: eshop
      service: seq
    annotations:
      kubernetes.io/ingress.class: "nginx"
      nginx.ingress.kubernetes.io/use-regex: "true"
      nginx.ingress.kubernetes.io/rewrite-target: /$2
    spec:
    rules:
    {{- if .Values.useHostName }}
    - host: {{ .Values.host }}
      http:
    {{- else }}
    - http:
    {{- end }}
        paths:
        - path: /seq(/|$)(.*)
          backend:
            serviceName: seq
            servicePort: 80
    ```

- Application Gateway Ingress Controller configuration<br><br>

    ```yml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
    name: seq
    labels:
      app: eshop
      service: seq
    annotations:
      kubernetes.io/ingress.class: azure/application-gateway
      appgw.ingress.kubernetes.io/backend-path-prefix: /
    spec:
    rules:
    {{- if .Values.useHostName }}
    - host: {{ .Values.host }}
      http:
    {{- else }}
    - http:
    {{- end }}
        paths:
        - path: /seq/*
          backend:
            serviceName: seq
            servicePort: 80
    ```

The ingress configuration for the AGIC is usually simpler than for NGINX.

The next table summarizes the changes that have to be made to all ingresses:

| chart | file | ingress-name | path-value | backend-path-prefix |
|--|--|--|--|--|
| apigateway | ingress-gateway | ingress-gw-c | /apigateway/c/* | /catalog-api/ |
| apigateway | ingress-gateway | ingress-gw-b | /apigateway/b/* | /basket-api/ |
| apigateway | ingress-gateway | ingress-gw-o | /apigateway/o/* | /ordering-api/ |
| apigateway | ingress-gateway | ingress-gw-cp | /apigateway/cp/* | /webshoppingagg/ |
| apigateway | ingress-gateway | ingress-gw-signalr | /apigateway/hub/notificationhub* | /hub/notificationhub |
| basket | ingress | basket | /basket-api/* |  |
| catalog | ingress | catalog | /catalog-api/* |  |
| coupon | ingress | coupon | /coupon-api/* |  |
| identity | ingress | identity | /identity/* |  |
| ordering | ingress | ordering | /ordering-api/* |  |
| seq | ingress | seq | /seq/* | / |
| webspa | ingress | webspa | /* |  |
| webstatus | ingress | webstatus | /webstatus/* |  |

> [!NOTE]
>
> The `ingress-gw-signalr` configurations end with `...notificationhub*` and `...notificationhub`, without a `/`, it's not a typo.

The table above can be read like:

- In the `deploy/k8s/helm-simple/{chart}/templates/{file}` file
- Change the `path` property to `{path-value}` for the ingress named `{ingress-name}`
- Add the `appgw.ingress.kubernetes.io/backend-path-prefix:{backend-path-prefix}` annotation (if it has value).

Note: Keep in mind that all ingresses must contain the `kubernetes.io/ingress.class: azure/application-gateway` annotation.

You can use VS Code's search feature to make it easier to update the ingresses, as shown in the next image:

![Image description follows in text.](media/update-ingresses-vscode.png)

In the preceding image you can see the searching for `kind: ingress` in VS Code makes it easy to identify all files that have to be updated.

If you don't feel like doing this task in the editor (which we recommend to reinforce learning 😉), you can also copy all files from the `helm-ingress` folder that already contains the updated ingresses, running this command from the `deploy/k8s` folder:

```bash
cp -r ./helm-ingress/* ./helm-simple
```

## Clean up old ingress objects

You'll need to clean up the old ingress objects before deploying the newly annotated `azure/application-gateway` ingress object and populate those with the public IP of the Application Gateway. So you need to run the below script.

```bash
kubectl delete ingress --all
```

## Deploy the application with the updated ingresses

Just run the following script, replacing the `{appgw-public-ip}` with the value of the variable `ESHOP_APPGATEWAYPUBLICIP` you got when creating the Application Gateway:

```bash
./deploy-application.sh --registry eshopdev --hostip {appgw-public-ip}
```

You should get an output just like the one from the initial deployment, only the IP will be different:

![Output from the deploy-application script. Highlighting the resulting deployment urls.](media/deploy-aks-application-gateway.png)

You can now explore the application deploy onto the new AKS, although, other than the IP, you shouldn't see any difference.

## Redeploy the affected apps to the cluster

Replace `{appgw-public-ip}` with the public ip address of the application gateway and then run the below command to deploy the affected services again to the cluster.

```bash
./deploy-affected-services.sh --ipAddress {appgw-public-ip}
```

The above script will deploy the following services :

- `WebStatus`
- `Identity.API`
- `WebSalesAgg`

![Deploy affected services](media/deploy-affected-services.png)

## Add the `websalesagg` client redirect uris in the `IdentityDb`

- The existing `[Microsoft.eShopOnContainers.Service.IdentityDb]` database of the `SQL` container will not have the necessary configuration for the `websalesagg` authorize.
- So, you'll need to repopulate the data in the `IdentityDb`.
- Delete the SQL related pod by using the below command.

    ```bash
    kubectl delete pods --selector service=sqldata
    ```

- Wait until the SQL Server pod is ready to accept connections and then restart all other pods. Then run the command mentioned below to restart the other instances of the app to populate all the necessary data in the respective databases.

    ```bash
    kubectl delete pods --selector service!=sqldata
    ```

- Check the `webstatus` app using `http://{appgw-public-ip}/webstatus/hc-ui#/healthchecks` and make sure `websalesagg` is up and running.
- Then you can access the `websalesagg` swagger ui by using `http://{appgw-public-ip}/websalesagg` url.

## Test `websalesagg` using Swagger UI

### Create an order

- It's important that you login to the `WebSPA` app using `http://{appgw-public-ip}/` and created a order. Otherwise you'll not able to see any data in the Sales API.

![List of orders](media/list-of-orders.png)

### Fetch the sales data

- Authorize the request with the `adminuser@microsoft.com` user.
- And click on the `Sales API` to fetch the API data.
- You'll see the below output, where aggregated sales unit per brand has been shown for those orders which has been created today.

![Sales API Data](media/websales-agg-sales-api-data.png)

| [TOC](../README.md) | [NEXT >](knowledge-check.md) |
