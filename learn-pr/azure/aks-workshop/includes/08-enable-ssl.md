The NGINX ingress controller supports TLS termination. There are several ways to retrieve and configure certificates for HTTPS. This unit demonstrates how to use [cert-manager](https://github.com/jetstack/cert-manager), which provides automatic [Let's Encrypt](https://letsencrypt.org/) certificate generation and management functionality.

In this exercise, you deploy cert-manager and configure it to automatically issue Let's Encrypt certificates. You also configure the ingress you created previously to serve encrypted SSL/TLS traffic through the generated certificates.

![Deployed resources on the Azure Kubernetes Service cluster](../media/08-arch-5.svg)

## Install cert-manager

Install cert-manager by using Helm. Configure it to use Let's Encrypt as the certificate issuer.

1. Create a namespace for cert-manager.

    ```bash
    kubectl create namespace cert-manager
    ```

1. You can find cert-manager in the Jetstack Helm repository. Add the Jetstack Helm repository.

    ```bash
    helm repo add jetstack https://charts.jetstack.io
    helm repo update
    ```

1. You can now go ahead and install cert-manager. Install the cert-manager custom resource definition (CRD).

    ```bash
    kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.13/deploy/manifests/00-crds.yaml
    ```

1. Install the cert-manager Helm chart.

    ```bash
    helm install cert-manager \
        --namespace cert-manager \
        --version v0.13.0 \
        jetstack/cert-manager
    ```

1. After the installation is finished, you'll get an output similar to this example.

    ```output
    NAME: cert-manager
    LAST DEPLOYED: Tue Jan  7 13:11:19 2020
    NAMESPACE: cert-manager
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    cert-manager has been deployed successfully!
    ```

1. Verify the installation by checking the `cert-manager` namespace for running pods.

    ```bash
    kubectl get pods --namespace cert-manager
    ```

    You'll see that the `cert-manager`, `cert-manager-cainjector`, and `cert-manager-webhook` pod is in a `Running` state. It might take a couple of minutes to provision the web hook required for the TLS assets.

    ```output
    NAME                                       READY   STATUS    RESTARTS   AGE
    cert-manager-5c6866597-zw7kh               1/1     Running   0          2m
    cert-manager-cainjector-577f6d9fd7-tr77l   1/1     Running   0          2m
    cert-manager-webhook-787858fcdb-nlzsq      1/1     Running   0          2m
    ```

## Create a Kubernetes configuration file for ClusterIssuer with Let's Encrypt

You need to set up ClusterIssuer before you can begin issuing certificates. The cluster issuer acts as an interface to a certificate-issuing service such as Let's Encrypt.

1. Edit the file called `cluster-issuer.yaml` by using the integrated editor.

    ```bash
    code cluster-issuer.yaml
    ```

1. Replace the existing content in the file with the following text. Note the change of the service `type` to `ClusterIP`.

    ```yaml
    apiVersion: cert-manager.io/v1alpha2
    kind: ClusterIssuer
    metadata:
      name: letsencrypt
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: <your email> # IMPORTANT: Replace with a valid email from your organization
        privateKeySecretRef:
          name: letsencrypt
        solvers:
        - http01:
            ingress:
              class: nginx
    ```

    In the `email` key, update the value by replacing `<your email>` with a valid email from your organization.

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

## Apply the cluster-issuer configuration to create a cluster issuer

1. Apply the configuration by using the `kubectl apply` command. Deploy the cluster-issuer configuration in the `ratingsapp` namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f cluster-issuer.yaml
    ```

    You'll get an output similar to this example.

    ```output
    clusterissuer.cert-manager.io/letsencrypt created
    ```

## Edit the Kubernetes ingress file for the ratings web service to enable SSL/TLS

1. Edit the file called `ratings-web-ingress.yaml` by using the integrated editor.

    ```bash
    code ratings-web-ingress.yaml
    ```

1. Replace the existing content in the file with the following text. Note the addition of the `cert-manager.io/issuer` annotation and the new `tls` section.

    ```yaml
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ratings-web-ingress
      annotations:
        kubernetes.io/ingress.class: nginx
        cert-manager.io/cluster-issuer: letsencrypt
    spec:
      tls:
        - hosts:
          - frontend.<ingress ip>.nip.io # IMPORTANT: update <ingress ip> with the dashed public IP of your ingress, for example frontend.13-68-177-68.nip.io
          secretName: ratings-web-cert
      rules:
      - host: frontend.<ingress ip>.nip.io # IMPORTANT: update <ingress ip> with the dashed public IP of your ingress, for example frontend.13-68-177-68.nip.io
        http:
          paths:
          - backend:
              serviceName: ratings-web
              servicePort: 80
            path: /
    ```

    In this file, update the `<ingress ip>` value in the `host` key with the *dashed* public IP of the ingress you retrieved earlier, for example, frontend.13-68-177-68.nip.io. This value allows you to access the ingress via a host name instead of an IP address.

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

## Apply the updated Kubernetes ingress file

1. Apply the configuration by using the `kubectl apply` command. Deploy the updated Kubernetes ingress file in the `ratingsapp` namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-web-ingress.yaml
    ```

    You'll get an output similar to this example.

    ```output
    ingress.networking.k8s.io/ratings-web-ingress configured
    ```

1. Verify that the certificate was issued.

    ```bash
    kubectl describe cert ratings-web-cert --namespace ratingsapp
    ```

    You'll get an output similar to this example.

    ```output
    Name:         ratings-web-cert
    Namespace:    ratingsapp
    API Version:  cert-manager.io/v1alpha2
    Kind:         Certificate

    [..]

    Spec:
      Dns Names:
        frontend.13-68-177-68.nip.io
      Issuer Ref:
        Group:      cert-manager.io
        Kind:       ClusterIssuer
        Name:       letsencrypt
      Secret Name:  ratings-web-cert
    Status:
      Conditions:
        Last Transition Time:  2020-01-07T22:27:23Z
        Message:               Certificate is up to date and has not expired
        Reason:                Ready
        Status:                True
        Type:                  Ready
      Not After:               2020-04-06T21:27:22Z
    Events:
      Type    Reason        Age   From          Message
      ----    ------        ----  ----          -------
      Normal  GeneratedKey  36s   cert-manager  Generated a new private key
      Normal  Requested     36s   cert-manager  Created new CertificateRequest resource "ratings-web-cert-1603291776"
      Normal  Issued        34s   cert-manager  Certificate issued successfully
    ```

## Test the application

Open the host name you configured on the ingress in a web browser over SSL/TLS, for example, at https:\//frontend.13-68-177-68.nip.io, to view and interact with the application.

:::image type="content" source="../media/08-ratings-web-ingress-tls.png" alt-text="Screenshot of the ratings-web application." loc-scope="other"::: <!-- no-loc -->

Verify that the front end is accessible over HTTPS and that the certificate is valid.

:::image type="content" source="../media/08-ratings-web-cert.png" alt-text="Screenshot of the valid SSL/TLS certificate." loc-scope="other":::

In this exercise, you deployed cert-manager and configured it to issue Let's Encrypt certificates automatically. You then configured the ingress you created earlier to serve encrypted SSL/TLS traffic through the generated certificates.
