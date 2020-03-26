The online security and privacy of user data is a primary concern for Fruit Smoothies as a company. It's important the ratings website allows HTTPS connections to all customers. NGINX ingress controller supports TLS termination and provides several ways to retrieve and configure certificates for HTTPS. This unit demonstrates how to use *cert-manager*, which provides automatic *Let's Encrypt* certificate generation and management functionality.

:::image type="content" source="../media/08-arch-5.svg" border="false" alt-text="Diagram that shows the deployed resources on the Azure Kubernetes Service cluster.":::

In this exercise, we'll deploy cert-manager and configure it to automatically issue Let's Encrypt certificates. We'll also configure the ingress created earlier to serve encrypted SSL/TLS traffic through the generated certificates.

Before we start with the exercise steps, let's define some of the items mentioned.

### What is a Let's Encrypt?

Let's Encrypt is a nonprofit Certificate Authority that provides TLS certificates. Let's Encrypt allows us to set up an HTTP server and have it automatically obtain a browser-trusted certificate. The process of retrieving and installing a certificate is fully automated without human intervention and managed by running a certificate management agent on the webserver. For more information about Let's Encrypt, see the *learn more* section at the end of this module.

### What is cert-manager?

Cert-manager is a Kubernetes certificate management controller that makes it possible to automate certificate management in cloud-native environments. Cert-manager supports various sources including Let's Encrypt, HashiCorp Vault, Venafi, simple signing key pairs, or self-signed certificates. We'll use cert-manager to ensure our website's certificate is valid and up to date, and attempt to renew certificates at a configured time before the certificate expires.

### What is a Kubernetes custom resource definition (CRD)?

A Kubernetes custom resource is an object that allows us to extend the Kubernetes API or to introduce our own API into a cluster. We use custom resource definition (CRD) files to define our object kinds and the API Server handle the lifecycle of the object.


## Install cert-manager

We'll use Helm to install cert-manager and then configure it to use Let's Encrypt as the certificate issuer.

1. Let's start by creating a namespace for cert-manager.

    ```bash
    kubectl create namespace cert-manager
    ```

1. We'll use the Jetstack Helm repository to find and install cert-manager. First, we'll add the Jetstack Helm repository by running the code below.

    ```bash
    helm repo add jetstack https://charts.jetstack.io
    helm repo update
    ```

1. Next, we'll install cert-manager by installing the cert-manager custom resource definition (CRD).

    ```bash
    kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.14/deploy/manifests/00-crds.yaml
    ```

1. Install the cert-manager Helm chart

    ```bash
    helm install cert-manager \
        --namespace cert-manager \
        --version v0.14.0 \
        jetstack/cert-manager
    ```

1. We'll see output similar to the example below when the installation completes.

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

    We'll see that the `cert-manager`, `cert-manager-cainjector`, and `cert-manager-webhook` pod is in a `Running` state. It might take a couple of minutes to provision the web hook required for the TLS assets.

    ```output
    NAME                                       READY   STATUS    RESTARTS   AGE
    cert-manager-5c6866597-zw7kh               1/1     Running   0          2m
    cert-manager-cainjector-577f6d9fd7-tr77l   1/1     Running   0          2m
    cert-manager-webhook-787858fcdb-nlzsq      1/1     Running   0          2m
    ```

## Create a Kubernetes configuration file for ClusterIssuer with Let's Encrypt

Cert-manager will ensure that our website's certificate is valid and up to date, and even attempt to renew certificates at a configured time before the certificate expires. However, we need to set up a *ClusterIssuer* before we can begin the certificate issuing process. The cluster issuer acts as an interface to a certificate-issuing service such as Let's Encrypt.

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

    In the `email` key, we'll update the value by replacing `<your email>` with a valid certificate administrator email from our organization.

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

## Apply the cluster-issuer configuration to create a cluster issuer

1. Apply the configuration by using the `kubectl apply` command. Deploy the cluster-issuer configuration in the `ratingsapp` namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f cluster-issuer.yaml
    ```

    We'll see an output similar to this example.

    ```output
    clusterissuer.cert-manager.io/letsencrypt created
    ```

## Edit the Kubernetes ingress file for the ratings web service to enable SSL/TLS

The last part of the configuration is to configure the Kubernetes ingress file for the ratings web service to enable SSL/TLS.

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

    In this file, update the `<ingress ip>` value in the `host` key with the *dashed* public IP of the ingress we retrieved earlier, for example, frontend.13-68-177-68.nip.io. This value allows us to access the ingress via a host name instead of an IP address.

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

## Apply the updated Kubernetes ingress file

1. Apply the configuration by using the `kubectl apply` command. Deploy the updated Kubernetes ingress file in the `ratingsapp` namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-web-ingress.yaml
    ```

    We'll see an output similar to this example.

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

Open the host name we configured on the ingress in a web browser over SSL/TLS to view and interact with the application. For example, at https:\//frontend.13-68-177-68.nip.io.

:::image type="content" source="../media/08-ratings-web-ingress-tls.png" alt-text="Screenshot of the ratings-web application." loc-scope="other"::: <!-- no-loc -->

Verify that the front end is accessible over HTTPS and that the certificate is valid.

:::image type="content" source="../media/08-ratings-web-cert.png" alt-text="Screenshot of the valid SSL/TLS certificate." loc-scope="other":::

In this exercise, we deployed cert-manager and configured it to issue Let's Encrypt certificates automatically. We then configured the ingress we created earlier to serve encrypted TLS/SSL traffic through the generated certificates.
