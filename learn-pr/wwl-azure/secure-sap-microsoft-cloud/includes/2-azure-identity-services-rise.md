This module details integration of Azure identity and security services with an SAP RISE workload. Additionally use of some Azure monitoring services are explained for an SAP RISE landscape.

## Single sign-on for SAP RISE

Single sign-on (SSO) is configured for many SAP environments. With SAP workloads running in ECS/RISE, steps to implement don't differ from a natively run SAP system. The integration steps with Microsoft Entra ID based SSO are available for typical ECS/RISE managed workloads:
- [Tutorial: Microsoft Entra Single sign-on (SSO) integration with SAP NetWeaver](https://learn.microsoft.com/entra/identity/saas-apps/sap-netweaver-tutorial)
- [Tutorial: Microsoft Entra single sign-on (SSO) integration with SAP Fiori](https://learn.microsoft.com/entra/identity/saas-apps/sap-fiori-tutorial)
- [Tutorial: Microsoft Entra integration with SAP HANA](https://learn.microsoft.com/entra/identity/saas-apps/saphana-tutorial)

| SSO method |   Identity Provider   | Typical use case                 | Implementation                    |
| :--------- | :-------------------: | :------------------------------- | :-------------------------------- |
| SAML/OAuth |  Microsoft Entra ID   | SAP Fiori, Web GUI, Portal, HANA | Configuration by customer         |
| SNC        |  Microsoft Entra ID   | SAP GUI                          | Configuration by customer         |
| SPNEGO     | Active Directory (AD) | Web GUI, SAP Enterprise Portal   | Configuration by customer and SAP |

SSO against Active Directory (AD) of your Windows domain for ECS/RISE managed SAP environment, with SAP SSO Secure sign in Client requires AD integration for end user devices. With SAP RISE, any Windows systems aren't integrated with the customer's Active Directory Domain. The domain integration isn't necessary for SSO with AD/Kerberos as the domain security token is read on the client device and exchanged securely with SAP system. Contact SAP if you require any changes to integrate AD based SSO or using third party products other than SAP SSO Secure sign in Client.


For more information about SNC, see [Getting started with SAP SNC for RFC integrations - SAP blog](https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/getting-started-with-sap-snc-for-rfc-integrations/ba-p/13983462).

## Multi-factor authentication for SAP GUI with Microsoft Entra

While SSO secures the sign-in experience, organizations increasingly require multi-factor authentication (MFA) for SAP GUI to meet Zero Trust and compliance requirements. Two approaches integrate MFA for SAP GUI with Microsoft Entra ID, both using SNC (Secure Network Communications) and Entra Conditional Access to enforce the second factor.

### Approach 1: Microsoft Entra Private Access with Global Secure Access client (recommended)

[Microsoft Entra Private Access](https://learn.microsoft.com/entra/global-secure-access/concept-private-access), part of [Global Secure Access (GSA)](https://learn.microsoft.com/entra/global-secure-access/), provides a Zero Trust Network Access (ZTNA) approach to MFA for SAP GUI — without requiring any SAP BTP services.

The [GSA client](https://learn.microsoft.com/entra/global-secure-access/concept-clients) installed on the user's workstation intercepts SNC traffic to the SAP system. Before the connection is established, the GSA client routes the request through Entra ID, where a Conditional Access policy enforces MFA (for example, passwordless authentication via the Microsoft Authenticator app). After successful MFA, the Kerberos-based SNC connection is established for SSO to the SAP system.

Key benefits of this approach:
- **Minimum set of components required** — SAP Secure Login and Microsoft GSA client are enough.
- **Zero Trust Network Access** — replaces traditional VPN-based access with identity-centric, per-application access controls.
- **Universal Continuous Access Evaluation (CAE)** — GSA extends CAE to SAP GUI, enabling near real-time session revocation on events like password resets or user deletion, without SAP GUI needing to be CAE-aware natively.
- **Works for remote and on-premises access** — the same setup secures SAP GUI whether the user is on the corporate network or connecting remotely.

For a detailed walkthrough, see [SAP GUI MFA with Microsoft Entra (Part II): Integration with Microsoft Entra Private Access](https://community.sap.com/t5/technology-blog-posts-by-members/sap-gui-mfa-with-microsoft-entra-part-ii-integration-with-microsoft-entra/ba-p/13691141).

### Approach 2: SAP Secure Login Service with SAP Cloud Identity Services

An alternative approach uses [SAP Secure Login Service (SLS) for SAP GUI](https://help.sap.com/docs/SAP%20SECURE%20LOGIN%20SERVICE) on SAP BTP. In this scenario, SLS issues a short-lived X.509 client certificate after the user authenticates through SAP Cloud Identity Services (IAS), which acts as a SAML proxy to Microsoft Entra ID. Entra Conditional Access enforces MFA during this authentication flow. The X.509 certificate is then used to establish the SNC connection for SSO.

> [!NOTE]
> This approach introduces additional dependencies: an SAP BTP subaccount, an SLS license, an IAS tenant configured as corporate identity provider proxy, and distribution of the SAP Cloud Root CA certificate to all client workstations.

For a detailed walkthrough, see [SAP GUI MFA with SAP Secure Login Service and Microsoft Entra ID](https://community.sap.com/t5/technology-blogs-by-members/sap-gui-mfa-with-sap-secure-login-service-and-microsoft-entra-id/ba-p/13605383).

## Identity governance for SAP RISE with Microsoft Entra ID Governance

SAP Identity Management (SAP IDM) has been a widely used solution for managing SAP user lifecycle and their authorizations. With the retirement of SAP IDM by 2027, Microsoft Entra ID Governance is the recommended migration path for SAP IDM users. Microsoft Entra ID Governance provides comprehensive identity governance capabilities, including access reviews, entitlement management, and privileged identity management, which can be leveraged to manage SAP user identities and their access rights effectively.

> [!NOTE]
> SAP [announced retirement](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101) of SAP Identity Management (SAP IDM) by 2027. [SAP recommends](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101) to customers to migrate to Microsoft Entra.

[Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) and built-in integrations with SAP Cloud Identity Service are an ideal fit to handle SAP user lifecycle and their authorizations across both eco-systems.

Learn more from this [Microsoft Learn article](https://learn.microsoft.com/entra/id-governance/scenarios/migrate-from-sap-idm) and the [SAP scenarios hub](https://microsoft.github.io/EntraIDGovernance-Training/SAPScenarios/).