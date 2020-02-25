## Decide How to Prioritize, Track, and Fix Each Issue

Reduce or eliminate each potential threat by using security controls mapped to STRIDE threats:

| Threat | Security Control | What to Verify |
| ------ | ---------------- | ----------- |
|Spoofing|Authentication|Have I authenticated both sides of the communication?|
|Tampering|Integrity|How do I know someone can't change my data in transit or at rest?|
|Repudiation|Non-Repudiation|Can I tie every action to an identity?|
|Information Disclosure|Confidentiality|Can I be sure no one can see my data in transit and at rest?|
|Denial of Service|Availability|Are there areas where my service is resource limited?|
|Elevation of Privilege|Authorization|How do I know the user is allowed to do this action?|

Some security controls can help reduce or completely eliminate multiple threats. Using SSL/TLS creates secure transmission channels to help prevent malicious data modification or disclosure. These types of controls are a good way to help secure your system and create multiple layers of security, also known as **defense-in-depth**.

### Issue Tracking

Bug management services, such as Azure DevOps, keeps track of each threat and security control using default templates and resolution categories. These templates foster collaboration between teams, prevent issues from slipping through the cracks, and provide issue history.

### Issue Prioritization

Apply the established risk management methods used by your organization to help prioritize the threats identified with threat modeling. Microsoft typically prioritizes security issues by:

- **Impact** - STRIDE categories
- **Severity** - Critical, Important, Moderate, Low, Defense-in-Depth (worst case scenarios assumed)
- **Risk** - Risk reduction or elimination is measured by implementation cost

### Issue Resolution

If your organization does not have a default set of resolution options, you can use the ones commonly used with threat modeling:

- **Reduce** - Issue will be addressed with bug fixes, redesign, or risk reduction strategies to reduces or eliminate threat impact or severity
- **Transfer** - Issue will be handled by another system
- **Avoid** - The part of the system containing the issue will be cut
- **Accept** - Risk will be accepted without a resolution. It will require the approval of an authorized risk decision maker, which may be based on threat severity. Critical severity threats may require approval from senior leadership, while a defense-in-depth risk may be approved by a senior engineer. Speak with your team for strategic guidance

> [!NOTE]
> Some security controls can be more expensive than the cost of a successful security breach. Speak with your colleagues or security team to come up with design changes if you are in a similar situation.

> [!IMPORTANT]
> Breaches create countless fire drills and absorb a lot of engineering bandwidth. On top of fixing the issue in a relatively short time-frame, the organization has to deal with reputation risk, potential legal liability, and other costs, which are hard to quantify.