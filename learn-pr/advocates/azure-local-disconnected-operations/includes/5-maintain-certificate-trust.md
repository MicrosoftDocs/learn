Public key infrastructure (PKI) establishes which services and clients the environment trusts. In a disconnected deployment, your organization must keep certificate issuance, trust distribution, revocation information, and renewal usable within the isolation boundary.

## Understand what a certificate check establishes

A service certificate binds a public key to a service identity. Its Subject Alternative Name (SAN) entries identify the names or addresses for which it's valid. A client verifies the endpoint name, the certificate's validity period, and a trust chain back to a trusted root.

A *certificate authority* (CA) issues certificates. A *certificate revocation list* (CRL) identifies certificates that the CA has revoked before their normal expiration. If a certificate directs the client to a revocation endpoint that can't be reached, an otherwise correct HTTPS configuration can fail validation.

For fully disconnected deployments, the documented model requires a private or internal CA and reachable internal CRL endpoints. Public-CA certificates can introduce internet-dependent CRL or Online Certificate Status Protocol (OCSP) lookups. The fully disconnected guidance explicitly warns against that configuration.

Self-signed endpoint certificates aren't supported. This restriction doesn't mean that a CA root can never be self-signed, and it shouldn't be confused with the separately documented automation-certificate option. The endpoint must use the supported CA-issued trust model.

The PKI guidance calls for a common trust chain and at least two years of certificate validity from deployment. That starting lifetime doesn't eliminate renewal work. Intermediate and root certificates, revocation publication, and client trust stores also have lifecycles.

## Build a certificate inventory

Inventory ingress certificates, management server and client certificates, federation and directory trust, and recovery-related encryption certificates. Record subjects, SANs, issuers, thumbprints, validity dates, service bindings, renewal owners, and replacement procedures. Record where protected private keys are held without including the keys themselves.

Management server certificates identify the protected management endpoint. Management client certificates authenticate authorized operational clients. Keep their purposes distinct: installing a server's public certificate on a client doesn't grant the client management rights.

Use the following renewal sequence to avoid replacing one expired certificate with a different outage.

1. Identify every service binding and client that depends on the certificate or chain.
1. Obtain a replacement through the approved CA process, with the required names and certificate properties.
1. Distribute any required trust-chain changes through the supported process before changing the service binding.
1. Apply the replacement through the release-supported procedure during an approved window.
1. Verify hostname validation, trust, revocation reachability, authentication, and management operations from representative clients.
1. Retire old material according to the supported recovery and retention procedure.

Don't disable TLS or revocation checking to make a renewal appear successful. Fix the trust or reachability problem.

Identity-provider certificate rotation has an additional appliance-side dependency. The `OidcCertChainInfo` and `LdapsCertChainInfo` settings record the certificate-chain information expected from the AD FS/OIDC and LDAPS endpoints. When that information changes, coordinate the identity-provider change with an update to the appliance's identity configuration. Updating an ordinary client trust store alone doesn't update these settings.

For release 2606 and later, the documented rotation procedure imports the matching OperationsModule, establishes a management-endpoint client context, builds a partial configuration with `New-AppliancePartialExternalIdentityConfiguration`, and applies the new chain information with `Update-ApplianceExternalIdentityConfiguration`. Use the applicable procedure during the planned maintenance window, then confirm user sign-in, directory synchronization, and the required management operations. Don't substitute `Set-ApplianceExternalIdentityConfiguration` for routine certificate-chain maintenance, because that command can reset the operator subscription.

## Inspect an illustrative expiry window

The following read-only Windows PowerShell example uses the built-in certificate provider. Run it on an authorized management host with access to the local machine certificate store. It exports no private keys.

```powershell
$ErrorActionPreference = 'Stop'
$cutoff = (Get-Date).AddDays(60)

Get-ChildItem -Path Cert:\LocalMachine\My |
    Where-Object { $_.NotAfter -le $cutoff } |
    Select-Object Subject, Thumbprint, NotAfter, HasPrivateKey
```

The output contains certificates in that host's personal machine store that are already expired or expire within the illustrative 60-day window. `HasPrivateKey` reports whether a private key is associated with an entry. It doesn't expose the key.

Map relevant results to inventory entries and renewal owners. Empty output means only that this query found no matching certificates in this store. It doesn't inspect appliance endpoints, other hosts, other stores, chain expiration, or CRL freshness. A certificate might also exist in the store without being the certificate that a service currently presents.

For Contoso, the acceptance evidence should therefore include both an inventory and endpoint checks. A clean local query isn't a substitute for validating the portal and resource-manager certificates from an actual management client.

Create individual CA-issued certificates for the required ingress endpoints, with the appropriate subject and SAN entries, and store their password-protected PFX files in `IngressEndpointsCerts`. The following table groups the required ingress names. Replace `fqdn` with the disconnected environment's DNS suffix, such as `cloud.contoso.com`.

| Endpoint group | Required certificate subject and SAN names |
| --- | --- |
| Portal, sign-in, and identity | `portal.fqdn`, `hosting.fqdn`, `catalogapi.fqdn`, `login.fqdn`, `graph.fqdn` |
| Resource management and policy | `armmanagement.fqdn`, `management.fqdn`, `adminmanagement.fqdn`, `data.policy.fqdn` |
| Arc agents and Kubernetes configuration | `agentserviceapi.fqdn`, `his.fqdn`, `guestnotificationservice.fqdn`, `arckubernetesconfig.fqdn` |
| Appliance and licensing services | `dp.appliances.fqdn`, `frontend.appliances.fqdn`, `dp.aszrp.fqdn` |
| Container registry and secrets | `*.edgeacr.fqdn`, `*.vault.fqdn` |
| Platform storage and messaging | `*.blob.fqdn`, `*.queue.fqdn`, `*.table.fqdn`, `*.servicebus.fqdn` |

Keep the service-specific wildcard names. For example, a certificate for `*.cloud.contoso.com` doesn't cover `myvault.vault.cloud.contoso.com`. The storage and messaging names secure platform endpoints. Their presence doesn't make the corresponding public Azure services available for arbitrary tenant workloads.

Keep the two management certificates in `ManagementEndpointsCerts`. The server certificate's subject must match the management endpoint IP address, or use an FQDN that resolves to that address. Include the appropriate SAN for the address or name clients use. Give the client certificate a recognizable subject, such as `ManagementEndpointClientAuth`, and protect its private key because it authenticates operational clients. The server and client certificates aren't interchangeable.

Provide the actual root CA certificate and the complete trust chain, not just an intermediate certificate. Export the root certificate in Base64-encoded form, typically as a `.cer`, `.crt`, or `.pem` file, without exporting the CA's private key. Use a common trust chain and certificates valid for at least two years from deployment. Supply the directory and federation certificate-chain information through `LdapsCertChainInfo` and `OidcCertChainInfo`. In a fully disconnected environment, use an internal or private CA and ensure that the CRL Distribution Point addresses embedded in the certificates remain reachable internally. Don't rely on internet-only revocation services or disable revocation checks to make the deployment succeed.
