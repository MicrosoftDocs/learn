It is critical to ensure that you design your internal CA in the optimal manner. Your design will have significant implications to security and operational aspects of your PKI environment.

## Designing AD CS-based hierarchy

Before implementing AD CS, you first should design your CA hierarchy. As part of your design, you should decide how many CA tiers you need and what will be the purpose of the CA in each tier. We don't recommend building a CA hierarchy deeper than three levels, unless it is in a complex, highly secure, or distributed environment. Most commonly, CA hierarchies have two levels, with the root CA at the top level and a subordinate, issuing CA on the second level. Usually, you use the root CA to build the CA hierarchy. In such case, the root CA remains offline while you rely on the subordinate CA to issue and manage certificates.

> [!NOTE]
> A multilevel CA hierarchy isn't mandatory. For smaller, less complex environments, you can implement a root CA only. In such case, the root CA also provides certificate issuance and management functionality.

Some more complex CA designs include:

 -  CA hierarchies with a policy CA. Policy CAs are subordinate CAs that reside directly under the root CA and above other, subordinate CAs in a CA hierarchy. You use policy CAs to issue CA certificates to their subordinate CAs. The CA certificates reflect the policies and procedures that an organization implements to secure its PKI, the processes that validate the identity of certificate holders, and the processes that enforce the procedures that manage certificates. A policy CA issues certificates only to other CAs. The CAs that receive these certificates must uphold and enforce the policies that the policy CA defined. Using policy CAs isn't mandatory unless different divisions, sectors, or locations of your organization require different issuance policies and procedures. For example, an organization can implement one policy CA for all certificates that it issues internally to employees and another policy CA for all certificates that it issues to contractors.
 -  CA hierarchies with cross-certification trust. In this scenario, two independent CA hierarchies interoperate when a CA in one hierarchy issues a cross-certified CA certificate to a CA in another hierarchy. When you do this, you establish mutual trust between different CA hierarchies.

:::image type="content" source="../media/m10-ca-hierarchies-012dfb9f.png" alt-text="The various CA hierarchy options, including policy CA usage, a two-tier hierarchy, and a cross-certification trust.":::


## Standalone vs. enterprise CAs

When using AD CS, you can deploy two types of CAs: standalone and enterprise. These types of CAs are not about hierarchy, but instead, about functionality and integration with AD DS. A standalone CA doesn't depend on AD DS. An enterprise CA requires AD DS, to provide additional functionality, such as autoenrollment. Autoenrollment allows domain users and domain-joined devices to enroll automatically for certificates after you enable automatic certificate enrollment through Group Policy.

The following table details the most significant differences between standalone and enterprise CAs.

:::row:::
  :::column:::
    **Characteristic**
  :::column-end:::
  :::column:::
    **Standalone CA**
  :::column-end:::
  :::column:::
    **Enterprise CA**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Typical usage
  :::column-end:::
  :::column:::
    You typically use a standalone CA for offline CAs.
  :::column-end:::
  :::column:::
    You typically use an enterprise CA to issue certificates to users, computers, and services. You can't use it as an offline CA.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    AD DS dependencies
  :::column-end:::
  :::column:::
    A standalone CA doesn't depend on AD DS.
  :::column-end:::
  :::column:::
    An enterprise CA relies on AD DS as its configuration and registration database. An enterprise CA also uses AD DS to publish certificates and their metadata.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Certificate request methods
  :::column-end:::
  :::column:::
    Users can request certificates from a standalone CA only by using a manual procedure or web enrollment.
  :::column-end:::
  :::column:::
    Users can request certificates from an enterprise CA by using manual enrollment, web enrollment, autoenrollment, enrollment on behalf, and web services
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Certificate issuance methods
  :::column-end:::
  :::column:::
    A CA administrator must approve all requests manually.
  :::column-end:::
  :::column:::
    CA can issue certificates or deny certificate issuance automatically based on a CA administrator-defined custom configuration.
  :::column-end:::
:::row-end:::


An enterprise root CA is the most common choice when deploying a single CA in an AD DS environment. If you deploy a two-tier hierarchy with a subordinate CA in an AD DS environment, then you should consider a using standalone root CA as the root CA. This allows you to take it offline without impacting the process of managing certificates for domain users and domain-joined devices.

Another consideration is the operating system installation type. Both the Desktop Experience and the Server Core installation scenarios support AD CS. Server Core minimizes potential malicious hacker surface and the operating system maintenance overhead, which makes it the optimal choice for AD CS in an enterprise environment.

Additionally, you should keep in mind that you can't change computer names, domain name, or computer domain memberships after you deploy a CA of any type on that computer. Therefore, it is important to configure these settings before the deployment.

There are also some considerations specific to deployment of an offline, standalone root CA:

 -  Before you issue a subordinate certificate from the root CA, make sure that you provide at least one certificate revocation list distribution point (CDP) and AIA location that will be available to all clients. This is because, by default, a standalone root CA has the CDP and AIA located on itself. Therefore, when you take the root CA off the network, a revocation check will fail because the CDP and AIA locations will be inaccessible. When you define these locations, you should manually copy CRL and AIA information to that location.
 -  Set a validity period for CRLs that the root CA publishes to a long period of time, for example, one year. This means that you'll have to turn on the root CA once per year to publish a new CRL, and then you'll have to copy it to a location that is available to clients. If you fail to do so, after the CRL on the root CA expires, revocation checks for all certificates will also fail.
 -  Use Group Policy to publish the root CA certificate to a trusted root CA store on all server and client computers. You must do this manually because a standalone CA can't do it automatically, unlike an enterprise CA. You can also publish the root CA certificate to AD DS by using the certutil command-line tool.

## Demonstration

The following video demonstrates how to:

 -  Configure prerequisites for an enterprise root CA.
 -  Deploy an enterprise root CA.

The main steps in the process are:

1.  Create an AD DS environment. Create a single-domain AD DS forest.
2.  Configure prerequisites for an enterprise root CA. Install the required server role and server role services.
3.  Deploy an enterprise root CA. Configure Enterprise Root CA settings.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4McIg]

---

##