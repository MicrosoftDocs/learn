Reduce or eliminate each potential threat by using security controls that are mapped to STRIDE threats:

| Threat | Security Control |
| ------ | ---------------- |
|Spoofing|Authentication|
|Tampering|Integrity|
|Repudiation|Non-Repudiation|
|Information Disclosure|Confidentiality|
|Denial of Service|Availability|
|Elevation of Privilege|Authorization|

Some security controls can help reduce or completely eliminate multiple threats. Using SSL/TLS creates secure transmission channels to help prevent malicious data modification or disclosure. These types of controls are a good way to help secure your system and create multiple layers of security, also known as defense-in-depth.

Bug management services, such as Azure DevOps, keeps track of each threat and security control using default templates and resolution categories. These templates foster collaboration between teams, prevent issues from slipping through the cracks, and provide issue history. Here are a few examples of resolutions used with threat modeling:

| Resolution | Description |
| ---------- | ------------------------------------------------------------ |
| Reduce | Issue will be addressed with bug fixes, redesign, or risk reduction strategies to reduces or eliminate threat impact or severity |
| Transfer | Issue will be handled by another system |
| Avoid | The part of the system containing the issue will be cut |
| Accept | Risk will be accepted without a resolution. It will require the approval of an authorized risk decision maker, which may be based on threat severity. Critical severity threats may require approval from senior leadership, while a defense-in-depth risk may be approved by a senior engineer. Speak with your team for strategic guidance |
 
Apply the established risk management methods used by your organization to help prioritize the threats identified with threat modeling. Microsoft typically prioritizes issues by:

- Security impact - STRIDE categories
- Security severity - Critical, Important, Moderate, Low, Defense-in-Depth (worst case scenarios assumed)
- Risk reduction or elimination - measured by implementation cost.

Some security controls can be more expensive than the cost of a successful security breach. Speak with your colleagues or security team to come up with design changes if you are in this situation.

Breaches create countless fire drills and absorb most engineering bandwidth. In addition to fixing the issue in short timeframe, the organization also needs to handle reputation risk, potential legal liability, and additional costs that are hard to quantify.