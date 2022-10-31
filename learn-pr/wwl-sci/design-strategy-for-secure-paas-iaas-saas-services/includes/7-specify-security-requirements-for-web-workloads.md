
When taking into consideration the security requirements for your web
workloads, you need to include Azure App Service. Azure App Service is
an HTTP-based service for hosting web applications, REST APIs, and
mobile back ends. Applications run and scale with ease on both Windows
and Linux-based environments.

The platform components of App Service, including Azure VMs, storage,
network connections, web frameworks, management, and integration
features, are actively secured and hardened. Security requirements for
Azure App Service include:

-   **Ensure that you secure your apps with HTTPS:** When your app is
    created, its default domain name (`{{app_name}}.azurewebsites.net`) is
    already accessible using HTTPS. If you configure a custom domain for
    your app, you should also secure it with a TLS/SSL certificate so
    that client browsers can make secured HTTPS connections to your
    custom domain.

-   **Disable insecure protocols:** To secure your app against all
    unencrypted (HTTP) connections, App Service provides one-click
    configuration to enforce HTTPS. Unsecured requests are turned away
    before they even reach your application code. For more information,
    see Enforce HTTPS.

-   **Create static IP restrictions:** by default, your App Service app
    accepts requests from all IP addresses from the internet, but you
    can limit that access to a small subset of IP addresses. App Service
    on Windows lets you define a list of IP addresses that are allowed
    to access your app.

-   **Enable client authentication and authorization:** Azure App
    Service provides turn-key authentication and authorization of users
    or client apps. When enabled, it can sign in users and client apps
    with little or no application code. You may implement your own
    authentication and authorization solution or allow App Service to
    handle it for you instead.

-   **Don't store application secrets:** application secrets, such as
    database credentials, API tokens, and private keys in your code or
    configuration files. The commonly accepted approach is to access
    them as environment variables using the standard pattern in your
    language of choice.

-   **Implement network isolation:** the isolated tier gives you
    complete network isolation by running your apps inside a dedicated
    App Service environment. An App Service environment runs in your own
    instance of Azure Virtual Network.

#### Security posture management for App Service

Just like any other cloud workload, web workloads need to have an
ongoing security assessment to improve the overall security posture.
Microsoft Defender for App Service uses the scale of the cloud to
identify attacks targeting applications running over App Service.
Attackers probe web applications to find and exploit weaknesses. Before
being routed to specific environments, requests to applications running
in Azure go through several gateways, where they're inspected and
logged. This data is then used to identify exploits and attackers, and
to learn new patterns that will be used later.

When you enable Microsoft Defender for App Service, you immediately
benefit from the following services offered by this Defender plan:

-   Security assessment: Defender for App Service assesses the resources
    covered by your App Service plan and generates security
    recommendations based on its findings. Use the detailed instructions
    in these recommendations to harden your App Service resources.

-   Threat Detection: Defender for App Service detects a multitude of
    threats to your App Service resources by monitoring:

    -   the VM instance in which your App Service is running, and its
        management interface

    -   the requests and responses sent to and from your App Service
        apps

    -   the underlying sandboxes and VMs

    -   App Service internal logs - available thanks to the visibility
        that Azure has as a cloud provider

As a cloud-native solution, Defender for App Service can identify attack
methodologies applying to multiple targets. For example, from a single
host it would be difficult to identify a distributed attack from a small
subset of IPs, crawling to similar endpoints on multiple hosts.

