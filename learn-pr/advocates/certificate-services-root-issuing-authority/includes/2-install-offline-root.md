Before installing the offline root, ensure you've met the following prerequisites:

- Build the host computer from approved Windows Server 2025 Desktop Experience media for this walkthrough and patch to the approved baseline before it enters offline custody.
- Keep the root in a workgroup. Never join it to an AD DS domain.
- Remove or disable unneeded network interfaces; don't use production network connectivity for publication. Deploy on an air-gapped network where possible.
- Use dedicated administrative credentials, protected local recovery credentials, physical controls, and audited boot/activation procedures.
- Configure HSM software and verify key backup/quorum before CA key creation.
- Set final computer and CA names. Don't rename after CA installation.

## Server Core versus Desktop Experience

When deploying Windows Server, you can choose between the Server Core and Desktop Experience installation options. The comparison table supports an installation choice based on supportability and operator capability rather than assuming that either interface is inherently secure.

| Consideration | Server Core | Desktop Experience |
|---|---|---|
| Attack and servicing surface | Fewer local components and patches. | More local components and GUI dependencies. |
| Local tools | Primarily command line and remote MMC where appropriate. | Local MMC and richer troubleshooting UI. |
| Offline operations | Can reduce installed surface but requires tested command runbooks. | May reduce ceremony operator error where local GUI is explicitly required. |
| Support | Requires staff proficiency and vendor/HSM support. | Requires equal hardening; GUI presence isn't a security control. |

Neither option is automatically secure. Choose the smallest supported installation that operators, HSM tooling, recovery procedures, and vendor support can reliably administer.

AD CS supports appropriate Server Core deployments, but the hands-on walkthrough in this module uses Windows Server Desktop Experience on the offline root and each issuing CA because mandatory steps use local MMC snap-ins. Use Desktop Experience for this walkthrough. The Server Core comparison is an architectural consideration, not a complete alternative procedure.

> [!NOTE]
> A Server Core deployment requires a separately approved and validated command-line or isolated remote-management runbook that covers all configuration, pending-request approval, artifact handling, and verification operations. Don't connect the offline root to production networks merely to run remote MMC.

### Time and service recovery

An offline root CA by its nature is in a dormant state and doesn't regularly perform clock synchronization with a PDC emulator. A root ceremony is a documented, witnessed process for temporarily bringing an offline root CA into operation to perform sensitive tasks. Before every root CA ceremony:

- Compare the offline root CA's clock with an approved independent time source.
- Record source, offset, operator, and any correction.
- Confirm time zone and planned `NotBefore`, `This Update`, and `Next Update` effects.
- Don't connect the root to an untrusted network to obtain time.

For online issuing CAs, use the domain time hierarchy with the forest-root PDC emulator synchronized to approved external sources. Monitor drift. Certificate validity, Kerberos, CRL freshness, logs, and custody timestamps depend on time.

Configure service recovery deliberately for issuing CAs after testing. Automatic restart can recover a transient failure, but it can't recover a failed HSM, corrupt storage, or bad configuration. For the offline root, normal state is powered off; don't treat unattended recovery as availability.

The following checks confirm the issuing CA's approved time configuration and capture evidence; they don't configure Certificate Services recovery actions. They require elevated local administrator privilege, and changing the forest-root PDC emulator's external peers also requires the authorized time-service administrator. Success means each issuing CA reports the domain hierarchy as its source with an acceptable offset. Time errors can invalidate certificates, Kerberos, CRL freshness, and evidence ordering. Before you accept an issuing CA, separately configure or confirm its approved, bounded `CertSvc` recovery policy, as described at the end of this section.

On each issuing CA, run these read-only checks to identify its time source, synchronization state, offset, and most recent successful synchronization:

```powershell
w32tm.exe /query /source
w32tm.exe /query /status
```

If the approved domain-member baseline has drifted, restore domain-hierarchy synchronization:

```powershell
w32tm.exe /config /syncfromflags:domhier /update
Restart-Service -Name W32Time
w32tm.exe /resync
```

Don't run that sequence on the offline root. Its time check is a recorded ceremony step against an approved independent source.

> [!NOTE]
> Air-gapped networks often use special time devices called GNSS-disciplined NTP servers or stratum 1 time servers. They use read-only GPS signals to calibrate time and provide time services to hosts on the air-gapped network. These devices allow for accurate time to be kept on air-gapped networks without requiring connectivity to time servers on the internet.

Configuring `CertSvc` recovery is a separate task from the time checks above. On the issuing CA, review **Services > Active Directory Certificate Services > Properties > Recovery**. Apply the approved recovery settings if the current values differ. Record the first, second, and subsequent failure actions, the restart delay, and the failure-count reset period required by the approved operations policy. A policy intended to stop retrying must end in a terminating no-action behavior rather than a final restart action that repeats indefinitely. Also record whether recovery actions run for non-crash failures. Query both settings without changing them:

```powershell
sc.exe qfailure CertSvc
sc.exe qfailureflag CertSvc
```

These commands report configuration; they don't set it. The `failure-actions flag` controls whether the configured actions also run when the service reports `SERVICE_STOPPED` with a nonzero Win32 exit code. If you change that flag, the change takes effect at the next system start, so schedule a controlled restart of that issuing CA's operating system before final testing, not merely a `CertSvc` restart. 

Validate the intended crash and applicable non-crash failure behavior in isolated preproduction conditions, and document operator intervention and escalation. A normal, successful service stop and start doesn't prove that failure recovery works. Don't extend an issuing CA's automatic-restart assumptions to the offline root, whose normal state is powered off, without its ceremony controls.

### Antivirus guidance

Use current Microsoft and antivirus-vendor guidance for the exact product/build, measure contention, test backup/restore and issuance, and scope any exception to the minimum path/process. Don't recommend broad CA, database, log, key, or `CertEnroll` exclusions by default. Document owner, rationale, expiry, monitoring, and rollback. An exclusion can create an unmonitored persistence or staging location.

## Server Manager installation demonstration

This following procedure installs the AD CS role and configures a new standalone root CA with approved key and storage settings. It requires elevated local administrator privilege on the offline root plus any ceremony quorum and custody required by policy. Success means AD CS Configuration reports completion, `CertSvc` runs during the ceremony, and the CA certificate matches the approved name, provider, key, hash, validity, policy, and empty root AIA/CDP design. Selecting the wrong CA type, key, name, or provider creates a different trust anchor and normally requires rebuilding before trust distribution.

> [!NOTE]
> **Required privilege:** elevated local administrator and approved root ceremony authority.  

1. Open **Server Manager > Manage > Add Roles and Features**.
1. Select **Role-based or feature-based installation** and the local server.
1. Select **Active Directory Certificate Services** and add required management tools.
1. On role services, select **Certification Authority** only.
1. Select **Configure Active Directory Certificate Services on the destination server**.
1. In the **AD CS Configuration wizard**, select:
   - **Standalone CA**
   - **Root CA**
   - **Create a new private key**
   - Approved CSP/KSP/HSM provider
   - Approved algorithm, key length/curve, and hash
   - `<RootCAName>` and approved DN suffix
   - Approved validity period
   - Approved database and log locations
1. Review the summary against the signed implementation record. Configure only after a second operator verifies it.

These selections have durable security consequences. A standalone CA can hold requests for manual approval without depending on AD DS, keeping the root outside the domain attack path. Selecting the root role creates the trust anchor, so an incorrect installation can't be repaired by changing a parent CA. A new key establishes a new PKI identity and must be protected and backed up before operational reliance. The provider and algorithm determine custody, compatibility, performance, and recovery behavior, while the CA name and DN appear throughout the chain and aren't merely friendly labels. Validity controls both exposure and renewal pressure, and the database and log paths determine integrity, recoverability, and storage failure domains.

## PowerShell installation

The following PowerShell command installs the Certification Authority role service and its management tools without configuring a CA:

```powershell
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools
```

`Install-AdcsCertificationAuthority` configures the CA using the supplied parameters and defaults for omitted settings. Its confirmation prompt isn't a configuration wizard. Review the approved CA type, provider, key length, hash, CA name, storage, and applicable validity or request-output settings before running the parameterized example below. Use the Server Manager AD CS Configuration wizard if you need an interactive configuration experience. Don't run a bare configuration command as a preliminary step.

`-AllowAdministratorInteraction` concerns private-key/provider prompts, not collection of the CA design. Don't rerun installation against an already configured CA to repair accidentally accepted defaults.

For a repeatable software-KSP example, adapt only after validating the exact cmdlet parameters on the target Windows Server 2025 build:

```powershell
Install-AdcsCertificationAuthority `
    -CAType StandaloneRootCA `
    -CACommonName '<RootCAName>' `
    -CryptoProviderName 'RSA#Microsoft Software Key Storage Provider' `
    -KeyLength 4096 `
    -HashAlgorithmName SHA256 `
    -ValidityPeriod Years `
    -ValidityPeriodUnits 20 `
    -DatabaseDirectory 'D:\CertDB' `
    -LogDirectory 'E:\CertLog'
```

> [!NOTE]
> If using an HSM, use its supported provider and interaction parameters. Never substitute the software KSP example for vendor instructions.

## Database and transaction-log volume design

For a low-volume offline root, separate physical volumes may add little assurance compared with protected backups and simple recovery. For a high-volume issuing CA, place the CA database, system, and temporary data on a tested location such as `D:\CertDB`, and place transaction logs on storage with genuinely independent failure behavior, such as `E:\CertLog`. Neither volume should contain general user or application data. Both require capacity alerts, backup and log-truncation procedures, restore testing, BitLocker and HSM compatibility validation, and documented replacement steps.

Separate drive letters on the same underlying failure domain, such as the same physical disk, don't satisfy the objective. Document storage topology and recovery, not only paths.

## Configure root issuance extensions before signing a subordinate

The empty root-certificate sections in `CAPolicy.inf` omit AIA/CDP from the self-signed root certificate. They do **not** configure the AIA/CDP values that the root will place in a subordinate CA certificate.

Configure generation-aware root certificate and root CRL references for future subordinate CA certificates without connecting the root to a publisher. Performing this procedure requires root CA administrator and elevated local administrator privilege under ceremony control. Success means the registry and UI show the approved HTTP AIA and CDP inclusion flags and the later `IssuingCA.cer` contains the exact expanded URLs. Signing a subordinate before performing this step would embed wrong or unreachable references for that subordinate generation.

To perform this procedure on the Desktop Experience root host, in **Certification Authority (`certsrv.msc`) > `<RootCAName>` > Properties > Extensions**:

1. For **CRL Distribution Point (CDP)**, retain an approved local filesystem publication entry for CRL generation, but don't include the local path in certificates.
1. Add:

   ```text
   http://<PkiWebHost>/pki/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl
   ```

   Select **Include in the CDP extension of issued certificates**. Don't select delta-related flags because the root design disables delta CRLs. Don't select **Publish CRLs to this location** for the HTTP URL; the offline root can't reach it.
1. For **Authority Information Access (AIA)**, add:

   ```text
   http://<PkiWebHost>/pki/<CaName><CertificateName>.crt
   ```

   Select **Include in the AIA extension of issued certificates**. Remove unapproved server-specific retrieval entries.
1. Approve the restart prompt and verify:

   ```powershell
   certutil.exe -getreg CA\CRLPublicationURLs
   certutil.exe -getreg CA\CACertPublicationURLs
   Restart-Service -Name CertSvc
   ```

The token-expanded `.crt` and `.crl` names are the HTTP content contract. Ceremony files can remain `RootCA.cer` and `RootCA.crl`, but the publisher must copy them under the exact expanded names referenced by `IssuingCA.cer`. Configuration still doesn't copy either file.

## Root verification

The following commands confirm service state, effective CA configuration, publication URLs, request disposition, and successful base-CRL generation before the root signs a subordinate:

> [!NOTE]
> **Required privilege:** elevated local administrator; CA configuration reads and CRL publication require CA administrative authority.  

```powershell
Get-Service CertSvc
certutil.exe -getreg CA
certutil.exe -getreg CA\CRLPublicationURLs
certutil.exe -getreg CA\CACertPublicationURLs
certutil.exe -getreg policy\RequestDisposition
certutil.exe -crl
```

> [!NOTE]
> **Expected success:** `CertSvc` is `Running` during the controlled session, registry values match the baseline, root requests are held pending for authorized review, and a current root CRL is generated with the approved period and no delta CRL.

To validate using the UI, open **Certification Authority (`certsrv.msc`)**. Inspect CA Properties, **Policy Module > Properties**, Revoked Certificates, and the generated CRL. The offline root must hold requests pending for explicit authorized issuance. Automatic root issuance could delegate CA authority without the ceremony approval. Don't issue any subordinate certificate until the root's publication settings and ceremony are approved.
