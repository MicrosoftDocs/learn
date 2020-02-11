At this phase, you will attempt to reduce or eliminate each potential threat by leveraging security controls that map to STRIDE threats:

| Threat | Security Control |
| ------ | ---------------- |
|Spoofing|Authentication|
|Tampering|Integrity|
|Repudiation|Non-Repudiation|
|Information Disclosure|Confidentiality|
|Denial of Service|Availability|
|Elevation of Privilege|Authorization|

You will often find a security control that reduces or completely eliminates multiple threats. One example is the enforcement of SSL/TLS, which helps prevent spoofing, tampering and information disclosure threats by providing authentication, integrity and confidentiality. They’re usually an inexpensive way to help secure your system.

Bug management services, such as Azure DevOps, allow you to keep track of each threat and associated security control using default templates and resolution categories, which fosters collaboration between teams, prevents issues from slipping through the cracks and also provides issue history. Here are a few examples of resolutions used with threat modeling:

| Resolution | Description |
| ---------- | ------------------------------------------------------------ |
| Reduce | Issue will be addressed with activities like engineering bug fixes, re-design, or a risk reduction strategy that significantly reduces the impact and/or severity of a threat |
| Transfer | Issue will be handled by another system |
| Avoid | The part of the system containing the issue will be cut |
| Accept | Risk will be accepted without a resolution and with the approval of someone authorized to make risk decisions, usually based on threat severity. For example, a critical severity threat may require approval from senior leadership, while a defense-in-depth risk may be approved by a senior engineer. Speak with your team for strategic guidance |
 
To prioritize potential threats identified in threat modeling, apply the established methods used in your organization. Microsoft typically prioritizes issues according to their security impact (STRIDE categories), security severity (Critical, Important, Moderate, Low, Defense-in-Depth) which assumes worst case scenario, and risk reduction or elimination measured by implementation cost. In some cases, proposed security controls can be more expensive than the cost of successful exploitation. If you are in this situation, speak with your team to identify possible alternatives or design changes. If applicable, speak with your security team to validate proposed solutions and decide on individual risk strategies. Be aware that the cost of exploitation can be manifold and hard to quantify, as this can include things like reputation risk, potential legal liability, and other costs of a high-priority fire drill, including cleanup and STILL having to fix the issue on an accelerated schedule.