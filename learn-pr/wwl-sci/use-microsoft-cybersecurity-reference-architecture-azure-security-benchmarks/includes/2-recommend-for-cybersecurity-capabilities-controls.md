Some best practices focus on technical capabilities and controls. While
security technology doesn't improve security on its own or replace the
need for security experts, technology is critically important to
automate processes and empower people to do more.

Capabilities and control best practices can be found throughout the MCRA
and ASB. Some are embedded into MCRA architecture diagrams, some are in
other MCRA sections, and others are explicitly called out in the ASBs.
Additionally, various other best practice sources are referenced in the
MCRA, such as the Azure Security Top 10 best practices (published at
<https://aka.ms/azuresecuritytop10>)

Key best practices in the MCRA include:

-   **Learn what you have available** - Learn about and utilize all the
    security capabilities and controls you have access to.

-   **Use the right tool for the job** - Use a multi-technology approach
    to apply the best solution to the problem, rather than relying on
    the same technology over and over like a network firewall or
    Security Information and Event Management (SIEM).

    -   **Data and Management Plane Security** - Ensure that you include
        both data plane security controls (available since pre-cloud
        on-premises datacenters) as well as management plane security
        controls (embedded into cloud platforms that allow additional
        layer of visibility and control).

    -   **Security for the platform/infrastructure and the workload** --
        Ensure you have controls to protect the specific workload (such
        as web application firewalls (WAFs)) as well as the overall
        infrastructure and development environments.

    -   **Use native cloud controls** that are designed to secure your
        cloud assets.

    -   **Use consistent tooling** across cloud providers to ensure
        controls are effectively implemented across all your
        infrastructure and platforms. This reduces the time and effort
        to implement and monitor controls, allowing you to accomplish
        more in security with the resources you have.

-   **Approach security holistically**-- Securing an asset requires
    establishing visibility and control over the full lifecycle.\
    For the example of a cloud hosted resource, this would include

    -   people accessing it

    -   accounts and groups they use to access it

    -   devices they log into those accounts with

    -   interface that provides access to the resource (Azure portal,
        Command Line Interface, application programming interfaces,
        etc.)

    -   the resource itself

    -   any underlying storage, virtual machines, containers, or other
        cloud/application services that interact with the resource

    -   any devices and customer accounts that interact with the
        resources

-   **Focus on Security and Productivity** -- Ensure that security
    enables productivity as well as reducing risk. Security should
    provide 'healthy friction' that causes people to think critically
    about risk while designing or operating a system, but shouldn't
    create 'unhealthy friction' that blocks productivity and/or doesn't
    reduce risk in a meaningful way.

-   **Protecting privileged access** -- Ensure that privileged accounts
    and systems are protected with elevated security protections,
    monitoring, and response. Compromises of privileged access enable an
    attacker to shut down business operations across the organization in
    a ransomware/extortion attack. Attackers frequently target highly
    privileged accounts because doing this allows rapid and efficient
    compromise of many systems at once and increase the attacker's
    return on their illicit investment.\
    Elevated protections organizations should implement include:

    -   **Protect Privileged User Accounts** -- with strong MFA, threat
        detection, and tagging accounts to ensure rapid response to
        anomalous events.

    -   **Protect Workstations and Devices** used by these accounts with
        Privileged Access Workstations (PAWs) and additional monitoring
        and response.

    -   **Protecting Intermediaries** that handle privileged accounts
        and sessions such as Virtual Private Networks (VPNs), PIM/PAM
        solutions, Domain Controllers, and more with elevated
        protections, security policy monitoring, threat detection, and
        more.

        More details on securing privileged access can be found at
        <https://aka.ms/SPA>

-   **Prepare for ransomware and extortion attacks** -- Ensure that you
    are mitigating the risk of ransomware attacks starting with the most
    impactful controls

    -   **Validating BC/DR process** -- Ensure your business continuity
        / disaster recovery (BC/DR) process includes all
        business-critical systems in scope, includes a scenario for a
        ransomware/extortion attack, and has exercised this scenario
        recently. Without this, your ability to recover from this type
        of attack may be much slower and may not recover all
        business-critical systems.

    -   **Securing backups against sabotage** -- Ensure that backups are
        protected against deliberate attacker erasure or encryption,
        which is a common attacker tactic. Without this you may find
        that critical business operations cannot be recovered without
        paying for the ransom/extortion payment (which is much slower,
        has no guarantee of success, and incurs potential liability and
        other risks).

    -   **Protecting privileged access** as described above.

The ASB security controls contain many best practices for cybersecurity
capabilities and controls, including both technical and non-technical
capabilities and controls like processes. Table 10-1 below lists several
relevant security controls:

Table 10-1 ASB Best practices for cybersecurity capabilities and
controls

+---------------+------------------------------------------------------+
| ASB Control   | Security Controls                                    |
| Domain        |                                                      |
+===============+======================================================+
| Data          | DP-1: Discover, classify, and label sensitive data   |
| Protection    |                                                      |
| (DP)          | DP-2: Monitor anomalies and threats targeting        |
|               | sensitive data                                       |
|               |                                                      |
|               | DP-3: Encrypt sensitive data in transit              |
|               |                                                      |
|               | DP-4: Enable data at rest encryption by default      |
|               |                                                      |
|               | DP-5: Use customer-managed key option in data at     |
|               | rest encryption when required                        |
|               |                                                      |
|               | DP-6: Use a secure key management process            |
|               |                                                      |
|               | DP-7: Use a secure certificate management process    |
|               |                                                      |
|               | DP-8: Ensure security of key and certificate         |
|               | repository                                           |
+---------------+------------------------------------------------------+
| Asset         | AM-1: Track asset inventory and their risks          |
| Management    |                                                      |
| (AM)          | AM-2: Use only approved services                     |
|               |                                                      |
|               | AM-3: Ensure security of asset lifecycle management  |
|               |                                                      |
|               | AM-4: Limit access to asset management               |
|               |                                                      |
|               | AM-5: Use only approved applications in virtual      |
|               | machine                                              |
+---------------+------------------------------------------------------+
| Posture and   | PV-1: Define and establish secure configurations     |
| Vulnerability |                                                      |
| Management    | PV-2: Audit and enforce secure configurations        |
| (PV)          |                                                      |
|               | PV-3: Define and establish secure configurations for |
|               | compute resources                                    |
|               |                                                      |
|               | PV-4: Audit and enforce secure configurations for    |
|               | compute resources                                    |
|               |                                                      |
|               | PV-5: Perform vulnerability assessments              |
|               |                                                      |
|               | PV-6: Rapidly and automatically remediate            |
|               | vulnerabilities                                      |
|               |                                                      |
|               | PV-7: Conduct regular red team operations            |
+---------------+------------------------------------------------------+
| Endpoint      | ES-1: Use Endpoint Detection and Response (EDR)      |
| Security (ES) |                                                      |
|               | ES-2: Use modern anti-malware software               |
|               |                                                      |
|               | ES-3: Ensure anti-malware software and signatures    |
|               | are updated                                          |
+---------------+------------------------------------------------------+
| Backup and    | BR-1: Ensure regular automated backups               |
| Recovery (BR) |                                                      |
|               | BR-2: Protect backup and recovery data               |
|               |                                                      |
|               | BR-3: Monitor backups                                |
|               |                                                      |
|               | BR-4: Regularly test backup                          |
+---------------+------------------------------------------------------+
| DevOps        | DS-1: Conduct threat modeling                        |
| Security (DS) |                                                      |
|               | DS-2: Ensure software supply chain security          |
|               |                                                      |
|               | DS-3: Secure DevOps infrastructure                   |
|               |                                                      |
|               | DS-4: Integrate static application security testing  |
|               | into DevOps pipeline                                 |
|               |                                                      |
|               | DS-5: Integrate dynamic application security testing |
|               | into DevOps pipeline                                 |
|               |                                                      |
|               | DS-6: Enforce security of workload throughout DevOps |
|               | lifecycle                                            |
|               |                                                      |
|               | DS-7: Enable logging and monitoring in DevOps        |
+---------------+------------------------------------------------------+
| Governance    | GS-1: Align organization roles, responsibilities and |
| and Strategy  | accountabilities                                     |
| (GS)          |                                                      |
|               | GS-2: Define and implement enterprise                |
|               | segmentation/separation of duties strategy           |
|               |                                                      |
|               | GS-3: Define and implement data protection strategy  |
|               |                                                      |
|               | GS-4: Define and implement network security strategy |
|               |                                                      |
|               | GS-5: Define and implement security posture          |
|               | management strategy                                  |
|               |                                                      |
|               | GS-6: Define and implement identity and privileged   |
|               | access strategy                                      |
|               |                                                      |
|               | GS-7: Define and implement logging, threat detection |
|               | and incident response strategy                       |
|               |                                                      |
|               | GS-8: Define and implement backup and recovery       |
|               | strategy                                             |
|               |                                                      |
|               | GS-9: Define and implement endpoint security         |
|               | strategy                                             |
|               |                                                      |
|               | GS-10: Define and implement DevOps security strategy |
+---------------+------------------------------------------------------+

For more information on the security controls in each of these areas,
see <https://aka.ms/benchmarkdocs>

These best practices in MCRA and ASB can help you improve your security
capabilities and controls.