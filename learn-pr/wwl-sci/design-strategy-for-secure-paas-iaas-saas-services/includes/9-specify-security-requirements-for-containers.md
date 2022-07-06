
A container is an isolated, lightweight silo for running an application
on the host operating system. Containers build on top of the host
operating system's kernel (which can be thought of as the buried
plumbing of the operating system), and contain only apps and some
lightweight operating system APIs and services that run in user mode.
While a container shares the host operating system's kernel, the
container doesn't get unfettered access to it. Instead, the container
gets an isolated--and in some cases virtualized--view of the system. For
example, a container can access a virtualized version of the file system
and registry, but any changes affect only the container and are
discarded when it stops. To save data, the container can mount
persistent storage such as an Azure Disk or a file share (including
Azure Files).

Containers are built from images that are stored in one or more
repositories. These repositories can belong to a public registry, like
Docker Hub, or to a private registry. An example of a private registry
is the Docker Trusted Registry, which can be installed on-premises or in
a virtual private cloud. You can also use cloud-based private container
registry services, including Azure Container Registry.

A publicly available container image does not guarantee security.
Container images consist of multiple software layers, and each software
layer might have vulnerabilities. To help reduce the threat of attacks,
you should store and retrieve images from a private registry, such as
Azure Container Registry or Docker Trusted Registry. In addition to
providing a managed private registry, Azure Container Registry supports
service principal-based authentication through Azure Active Directory
for basic authentication flows. This authentication includes role-based
access for read-only (pull), write (push), and other permissions.

Take advantage of solutions to scan container images in a private
registry and identify potential vulnerabilities. It's important to
understand the depth of threat detection that the different solutions
provide. For example, Azure Container Registry optionally integrates
with Microsoft Defender for Cloud to automatically scan all Linux images
pushed to a registry. Microsoft Defender for Cloud integrated Qualys
scanner detects image vulnerabilities, classifies them, and provides
remediation guidance.

Containers can spread across several clusters and Azure regions. So, you
must secure credentials required for logins or API access, such as
passwords or tokens. Ensure that only privileged users can access those
containers in transit and at rest. Inventory all credential secrets, and
then require developers to use emerging secrets-management tools that
are designed for container platforms. Make sure that your solution
includes encrypted databases, TLS encryption for secrets data in
transit, and least-privilege role-based access control. Azure Key Vault
is a cloud service that safeguards encryption keys and secrets (such as
certificates, connection strings, and passwords) for containerized
applications. Because this data is sensitive and business critical,
secure access to your key vaults so that only authorized applications
and users can access them.

There's enough change and volatility in a container ecosystem without
allowing unknown containers as well. Allow only approved container
images. Have tools and processes in place to monitor for and prevent the
use of unapproved container images. An effective way of reducing the
attack surface and preventing developers from making critical security
mistakes is to control the flow of container images into your
development environment. For example, you might sanction a single Linux
distribution as a base image, preferably one that is lean (Alpine or
CoreOS rather than Ubuntu), to minimize the surface for potential
attacks.

#### Security posture management for containers

Just like any other cloud workload, web workloads need to have an
ongoing security assessment to improve the overall security posture.
Defender for Containers helps with the core aspects of container
security, including:

-   **Environment hardening:** Defender for Containers protects your Kubernetes clusters whether they're running on Azure Kubernetes Service, Kubernetes on-premises / IaaS, or Amazon EKS. By continuously assessing clusters, Defender for Containers provides visibility into misconfigurations and guidelines to help mitigate identified threats. Learn more in Hardening.
-   **Vulnerability assessment:** Vulnerability assessment and management tools for images stored in ACR registries and running in Azure Kubernetes Service. Learn more in Vulnerability assessment.
-   **Run-time threat protection for nodes and clusters:** Threat protection for clusters and Linux nodes generates security alerts for suspicious activities. Learn more in Run-time protection for Kubernetes nodes, clusters, and hosts.

Defender for Cloud continuously assesses the configurations of your
clusters and compares them with the initiatives applied to your
subscriptions. When it finds misconfigurations, Defender for Cloud
generates security recommendations. Use Defender for Cloud's
recommendations page to view recommendations and remediate issues, as
you can see the example below:

:::image type="content" source="../media/defender-cloud-recommendations-page.png" alt-text="Use Defender for Cloud recommendations to remediate container vulnerabilities." lightbox="../media/defender-cloud-recommendations-page.png":::