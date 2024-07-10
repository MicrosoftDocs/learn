## Brute force attacks

A brute force attack is a type of hacking technique in which an attacker tries to gain access to a network or system by guessing the username and password combination through an automated process. The attacker typically uses a program that generates a large number of login attempts in a short period of time to try every possible combination of characters until the correct one is discovered. This type of attack can be very effective against weak passwords and security systems with no protection against brute force attacks, but it is time-consuming and can be detected by security measures such as account lockouts after a certain number of failed login attempts.

## Management services, ports, and protocols

Adversaries without prior knowledge of legitimate credentials within the system or environment may guess passwords to attempt access to accounts. Without knowledge of the password for an account, an adversary may opt to systematically guess the password using a repetitive or iterative mechanism. An adversary may guess login credentials without prior knowledge of system or environment passwords during an operation by using a list of common passwords. Password guessing may or may not take into account the target's policies on password complexity or use policies that may lock accounts out after a number of failed attempts.

Typically, management services over commonly used ports are used when guessing passwords. Commonly targeted services include the following:

| **Management Service**                                                       | **Port and Protocol**                                                                  |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| SSH (Secure Shell)                                                           | 22 / TCP (Transmission Control Protocol)                                               |
| Telnet (Teletype Network)                                                    | 23 / TCP (Transmission Control Protocol)                                               |
| FTP (File Transfer Protocol)                                                 | 21 / TCP (Transmission Control Protocol)                                               |
| NetBIOS (Network Basic Input/Output System)/SMB (Server Message Block)/Samba | 139 and 445 / TCP (Transmission Control Protocol)                                      |
| LDAP (Lightweight Directory Access Protocol)                                 | 389 / TCP (Transmission Control Protocol)                                              |
| Kerberos                                                                     | 88 / TCP (Transmission Control Protocol)                                               |
| RDP (Remote Desktop Protocol)                                                | 3389 / TCP (Transmission Control Protocol)                                             |
| HTTP/HTTP (Hypertext Transfer Protocol) Management Services                  | 80 and 443 / TCP (Transmission Control Protocol)                                       |
| MSSQL (Microsoft Structured Query Language)                                  | 1433 / TCP (Transmission Control Protocol)                                             |
| Oracle                                                                       | 1521 / TCP (Transmission Control Protocol)                                             |
| My SQL (My Structured Query Language)                                        | 3306 / TCP (Transmission Control Protocol)                                             |
| VNC (Virtual Network Computing)                                              | 5900 / TCP (Transmission Control Protocol)                                             |
| SNMP (Simple Network Management Protocol)                                    | 161 and 162 / UDP (User Datagram Protocol) / 162 / TCP (Transmission Control Protocol) |

## Brute force attack programs and use cases

These programs can be used individually or in combination to launch a successful brute force attack on a target network or system. There are several types of brute force attack programs used by attackers, including:

| Types of Brute Force Attack Programs | Use Case                                            |
| ------------------------------------ | --------------------------------------------------- |
| Password crackers                    | used for guessing passwords and encryption keys.    |
| Port scanners                        | used to identify open ports on a network or system. |
| Network mappers                      | used to map the topology of a network.              |
| Web application servers              | used to test web applications for vulnerabilities.  |
| SSH brute force tools                | used to guess SSH login credentials.                |
| Remote desktop brute force tools     | used to guess RDP login credentials.                |
| FTP brute force tools                | used to guess FTP login credentials.                |
| SNMP brute force tools               | used to guess SNMP community strings.               |

## Indications of an attack<br>

 -  Extreme counts of failed sign-ins from many unknown usernames
 -  Never previously successfully authenticated from multiple remote desktop protocol (RDP) connections or from new source IP addresses

**Example:** Potential SQL Brute Force attempt alert

:::image type="content" source="../media/example-of-a-potential-sql-brute-force-attempt-alert-7a3d05aa.png" alt-text="Screenshot showing a potential sql brute force attempt alert example.":::


## Practices to blunt a Brute Force Attacks

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
