The **Certificate Enrollment Policy Web Service (CEP)** supplies native Windows enrollment policy over HTTPS. The **Certificate Enrollment Web Service (CES)** receives a native enrollment request over HTTPS and connects to the CA using DCOM/RPC. Clients outside the corporate network need not receive LDAP or CA RPC access; the service tier does.

Enrollment uses the following process:

1. Client validates the HTTPS certificate and authenticates to CEP.
1. CEP reads policy/templates from AD DS and returns eligible policy.
1. Client generates the private key locally and builds the request.
1. Client authenticates to CES and submits over HTTPS.
1. CES submits to `<CAName>` and returns disposition/certificate.

Install CEP/CES on dedicated domain member servers rather than the issuing CA when practicable. Keeping IIS and the enrollment web endpoints off the CA reduces the attack surface of the server that holds the CA's private key. Separate hosts also keep web-tier patching and restarts from interrupting the CA service.

Publish multiple distinct URIs for equivalent instances of each service on separate servers. Native Windows clients randomize the endpoint list and try another endpoint when one is unavailable, providing load distribution and failover. Keep alternative instances consistent in policy and authentication so switching endpoints doesn't change the available templates or sign-in requirements.

Avoid relying only on DNS round robin or a transport-only virtual IP (**VIP**). DNS round robin doesn't check application health, and a transport-level check can succeed even when CEP or CES can't process requests. Publishing only one URI for all instances also hides the alternative endpoints from native clients, limiting their built-in failover.

## CES authentication modes

The following table compares CES authentication modes and explains when CES needs permission to submit requests to a CA on another server using the requester's identity. This CES-to-CA step is the delegation boundary: authenticating to CES doesn't automatically authorize CES to act as the requester on the CA. Delegation requirements depend on the authentication mode and whether CES handles initial enrollment or only renewal.

| CES authentication | Typical use | Delegation boundary | Renewal considerations |
|---|---|---|---|
| Windows integrated | Domain-connected intranet/cross-forest with appropriate trust | If CES is remote from CA and handles initial enrollment, delegate the CES computer/app-pool service identity. Use Kerberos-only constrained delegation for integrated auth; configure SPNs correctly for a domain service account | Native renewals supported; external clients still need Windows auth path |
| Username/password | Initial enrollment for clients without integrated auth | CES can use supplied credentials and doesn't require the same delegation arrangement described for integrated/client-certificate initial enrollment; protect credentials with strict TLS and endpoint controls | Useful only as bootstrap. Prefer moving subsequent renewal to client certificate/KBR instead of repeatedly exposing passwords |
| Client certificate | Internet/remote clients already holding a suitable certificate | Initial enrollment through a remote CA can require protocol-transition/"any authentication protocol" constrained delegation. Renewal-only reduces exposure because new enrollment is rejected | Required foundation for key-based renewal. Validate certificate mapping, original identity, status, and remaining validity |

Delegation is unnecessary when CES and CA are colocated, but colocation expands web exposure on the CA and isn't recommended. Delegation is also unnecessary for the documented username/password path. For a remote CA, initial enrollment with Windows integrated or client-certificate authentication requires the correct constrained delegation. Never enable unconstrained delegation.

- **Renewal-only** endpoints reject initial requests and process renewals without exposing a general delegation path.
- **Key-based renewal (KBR)** uses the private key of an existing valid certificate to authenticate renewal, including for workgroup or untrusted-forest systems. KBR authentication is distinct from the template decision to reuse that key in the newly issued certificate.

### Key-based renewal

Key-based renewal (KBR) uses an existing valid certificate and its private key to authenticate renewal requests through CEP/CES. Remote and non-domain Windows clients can renew without repeatedly supplying a username and password. The existing key authenticates the request, but the renewed certificate can use a new key if policy permits.

Follow these steps to configure and validate key-based renewal with separate initial-enrollment and renewal-only endpoints:

1. Use one CEP/CES instance for authenticated initial enrollment and a separate certificate-authenticated instance configured for renewal-only and allowed KBR.
1. Configure the template's renewal identity behavior explicitly. If it supplies identity in the request, use the existing-certificate subject/SAN option only after confirming stale names can't survive an identity correction.
1. Give the CES service identity only the required Read/Enroll and CA access. For a mapped workgroup computer, create/maintain the corresponding forest identity and use constrained protocol transition only to the named CA services.
1. Configure client-certificate authentication on the KBR endpoint and a higher preference (lower numeric priority) than the bootstrap policy.
1. Test valid renewal, expired/revoked certificate rejection, missing-private-key rejection, wrong account mapping, provider/key rotation, and endpoint failover.

## Enrollment policy priority

Enrollment policy tells Windows clients which certificate templates are available and the requirements for enrollment. When you configure multiple policy sources, clients prefer those with lower priority numbers. Use this preference to favor certificate-based renewal over the username/password policy used for initial enrollment.

Configure **Certificate Services Client - Certificate Enrollment Policy** in Group Policy or local policy:

- Give each policy service a stable HTTPS URI, friendly name, authentication type, and numeric priority.
- Lower numeric priority is preferred. In a common bootstrap design, a certificate-authenticated KBR policy has priority `1`, while username/password initial policy has priority `10`.
- Keep AD enterprise policy and added CEP sources intentional. Duplicate templates or inconsistent policy sources can produce ambiguous selection; document which source owns each population.
- Validate every URI under the actual identity. A successful CEP validation doesn't prove CES submission, CA disposition, or renewal.
- Publish multiple endpoint URIs rather than hiding all instances behind one opaque address. Keep template visibility and authentication configuration equivalent across peers.

## Procedure: Non-domain and disconnected Windows clients

To provide a workgroup server needs a TLS certificate without inbound AD DS or CA RPC access:

- Install the approved root/intermediate chain and validate the CEP/CES TLS name `<PkiWebHost>` before sending credentials.
- Predefine how the non-domain computer maps to an account/identity in the CA forest. For certificate-authenticated computer KBR, the documented design uses a corresponding computer account and correct certificate names.
- Use a username/password CEP/CES instance only for controlled initial enrollment, then a separate certificate-authenticated, renewal-only/KBR instance.
- Configure template subject behavior for the renewal model; validate whether identity is rebuilt from directory data or copied from the existing certificate.
- Permit client HTTPS only. Permit CEP to AD DS and CES to the CA's required DCOM/RPC ports internally; don't publish CA RPC to the internet.

## Procedure: Install and verify CEP/CES role services

To deploy HTTPS policy/enrollment endpoints and prove policy retrieval and request submission from the intended boundary, ensure that you have Local administrator on web servers; Enterprise Admin or specifically delegated AD/SPN/delegation administration where required; CA Admin for CES/CA configuration; IIS administrator for bindings. Then perform the following steps in Server Manager:

1. **Add Roles and Features** > **Active Directory Certificate Services**.
1. Select **Certificate Enrollment Policy Web Service** and **Certificate Enrollment Web Service**. Don't confuse either with **Certification Authority Web Enrollment**. Choosing these options will install the necessary IIS components if they aren't already present.
1. Configure the chosen authentication type and CA. Use dedicated service accounts or a group Managed Service Account (**gMSA**) where the role and support model permit it; register SPNs and constrained delegation only to the required CA services.

To install from the command line, run the following command on each approved web-tier server to install both CEP and CES role services and their management tools (this command also installs the needed IIS elements).

```powershell
Install-WindowsFeature ADCS-Enroll-Web-Pol,ADCS-Enroll-Web-Svc -IncludeManagementTools
```

Once installed, you configure IIS using the following steps:

1. Open **Sites** > the CEP/CES applications. Confirm only required authentication methods are enabled.
1. Open **Bindings** and bind HTTPS to a certificate whose SAN contains `<PkiWebHost>`, with a trusted chain and approved TLS configuration.
1. Require HTTPS, restrict internet paths, enable logging, and verify that proxy/load-balancer health checks test the application rather than TCP alone.
1. Record CEP and CES URIs exactly; configure distinct URIs for initial and KBR/renewal-only instances.

Use the following command to inventory HTTPS bindings before validating each bound certificate and endpoint from a client.

```powershell
Get-WebBinding -Protocol https
```

Each intended CEP/CES site should expose only the approved HTTPS host name and port. Also validate the bound certificate thumbprint and live TLS chain/name from a client.

To configure the client:

1. Open Local Group Policy or the applicable GPO > **Public Key Policies** > **Certificate Services Client - Certificate Enrollment Policy**.
1. Add the initial CEP URI, select its authentication method, set priority `10`, and validate.
1. After initial issuance, add the certificate-authenticated KBR CEP URI at priority `1` and validate with the issued certificate.
1. Use Certificates MMC under the actual computer/user identity to enroll and renew; compare request/CA/IIS events.
