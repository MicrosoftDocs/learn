# Knowledge check

## Check your knowledge

1. Mark all the correct statements about Ingress in a typical Kubernetes cluster:

   - The ingress resources can route traffic to any service.
   - The ingress controller routes traffic in the cluster. - **CORRECT ANSWER**
   - NGINX is frequently used as an ingress controller. - **CORRECT ANSWER**
   - The ingress resources are configuration objects used by the ingress controller. - **CORRECT ANSWER**
   - The Application Gateway Ingress Controller routes traffic in the cluster.

2. Select the correct statement about TLS

   - *cert-manager* can only issue certificates for an external CA.
   - It's safe to install Let's Encrypt staging certificate in your day-to-day browser.
   - *cert-manager* automates the certificates issuing process in the cluster. - **CORRECT ANSWER**
   - It's possible to get a certificate from Let's Encrypt for a deployment to an IP-address.

3. The BFF pattern can be implemented by configuring routes with an API Gateway

   - True
   - False

4. Mark the correct answers about the Azure Application Gateway

   - The Application Gateway "lives" inside the AKS cluster to route traffic to the pods.
   - The Application Gateway uses a special network configuration to access the pods directly. - **CORRECT ANSWER**
   - The NGINX ingress controller can use the Application Gateway if the ingresses have the `kubernetes.io/ingress.class: azure/application-gateway` annotation.
   - All ingresses need the `appgw.ingress.kubernetes.io/backend-path-prefix` annotation to use the Application Gateway.
   - The Application Gateway Ingress Controller must be installed in the cluster, with permissions to update the Application Gateway configuration. - **CORRECT ANSWER**

| [TOC](../README.md) | [NEXT >](summary.md) |
