You can restrict access to your Azure App Service app by enabling different types of authentication for it. One way to do it is to request a client certificate when the client request is over TLS/SSL and validate the certificate. This mechanism is called TLS mutual authentication or client certificate authentication. This article shows how to set up your app to use client certificate authentication If you access your site over HTTP and not HTTPS, you will not receive any client certificate. So if your application requires client certificates, you should not allow requests to your application over HTTP.

:::image type="content" source="../media/az500-web-app-certificates-171b35fc.png" alt-text="az500 web app certificate":::


## Enable client certificates

To set up your app to require client certificates, you can switch On the **Require incoming certificate** by selecting Configuration &gt; General Settings from the Azure portal or you need to set the clientCertEnabled setting for your app to true.

## Exclude paths from requiring authentication

When you enable mutual auth for your application, all paths under the root of your app will require a client certificate for access. To allow certain paths to remain open for anonymous access, you can define exclusion paths as part of your application configuration.

Exclusion paths can be configured by selecting **Configuration &gt; General Settings** and defining an exclusion path. In this example, anything under /public path for your application would not request a client certificate

## Access client certificate

In App Service, TLS termination of the request happens at the frontend load balancer. When forwarding the request to your app code with client certificates enabled, App Service injects an X-ARR-ClientCert request header with the client certificate. App Service does not do anything with this client certificate other than forwarding it to your app. Your app code is responsible for validating the client certificate.
