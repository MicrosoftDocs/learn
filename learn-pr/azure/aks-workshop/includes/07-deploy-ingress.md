A Kubernetes service is a layer 4 load balancer. A Kubernetes ingress controller is a piece of software that provides layer 7 features such as reverse proxy, configurable traffic routing, and TLS termination for Kubernetes services. 

You use Kubernetes ingress resources to configure the ingress rules and routes for individual Kubernetes services. In this exercise, you use an ingress controller and ingress rules that allow a single IP address to route traffic to multiple services in a Kubernetes cluster.

There are several options for running Kubernetes ingress on Azure Kubernetes Service (AKS), such as Azure Application Gateway, Ambassador, HAProxy, Kong, NGINX, and Traefik. The ingress controllers are exposed to the internet by using a Kubernetes service of type LoadBalancer. The ingress controller watches and implements Kubernetes ingress resources, which create routes to application endpoints.

In this exercise, you deploy a basic Kubernetes ingress controller by using NGINX. Then you configure the ratings front-end service to use that ingress for traffic.

![Deployed resources on the Azure Kubernetes Service cluster](../media/07-arch-4.svg)

## Deploy the NGINX ingress controller with Helm

1. Create a namespace for the ingress.

    ```bash
    kubectl create namespace ingress
    ```

1. Install the NGINX ingress controller. NGINX ingress is part of the stable Helm repository you configured earlier when you installed MongoDB. For added redundancy, two replicas of the NGINX ingress controllers are deployed with the `--set controller.replicaCount` parameter. The ingress controller also needs to be scheduled on a Linux node. Windows Server nodes shouldn't run the ingress controller. A node selector is specified by using the `--set nodeSelector` parameter to tell the Kubernetes scheduler to run the NGINX ingress controller on a Linux-based node.

    ```bash
    helm install nginx-ingress stable/nginx-ingress \
        --namespace ingress \
        --set controller.replicaCount=2 \
        --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
        --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
    ```

1. After the installation is finished, you'll get an output similar to this example.

    ```output
    NAME: nginx-ingress
    LAST DEPLOYED: Mon Jan  6 15:18:42 2020
    NAMESPACE: ingress
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    The nginx-ingress controller has been installed.
    It may take a few minutes for the LoadBalancer IP to be available.
    You can watch the status by running 'kubectl --namespace ingress get services -o wide -w nginx-ingress-controller'
    ```

1. Next, let's check the public IP of the ingress service. It takes a few minutes for the service to acquire the public IP. Run the following command with a *watch* by adding the `-w` flag to see it update in real time. Select <kbd>Ctrl+C</kbd> to stop watching.

    ```bash
    kubectl get service nginx-ingress-controller --namespace ingress -w
    ```

    The service shows `EXTERNAL-IP` as `<pending>` for a while until it finally changes to an actual IP.

    ```output
    NAME                       TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)                      AGE
    nginx-ingress-controller   LoadBalancer   10.2.0.162    13.68.177.68     80:32010/TCP,443:30245/TCP   3m30s
    ```

    Make a note of that EXTERNAL-IP, for example, 13.68.177.68.

## Edit the Kubernetes service file for the ratings web service

There's no need to use a public IP for the service because you're going to expose the deployment by using an ingress. That's why you can set the type of service to be `ClusterIP` instead of `LoadBalancer`.

1. Edit the file called `ratings-web-service.yaml` by using the integrated editor.

    ```bash
    code ratings-web-service.yaml
    ```

1. Replace the existing content in the file with the following text. Note the change of the service `type` to `ClusterIP`.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: ratings-web
    spec:
      selector:
        app: ratings-web
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
      type: ClusterIP
    ```

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

1. Changing the value of `type` on a deployed service isn't allowed. You delete the service and re-create it with the changed configuration.

    Run the following command to delete the service.

    ```bash
    kubectl delete service \
        --namespace ratingsapp \
        ratings-web
    ```

    Run the following command to re-create the service.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-web-service.yaml
    ```

## Create an ingress route file for the ratings web service

1. Edit the file called `ratings-web-ingress.yaml` by using the integrated editor.

    ```bash
    code ratings-web-ingress.yaml
    ```

1. Paste the following text in the file.

    ```yaml
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ratings-web-ingress
      annotations:
        kubernetes.io/ingress.class: nginx
    spec:
      rules:
      - host: frontend.<ingress ip>.nip.io # IMPORTANT: update <ingress ip> with the dashed public IP of your ingress, for example frontend.13-68-177-68.nip.io
        http:
          paths:
          - backend:
              serviceName: ratings-web
              servicePort: 80
            path: /
    ```

    In this file, update the `<ingress ip>` value in the `host` key with the *dashed* public IP of your ingress that you retrieved earlier, for example, `frontend.13-68-177-68.nip.io`. This value allows you to access the ingress via a host name instead of an IP address. In the next unit, you'll configure SSL/TLS on that host name.

    > [!NOTE]
    > In this example, you use [nip.io](https://nip.io), which is a free service that provides wildcard DNS. You can use alternatives such as [xip.io](http://xip.io) or [sslip.io](https://sslip.io). Alternatively, you can use your own domain name and set up the proper DNS records.

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

## Apply the Kubernetes ingress route file to create a load-balanced service

1. Apply the configuration by using the `kubectl apply` command. You'll deploy the ingress route file in the `ratingsapp` namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-web-ingress.yaml
    ```

    You'll get an output similar to this example.

    ```output
    ingress.networking.k8s.io/ratings-web-ingress created
    ```

## Test the application

Open the host name you configured on the ingress in a web browser, for example, at <http://frontend.13-68-177-68.nip.io>, to view and interact with the application.

![Screenshot of the ratings-web application](../media/07-ratings-web-ingress.png)

In this exercise, you deployed an NGINX ingress controller and updated the **ratings-web** service to be accessible only from within the cluster. You then created an ingress route to reverse proxy the deployment of the **ratings-web** service through a host name.
