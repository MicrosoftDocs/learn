Host-key attestation proves that a Hyper-V host possesses a key whose public portion HGS recognizes. It doesn't inspect the measured boot and CI state in the same way as TPM-trusted attestation. A Hyper-V host with an unapproved driver can still possess its registered key.

HGS registers the public key, not the certificate's chain or expiration as an authorization rule. Letting that certificate expire doesn't deauthorize the Hyper-V host. Prefer a distinct, protected key per Hyper-V host. Shared or copied private keys weaken attribution and make selective withdrawal unreliable.

Rotate a host key when its private key might be compromised, when rebuilding a host after compromise, when replacing a shared key with a unique per-host key, or when organizational policy requires periodic key replacement. A copied private key can let another machine impersonate the enrolled host, so withdraw a suspected compromised key promptly and establish the replacement on a known-clean host. Routine driver updates and certificate expiration alone don't require host-key rotation.

Rotate a Hyper-V host key as an identity change: approve the replacement, enroll its public key in every applicable HGS deployment, prove the intended new attestation path, and withdraw the old registration. Decommissioning also requires withdrawal and controlled disposal of private-key copies. Don't leave the old key indefinitely authorized merely because its certificate has expired.

On a deliberately selected alternative Hyper-V host, the fabric administrator creates and exports the public certificate for that Hyper-V host's key. Don't regenerate a working key during routine inventory as that changes identity.

```powershell
Set-HgsClientHostKey
Get-HgsClientHostKey -Path 'C:\Attestation\HVKey01-HostKey.cer'
```

The HGS administrator then verifies the public key's provenance and registers it on the intended HGS deployment.

```powershell
Add-HgsAttestationHostKey -Name 'HVKey01' `
    -Path 'C:\Attestation\HVKey01-HostKey.cer'
```

Registration doesn't switch the service to host-key mode. In host-key mode, HGS authenticates a Hyper-V host by verifying possession of the private key corresponding to a registered public key, rather than evaluating TPM-backed measured-boot and code integrity evidence.

## Treat the active mode as a service-wide decision

HGS attestation modes use different evidence to decide whether a Hyper-V host is trusted. 

- **TPM-trusted mode** verifies the host's TPM identity and measured security state against approved boot baselines and code integrity policies. 
- **Host-key mode** verifies possession of a registered private key without the same measured-health checks. 
- **Admin-trusted mode**, also called AD-based attestation, authorizes hosts through membership in approved AD DS security groups rather than TPM measurements. It's deprecated beginning with Windows Server 2019.

> [!NOTE]
> Deprecated doesn't mean removed or unsupported. Microsoft defines deprecated Windows Server components as no longer in active development but still supported for production use, with security and quality updates under the product lifecycle, until removal. The Windows Server 2025 `Set-HgsServer` reference still includes `-TrustActiveDirectory` for AD-based attestation. Retain this mode only where needed for existing deployments. Use TPM-trusted attestation for this module's new deployment, or evaluate host-key attestation where TPM attestation isn't possible.

HGS has one active attestation mode. Before a mode change, inventory all clients, their available credentials, and the admission consequences. Stage enrollment in advance, use a maintenance window, retain an approved rollback configuration, and collect new attestation evidence afterward.

On a nonproduction HGS deployment running the same Windows Server build as production, an HGS administrator checks the current attestation mode and the parameters supported by the installed `Set-HgsServer` cmdlet. The following commands don't change the configuration. They verify that the cmdlet exposes `-TrustHostKey` and show its installed help. If that parameter is absent, stop and resolve the supported configuration procedure before attempting to switch to host-key mode. A successful check confirms parameter availability, not that the mode change or host enrollment will work.

```powershell
Get-HgsServer
$setHgsServer = Get-Command Set-HgsServer -ErrorAction Stop
$setHgsServer.Parameters.Keys

if (-not $setHgsServer.Parameters.ContainsKey('TrustHostKey')) {
    throw 'Host-key mode switching is not exposed by this installed command.'
}

Get-Help Set-HgsServer -Full
```

Only after verifying the installed interface and the staged behavior would an approved change use `Set-HgsServer -TrustHostKey`. Inspect `Get-HgsServer` afterward and force fresh client attestation. Test a client that should be rejected as well as one that should pass.

Returning to TPM mode uses the following command only when the TPM artifacts are already valid. It's a separate rollback or migration action, not the next unconditional line of the host-key demonstration.

```powershell
Set-HgsServer -TrustTpm
Get-HgsServer
```
