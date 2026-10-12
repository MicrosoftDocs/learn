Guest administration remains an owner-authenticated operation. Use Remote Desktop Protocol (RDP), Windows Remote Management (WinRM), or Secure Shell (SSH) where configured and supported. Verify endpoint identity, authorize credentials, and define guest firewall rules deliberately. Reachability isn't authentication, and fabric membership isn't guest authorization.

Distinguish blocked basic-console or debugging access from newer guest-authenticated management paths. Verify the exact Windows Server 2025 Hyper-V host and shielded VM guest behavior, owner credentials, and restrictions before publishing a categorical access statement. See the version-specific troubleshooting changes.

Supported Enhanced Session Mode and PowerShell Direct paths still require guest credentials and can be restricted by the owner. Their availability doesn't grant the fabric administrator an owner-credential bypass.

## Make every destination eligible

A Hyper-V workload cluster provides VM availability. The HGS cluster provides attestation and key-protection availability. They're different systems with different failure modes.

Before moving a protected VM, the destination Hyper-V host must meet platform and CPU/configuration compatibility requirements, have appropriate storage and network access, pass the intended HGS attestation, and reach KPS keys authorized by that VM's KP. Successful attestation alone isn't a placement rule.

For example: A fabric cluster administrator works in a supported, preconfigured Hyper-V failover cluster. `App01` is already stored and networked appropriately for that cluster. Adding its clustered role changes availability management but doesn't shield the VM.

```powershell
Add-ClusterVirtualMachineRole -VirtualMachine 'App01'
```

After destination eligibility and capacity are established, an approved live migration uses the actual clustered role name.

```powershell
Move-ClusterVirtualMachineRole -Name 'App01' `
    -Node 'HV02' -MigrationType Live
```

Inspect the cluster's resulting owner node and workload health. An error isn't a reason to remove the KP, use local mode, or move to an unguarded Hyper-V host.

For a nonclustered migration, the corresponding Hyper-V operation is `Move-VM`. Its authentication, storage, and destination requirements must still be met.

```powershell
Move-VM -Name 'App01' -DestinationHost 'HV02'
```

That example assumes the supported storage arrangement doesn't require a separate storage move. Use the appropriate documented storage parameters for another arrangement, not a blind copy of the disk while the VM is running.

## Windows Server 2025 Credential Guard

Credential Guard is enabled by default on eligible domain-joined, non-domain-controller Windows Server 2025 systems. It can prevent credential delegation on which CredSSP-based live migration relied. A migration failure after upgrading can therefore be an authentication failure rather than an attestation or shielding failure.

Prefer a supported Kerberos constrained delegation or resource-based constrained delegation design for the relevant migration and storage services. Don't make disabling Credential Guard the default repair.

For example: A fabric administrator inspects the Hyper-V host settings. The following PowerShell code selects Kerberos for migration, but it doesn't create AD delegation permissions.

```powershell
Get-VMHost |
    Select-Object VirtualMachineMigrationEnabled,
        VirtualMachineMigrationAuthenticationType

Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos
```

An authorized AD administrator must separately configure the intended delegation scope, identities, and services. Verify the initiating identity and the behavior of the source and destination Hyper-V hosts. Keep authentication, CPU compatibility, networking, storage, destination attestation, and KP authorization as distinct diagnostic checks. See Credential Guard and migration.

## Protect checkpoints, replicas, and backups

Treat a checkpoint or replica as another recoverable state with its own key dependencies. A replica destination needs the intended guarded-fabric authorization when it becomes active. A checkpoint isn't an independent backup, and a copied VHDX isn't a complete shielded-VM recovery set.

**Export/import and saved state:** Preserve the supported configuration, KP, vTPM, encrypted state, and disk set. Validate saved-state compatibility with the destination build, VM configuration version, and processor environment. An export doesn't remove guardian requirements, and attaching an exported disk to a new VM isn't equivalent to importing the protected VM.

**Failover and failback:** Prove the recovery Hyper-V host can obtain the VM's keys before relying on replication. On failback, recheck the original site's current Hyper-V hosts, policies, endpoints, and KP authorization. A formerly authorized site can now be stale or deliberately withdrawn.

Verify the exact Hyper-V host builds, guest workloads, backup-product version, and operation in the compatibility record. Don't generalize a successful unshielded-VM backup test to protected-state restore.

Apply the same support/evidence distinction to device features such as pass-through hardware and nested virtualization. Keep unverified combinations out of the worked path. Protected migration doesn't establish a blanket security guarantee for every export, replication, or backup transport.
