Brute-force login attacks commonly target management ports as a means to gain access to a virtual machine (VM) or server. If successful, an attacker can take control of the host and establish a foothold in your environment. A brute-force attack consists of checking all possible user names or passwords until the correct one is found.

This form of attack isn't the most sophisticated, but tools such as THC-Hydra make it a relatively simple attack to perform. For example, the following command sequence is used to attack a Windows server.

```bash
user@debian$ hydra -l administrator -P wordlist.txt rdp://13.66.150.191 -t 1 -V -f
```

```output
Hydra v9.0 (c) 2004 by van Hauser/THC - Please do not use in military or secret service organizations, or for illegal purposes.

Hydra (http://www.thc.org) starting at 2019-10-10 17:38:44
[DATA] max 7 tasks per 1 server, overall 64 tasks, 7 login tries (1:1/p:7), ~0 tries per task
[DATA] attacking service rdp on port 3389
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "123456"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "654321" 
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "password"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "iloveyou"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "rockyou"
...
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "P@ssword!123"
[3389][rdp] host 13.66.150.191 login: administrator  password: P@ssword!123
[STATUS] attack finished for 13.66.150.191 (waiting for children to complete tests)
```

### Stop brute-force attacks

To counteract brute-force attacks, you can take multiple measures such as:

- Disable the public IP address and use one of these connection methods:
  - A point-to-site virtual private network (VPN).
  - Create a site-to-site VPN.
  - Use Azure ExpressRoute to create secure links from your on-premises network to Azure.

- Require two-factor authentication
- Increase password length and complexity
- Limit login attempts
- Implement Captcha
- Limit the amount of time that the ports are open

This final approach is what Microsoft Defender for Cloud implements on your behalf. Management ports such as Remote Desktop and SSH only need to be open while you're connected to the VM. For example, to perform management or maintenance tasks. The enhanced security features in Microsoft Defender for Cloud support Just-in-time (JIT) virtual machine (VM) access. When JIT VM access is enabled, Defender for Cloud uses network security group (NSG) rules to restrict access to management ports. The access is restricted when the ports aren't in use, so that attackers can't target them.

## Create a policy that enables JIT VM access

When you enable JIT VM access for your VMs, you can create a policy that determines:

- The ports to help protect.
- The length of time the ports should remain open.
- The approved IP addresses that can access these ports.

The policy enables you to stay in control of what users can do when they request access. Requests are logged in the Azure activity log so you can easily monitor and audit access. The policy also helps you quickly identify the existing VMs that have JIT VM access enabled. You can also see the VMs where JIT VM access is recommended.
