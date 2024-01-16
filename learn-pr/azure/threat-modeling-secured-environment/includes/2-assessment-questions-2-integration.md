## Integration

![Integration category.](../media/supporting-icons/integration.png)

### Why ask these questions

These questions allow you to:

- Check if the application went through a Security Development Lifecycle (SDL) process.
- Learn if there are open Common Vulnerabilities and Exposure (CVE) or other known critical issues.
- Learn all of the encryption algorithms used to protect data at-rest, in-transit, and in-use.
- Understand if the system process persists data, logs, or secrets beyond the expected scope to gain elevated privileges.
- Learn about sensitive data stored by the application.
- Investigate if the application requires services from trusted cloud providers to authenticate users or provide backups.
- Learn of application network usage requirements, like ports and protocols.
- Enumerate which application security controls to enable by default, and which ones to enable from the environment.

|Question|Areas to cover|
|--------|--------------|
|**Has the application gone through an SDL process?**|<ul><li>Previous security reviews and open issues</li><li>Security tools and scanners used</li><li>Development process used to build the application</li></ul>|
|**Does the application have open CVE, critical security issues, or security breaches in the past?**|<ul><li>Public vulnerabilities found in the wild by users and attackers</li><li>Open issues affecting the proposed version</li></ul>|
|**How is encryption used in the application?**|<ul><li>Use of strong encryption</li><li>Data encryption at-rest, in-transit, and in-use</li><li>Use of weak or broken encryption</li></ul>|
|**What type of data will be stored in the SAW host?**|<ul><li>List of data types and files stored permanently or temporarily</li><li>Storage location</li><li>File or database format</li></ul>|
|**How does the application handle sensitive data?**|<ul><li>Data encryption and storage process</li><li>Use of cache or cloud services</li><li>Data access</li><li>Privacy implications</li></ul>|
|**Are cloud providers or services required by the application?**|<ul><li>Cloud provider used</li></ul>|
|**What does the application need to do on the network?**|<ul><li>Open ports needed</li><li>Network protocols used</li><li>Inbound and outbound traffic flow</li></ul>|
|**Are there specific configuration settings we need to enable by default?**|<ul><li>Security features available to be enabled by default</li><li>Other security controls to be enabled for the application</li></ul>|