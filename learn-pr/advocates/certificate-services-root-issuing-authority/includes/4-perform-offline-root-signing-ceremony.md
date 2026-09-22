:::image type="content" source="../media/offline-root-ceremony.svg" alt-text="Diagram that shows the offline root CA signing ceremony and controlled artifact transfer." border="false":::

Enforce the following controls during the root CA ceremony:

- Approved change/signing request and expected subordinate certificate contents.
- Named ceremony lead, root operators, certificate manager, auditor/witness, and receiving publisher.
- Quorum/dual control for root key access and issuance.
- Known-clean, approved transfer media; media identifier and seal.
- Malware-control procedure that doesn't modify signed artifacts.
- Hashes recorded over an independent channel or in a signed ceremony record.
- Root time verification.
- Request inspection, disposition, certificate verification, CRL generation, and shutdown evidence.
- Exception, abort, and rollback criteria.

## End-to-end root-to-issuing workflow

The following workflow preserves the offline boundary while moving a subordinate request into the root zone and signed public artifacts back out. Each step has a separate custody, validation, or authorization purpose. In environments that require the security of an offline root CA, don't collapse the sequence into an unaudited file copy.

On the root, use the protected `C:\CAConfig` directory prepared earlier for this ceremony's request and public exports. Keep artifacts for different requests or CA generations separately identified; don't overwrite another ceremony's files. In the approved root session, set the working directory before using the relative filenames in the following commands:

```powershell
Set-Location -LiteralPath 'C:\CAConfig' -ErrorAction Stop
```

### Set the root's issued-certificate validity policy

The root certificate's own lifetime isn't the policy for certificates it issues. Before you approve a subordinate request, configure the standalone root's issued-certificate validity policy to the approved subordinate lifetime. This aligns the signing root with the subordinate period recorded in the preflight matrix's **CA certificate validity** row. The following five-year value is an example, not a default requirement.

Under ceremony control, use an elevated session on the offline root with root CA administrative and service-control authority. Record the previous settings, apply the approved values, and restart Certificate Services before signing. Check each native command's exit code and output before proceeding, and stop on any unexpected result:

```powershell
certutil.exe -getreg 'CA\ValidityPeriod'
certutil.exe -getreg 'CA\ValidityPeriodUnits'
certutil.exe -setreg 'CA\ValidityPeriod' Years
certutil.exe -setreg 'CA\ValidityPeriodUnits' 5
Restart-Service -Name CertSvc -ErrorAction Stop
certutil.exe -getreg 'CA\ValidityPeriod'
certutil.exe -getreg 'CA\ValidityPeriodUnits'
```

This CA-wide policy applies to certificates the root subsequently issues. It doesn't change the root certificate, renew existing subordinate certificates, or permit issuance beyond the signing root certificate's remaining validity. Microsoft documents a one-year default validity for certificates that a standalone CA issues, so set and verify the approved policy explicitly. Validate the request and applicable policy, then inspect the issued subordinate certificate's actual `NotBefore` and `NotAfter` values before you accept it. Stop if those values don't match the approved hierarchy plan.

### Step 1: Transfer the request into the offline zone

This step moves only the approved `IssuingCA.req` into the offline zone and proves that it's unchanged. It requires named media custodians, no AD DS privilege, and root-local access only under ceremony quorum. Success means the inbound request hash matches the independently recorded source hash and the media handoff is logged. Signing a substituted request would delegate certification authority to an attacker-controlled key.

Use approved media and malware-control handling to stage this ceremony's `IssuingCA.req` in the protected working directory, then recalculate its hash and inspect its contents before allowing the root to sign it:

```powershell
Get-FileHash -Algorithm SHA256 IssuingCA.req
certutil.exe -dump IssuingCA.req
```

### Step 2: Submit and approve on the offline root

On the Desktop Experience root host, using the UI:

1. In **Certification Authority (`certsrv.msc`)**, open the shortcut menu for the CA, and then select **All Tasks** > **Submit new request**.
1. Select `IssuingCA.req`. Open **Pending Requests**, inspect the request, and record `<RequestId>`.
1. After authorized approval, open its shortcut menu, and then select **All Tasks** > **Issue**.

> [!NOTE]
> **Required privilege:** root CA certificate-manager/issue authority according to role separation; local/HSM authorization for signing.  

The following command submits the request to the standalone root and records the returned request identifier:

```powershell
certreq.exe -submit IssuingCA.req IssuingCA.cer
```

On a standalone root configured to hold requests, the command reports a request identifier and pending disposition. After authorized issuance:

```powershell
certreq.exe -retrieve "<RequestId>" IssuingCA.cer
```

The issued request moves to **Issued Certificates**, `IssuingCA.cer` is retrieved, and its subject, issuer, key, validity, Basic Constraints, policy, AIA, and CDP match the approved design.

> [!WARNING]
> **Irreversible-impact warning:** Don't issue until request identity, key, policy, and extension review passes. Revoking a wrongly signed subordinate can't erase copies or immediately remove trust; it triggers emergency publication and incident response.

### Step 3: Generate/export root artifacts

Generate a current root base CRL before export so relying parties receive revocation data whose validity covers transfer and publication:

```powershell
certutil.exe -crl
```

Export the current root certificate as `RootCA.cer` into the protected ceremony directory. Rather than assuming the generated CRL filename, explicitly export the current base CRL alongside the other ceremony artifacts by using `certutil -getcrl`:

```powershell
certutil.exe -getcrl RootCA.crl
```

By default, `-getcrl` retrieves the base CRL for the most recent CA key. Verify the issuer/key identifier, CRL number, and `This Update`/`Next Update`, then record the approved hash. After a CA key renewal, retain and export each still-required older key's CRL using its correct CRL/key index; the newest CRL isn't a replacement for every historical CRL.

As noted when you configured the root issuance extensions, `RootCA.crl` is the ceremony transfer name. Preserve the mapping to the canonical token-expanded filenames embedded in the issued certificates and CRLs when publishing. Don't overwrite a differently indexed CRL or publish only the alias when clients request another filename.

To do this using the UI, use **Certification Authority > CA Properties > General > View Certificate > Details > Copy to File** for the root certificate, or export the exact CA certificate by a controlled, verified method.

Inspect the fields of all three exported artifacts before they leave the offline zone. With `certutil -dump`, read names, serial numbers, key identifiers, constraints, URLs, and validity fields; this is field inspection, not complete cryptographic verification:

```powershell
certutil.exe -dump RootCA.cer
certutil.exe -dump RootCA.crl
certutil.exe -dump IssuingCA.cer
```

Field inspection shows readable values, but it doesn't by itself establish signatures, issuer relationships, or trust. Separately verify signatures and issuer relationships against the approved root certificate, and verify the root certificate's identity against the independently approved certificate/thumbprint record; a self-signature alone doesn't authorize trust.

Use the explicit-file forms of `-verify` against the staged ceremony files, supplying the signing certificate explicitly:

```powershell
certutil.exe -verify RootCA.cer RootCA.cer
certutil.exe -verify IssuingCA.cer RootCA.cer
certutil.exe -verify RootCA.crl RootCA.cer IssuingCA.cer
```

These commands supply the signing certificate explicitly. They check the supplied certificate and CRL fields and signatures; they don't establish the connected clients' Windows chain-building, trust-distribution, or URL-retrieval results. In the final command, `IssuingCA.cer` is the documented optional `IssuedCertFile` for the CRL form of `-verify`.

Record the root identity, issuer/key relationships, certificate constraints and validity, and the CRL number with its `This Update`/`Next Update`. Check and record whether the subordinate certificate's serial number appears in the verified root CRL. A signature mismatch, wrong issuer/key, unapproved root, invalid time period, or revoked subordinate blocks release. Repeat the subordinate checks for every certificate approved in the ceremony.

Keep the root offline. Don't disable revocation checking globally or import an unapproved trust anchor just to obtain a successful result. A full-chain invocation without an explicit issuer can depend on machine stores and retrieval or cache state; merely placing a CRL next to a certificate doesn't load it into those stores. A retrieval failure isn't proof of a bad signature and isn't a successful end-to-end result. Complete the module's separate clean-client `-urlfetch` checks from the appropriate connected validation clients after publication; offline signature checks don't prove HTTP availability or client trust deployment.

Success means `RootCA.cer` is the intended trust anchor and contains the approved root policy, `RootCA.crl` has a valid signature and a `Next Update` that covers transfer, publication, and overlap, and `IssuingCA.cer` is a CA certificate for the requested key that was issued by `<RootCAName>` with the planned AIA and CDP references.

### Step 4: Hash, seal, and shut down

Calculate hashes for the root public artifacts so the receiving publisher can detect substitution or corruption:

```powershell
Get-FileHash -Algorithm SHA256 RootCA.cer, RootCA.crl
```

Also hash `IssuingCA.cer`:

```powershell
Get-FileHash -Algorithm SHA256 IssuingCA.cer
```

Record filenames, sizes, hashes, certificate thumbprints, CRL number, `This Update`, `Next Update`, `<RequestId>`, operators, time, media identifier, and seal and store in a safe location.

Because the offline root is otherwise powered off, this ceremony is its backup window. Before you stop the service, back up the root's CA database and, for an exportable software-protected key, its private key and certificate to the approved protected backup destination. Keep this backup separate from the public-artifact transfer media, the HTTP publication tree, and the baseline-export directory. Record a successful protected backup and an isolated restore exercise before asserting root recoverability. Don't expose the root private key through the public-artifact ceremony media.

Stop the service and power off:

```powershell
Stop-Service -Name CertSvc
Get-Service -Name CertSvc
```

Expected success is `Stopped`, followed by controlled host shutdown and secure storage. Don't leave the root running for convenience.

### Step 5: Verify after transfer

At an authorized, domain-connected administrative workstation:

1. Inspect the seal and custody log.
1. Apply the approved malware-control process.
1. Recalculate hashes without renaming or changing the artifacts.
1. Compare hashes to the independent ceremony record.
1. Abort publication on any mismatch.

> [!NOTE]
> **Security consequence:** A hash validates identity only when the expected hash is obtained through a trusted, independent record. A hash stored solely beside the files can be replaced with them.
