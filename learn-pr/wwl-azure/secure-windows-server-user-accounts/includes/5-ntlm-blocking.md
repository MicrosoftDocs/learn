The NTLM authentication protocol is less secure than the Kerberos authentication protocol. You should block the use of NTLM for authentication and use Kerberos instead.

## Audit NTLM traffic

Prior to blocking NTLM, you need to ensure that existing applications are no longer using the protocol. You can audit NTLM traffic by configuring the following Group Policy settings under Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options:

- **Network security: Restrict NTLM: Outgoing NTLM Traffic to remote servers**. Configure this policy with the Audit All setting.

- **Network security: Restrict NTLM: Audit Incoming NTLM Traffic**. Configure this policy with the Enable auditing for all accounts setting.

Network security: Restrict NTLM: Audit NTLM authentication in this domain. Configure this policy with the Enable for domain accounts to domain servers setting on domain controllers. You should not configure this policy on all computers.

## Block NTLM

After you have determined that you can block NTLM in your organization, you need to configure the Restrict NTLM: NTLM authentication in this domain policy in the previous Group Policy node. The configuration options are:

- **Deny for domain accounts to domain servers**. This option denies all NTLM authentication sign-in attempts for all servers in the domain that use domain accounts, unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions for NTLM authentication** setting in this domain policy.

- **Deny for domain accounts**. This option denies all NTLM authentication attempts for domain accounts unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions for NTLM authentication** setting in this domain policy.

- **Deny for domain servers**. This option denies NTLM authentication requests to all servers in the domain unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions** setting for NTLM authentication in this domain policy.

- **Deny all**. This option ensures that all NTLM pass-through authentication requests for servers and accounts will be denied unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions** setting for NTLM authentication in this domain policy.

