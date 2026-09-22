After deployment, you should export the effective baseline. The following procedure captures effective state and evidence to detect unauthorized drift and document what the CA enforced. These exports record effective configuration and support recovery; they aren't a CA backup. Recovery also requires the CA database, the CA certificate and usable private-key recovery material, the associated configuration, and a tested restore procedure appropriate to the provider. It requires elevated local administrator or CA administrator privileges for CA registry and service configuration, plus read or delegated access for AD DS and IIS evidence. Success means the protected, access-controlled baseline contains effective CA registry, publication, policy, service, storage, directory, web, certificate, CRL, and validation evidence. A design document without an effective-state export can't prove what the CA enforced, while the baseline itself reveals sensitive topology and therefore requires protection.

The following command captures the broad CA registry view in the `C:\CAConfig` staging directory prepared earlier:

```powershell
certutil.exe -getreg CA > C:\CAConfig\CA-Registry.txt
```

The following focused exports make publication, policy, and service settings easier to compare during recovery and drift review:

```powershell
certutil.exe -getreg CA\CRLPublicationURLs > C:\CAConfig\CRL-Publication.txt
certutil.exe -getreg CA\CACertPublicationURLs > C:\CAConfig\AIA-Publication.txt
certutil.exe -getreg policy\EditFlags > C:\CAConfig\Policy-EditFlags.txt
sc.exe qc CertSvc > C:\CAConfig\CertSvc-Config.txt
sc.exe qfailure CertSvc > C:\CAConfig\CertSvc-Recovery.txt
sc.exe qfailureflag CertSvc > C:\CAConfig\CertSvc-RecoveryFlag.txt
```

Securely retain the following in a secure offline location such as a safe:

- `CAPolicy.inf` and hash.
- CA certificates, thumbprints, chain, provider/key evidence, and CRLs.
- Full approved CA registry export and focused human-readable exports.
- Database/log/storage design and ACL evidence.
- Service startup/recovery configuration and relevant event validation.
- AIA/CDP UI/registry settings and token-expanded filenames.
- Policy/exit module, disposition, `EditFlags`, original values, test, and rollback.
- Public Key Services object/thumbprint and ACL inventory.
- IIS paths, ACLs, MIME types, headers, hashes, and retrieval evidence.
- Role holders, ceremony records, custody, hashes, replication, domain/non-domain validation, exceptions, and sign-off.

## Back up the CA database and keys

The baseline exports record configuration, but recovery also needs a usable CA backup. After installation, and again whenever the CA materially changes, back up the CA database and, for exportable software-protected keys, the CA private key and certificate to the approved protected backup destination. Use the organization's secure password-handling process. Keep key backups separate from the public-artifact transfer media, the HTTP publication tree, and the baseline-export directory.

Run the applicable commands in an elevated Windows PowerShell session on the CA using an account authorized to back up the CA and its key material. Replace each example path with an approved destination before running a command.

For an exportable software key, the `Backup-CARoleService` cmdlet backs up the database and private key together:

```powershell
$backupPassword = Read-Host 'Enter the approved CA backup password' -AsSecureString
Backup-CARoleService -Path '<ApprovedProtectedBackupPath>' -Password $backupPassword -ErrorAction Stop
```

For an HSM-protected or other non-exportable key, back up the database and follow the provider's supported key backup and recovery process separately. `-DatabaseOnly` doesn't back up the key and isn't a complete CA backup:

```powershell
Backup-CARoleService -Path '<ApprovedProtectedDatabaseBackupPath>' -DatabaseOnly -ErrorAction Stop
```

Don't treat a local backup on the CA's only disk as the complete recovery copy. Retain the baseline configuration alongside the protected recovery set, using the approved separation of access and storage. Maintain separately identified recovery sets for the root and each issuing CA, and account for the historical CA keys and certificates still needed after renewal.

Record a successful protected backup transfer and an isolated restore exercise, using `Restore-CARoleService`. Don't activate a duplicate production CA identity or issue certificates from the restored test instance. A complete disaster-recovery runbook can remain a separate prerequisite; don't invent a generic HSM restore recipe or expose the root key through the public-artifact ceremony.

## Define renewal before first production issuance

The renewal record below ensures that schedule, key choice, policy-file handling, generation-specific filenames, publication, validation, and retirement are decided before expiry pressure begins. Record for every CA:

| Renewal item | Required decision |
|---|---|
| Dates | Decision, compatibility test, ceremony/change, publication, validation, rollback margin, and expiry. |
| Key decision | Reuse or new key; approver; mandatory new-key triggers; HSM capacity and backup. |
| CAPolicy.inf | Which values apply to renewal and when the file must be staged. |
| Generation names | Expected CA certificate/CRL suffixes and HTTP/AD DS filenames. |
| Publication | Root/CA/AIA/CDP/NTAuth tasks and old-generation retention. |
| Validation | Existing and new certificate chains; clean domain and non-domain clients; application tests. |
| Retirement | Last dependent certificate, revocation duty, record retention, trust removal, key destruction. |

## Two-tier applied acceptance scenario

Deploy one offline root and two issuing CAs:

- Both issuing CAs use the approved baseline and stable `<PkiWebHost>`.
- Either both issue the same approved profiles for availability, or profile placement has a documented assurance/capacity reason. Avoid arbitrary "one user, one computer" partitioning that creates unnecessary outage domains.
- Root artifacts move only through controlled media. AD DS and HTTP publication occur separately from a domain-connected workstation/publisher.
- Enterprise issuing CAs automatically publish NTAuth where applicable; verify both. Authorize only CAs intended for AD DS authentication.
- Root trust reaches domain, managed non-domain, and specialized populations through their own mechanisms.
- Controlled preproduction test issuance is permitted only after both `CertSvc` instances are healthy, AIA/CDP and CRL values are final, root and issuing artifacts are present and current in every intended store or path, and AD DS replication passes. `EditFlags`, request disposition, default modules, and test-template permissions must match the approved record. Keep both CAs limited to the approved preproduction test templates for designated test principals. Approve the pre-test baseline, backup/recovery inputs, renewal plan, owners, monitoring, and rollback before this test issuance. Use it solely to obtain the per-issuer test certificates needed for clean domain and non-domain client validation.
- Production issuance remains blocked until:
  - Both `CertSvc` instances remain healthy.
  - AIA/CDP and CRL values are final.
  - Root and issuing artifacts are present and current in every intended store/path.
  - AD DS replication passes.
  - `EditFlags`, request disposition, default modules, and template publication match the catalog.
  - A clean domain and clean non-domain client validate chain and revocation using a test certificate from each issuing CA.
  - Baseline, backup/recovery inputs, renewal dates, owners, monitoring, and rollback are signed off.

## Operational risks

The following risk register connects common deployment failures with observable indicators and the required containment or correction.

| Risk | Indicator | Response |
|---|---|---|
| Wrong CAPolicy.inf | File is missing, `.txt`, wrong role, or unapproved hash. | Abort installation/renewal and correct before proceeding. |
| Wrong subordinate request | Subject/key/hash differs from approval. | Don't issue; preserve evidence and regenerate under change control. |
| Root connected for convenience | Network cable/domain/web access proposed. | Stop ceremony; transfer only signed public artifacts through controlled media. |
| URL configured but artifact unavailable | Registry/UI looks correct; HTTP returns 404/stale content, or `404.11` on plus-suffixed delta-CRL URLs. | Perform separate publication, permission, MIME/cache, and retrieval validation. Treat `404.11` on a delta-CRL filename as Request Filtering blocking double escaping, not a missing file. |
| Default templates loaded | Enterprise CA immediately advertises unreviewed templates. | Unpublish under change control and investigate any issued requests before production. |
| Unsafe SAN policy | `EDITF_ATTRIBUTESUBJECTALTNAME2` enabled with authentication templates. | Halt affected issuance; analyze workflows; test and remove flag or constrain design under approved change. |
| NTAuth overpublication | Unexpected CA appears in Enterprise NTAuth. | Preserve evidence, inventory dependent certs, authorize/remove under controlled incident/change process. |
| Old NTAuth removed early | Existing smart-card/DC auth begins failing. | Restore approved value if rollback criteria are met; replace dependencies before later removal. |
| Storage separation is cosmetic | DB and logs use different letters on same failure domain. | Redesign against actual performance/failure/RPO objective. |
| Service recovery loops | Repeated restart against HSM/storage failure. | Stop loop by specific runbook action, preserve events, recover dependency, then restart. |
| Domain-only validation | Admin client succeeds; external/non-domain fails. | Test clean clients through actual DNS/proxy/firewall and application trust paths. |
| Renewal unplanned | New certificates are shortened or generation filenames surprise automation. | Renew early; publish both generations; validate old/new chains and filenames. |
