Local service accounts run a service on a single computer without a separately managed domain identity. Windows Server provides three built-in identities, plus virtual accounts. The operating system manages all of them, so there's no password to rotate.

## Built-in service identities

The following table compares the three built-in identities by local privilege and network identity:

| Identity | SID | Local privilege | Network identity |
| --- | --- | --- | --- |
| **LocalSystem** (`NT AUTHORITY\SYSTEM`) | `S-1-5-18` | Extensive | Computer account (`DOMAIN\computer$`) |
| **NetworkService** (`NT AUTHORITY\NetworkService`) | `S-1-5-20` | Minimal | Computer account (`DOMAIN\computer$`) |
| **LocalService** (`NT AUTHORITY\LocalService`) | `S-1-5-19` | Minimal | Anonymous (null session) |

Use the following guidance to choose among them:

- **LocalSystem** is powerful and convenient, but rarely appropriate. A compromise grants near-total control of the computer.
- **NetworkService** suits services that authenticate to network resources but need low local privilege.
- **LocalService** suits services that need no network identity.

> [!CAUTION]
> Use LocalSystem only when a service genuinely requires it. Otherwise, create a service account using the least-privileged option that meets the service's needs.

## Local user accounts

A standard local (SAM) account can run a service, but you own password rotation, the *Log on as a service* right, and any SPNs. Local accounts can't authenticate to domain resources, so use them only on standalone, workgroup servers.

## Virtual accounts

Virtual accounts (`NT SERVICE\<ServiceName>`) are automanaged *local* accounts introduced in Windows Server 2008 R2. They require no password management, isolate each service, and access network resources as the computer account. SQL Server uses them by default (for example, `NT SERVICE\MSSQLSERVER`).

## Choose a local account

Prefer, in order: a virtual account or LocalService, then NetworkService when a network identity is required, and LocalSystem only as a last resort. A more secure option is to use a managed service account, which you'll learn about in the next unit.

## Configure a service to use a local account

View the account a service currently runs under:

```powershell
Get-CimInstance Win32_Service | Select-Object Name, StartName
```

Set a built-in or virtual account with the Services snap-in:

1. Run `services.msc`, then open the service's **Properties**.
1. On the **Log On** tab, select **This account**.
1. Enter `NT AUTHORITY\LocalService`, `NT AUTHORITY\NetworkService`, or `NT SERVICE\<ServiceName>`, and leave both password boxes blank.
1. Select **OK**, then restart the service.

Set the account from the command line:

```cmd
sc.exe config <ServiceName> obj= "NT AUTHORITY\NetworkService"
```

Grant the *Log on as a service* right to a local user account:

1. Run `secpol.msc`, then go to **Local Policies** > **User Rights Assignment**.
1. Open **Log on as a service** and add the account. On domain-joined servers, assign this right through Group Policy.
