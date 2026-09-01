Windows authentication troubleshooting is an evidence-driven process. SSPI and Negotiate can hide the protocol path, so administrators need to prove whether an application used Kerberos, NTLM, or fallback. A successful sign-in doesn't prove that the service ticket, SPN, delegation path, PAC, encryption type, or authorization decision is correct.

In this module, you learned how to:

- Explain how applications use SSPI and how Negotiate selects Kerberos or NTLM.
- Trace Kerberos from TGT issuance through service ticket issuance, ticket presentation, and authorization.
- Use `klist`, `setspn`, Event ID 4768, Event ID 4769, Event ID 4771, Event ID 4624, Event ID 4625, Event ID 4776, and NTLM operational logs to locate the failing authentication phase.
- Diagnose SPN ownership, duplicate SPNs, service account identity, delegation, double-hop, PAC, token size, and authorization issues.
- Explain why NTLM fallback can hide Kerberos misconfiguration and how Windows Server 2025 SMB NTLM blocking changes testing.
- Plan an NTLM-to-Kerberos migration by auditing dependencies, correcting Kerberos prerequisites, validating service tickets, piloting restrictions, and controlling exceptions.
- Audit RC4 usage by reviewing advertised encryption types, available keys, ticket encryption type, session encryption type, and failure code.
- Prepare for Windows Server 2025 Kerberos hardening, including RC4 TGT removal, PKINIT cryptographic agility, Group Policy-based encryption configuration, and SAM RPC password-change hardening.
- Remediate legacy dependencies by resetting account passwords, rotating managed service accounts, correcting SPNs, configuring supported encryption types deliberately, validating trusts, and replacing RC4-only devices.

Use this checklist when you troubleshoot or review readiness:

| Area | Question to answer |
| --- | --- |
| Protocol selection | Did the application use Kerberos, NTLM, or fallback through Negotiate? |
| TGT issuance | Did the client obtain a TGT from the expected KDC with acceptable encryption? |
| Service ticket | Did the client request the correct SPN, and did the KDC issue a ticket without RC4 or unsupported encryption errors? |
| Service identity | Does the account that owns the SPN match the account that can decrypt the service ticket? |
| Delegation | Does the application need local impersonation only, constrained delegation, protocol transition, or resource-based constrained delegation? |
| Authorization | Did authentication succeed but access fail because of permissions, group membership, claims, or token size? |
| NTLM migration | Are NTLM dependencies inventoried, owned, remediated, validated with Kerberos evidence, and covered by staged restrictions? |
| RC4 readiness | Do events 4768 and 4769 show RC4 usage, missing AES keys, or accounts that only support RC4? |
| Windows Server 2025 compatibility | Are PKINIT, encryption policy, SMB NTLM blocking, trust referrals, and SAM RPC password-change workflows tested? |

The most important operational lesson is to remove ambiguity. Don't accept "it works" as proof that the environment is ready. Prove the selected protocol, the requested SPN, the ticket encryption type, the account key material, the delegation path, and the authorization result. Windows Server 2025 strengthens the defaults, but a secure deployment still depends on disciplined auditing, remediation, staged enforcement, and documented exceptions.

## Learn more

- [Kerberos authentication overview in Windows Server](/windows-server/security/kerberos/kerberos-authentication-overview)
- [Kerberos authentication troubleshooting guidance](/troubleshoot/windows-server/windows-security/kerberos-authentication-troubleshooting-guidance)
- [Troubleshooting Kerberos constrained delegation issues](/troubleshoot/windows-server/windows-security/troubleshoot-kerberos-constrained-delegation-issues)
- [NTLM overview](/windows-server/security/kerberos/ntlm-overview)
- [How to configure SPNs](/windows-server/identity/ad-ds/manage/how-to-configure-spn)
- [Setspn command reference](/windows-server/administration/windows-commands/setspn)
- [Klist command reference](/windows-server/administration/windows-commands/klist)
- [Advanced Audit Policy Configuration](/windows-server/identity/ad-ds/plan/security-best-practices/advanced-audit-policy-configuration)
- [Block NTLM connections on SMB](/windows-server/storage/file-server/smb-ntlm-blocking)
- [SMB security hardening](/windows-server/storage/file-server/smb-security-hardening)
- [Detect and remediate RC4 usage in Kerberos](/windows-server/security/kerberos/detect-remediate-rc4-kerberos)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)

