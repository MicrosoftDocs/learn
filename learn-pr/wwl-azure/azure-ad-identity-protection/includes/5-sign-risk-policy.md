Sign-in risk represents the probability that a given authentication request isn't authorized by the identity owner. For users of Azure Identity Protection, sign-in risk can be evaluated as part of a Conditional Access policy. Sign-in Risk Policy supports the following conditions:

## Location

When configuring location as a condition, organizations can choose to include or exclude locations. These named locations may include the public IPv4 network information, country or region, or even unknown areas that don't map to specific countries or regions. Only IP ranges can be marked as a trusted location. When including **any location**, this option includes any IP address on the internet not just configured named locations. When selecting **any location**, administrators can choose to exclude **all trusted** or **selected locations**.

## Client apps

Conditional Access policies by default apply to browser-based applications and applications that utilize modern authentication protocols. In addition to these applications, administrators can choose to include Exchange ActiveSync clients and other clients that utilize legacy protocols.

 -  **Browser** \- These include web-based applications that use protocols like SAML, WS-Federation, OpenID Connect, or services registered as an OAuth confidential client.
 -  **Mobile apps and desktop clients** \- These access policies are commonly used when requiring a managed device, blocking legacy authentication, and blocking web applications but allowing mobile or desktop app.

## Risky sign-ins

The risky sign-ins report contains filterable data for up to the past 30 days (1 month).

With the information provided by the risky sign-ins report, administrators can find:

 -  Which sign-ins are classified as at risk, confirmed compromised, confirmed safe, dismissed, or remediated.
 -  Real-time and aggregate risk levels associated with sign-in attempts.
 -  Detection types triggered
 -  Conditional Access policies applied
 -  MFA details
 -  Device information
 -  Application information
 -  Location information

Administrators can then choose to take action on these events. Administrators can choose to:

 -  Confirm sign-in compromise
 -  Confirm sign-in safe
