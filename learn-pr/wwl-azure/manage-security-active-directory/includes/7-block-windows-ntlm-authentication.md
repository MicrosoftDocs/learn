The NTLM authentication protocol is a legacy protocol that was the default for Windows NT 4.0. Since Windows Server 2000, the default has been the Kerberos authentication protocol. Kerberos provides some significant enhancements over NTLM authentication.

Some significant differences between the two protocols include:

 -  No mutual authentication: Kerberos allows for mutual authentication, meaning both the client and server can verify each other’s identity. NTLM doesn't allow for client verification of server identity.
 -  Vulnerability to replay attacks: Kerberos includes features like the authenticator to prevent replay attacks, which NTLM is susceptible to.
 -  Dependence on trust: In a multi-domain environment, Kerberos doesn't require all domains to trust each other, using existing trusts to find a path to the target. NTLM’s trust model is less flexible.
 -  Credential delegation: Kerberos introduced credential delegation, allowing for more secure and efficient access to resources. NTLM lacks this feature.

These points highlight the advancements in security and efficiency that Kerberos offers over NTLM. Because the NTLM authentication protocol is less secure than the Kerberos authentication protocol, you should block the use of NTLM for authentication and use Kerberos instead.

## Audit NTLM traffic

Prior to blocking NTLM, you need to ensure that existing applications are no longer using the protocol. You can audit NTLM traffic by configuring the following Group Policy settings under Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options:

 -  **Network security: Restrict NTLM: Outgoing NTLM Traffic to remote servers**. Configure this policy with the Audit All setting.
 -  **Network security: Restrict NTLM: Audit Incoming NTLM Traffic**. Configure this policy with the Enable auditing for all accounts setting.
 -  **Network security:Restrict NTLM: Audit NTLM authentication in this domain**. Configure this policy with the Enable for domain accounts to domain servers setting on domain controllers. You shouldn't configure this policy on all computers.

## Block NTLM

After you have determined that you can block NTLM in your organization, you need to configure the Restrict NTLM: NTLM authentication in this domain policy in the previous Group Policy node. The configuration options are:

 -  **Deny for domain accounts to domain servers**. This option denies all NTLM authentication sign-in attempts for all servers in the domain that use domain accounts, unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions for NTLM authentication** setting in this domain policy.
 -  **Deny for domain accounts**. This option denies all NTLM authentication attempts for domain accounts unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions for NTLM authentication** setting in this domain policy.
 -  **Deny for domain servers**. This option denies NTLM authentication requests to all servers in the domain unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions** setting for NTLM authentication in this domain policy.
 -  **Deny all**. This option ensures that all NTLM pass-through authentication requests for servers and accounts will be denied unless the server name is listed in the **Network Security: Restrict NTLM: Add server exceptions** setting for NTLM authentication in this domain policy.

To disable NTLM on domain controllers using the Group Policy Management Console, you can follow these steps:

1.  Open the **Group Policy Management Console (GPMC)**.
2.  Create a new **Group Policy Object (GPO)** and give it a descriptive name.
3.  Edit the GPO and navigate to Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Local Policies\\Security Options.
4.  Locate the policy **Network security: Restrict NTLM: NTLM authentication in this domain** and set it to **Deny all**.
5.  Locate the policy “Network security: Restrict NTLM: Add server exceptions in this domain” and configure it with the necessary exceptions if required.
6.  Link the GPO to the domain controllers’ Organizational Unit (OU).
7.  Ensure the policy is enforced by running the **gpupdate /force** command on the domain controllers or waiting for the next Group Policy refresh cycle.
