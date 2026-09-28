An import places certificate material in a selected context and store. It doesn't automatically establish trust, restore service permissions, configure an application, or create a renewal arrangement.

## Select the destination explicitly

A user's own authentication certificate normally belongs in **Current User Personal**. A machine service certificate normally belongs in **Local Computer Personal** when that service searches the machine store.

An approved root belongs in **Trusted Root Certification Authorities**. An intermediate belongs in **Intermediate Certification Authorities**. A server certificate doesn't belong in **Root** merely because a client reports a trust error.

Starting an import from the intended store reduces ambiguity. Opening a file and accepting default choices can place it in an unintended context.

1. Open `certmgr.msc` for the intended user or elevated `certlm.msc` for the computer.
1. Open the destination store's shortcut menu and select **All Tasks** > **Import**.
1. Select the approved file. For a PFX, enter its password and review private-key protection and exportability options.
1. Select **Place all certificates in the following store** and confirm the intended destination.
1. Complete the import. Reopen the certificate and verify its thumbprint, key association, and chain.

Don't enable certificate exportability unless your approved backup or migration design requires it. Strong private-key protection can introduce interactive prompts; an unattended service might be unable to respond. Choose protection that fits the key provider and workload without removing required controls.

Retain extended properties where the package and importer support them. Properties such as a friendly name can help identify the imported certificate, but they aren't signed identity claims and don't restore the destination service's key permissions.

## Import public certificates

The following command imports an existing user's public certificate into that user's Personal store. It doesn't supply a private key or establish CA trust.

```console
certutil.exe -user -addstore My "C:\CertWork\user.cer"
```

For the corresponding machine-store operation, omit `-user` and run from an elevated prompt. Import CA certificates separately through the controlled trust process later in this module.

If the certificate is the response to a request generated on this computer, complete that request instead of treating the response as an unrelated file. `certreq.exe -accept` performs the association with the existing key and outstanding request.

Copying a certificate between stores isn't a supported method for migrating its private-key context. To migrate a certificate between stores, transfer an authorized PFX or generate a new key and certificate in the correct context.

## Import a PFX

Inspect the package first and obtain approval for its contents. Import a user PFX as the intended user:

```console
certutil.exe -user -importPFX My "C:\CertWork\user-backup.pfx"
```

For an authorized server transfer, use an elevated prompt and import into Local Computer Personal:

```console
certutil.exe -importPFX My "C:\CertWork\server.pfx"
```

Enter the package password only when prompted. Use the import wizard instead when you must explicitly review strong key protection or destination exportability options. Importing the package doesn't destroy or protect the original PFX; retain or dispose of the source according to policy.

A PFX can contain several certificates. Verify the actual installed leaf and chain material rather than assuming one returned object represents everything in the package. Chain inclusion isn't permission to trust an unfamiliar CA.
