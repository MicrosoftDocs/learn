Applications and their data ultimately act as the primary store of
business value on a cloud platform. While the platform components like
identity and storage are critical elements of the security environment,
applications play an outsize role in risks to the business because:

-   **Business Processes** are encapsulated and executed by
    applications, and services need to be available and provided with
    high integrity
-   **Business Data** is stored and processed by application workloads
    and requires high assurances of confidentiality, integrity, and
    availability.

This section focuses on applications written by your organization or by
others on behalf of your organization vs. SaaS or commercially available
applications installed on IaaS VMs.

![Diagram that shows various application models.](../media/iaas-paas-application-models.png) 

Modern cloud platforms like Azure can host both legacy and modern
generations of applications

-   **Legacy**--applications are hosted on Infrastructure as a Service
    (IaaS) virtual machines that typically include all dependencies,
    including OS, middleware, and other components.
-   **Modern**--Platform as a Service (PaaS) applications don't require
    the application owner to manage and secure the underlying server
    operating systems (OSes) and are sometimes fully "Serverless" and
    built primarily using functions as a service.
-   **Hybrid**--While hybrid applications can take many forms, the
    most common is an "IaaS plus" state where legacy applications are
    transitioning to modern architecture with modern services replacing
    legacy components or being added to a legacy application.

Securing an application requires security assurances for three different
component types:

-   **Application Code**--Application Code is the logic that defines the custom
    application that you write. The security of this code is the
    application owners' responsibility in all generations of
    application architecture, including any open-source snippets or
    components included in the code. Securing the code requires
    identifying and mitigating risks from the design and implementation
    of the application. It also requires assessing the supply chain risk of included
    components.
-   **Application Services**--Application Services are the various standardized
    components that the application uses, such as databases, identity
    providers, event hubs, IoT device management, and so on.
-   **Application Hosting Platform**--This is the computing
    environment where the application actually executes and runs. In an
    enterprise with applications hosted on premises, in Azure, and in
    third-party clouds like Amazon Web Services (AWS), this (Application Hosting Platform) could take
    many forms with significant variations on who is responsible for
    security:

## Onboarding New Applications

An Azure Active Directory (Azure AD) application registration is a
critical part of your business application. Any misconfiguration or
lapse in the hygiene of your application can result in downtime or
compromise.

This article describes security best practices for the following
application registration properties.

| Redirect URI                            | It's important to keep Redirect URIs of your application up to date. A lapse in the ownership of one of the redirect URIs can lead to an application compromise. Ensure that all DNS records are updated and monitored periodically for changes. Along with maintaining ownership of all URIs, don't use wildcard reply URLs or insecure URI schemes such as http or URN.                                                                                                                                                     |
|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Implicit grant flow for an access token | Scenarios that require implicit flow can now use Auth code flow to reduce the risk of compromise associated with implicit grant flow misuse. If you configured your application registration to get Access tokens using implicit flow but don't actively use it, we recommend you turn off the setting to protect it from misuse.                                                                                                                                                                                             |
| Credential                              | Credentials are a vital part of an application registration when your application is used as a confidential client. If your app registration is used only as a Public Client App (which allows users to sign in using a public endpoint), ensure that you don't have any credentials on your application object.                                                                                                                                                                                                              |
| AppId URI                               | Certain applications can expose resources (via WebAPI) and, as such, need to define an AppId URI that uniquely identifies the resource in a tenant. We recommend using either of the following URI schemes: API or HTTPS, and set the AppId URI in the following formats to avoid URI collisions in your organization. The AppId URI acts as the prefix for the scopes referenced in the API's code, and it must use a verified customer owned domain. For multi-tenant applications, the value must also be globally unique. |
| Application ownership                   | Ensure app ownership is kept to a minimal set of people within the organization. It's recommended to run through the owner's list once every few months to ensure owners are still part of the organization and their charter accounts for ownership of the application registration.                                                                                                                                                                                                                                         |
| Checklist | App developers can use the Checklist available in the Azure portal to ensure their app registration meets a high quality bar and provides guidance to integrate securely. The integration assistant highlights best practices and recommendations that help avoid common oversights when integrating with the Microsoft identity platform.                                                                                                                                                                                    |

## Security Standards for Onboarding applications

Organizations should use guidance and automation for securing
applications in the cloud rather than starting from zero.

-   Using resources and lessons learned by external organizations that
    are early adopters of these models can accelerate the improvement of
    an organization's security posture with less effort and resources.

-   Developers should use services available from your cloud provider
    for well-established functions like databases, encryption, identity
    directory, and authentication instead of writing custom versions of
    them.

-   Use native security capabilities built into cloud services instead
    of adding external security components (data encryption, network
    traffic filtering, threat detection, and other functions).

-   Always authenticate with identity services rather than cryptographic
    keys when available.

-   Deploy web application firewalls (WAFs) to mitigate the risk of an
    attacker being able to exploit commonly seen security
    vulnerabilities for applications.

-   Enforce security for applications hosted in containers, general
    application best practices, and some specific guidelines to manage
    this new application architecture type.

-   Enforce a more comprehensive threat model standard that can identify
    more potential risks; two popular standards are STRIDE and OWASP.

Several capabilities should be prioritized first because of potential
security impact:

-   **Identity** - User directories and other authentication functions
    are complex to develop and critically important to security
    assurances. Avoid using homegrown authentication solutions and favor
    mature capabilities like: 
    * Azure Active Directory ([Azure AD](/azure/active-directory/)) 
    * [Azure AD B2B](/azure/active-directory/b2b/) 
    * [Azure AD B2C](/azure/active-directory-b2c/)
    * Third-party solutions to authenticate and grant permission to users, partners, and customers, applications, services, and other entities.

-   **Data Protection** - Developers, should use established
    capabilities from cloud providers such as native encryption in cloud
    services to encrypt and protect data. The security world is littered
    with examples of failed attempts to protect data or passwords that
    didn't stand up to real world attacks. If direct use of
    cryptography is required, developers should call well-established
    cryptographic algorithms and not attempt to invent their own.

-   **Key management**--Ideally, use identity for authentication rather than directly handling keys (see [Prefer Identity Authentication over Keys](/security/compass/applications-services#prefer-identity-authentication-over-keys)). For situations where accessing services that require access to keys, use a key management service like [Azure Key Vault](/azure/key-vault/) or AWS [Key Management Service](https://aws.amazon.com/kms/). This will help you manage and secure these keys rather than attempting to safely handle keys in application code. You can use [CredScan](https://secdevtools.azurewebsites.net/helpcredscan.html) to discover potentially exposed keys in your application code.

-   **Application Configurations** - Inconsistent configurations for
    applications can create security Risks. Azure App Configuration
    provides a service to centrally manage application settings and
    feature flags, which helps mitigate this risk.

## Additional information

For additional information on Security Standards for applications, see the following:

-   [**Best Practices for Application Registration**](/azure/active-directory/develop/security-best-practices-for-app-registration)
-   [**Threat Modeling**](/azure/security/develop/threat-modeling-tool)
-   [**OWASP ASVS**](https://owasp.org/www-project-application-security-verification-standard/)
-   [**STRIDE**](/azure/security/develop/threat-modeling-tool-threats)
-   [**NIST SSDF**](https://csrc.nist.gov/publications/detail/sp/800-218/final)
-   [**Microsoft Secure DevOps using Azure**](https://azsk.azurewebsites.net/)