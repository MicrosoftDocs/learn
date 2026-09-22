To install the subordinate certificate, associate `IssuingCA.cer` with the original subordinate private key and start the enterprise issuing CA. This procedure requires elevated local administrator and CA administrator or HSM authorization on the issuing host. Success means `CertSvc` remains running, the CA certificate is associated with its private key, and the chain terminates at the intended root. A certificate for a different request, key, or root would cause startup failure or create an unintended trust path.

After verifying the ceremony hashes, bootstrap the issuing host's local-machine trust in the verified root if forest publication hasn't yet replicated:

> [!NOTE]
> **Required privilege:** elevated local administrator.  

```powershell
certutil.exe -addstore -f Root RootCA.cer
```

> [!NOTE]
> **Expected success:** the local computer **Trusted Root Certification Authorities** store contains the expected root thumbprint.

To perform these steps using UI tools, open `certlm.msc` > **Trusted Root Certification Authorities > Certificates > All Tasks > Import**; verify the displayed thumbprint before completing the wizard.

This host-local bootstrap doesn't replace AD DS, Group Policy, managed-device, or application trust distribution. If policy requires forest and HTTP publication before CA activation, complete and verify the publication procedures first.

To perform the next step in the user interface, open **Certification Authority (`certsrv.msc`)**, open the shortcut menu for the CA, select **All Tasks** > **Install CA Certificate**, select `IssuingCA.cer`, and then start the service.

The following commands install the signed CA certificate, start Certificate Services, and confirm its resulting state:

```powershell
certutil.exe -installcert IssuingCA.cer
Start-Service -Name CertSvc
Get-Service CertSvc
```

Expected success result is that the service is reported as `Running`. Validate the certificate and private-key association in the local computer certificate store and CA Properties.

## Configure AIA/CDP before production issuance

AIA/CDP URLs tell clients where to retrieve issuer certificates and certificate revocation lists. Configure and test these locations before production issuance because later CA configuration changes don't update URLs in existing certificates. Incorrect or unreachable locations can cause validation failures and may require certificate reissuance.

> [!NOTE]
> **Critical rule:** CA Properties > Extensions configures references embedded in newly issued certificates/CRLs and local/directory publication behavior. It does **not** copy CA certificate or CRL files to `<PkiWebHost>`.

This example procedure configures stable retrieval references and intentional publication flags before production issuance. It requires CA administrator privilege and local administrator privilege for the service restart. Success means the registry and UI contain only approved locations and flags and a new test certificate contains the exact approved AIA/CDP values. Incorrect URLs persist in certificates already issued, while unnecessary LDAP or server-name entries expose topology and create avoidable availability dependencies.

1. Open **Certification Authority (`certsrv.msc`) > `<IssuingCAName>` > Properties > Extensions**.
1. For **CRL Distribution Point (CDP)**:

   - Keep only approved publication/retrieval locations.
   - Example client retrieval:

     ```text
     http://<PkiWebHost>/pki/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl
     ```

1. Select **Include in the CDP extension of issued certificates** and, when delta CRLs are used, **Include in CRLs. Clients use this to find Delta CRL locations**.

   - Use a separate local/UNC/file publication location only if the CA is authorized to write there. Select **Publish CRLs to this location** and **Publish Delta CRLs to this location** only for the actual write target.
   - Retain LDAP publication only if it's approved and monitored. HTTP remains necessary for non-domain clients.

1. For **Authority Information Access (AIA)**:

   - Example retrieval:

     ```text
     http://<PkiWebHost>/pki/<CaName><CertificateName>.crt
     ```

   - Select **Include in the AIA extension of issued certificates**.
   - Don't select OCSP-related flags unless an Online Responder design is approved.

1. After approved changes, restart once:

   ```powershell
   Restart-Service -Name CertSvc
   Get-Service CertSvc
   ```

1. The following read-only commands show the effective CDP and AIA publication strings and their inclusion flags after the restart:

   ```powershell
   certutil.exe -getreg CA\CRLPublicationURLs
   certutil.exe -getreg CA\CACertPublicationURLs
   ```

Validate token expansion against the actual exported filenames, including generation suffixes after CA renewal.

## Configure CRL periods, overlap, and delta CRLs

The following PowerShell example configures a seven-day base CRL, daily delta CRLs, and separate 12-hour overlaps before restarting the service and publishing both CRL types:

> [!NOTE]
> **Required privilege:** CA administrator and elevated local administrator.  

```powershell
certutil.exe -setreg CA\CRLPeriod Days
certutil.exe -setreg CA\CRLPeriodUnits 7
certutil.exe -setreg CA\CRLOverlapPeriod Hours
certutil.exe -setreg CA\CRLOverlapUnits 12
certutil.exe -setreg CA\CRLDeltaPeriod Hours
certutil.exe -setreg CA\CRLDeltaPeriodUnits 24
certutil.exe -setreg CA\CRLDeltaOverlapPeriod Hours
certutil.exe -setreg CA\CRLDeltaOverlapUnits 12
Restart-Service -Name CertSvc
certutil.exe -crl
certutil.exe -crl delta
```

The result of these commands outputs:

- Base and delta CRLs, where configured
- Contains the intended `This Update`, `Next Update`, CRL number, overlap, and Freshest CRL relationship
- Are generated and published to the destinations configured and flagged for CA publication. Retrieval-only HTTP URLs still require the separate staging-to-web deployment procedure; verify those endpoints after that operation.

Base and delta overlap are separate settings and must each cover the relevant publication and retrieval delay.

> [!NOTE]
> **Security consequence:** Shorter intervals reduce potential stale revocation but increase publication load and outage sensitivity. Overlap must cover generation, copy, AD DS replication, web deployment, cache, monitoring, and rollback--not mask failed operations.

## Configure request disposition and understand the default policy module

The Microsoft default policy module evaluates enterprise template and CA policy, or standalone request behavior, to determine issuance disposition and certificate content. It doesn't make every request safe automatically.

You can view this in the UI by navigating to: **CA Properties > Policy Module > Properties**. Record whether requests are automatically issued or held pending. Enterprise template issuance can still be automatic according to effective policy and permissions; high-risk workflows can require template issuance requirements or a separate controlled path.

The following read-only registry query confirms the effective request-disposition value used by the policy module:

```powershell
certutil.exe -getreg policy\RequestDisposition
```

The output value should match the approved profile catalog. Automatic issuance lowers latency but amplifies permission, identity, template, and CA-policy mistakes. Pending issuance adds human validation, queue monitoring, and renewal risk.

## Establish the EditFlags baseline

The following read-only query displays the numeric and symbolic policy flags that can change how request data is accepted:

> [!NOTE]
> **Required privilege:** CA administrator for the policy change and elevated local administrator or delegated service-control rights for restart.  

```powershell
certutil.exe -getreg policy\EditFlags
```

Record and store the following information from the output:

- Original numeric and symbolic value.
- Whether `EDITF_ATTRIBUTESUBJECTALTNAME2` is present.
- Every published authentication-capable template.
- Enrollment interfaces that can submit request attributes.
- Representative pre/post-change tests.
- Service restart, maintenance window, rollback command, and owner.

`EDITF_ATTRIBUTESUBJECTALTNAME2` permits the CA-wide default policy module to accept SAN values from request attributes. This can override assumptions made from a template's **Subject Name** settings. Template safety must therefore be reviewed with effective CA policy and every enrollment interface.

For a new baseline, leave this flag disabled unless a documented, constrained workflow requires it and all authentication-capable profiles remain safe. If an approved change removes it:

```powershell
certutil.exe -setreg policy\EditFlags -EDITF_ATTRIBUTESUBJECTALTNAME2
Restart-Service -Name CertSvc
```

The symbolic flag is should be absent after restart, authorized SAN workflows pass, and untrusted request-attribute SANs aren't issued.

> [!WARNING]
> **Change warning:** Don't run the change command merely because the flag appears. First capture the original value, identify affected workflows, reproduce tests, approve rollback, and use a maintenance window. A CA-wide change can break legitimate enrollment or close an unsafe path.

If approved rollback criteria are met, restore the exact captured value:

```powershell
certutil.exe -setreg policy\EditFlags "<OriginalEditFlagsValue>"
Restart-Service -Name CertSvc
```

Expected success isn't only the registry value: test certificates must contain only authorized SANs, and affected valid workflows must still work.

## Understand the default exit module

The Microsoft default exit module performs configured post-issuance actions, including enterprise-directory publication behavior where applicable. It isn't a general-purpose guarantee that HTTP files, arbitrary application records, or every certificate are published. Keep custom policy and exit modules architectural in this learning path; custom development requires separate secure engineering and support.

To view this information in the UI, navigate to **CA Properties > Exit Module > Properties**. Record effective settings.  

The following registry export provides a broad inspection of CA settings that can influence default exit-module behavior:

```powershell
certutil.exe -getreg CA
```
> [!NOTE]
> **Security consequence:** Unreviewed exit behavior can disclose issued certificates, create unsupported dependencies, or be mistaken for AIA/CDP artifact publication.

## Control and validate CertSvc

The following controlled stop/start sequence confirms that the service responds as expected after configuration changes and that it can reopen its key, database, and log:

> [!NOTE]
> **Required privilege:** elevated local administrator or delegated service-control rights.  

```powershell
Stop-Service -Name CertSvc
Get-Service CertSvc
Start-Service -Name CertSvc
Get-Service CertSvc
```

The service state should transition to `Stopped` and then `Running`, and remains running without CA/HSM/storage events.

> [!NOTE]
> Use a change window. Stopping `CertSvc` interrupts enrollment, issuance, revocation actions, and CRL generation on that CA.
