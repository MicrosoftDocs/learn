Expired or lost certificates can cause disruption to services. Ensure that you have a certificate lifecycle management process in place for important certificates such as the SSL/TLS certificates used by important services.

## Renew before the old certificate expires

Renewal issues a new certificate. It doesn't edit the old certificate's `NotAfter` value. The new certificate has a different encoding and thumbprint even when the subject and public key remain the same.

Renewal with a new key replaces the key material. Renewal with an existing key retains it where policy and the provider permit that choice. New enrollment creates a request under current policy when a renewal path isn't applicable.

Prefer a new key when policy requires rotation or the old key might be compromised. Retaining a compromised key defeats the purpose of replacing the certificate.

In the correct console, select the certificate and inspect its available **All Tasks** actions. Use **Renew Certificate with New Key** when supported. Existing-key renewal can appear under the advanced operations menu. Missing actions can reflect enrollment source, template, provider, or certificate state rather than a broken console.

For an eligible, currently valid machine certificate, the native renewal workflow is:

```console
certreq.exe -enroll -machine -cert "<CertificateThumbprint>" renew
```

Use `-user` for an applicable user certificate under the intended user identity. The documented `reusekeys` modifier requests existing-key reuse when supported and approved. It isn't the default recommendation for every renewal.

`certreq.exe -enroll` renewal requires a valid certificate. Use the appropriate new issuance path for an expired certificate. Autoenrollment's broader lifecycle settings don't remove that command-specific requirement.

## Switching to use updated certificate during overlap period

Obtain the replacement early enough to inspect its chain, identities, purposes, and key access while the old certificate remains available. Update consumers according to their selection rules.

A service bound to the old thumbprint doesn't automatically select a new certificate with the same subject. A service that chooses certificates automatically can select an unexpected candidate if multiple certificates meet its rules. 

New keys can need new permissions. Applications can cache certificate objects or key handles and require a documented reload. Test from representative clients after the change, then retain the old certificate only for the approved overlap or recovery purpose.

AD CS autoenrollment can renew eligible template certificates under applied policy. An imported external certificate normally requires the external issuer's renewal workflow. 

## Back up and recovery

A recoverable key backup requires key material, permitted export, protection, and a tested restore path. A `.cer` export or a CA database record of the issued certificate isn't enough.

Back up exportable keys through the protected PFX workflow. Document the password custody, certificate thumbprint, applicable system or user context, and applications that need the key. Keep an authorized recovery copy independent of temporary transfer locations.

Test restoration in an isolated, approved account or computer that doesn't already hold the private key. In that user's session, restore the approved test copy and compare it with the backup record:

```console
certutil.exe -user -importPFX My "C:\CertWork\user-backup.pfx"
certutil.exe -user -store My "<ExpectedBackupThumbprint>"
```

Enter the package password only when prompted. A successful import and reported key association don't establish application recovery. Test the consumer or the data operation that recovery must support, such as decrypting an authorized test file or message. Afterward, remove only the test installation and temporary copies according to the recovery test plan.

An imported key can be non-exportable while the original protected PFX remains the approved recovery copy. Don't mark every restored key exportable just to reproduce another backup step.

## Preserve decryption capabilities

An expired encryption certificate can still be necessary to decrypt existing data. EFS-protected files and older S/MIME messages can depend on historical private keys rather than the latest certificate.

> [!WARNING]
> Renewing or replacing a certificate doesn't automatically re-encrypt existing data with the new key. Don't delete old encryption keys based only on `NotAfter`.

Key archival at a CA is a separate, preconfigured recovery capability. It requires an applicable template and authorized recovery process. It isn't automatically available for every issued certificate, and it doesn't retroactively recover keys that were never archived.

Device-bound, non-exportable, smart-card, and HSM keys have provider-specific recovery limits. If no supported recovery path exists, obtain a replacement key and certificate. Replacement can restore future authentication but might not recover data encrypted for a lost key.
