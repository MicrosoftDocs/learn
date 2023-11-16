Organizations can use Azure Firewall Premium features like IDPS and TLS inspection to prevent malware and viruses from spreading across networks in both lateral and horizontal directions. To meet the increased performance demands of IDPS and TLS inspection, Azure Firewall Premium uses a more powerful virtual machine SKU. Like the Standard SKU, the Premium SKU can seamlessly scale up to 30 Gbps and integrate with availability zones to support the service level agreement (SLA) of 99.99 percent. The Premium SKU complies with Payment Card Industry Data Security Standard (PCI DSS) environment needs.

To help you decide if Azure Firewall Premium is right for your organization, consider the following scenarios:

## You want to inspect outbound TLS encrypted network traffic

Azure Firewall Premium TLS Inspection can decrypt outbound traffic, process the data, then encrypt the data and send it to the destination.

Azure Firewall Premium terminates outbound and east-west TLS connections. Inbound TLS inspection is supported with [Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview) allowing end-to-end encryption. Azure Firewall does the required value-added security functions and re-encrypts the traffic that is sent to the original destination.

## You want to protect your network using signature-based malicious traffic detection

A network intrusion detection and prevention system (IDPS) allows you to monitor your network for malicious activity. It also allows you to log information about this activity, report it, and optionally attempt to block it.

Azure Firewall Premium provides signature-based IDPS to allow rapid detection of attacks by looking for specific patterns, such as byte sequences in network traffic, or known malicious instruction sequences used by malware. The IDPS signatures are applicable for both application and network level traffic (Layers 4-7). They're fully managed and continuously updated. You can apply IDPS to inbound, spoke-to-spoke (East-West), and outbound traffic.

The Azure Firewall signatures/rulesets include:

- An emphasis on fingerprinting actual malware, Command and Control, exploit kits, and in the wild malicious activity missed by traditional prevention methods.
- Over 55,000 rules in over 50 categories.
- The categories include malware command and control, DoS attacks, botnets, informational events, exploits, vulnerabilities, SCADA network protocols, exploit kit activity, and more.
- 20 to 40+ new rules are released each day.
- Low false positive rating by using state-of-the-art malware sandbox and global sensor network feedback loop.

IDPS allows you to detect attacks in all ports and protocols for nonencrypted traffic. However, when HTTPS traffic needs to be inspected, Azure Firewall can use its TLS inspection capability to decrypt the traffic and better detect malicious activities.

The IDPS Bypass List allows you to not filter traffic to any of the IP addresses, ranges, and subnets specified in the bypass list.

You can also use signature rules when the IDPS mode is set to Alert. But, there are one or more specific signatures that you want to block, including their associated traffic. In this case, you can add new signature rules by setting the TLS Inspection mode to deny.

## You want to extend Azure Firewall’s FQDN filtering capability to consider an entire URL

Azure Firewall Premium can filter on an entire URL. For example, `www.contoso.com/a/c` instead of `www.contoso.com`.

URL Filtering can be applied both on HTTP and HTTPS traffic. When HTTPS traffic is inspected, Azure Firewall Premium can use its TLS inspection capability to decrypt the traffic and extract the target URL to validate whether access is permitted. TLS inspection requires opt-in at the application rule level. Once enabled, you can use URLs for filtering with HTTPS.

## You want to allow or deny access based on categories

The Web categories feature lets administrators allow or deny user access to web site categories such as gambling websites, social media websites, and others. Web categories are also included in Azure Firewall Standard, but it's more fine-tuned in Azure Firewall Premium. As opposed to the Web categories capability in the Standard SKU that matches the category based on an FQDN, the Premium SKU matches the category according to the entire URL for both HTTP and HTTPS traffic.

For example, if Azure Firewall intercepts an HTTPS request for www.google.com/news, the following categorization is expected:

- Firewall Standard – only the FQDN part is examined, so www.google.com is categorized as Search Engine.
- Firewall Premium – the complete URL is examined, so www.google.com/news is categorized as News.

The categories are organized based on severity under Liability, High-Bandwidth, Business Use, Productivity Loss, General Surfing, and Uncategorized.

