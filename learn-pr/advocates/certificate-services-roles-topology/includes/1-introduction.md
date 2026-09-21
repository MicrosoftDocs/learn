This advanced module is designed for experienced Windows Server, Active Directory Domain Services (AD DS), security, and networking administrators who design or approve enterprise Active Directory Certificate Services (AD CS) deployments. The platform baseline is Windows Server 2025.

This module turns business, assurance, availability, and boundary requirements into an AD CS topology. It doesn't prescribe one CA per site or one role service per server. Every component must have a reason, a trust boundary, an owner, and a recovery path.

AD CS is a set of role services, not one monolithic server role. Install only the services required by a documented enrollment or validation flow. Co-locating every service on a CA widens its attack surface, couples maintenance windows, and gives an IIS or registration-authority (RA) compromise a shorter path to the CA.

## Learning objectives

By the end of the module, you should be able to:

- Select the AD CS role services needed for each enrollment and validation population.
- Choose enterprise or standalone CA operating models and an appropriate hierarchy depth.
- Defend a protected offline root with one or more online enterprise issuing CAs as the usual production starting point.
- Scale issuance and enrollment services without confusing service availability with CA identity or revocation availability.
- Design across forest, extranet, domain, non-domain, and application trust boundaries.
- Separate root trust, chain construction, Enterprise NTAuth authorization, and application-specific trust.
- Place hardware security module (HSM) services and administrative roles according to assurance, availability, and recovery objectives.
- Plan a controlled root ceremony and offline custody model.

## Understanding AD CS role services

The following table explains what each AD CS role service does, when it's appropriate in your deployment, and which security or operating obligations accompany its use.

| AD CS role service | What it provides | Use when | Don't assume | Security and operational consequences |
|---|---|---|---|---|
| **Certification Authority** | Root or subordinate CA; signs certificates and certificate revocation lists (CRLs); maintains CA database and transaction logs | A Microsoft CA must issue, revoke, renew, and audit certificates | Installing a CA makes clients trust it, makes its templates safe, or makes publication highly available | The signing key and CA service are a control-plane asset. Keep online issuing CAs dedicated, constrain administrators, and design database/log recovery. |
| **Certification Authority Web Enrollment** | Legacy Internet Information Services (IIS) pages for interactive certificate requests, status retrieval, and CRL access | A documented legacy workflow can't use MMC, autoenrollment, `certreq.exe`, the policy and enrollment web services described below, or another supported interface | It's equivalent to Certificate Enrollment Web Service or suitable for every template and identity | Adds IIS/authentication/relay exposure and limited legacy behavior. Require HTTPS, hardening, relay resistance, and a retirement owner. Prefer not to install it on a CA. |
| **Online Responder** | Online Certificate Status Protocol (OCSP) responses for certificate revocation status using configured revocation data and OCSP signing certificates | High-volume or latency-sensitive relying parties support OCSP and the revocation design justifies it | OCSP removes the need for correct CRLs, responder signing renewal, or relying-party testing | Requires responder arrays, revocation configurations, fresh upstream data, signing-key protection, monitoring, and defined unknown/offline behavior. |
| **Network Device Enrollment Service (NDES)** | Simple Certificate Enrollment Protocol (SCEP) registration-authority function for devices that can't use native domain enrollment | Managed network/mobile/device platforms require SCEP and their identity/one-time-password model is acceptable | SCEP request submission proves a device identity or supports every template/profile | NDES maps requests to constrained templates and introduces service accounts, RA certificates, IIS endpoints, one-time-password/admin interfaces, and relay/authorization concerns. The NDES host must be joined to an AD DS domain, even when the devices it serves aren't domain joined. Place it on a separate hardened server. |
| **Certificate Enrollment Policy Web Service (CEP)** | Publishes enrollment policy over HTTPS | Domain-disconnected or non-domain clients need web-based policy discovery | CEP issues certificates | The CEP host must be joined to an AD DS domain, even when clients aren't domain joined or can't connect directly to AD DS. It exposes policy and template eligibility. Authentication method, policy source priority, TLS, availability, and forest boundary must be designed. |
| **Certificate Enrollment Web Service (CES)** | Submits and renews certificate requests over HTTPS | Clients must enroll across HTTPS rather than direct RPC/DCOM, commonly with CEP | CES is interchangeable with legacy Web Enrollment or eliminates delegation and multi-hop authentication design | The CES host must be joined to an AD DS domain. Authentication, service identities, delegation or protocol transition, key-based renewal, load balancing, and CA connectivity are part of its trust boundary. Keep it separate from the CA where practical. |

### Role placement principles

Role placement should preserve the distinction between signing and brokering: **CA servers sign, while web tiers broker enrollment**. A web role's need to reach a CA isn't a reason to expose the CA itself to an extranet. Registration authorities are also security-sensitive rather than harmless proxies, because a compromised NDES or CES service can cause issuance within the profiles it's authorized to use.

Validation distribution must remain separate from issuance. Authority Information Access (AIA) locations distribute issuer certificates, CRL Distribution Point (CDP) locations distribute CRLs, and OCSP services answer status queries; these HTTP-based services should continue operating while a CA is offline or being recovered. Each installed role also has its own lifecycle for TLS certificates, service accounts, signing certificates, state, configuration, backup, and recovery. An unused role adds patching and monitoring obligations without adding assurance, so remove services that don't support a documented flow.

## Enterprise versus standalone CAs

The following table compares enterprise and standalone CA operating models. The distinction controls directory integration and workflow; it doesn't by itself determine whether a CA is secure.

| Decision dimension | Enterprise CA | Standalone CA |
|---|---|---|
| AD DS dependency | Must be domain joined and uses AD DS configuration data | Can be workgroup or domain joined; doesn't require enterprise template integration |
| Template issuance | Issues AD DS certificate templates and can support autoenrollment | Doesn't provide enterprise template-based issuance |
| Request identity/policy | Can derive identity and authorization through templates and AD DS | Requests are handled through configured policy and administrative workflow; identity validation is external to enterprise templates |
| Publication/registration | Publishes enterprise CA metadata; enterprise CA certificates are normally published to relevant AD containers, including NTAuth behavior for applicable enterprise CAs | AD publication and NTAuth authorization are controlled manual decisions where required |
| Availability dependency | Requires functioning forest connectivity for enterprise operations | Can operate isolated, which suits a protected offline root |
| Typical production role | Online enterprise issuing CA | Offline standalone root CA; specialized disconnected CA only with explicit design |
| Main risk | Domain/control-plane compromise can reach an online CA or its configuration | Manual issuance and publication can fail through poor ceremony, stale CRLs, or lost custody |

> [!NOTE]
> Use a standalone CA because its workflow and isolation are required, not because it's inherently secure. Use an enterprise CA because templates and directory-integrated enrollment are required, not because domain membership supplies all security controls.

### Suitable combinations

A recommended production combination is an **offline standalone root CA** and one or more **online enterprise issuing CAs**. The root is non-domain joined, powered off between controlled ceremonies, and used only for subordinate CA lifecycle operations and root CRLs. Issuing CAs are domain joined, dedicated to online leaf issuance, and governed through approved templates. 

> [!NOTE]
> A compromised root CA means all CAs in the hierarchy are suspect. Keeping the root CA offline makes it difficult for even the most skilled of attacker to compromise.

An **enterprise root CA** is more appropriate for a constrained lab or an explicitly accepted low-assurance environment than for a production default because the trust anchor remains online. A **standalone issuing CA** is justified only when manual or external issuance policy is intentional and enterprise template integration is unnecessary. It's not a shortcut for serving non-domain clients, which can instead use CEP/CES, NDES, or another governed interface to an enterprise CA.
