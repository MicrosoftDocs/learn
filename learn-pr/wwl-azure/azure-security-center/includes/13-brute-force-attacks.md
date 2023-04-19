
## Brute force attacks

Adversaries without prior knowledge of legitimate credentials within the system or environment may guess passwords to attempt access to accounts. Without knowledge of the password for an account, an adversary may opt to systematically guess the password using a repetitive or iterative mechanism. An adversary may guess login credentials without prior knowledge of system or environment passwords during an operation by using a list of common passwords. Password guessing may or may not take into account the target's policies on password complexity or use policies that may lock accounts out after a number of failed attempts.

Typically, management services over commonly used ports are used when guessing passwords. Commonly targeted services include the following:

 -  SSH (22/TCP)
 -  Telnet (23/TCP)
 -  FTP (21/TCP)
 -  NetBIOS / SMB / Samba (139/TCP & 445/TCP)
 -  LDAP (389/TCP)
 -  Kerberos (88/TCP)
 -  RDP / Terminal Services (3389/TCP)
 -  HTTP/HTTP Management Services (80/TCP & 443/TCP)
 -  MSSQL (1433/TCP)
 -  Oracle (1521/TCP)
 -  MySQL (3306/TCP)
 -  VNC (5900/TCP)
 -  SNMP (161/UDP and 162/TCP/UDP)

:::image type="content" source="../media/remote-desktop-services-primary-54ce8abb.png" alt-text="Screenshot showing Brute Force Attack example.":::


One way to reduce exposure to a brute force attack is to limit the amount of time a port is open. Management ports don't need to be open at all times. They only need to be open while you're connected to the VM, for example, to perform management or maintenance tasks. When just-in-time is enabled, Microsoft Defender for Cloud uses network security group (NSG) and Azure Firewall rules, which restrict access to management ports so they cannot be targeted by attackers.

Microsoft Defender for Cloud leverages the Microsoft intelligent security graph to discover and act against attacks. The graph combines the cyber intelligence Microsoft collects across all of its services along with industry data to block known attack patterns. Microsoft also gives you the control you need to prioritize alerts and incidents that are important to your organization. Additionally, we give you a unified view for forensics analysis and the ability to search across all your computer resources. Threat intelligence can be visualized down to the trending attack techniques and the geographic regions affected.

### Indications of an attack

 -  Extreme counts of failed sign-ins from many unknown usernames
 -  Never previously successfully authenticated from multiple remote desktop protocol (RDP) connections or from new source IP addresses

### Stop brute-force attacks

To counteract brute-force attacks, you can take multiple measures such as:

 -  Disable the public IP address and use one of these connection methods:
    
    
     -  Use a point-to-site virtual private network (VPN)
     -  Create a site-to-site VPN
     -  Use Azure ExpressRoute to create secure links from your on-premises network to Azure.

 -  Require two-factor authentication
 -  Increase password length and complexity
 -  Limit login attempts
 -  Implement Captcha
     -  **About CAPTCHAs** \- Any time you let people register on your site or even enter a name and URL (like for a blog comment), you might get a flood of fake names. These are often left by automated programs (bots) that try to leave URLs on every website they can find. (A common motivation is to post the URLs of products for sale.) You can help make sure that a user is a real person and not a computer program by using a *CAPTCHA* to validate users when they register or otherwise enter their name and site.
     -  CAPTCHA stands for **Completely Automated Public Turing test to tell Computers and Humans Apart**. A CAPTCHA is a ***challenge-response*** test in which the user is asked to do something that is easy for a person to do but hard for an automated program to do. The most common type of CAPTCHA is one where you see distorted letters and are asked to type them. (**The distortion is supposed to make it hard for bots to decipher the letters.**)
 -  Limit the amount of time that the ports are open.
