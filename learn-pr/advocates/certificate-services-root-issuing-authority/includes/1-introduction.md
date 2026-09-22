An offline root certification authority (CA) helps protect certificate trust, while online issuing CAs handle routine certificate issuance. In this module, you learn to deploy, harden, and validate this hierarchy with Active Directory Certificate Services (AD CS) before production use.

By the end of this module, you can:

- Prepare separate, technically appropriate `CAPolicy.inf` files and explain install, renewal, and non-retroactive behavior.
- Install standalone root and enterprise subordinate CAs through Server Manager and PowerShell.
- Make and record CA type, key, provider, algorithm, name, validity, database, log, time, service-recovery, OS, and antivirus decisions. Store in a safe location.
- Execute a controlled offline-root-to-issuing-CA signing workflow without connecting the root to AD DS or the web publisher.
- Configure AIA, CDP, CRL, request disposition, policy-module, exit-module, and `CertSvc` baselines before production issuance.
- Publish CA certificates and CRLs separately to AD DS and HTTP; manage root and NTAuth trust deliberately.
- Verify Public Key Services objects, replication, HTTP content, trust, chain building, AIA, and CRL retrieval from clean domain and non-domain clients.
- Export a protected post-install baseline, back up the CA database and private keys to a separate protected destination, and define CA renewal before first production issuance.

> [!NOTE]
> Throughout this module it's suggested that you record various characteristics about servers, configuration, and certificate properties. You should store these records in a safe tamper proof offline location.

AD CS is Microsoft's certification-authority role, while the public key infrastructure (PKI) includes the CAs, trust stores, publication services, policies, operators, and recovery processes around it. A root CA is the self-signed trust anchor; an issuing or subordinate CA is signed by a superior CA and signs end-entity certificates. The following predeployment matrix compares the decisions required for the offline root and online issuing CAs and explains the principal consequence of each choice. Use one signed implementation record for each CA.

| Setting | Offline root decision | Issuing CA decision | Security consequence / tradeoff |
|---|---|---|---|
| CA type | Standalone root, workgroup, offline. | Enterprise subordinate, domain joined. | An online enterprise root concentrates trust anchor and issuance risk; it isn't the default production design. |
| Private key | New key unless performing an approved restore/migration. | New key for new hierarchy; existing key only for documented restore/migration/renewal. | Selecting the wrong existing key can create an unusable or unauthorized CA identity. |
| Provider | Approved software KSP or supported HSM KSP/CSP. | Approved KSP/HSM after workload compatibility test. | Provider choice affects algorithm support, key custody, backup, performance, and recovery. |
| Algorithm/key | Illustrative compatibility baseline: RSA 4096, SHA-256 or stronger. | Illustrative baseline: RSA 4096 CA key, SHA-256 or stronger. | Stronger isn't automatically compatible; test complete chains and HSM/recovery tooling. |
| CA common name | Stable `<RootCAName>`, not host FQDN. | Stable `<IssuingCAName>`, not host FQDN. | CA names are long-lived issuer identities and can't be casually renamed. |
| DN suffix | Approved organization suffix or intentionally blank. | Approved suffix consistent with policy. | Incorrect DNs remain in issued certificates. |
| CA certificate validity | Example 20 years, adapted to policy and supported generations. | Requested period is governed by root policy and remaining root lifetime; example 5 years. | Long periods increase exposure; short periods increase renewal and outage pressure. |
| Database/log | Protected local volumes with recoverable design. | Separate volumes where scale/failure objectives justify it. | Same-volume failure can lose database and uncommitted transaction logs together. |
| Default templates | None on installation. | `LoadDefaultTemplates=0`. | Loading defaults can permit enrollment before hardening and profile approval. |

These are illustrative starting points, not universal defaults. Record the Windows Server build, provider, HSM firmware, tested relying parties, exception authority, and review date.  

> [!NOTE]
> The following extended PKI terminology is useful for understanding concepts in this module: Authority Information Access (AIA) points clients to issuer certificates. A Certificate Revocation List (CRL) is a list of revoked certificates. A CRL Distribution Point (CDP) points clients to CRLs. A key storage provider (KSP), legacy cryptographic service provider (CSP), or hardware security module (HSM) protects and uses CA private keys. Enterprise NTAuth is a separate forest authorization list for CAs that issue certificates used in AD DS authentication; it isn't the same as root trust.

## Root CAPolicy.inf

`CAPolicy.inf` is an optional configuration file that AD CS reads during CA installation or CA certificate renewal to define CA certificate extensions and selected CA settings. Editing it doesn't change existing certificates or the running CA's configuration.

Create `%systemroot%\CAPolicy.inf` **before** installing AD CS.

An example `CAPolicy.inf` for an offline root is as follows:

```ini
[Version]
Signature="$Windows NT$"

[PolicyStatementExtension]
Policies=RootPolicy

[RootPolicy]
OID=<EnterpriseArc>.1.1
URL=https://<PkiWebHost>/pki/cps.html
Notice="Issued under the approved root certificate policy."

[BasicConstraintsExtension]
PathLength=1
Critical=Yes

[Certsrv_Server]
RenewalKeyLength=4096
RenewalValidityPeriod=Years
RenewalValidityPeriodUnits=20
CRLPeriod=Months
CRLPeriodUnits=6
CRLOverlapPeriod=Weeks
CRLOverlapUnits=4
CRLDeltaPeriod=Days
CRLDeltaPeriodUnits=0
LoadDefaultTemplates=0
AlternateSignatureAlgorithm=0

[CRLDistributionPoint]

[AuthorityInformationAccess]
```

The policy OID and CPS URL must come from the governed registry. A placeholder OID should never be used in production environments. The HTTPS CPS pointer publishes policy documentation and isn't an AIA or CDP retrieval location. Empty root `[CRLDistributionPoint]` and `[AuthorityInformationAccess]` sections omit unnecessary references from a self-signed trust anchor because the root has no superior CA to locate. Critical `PathLength=1` permits at most one non-self-issued CA level beneath the root, which supports issuing CAs but prevents another policy or intermediate tier below them.

`RenewalKeyLength` applies only when renewal generates a new key; the installation wizard or cmdlet selects the initial key size. Root renewal validity is a root behavior, whereas a subordinate CA certificate's lifetime is controlled by its parent. Delta CRLs are disabled for the offline root because subordinate revocation should be rare and handled through a controlled base-CRL ceremony. `LoadDefaultTemplates=0` has no practical template effect on a standalone root but records the intent not to preload enterprise templates. `AlternateSignatureAlgorithm=0` is a compatibility choice and should change only after representative complete-chain testing.

> [!NOTE]
> **Security consequence:** A long root CRL reduces ceremony frequency but increases potential revocation exposure. Its period and four-week overlap are examples requiring an approved failure-window exercise.

## Module working conventions

The following placeholders and stable filenames keep the procedures outlined in this module reusable. When implementing in your own environment, replace `<RootCAName>` with the offline standalone root CA common name, `<IssuingCAName>` with the current enterprise subordinate CA common name, and `<PkiWebHost>` with the stable HTTP publication alias. `<ForestDN>` is the forest-root domain distinguished name, such as `DC=example,DC=com`. `<EnterpriseArc>` is the organization-assigned numeric OID arc, such as `1.3.6.1.4.1.55555`, and must be replaced before either `CAPolicy.inf` example is used. `<RequestId>` is the request identifier recorded by the root CA, `<CertificateFile>` is the certificate selected for validation, and `<OriginalEditFlagsValue>` is the exact numeric `EditFlags` value captured before an approved policy-module change.

The workflow uses `IssuingCA.req` for the subordinate request, `RootCA.cer` and `RootCA.crl` for root public artifacts, `IssuingCA.cer` for the signed issuing-CA certificate, and `IssuingCA.crl` for the issuing CA's base CRL. `C:\CAConfig` is the protected local baseline-export directory. Preserve these names where later commands and custody records depend on them.

Within CA extension strings, `<CaName>`, `<CertificateName>`, `<CRLNameSuffix>`, and `<DeltaCRLAllowed>` are literal AD CS replacement tokens. Don't replace them in the configured value; inspect their expanded filenames before publication.

## Prepare CAConfig directory

Before any request-generation or evidence-export command, prepare `C:\CAConfig` on the relevant CA. If the directory already exists, inspect its contents, owner, and permissions before changing anything. A dedicated `C:\CAConfig` directory provides a predictable staging location for certificate requests, public CA artifacts, and configuration exports. Restricting access helps protect sensitive configuration details and preserve the integrity of files used for verification, transfer, and auditing.

Apply the approved administrative ACL before you use the directory: retain the required SYSTEM and local-administrator access, and grant only explicitly authorized operator or backup access. Review inherited permissions rather than assuming that directory creation makes the folder protected. Confirm that the command's operating identity can write to the folder and that storage is available. Don't remove required service or backup permissions, and don't reset an existing folder's ACL blindly. The issuing CA's [`-OutputCertRequestFile`] destination must exist with these permissions before you run the configuration command.

`C:\CAConfig` is a staging and evidence directory, not the CA key store or a destination for public HTTP access. Don't place private-key recovery backups in it.

> [!NOTE]
> Commands that require a local or CA-specific name use a placeholder. All `certutil.exe` verbs are lowercase. Run commands in an elevated session only where stated.

Run native commands such as `certutil.exe` individually and inspect their output and `$LASTEXITCODE` immediately afterward. Stop on an unexpected result or nonzero exit code; a later successful command doesn't prove that earlier operations succeeded.

> [!NOTE]
> **Security consequence:** The first production certificate freezes critical assumptions: issuer identity, algorithms, policy, and embedded AIA/CDP references. Don't issue production certificates until configuration, publication, trust, replication, recovery, and clean-client evidence pass.

## Issuing CA CAPolicy.inf

Preparing `CAPolicy.inf` before CA configuration lets AD CS apply the intended certificate policies, requested constraints, and initial CA settings instead of relying on defaults. Creating or editing the file afterward doesn't change existing certificate requests, issued certificates, or the running CA's configuration.

Create `%systemroot%\CAPolicy.inf` on each issuing CA before CA configuration. A sample example:

```ini
[Version]
Signature="$Windows NT$"

[PolicyStatementExtension]
Policies=IssuingPolicy

[IssuingPolicy]
OID=<EnterpriseArc>.1.2
URL=https://<PkiWebHost>/pki/cps.html
Notice="Issued under the approved enterprise issuing policy."

[BasicConstraintsExtension]
PathLength=0
Critical=Yes

[Certsrv_Server]
RenewalKeyLength=4096
CRLPeriod=Days
CRLPeriodUnits=7
CRLOverlapPeriod=Hours
CRLOverlapUnits=12
CRLDeltaPeriod=Hours
CRLDeltaPeriodUnits=24
LoadDefaultTemplates=0
AlternateSignatureAlgorithm=0
```

Critical `PathLength=0` requests an issuing CA beneath which a valid path can't contain another non-self-issued CA. Also restrict CA permissions and issuance policy; path length is relying-party enforcement, not a substitute for preventing unauthorized CA signing. The constraint enforces the two-tier topology but complicates a later policy-CA insertion, which requires a new, validated CA-certificate strategy. The example omits `RenewalValidityPeriod*` because those values can't force the parent to grant a particular subordinate-CA lifetime. Do **not** add empty `[CRLDistributionPoint]` or `[AuthorityInformationAccess]` sections to try to control the issuing CA's subordinate certificate. The offline root, as the signing CA, determines the AIA/CDP extensions in `IssuingCA.cer`. After the issuing CA is installed, its CA Properties or registry configuration determines the AIA/CDP references placed in certificates it issues.

## Install, renewal, both, and non-retroactivity

The following matrix shows when each `CAPolicy.inf` setting is read and emphasizes that changing the file never rewrites an existing certificate or live CA setting.

| Setting | Initial install | CA certificate renewal | Post-install behavior |
|---|---|---|---|
| `[Version]` | Required to recognize file. | Required when file is used. | No effect on existing certificates. |
| Policy statement | Included according to setup/signing context. | Can affect the newly renewed CA certificate. | Doesn't rewrite old CA or end-entity certificates. |
| Basic Constraints/path length | Included in the created CA certificate or request/signing result. | Can affect the new CA certificate generation. | Existing CA certificates retain their original constraint. |
| Root AIA/CDP sections | Can shape root certificate. | Can shape a renewed root certificate. | Doesn't modify the current root certificate. |
| `RenewalKeyLength` | Doesn't set initial key size. | Used only when generating a new renewal key. | No retroactive effect. |
| `RenewalValidityPeriod*` | Can establish root behavior. | Controls renewed root lifetime; doesn't force subordinate lifetime. | Existing CA certificate is unchanged. |
| CRL period/overlap/delta | Can seed initial CA configuration. | Can be read during renewal/setup context. | Effective values can be changed in registry later; restart and validate. Existing CRLs remain unchanged. |
| `LoadDefaultTemplates=0` | Applies during enterprise CA installation. | Not a way to remove already published templates. | Existing template publication must be reviewed separately. |
| `AlternateSignatureAlgorithm` | Affects applicable CA certificate/request behavior. | Can affect the renewed certificate/request. | Existing signatures and certificates remain unchanged. |

`CAPolicy.inf` is read at defined setup or renewal operations. Editing it later isn't a live configuration update and never rewrites issued certificates. Put the correct file in `%systemroot%` **before** the applicable installation or renewal, then inspect the result.
