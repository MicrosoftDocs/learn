A Zero Trust approach to security is required to be effective at keeping
up with threats, changes to cloud platforms, and changes in business
models responding to a rapidly evolving world. You can find best
practices for adopting a Zero Trust approach to security throughout the
MCRA and ASB. Nearly all modern security controls support a Zero Trust
strategy, so this section will focus primarily on best practices related
to the first and most visible priority for Zero Trust -- modernizing
access control. See the Access Control discipline in the Cloud Adoption
Framework Secure Methodology (CAF Secure) for more -
<https://aka.ms/CAFSecure-AccessControl>

Microsoft Zero Trust approach to security is based on three principles
of Assume Breach (Assume Compromise), Verify Explicitly, and Least
Privilege. These principles apply across the whole technical estate and
are usually applied to a Zero Trust transformation through a series of
modernization initiatives.

Figure 10-4 depicts how these Zero Trust principles apply across these
initiatives![](media/image4.png){width="6.077083333333333in"
height="2.9006944444444445in"}

**Figure 10-4**  Zero Trust Principles and Initiatives

F10XX04: A diagram depicting the three Zero Trust principles and the
five security modernization initiatives.

The initiatives include:

-   **Secure Identities and Access** -- This initiative focuses on
    modernizing access control, ensuring that users can access the
    resources they need securely from anywhere. This focuses heavily on
    explicit validation of trust signals on users and devices, rather
    than on traditional reliance on network location for trust. This
    also applies the general mindset of assuming breach/compromise, and
    implementing least privilege to limit who has access to resources
    (limiting permissions, just in time permissions, and more).

-   **Modern Security Operations** -- This initiative focuses on
    reducing organizational risk by reducing attacker dwell time, which
    is how much time attackers have access resources before they are
    detected and removed. This is heavily focused on the assume
    breach/compromise principle to build modern detection for attackers
    that try to stay hidden and ensure the organization can quickly kick
    them out.

-   **Infrastructure and Development Security** -- This initiative
    focuses on integrating security into new and existing
    infrastructure, platforms, and applications. The main focus is to
    integrate security into existing initiatives like migrating existing
    workloads to cloud, development of new workloads using
    DevOps/DevSecOps and other processes, or a security modernization
    initiative. All three Zero Trust principles are applicable across
    many aspects of these processes and environments.

-   **Operational Technology (OT) and Internet of Things (IoT)
    security** -- This initiative focuses on modernizing security of OT
    and IoT devices and adapting Zero Trust principles within the
    constraints of the older technologies that are hard to maintain,
    limited processing power and connectivity, stringent regulations and
    safety concerns, and operational uptime requirements.

-   **Data Security and Governance, Risk, Compliance (GRC)** -- These
    focus on key aspects of security that have technical components but
    are primarily about business processes and outcomes.

-   **Data Security** -- This focuses on enabling the organizations to
    discover, classify, protect, and monitor business critical data
    wherever it is and goes.

-   **Governance, Risk, and Compliance** -- This focuses on the
    modernization of these functions that ensure the organization is
    consistently meeting the various security and compliance
    requirements. These functions embed the principles of Zero Trust in
    processes, practices, and policies.

The MCRA includes many best practices related to the access control
modernization initiative

-   **Prioritize privileged access** -- Ensure you are following
    security best practices to protect privileged resources with
    elevated protections (described more in Skill 10.1)

-   **Apply Zero Trust principles to modernizing access control** --
    Ensure that you are assuming breach/compromise, explicitly
    validating telemetry and signals during access requests and
    authorized sessions, and applying least privilege principle to how
    much access accounts get (and for how long). This can be done with
    Azure Active Directory (Azure AD) Conditional Access and should
    include:

    -   **Explicitly validate multi-factor authentication (MFA)** -- to
        ensure that user account authentication combines multiple types
        of validation that the user is who they claim to be.

    -   **Explicitly validate user trust signals** -- to measure risk on
        the user and their session including behavior patterns, timing,
        location, and other indicators. This can be implemented with
        Azure AD Identity Protection and Azure AD Conditional Access.

    -   **Explicitly validate device trust signals** -- that measure
        whether the user's device is configured properly, patched, and
        whether the device is known to be compromised by an attacker.
        This can be implemented with Azure AD Conditional Access,
        Microsoft Intune, and Microsoft Defender for Endpoint.

    -   **Continually improve signal coverage and fidelity** to keep up
        with attackers as they find new ways to evade existing controls.

    -   **Consistent application across the technical estate** -- Ensure
        that authentication policies are consistently enforced across
        all access requests including direct to cloud applications,
        remote network access through VPNs, remote access of legacy and
        on- premises applications through application proxies, and local
        wireless and wired network access. This allows people to work
        securely from anywhere.

-   **Integrated security operations signals with access decisions.**
    Access decisions should integrate current information on compromised
    devices, users, and other assets. Access should be blocked to and
    from compromised assets while they are being cleaned up by security
    operations, and then access restored after the asset integrity has
    been restored.

-   **Simplify Identity and Access management architecture.** Complexity
    is the enemy of security as it causes human errors in manual tasks
    and in designing/implementing automation. These errors open up gaps
    and inconsistencies that attackers can exploit. While identity and
    access technology across a complex technical estate will always be
    complicated, the user experience of users and IT and security roles
    (architects, engineers, administrators, developers, and operations)
    should be simplified as much as possible to reduce human error. For
    example, using a single identity and implementing single sign on
    will simplify the user experience and reduce friction and complexity
    in security operations workflows, administrator workflows, and more.
    Using a single directory (or fewer directories) will simplify
    architecture, operations, security operations, and more.

-   **Go beyond VPN** to modernize access to existing legacy and
    on-premises applications. This enables people to work from home
    without slowdowns and extra steps that VPN introduces and increase
    security assurances. This is an implicit message in the adoption of
    secure access service edge (SASE) architectures that focuses heavily
    on identity-enabled network access technologies.

Many Zero Trust best practices can be found throughout the ASB security
controls including those listed in Table 10-3 that focus on modernizing
access control:

Table 10-3 ASB Best practices for access control

+------------------+---------------------------------------------------+
| ASB Control      | Security Controls                                 |
| Domain           |                                                   |
+==================+===================================================+
| Identity         | IM-1: Use centralized identity and authentication |
| Management (IM)  | system                                            |
|                  |                                                   |
|                  | IM-2: Protect identity and authentication systems |
|                  |                                                   |
|                  | IM-3: Manage application identities securely and  |
|                  | automatically                                     |
|                  |                                                   |
|                  | IM-4: Authenticate server and services            |
|                  |                                                   |
|                  | IM-5: Use single sign-on (SSO) for application    |
|                  | access                                            |
|                  |                                                   |
|                  | IM-6: Use strong authentication controls          |
|                  |                                                   |
|                  | IM-7: Restrict resource access based on           |
|                  | conditions                                        |
|                  |                                                   |
|                  | IM-8: Restrict the exposure of credential and     |
|                  | secrets                                           |
|                  |                                                   |
|                  | IM-9: Secure user access to existing applications |
+------------------+---------------------------------------------------+
| Privileged       | PA-1: Separate and limit highly                   |
| Access (PA)      | privileged/administrative users                   |
|                  |                                                   |
|                  | PA-2: Avoid standing access for user accounts and |
|                  | permissions                                       |
|                  |                                                   |
|                  | PA-3: Manage lifecycle of identities and          |
|                  | entitlements                                      |
|                  |                                                   |
|                  | PA-4: Review and reconcile user access regularly  |
|                  |                                                   |
|                  | PA-5: Set up emergency access                     |
|                  |                                                   |
|                  | PA-6: Use privileged access workstations          |
|                  |                                                   |
|                  | PA-7: Follow just enough administration (least    |
|                  | privilege) principle                              |
|                  |                                                   |
|                  | PA-8 Determine access process for cloud provider  |
|                  | support                                           |
+------------------+---------------------------------------------------+
| Network security | NS-1: Establish network segmentation boundaries   |
| (NS)             |                                                   |
|                  | NS-2: Secure cloud services with network controls |
|                  |                                                   |
|                  | NS-3: Deploy firewall at the edge of enterprise   |
|                  | network                                           |
|                  |                                                   |
|                  | NS-4: Deploy intrusion detection/intrusion        |
|                  | prevention systems (IDS/IPS)                      |
|                  |                                                   |
|                  | NS-5: Deploy DDOS protection                      |
|                  |                                                   |
|                  | NS-6: Deploy web application firewall             |
|                  |                                                   |
|                  | NS-7: Simplify network security configuration     |
|                  |                                                   |
|                  | NS-8: Detect and disable insecure services and    |
|                  | protocols                                         |
|                  |                                                   |
|                  | NS-9: Connect on-premises or cloud network        |
|                  | privately                                         |
|                  |                                                   |
|                  | NS-10: Ensure Domain Name System (DNS) security   |
+------------------+---------------------------------------------------+

For more information on the security controls in each of these areas,
see <https://aka.ms/benchmarkdocs>

These best practices in MCRA and ASB can help you with your Zero Trust
security transformation.