The brute force attack is the most common attack, and the easiest to be used against your Azure solutions.

## Attack scenario

Brute force is targeted. The hacker goes after specific users and cycles through as many passwords as possible using either a full dictionary or one that’s edited to common passwords. An even more targeted password-guessing attack is when the hacker selects a person and conducts research to determine if they can guess the user’s password—discovering family names through social media posts, for example. And then trying those variants against an account to gain access.

Brute force attacks commonly target management ports as a means to gain access to a VM. If successful, an attacker can take control over the VM and establish a foothold into your environment. Computers with Windows Remote Desktop Protocol (RDP) exposed to the internet are an attractive target for adversaries because they present a simple and effective way to gain access to a network. Brute forcing RDP, a secure network communications protocol that provides remote access over port 3389, does not require a high level of expertise or the use of exploits; attackers can utilize many off-the-shelf tools to scan the internet for potential victims and leverage similar such tools for conducting the brute force attack.

Attackers target RDP servers that use weak passwords and are without multifactor authentication, virtual private networks (VPNs), and other security protections. Through RDP brute force, threat actor groups can gain access to target machines and conduct many follow-on activities like ransomware and coin mining operations.

In a brute force attack, adversaries attempt to sign in to an account by effectively using one or more trial-and-error methods. Many failed sign-ins occurring over very short time frequencies, typically minutes or even seconds, are usually associated with these attacks. A brute force attack might also involve adversaries attempting to access one or more accounts using valid usernames that were obtained from credential theft or using common usernames like “administrator”. The same holds for password combinations.

:::image type="content" source="../media/az500-brute-force-0082a211.png" alt-text="A hacker uses brute force attack on management ports to gain access.":::


One way to reduce exposure to a brute force attack is to limit the amount of time that a port is open. Management ports don't need to be open at all times. They only need to be open while you're connected to the VM, for example to perform management or maintenance tasks. When just-in-time is enabled, Security Center uses network security group (NSG) and Azure Firewall rules, which restrict access to management ports so they cannot be targeted by attackers.

Microsoft Defender for Cloud leverages the Microsoft intelligent security graph to discover and act against attacks. The graph combines the cyber intelligence Microsoft collects across all of its services along with industry data to block known attack patterns. Microsoft also gives the control you need to prioritize alerts and incidents that are important to your organization. Additionally, we give you a unified view for forensics analysis, and the ability to search across all your computer resources. Threat intelligence can be visualized down to the trending attack techniques and the geographic regions affected.

### Indications of an attack

 -  Extreme counts of failed sign-ins from many unknown usernames
 -  Never previously successfully authenticated from multiple RDP connections or from new source IP addresses

### Practices to blunt a Brute Force Attacks

 -  Disable the public IP address - use a Bastion host
 -  Use Point-to-Site VPN, Site-to-Site VPN, or Azure ExpressRoute
 -  Require two-factor authentication
 -  Use complex passwords
 -  Limit the time that the ports are open
