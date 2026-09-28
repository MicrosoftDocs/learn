A certificate store is a Windows collection of certificates and related properties. Select both the account context and the logical store before performing an operation.

## Choose the correct console

Run `certmgr.msc` to manage certificates for the account running the console. The console root identifies **Certificates - Current User**. Run `certlm.msc` to manage local computer certificates and use elevation for machine-level changes.

`LocalMachine` refers to the local Windows computer. It doesn't mean a CA server, and it doesn't require domain membership. A workgroup computer also has user and machine certificate stores.

Running `certmgr.msc` under different credentials opens the other account's store. Elevation isn't an instruction to show every user's certificates. Check the process identity, especially when support staff use a separate administrator account.

To compare contexts in one Microsoft Management Console (MMC):

1. Open `mmc.exe` with the required privileges. Select **File** > **Add/Remove Snap-in**.
1. Add **Certificates**, select **My user account**, and finish the selection.
1. Add **Certificates** again. Select **Computer account** > **Next**, then **Local computer** > **Finish**.
1. Select **OK** and expand both certificate snap-ins.

:::image type="content" source="../media/user-computer-certificate-console.png" alt-text="Screenshot of Microsoft Management Console with Current User and Local Computer certificate snap-ins." lightbox="../media/user-computer-certificate-console.png":::

The snap-in also offers **Service account** for supported service-specific stores. That store isn't the same concept as granting a service access to a key in Local Computer Personal. Determine which store the application actually opens.

> [!NOTE]
> The SDK utility `certmgr.exe` is a separate command-line program. It isn't `certmgr.msc`. Similarly, `certsrv.msc` administers a CA rather than the local certificates used by an ordinary application.

## Certificate stores

**Current User Personal** and **Local Computer Personal** are separate certificate stores. Importing a server certificate into an administrator's Personal store doesn't make it a machine certificate.

Trust behaves differently. Current-user stores generally inherit certificates from corresponding local-machine stores, except for Personal. A root certificate installed for the machine can therefore influence validation for its users. Application policy can further restrict the trust that an application uses.

The following diagram separates certificate identity storage from shared trust. The machine and user Personal stores don't merge. Machine trust contributes to the effective trust of Windows applications that use the corresponding user-store view.

:::image type="content" source="../media/certificate-store-scope-trust.svg" alt-text="Diagram that shows separate user and computer certificate stores with shared machine trust." lightbox="../media/certificate-store-scope-trust.svg":::

Visibility isn't key access. The computer store can expose a public certificate to multiple processes while the key provider permits only selected identities to use its private key.

## Logical stores

Logical stores can combine certificates from several physical locations, including local settings and policy. In the Certificates snap-in, select **View** > **Options** and enable **Physical certificate stores** to investigate the source. Don't edit the backing registry entries to change trust.

The primary stores are as follows:

- **Personal**, identified as `My` by native certificate tools, holds certificates intended for the user or computer's own use. It can contain certificates without private keys, so inspect the association rather than assuming one exists.
- **Trusted Root Certification Authorities**, named `Root`, contains trust anchors. **Intermediate Certification Authorities**, named `CA`, contains intermediate certificates used to build chains. Installing an intermediate doesn't independently authorize its root.
- **Trusted Publishers**, named `TrustedPublisher`, records publisher trust decisions used by supporting applications. **Trusted People**, named `TrustedPeople`, supports explicit peer trust where the application recognizes that store. Neither is a universal replacement for CA trust.
- **Untrusted Certificates**, named `Disallowed`, contains explicit distrust entries. Explicit distrust differs from not yet trusting an issuer. **Other People**, named `AddressBook`, holds other entities' public certificates, such as email recipients' certificates.
- **Certificate Enrollment Requests**, named `Request`, holds request-related information. An entry there isn't evidence of an issued certificate ready for application use.
- **Third-Party Root Certification Authorities**, named `AuthRoot`, participates in Windows-managed third-party root trust. Its contents and certificate trust lists contribute to effective trust. Don't manage it as an arbitrary substitute for the ordinary Root store.
- **Web Hosting**, named `WebHosting`, can hold certificates for supporting web workloads. Store availability depends on the system and installed roles. A certificate in Web Hosting doesn't automatically satisfy an application that only searches Personal.

## Use native command-line tools

`certutil.exe` inspects certificate stores and files, verifies chains, and performs selected store operations. `certreq.exe` creates, submits, retrieves, accepts, and renews certificate requests. `gpupdate.exe` and `gpresult.exe` refresh and report Group Policy. `wevtutil.exe` queries event logs, and `netsh.exe` inspects HTTP.sys certificate associations.

Inspect user and computer Personal stores separately:

```console
certutil.exe -user -store My
certutil.exe -store My
```

Native command output can be localized and can change between Windows releases. Use it for operator diagnostics and controlled procedures, not as an unversioned text-parsing API. A remote command session also runs under its own identity; its user store isn't automatically the interactive desktop user's store.
