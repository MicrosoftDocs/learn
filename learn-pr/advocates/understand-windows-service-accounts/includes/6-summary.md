In this module, you learned how to choose and configure the security context for Windows services. The right account follows a path from simplest to most secure. A built-in or virtual account suits a single server that has no domain identity to manage. A standalone Managed Service Account (sMSA) fits a single server that needs an Active Directory-managed password and service principal names (SPNs). A group Managed Service Account (gMSA) provides one identity for multiple servers, farms, or load-balanced apps. A delegated Managed Service Account (dMSA) protects machine-bound, high-security accounts on Windows Server 2025 that must resist attacks like Kerberoasting.

## Further reading

Use the following resources to learn more:

- [Service Accounts in Windows Server](/windows-server/identity/ad-ds/manage/understand-service-accounts)
- [Group Managed Service Accounts overview](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/group-managed-service-accounts-overview)
- [Delegated Managed Service Accounts overview](/windows-server/identity/ad-ds/manage/delegated-managed-service-accounts/delegated-managed-service-accounts-overview)
