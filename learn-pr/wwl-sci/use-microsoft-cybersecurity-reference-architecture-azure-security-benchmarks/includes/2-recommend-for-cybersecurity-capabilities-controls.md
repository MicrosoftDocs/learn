
Some best practices focus on technical capabilities and controls. Although technology doesn't improve security on its own or replace the
need for security experts, technology is important to automate processes and allow people to focus on other activities.

Capabilities and control best practices can be found throughout the Microsoft Cybersecurity Reference Architecture (MCRA)
and Microsoft Cloud Security Benchmarks (MCSB). Some are embedded into MCRA architecture diagrams, some are in
other MCRA sections, and others are explicitly called out in the MCSBs. Other best practice sources are referenced in the MCRA, such as the [Azure Security Top 10 best practices](https://aka.ms/azuresecuritytop10)

Key best practices in the MCRA include:

- **Learn what you have available** - Learn about and utilize all the security capabilities and controls that you have access to.

- **Use the right tool for the job** - Use a multi-technology approach to apply the best solution to the problem, rather than relying on
    the same technology over and over like a network firewall or Security Information and Event Management (SIEM).

    - **Data and Management Plane Security** - Ensure that you include both data plane security controls (available since pre-cloud
        on-premises datacenters) as well as management plane security controls (embedded into cloud platforms that allow additional
        layer of visibility and control).

    - **Security for the platform/infrastructure and the workload** - Ensure you have controls to protect the specific workload (such
        as web application firewalls (WAFs)) as well as the overall
        infrastructure and development environments.

    - **Use native cloud controls** that are designed to secure your cloud assets.

    - **Use consistent tooling** across cloud providers to ensure controls are effectively implemented across all your infrastructure and platforms. This reduces the time and effort to implement and monitor controls, allowing you to accomplish more in security with the resources you have.

- **Approach security holistically** - Securing an asset requires establishing visibility and control over the full lifecycle. For the example of a cloud hosted resource, this would include the following:
    - people accessing it
    - accounts and groups they use to access it
    - devices they log into those accounts with
    - interface that provides access to the resource (Azure portal, Command Line Interface, application programming interfaces, etc.)
    - the resource itself
    - any underlying storage, virtual machines, containers, or other cloud/application services that interact with the resource
    - any devices and customer accounts that interact with the resources

-   **Focus on security and productivity** - Ensure that security
    enables productivity as well as reducing risk. Security should
    provide 'healthy friction' that causes people to think critically
    about risk while designing or operating a system. Security shouldn't
    create 'unhealthy friction' that blocks productivity and/or doesn't
    reduce risk in a meaningful way.

-   **Protect privileged access** - Ensure that privileged accounts
    and systems are protected with elevated security protections,
    monitoring, and response. Compromises of privileged access enable an
    attacker to shut down business operations across the organization in
    a ransomware/extortion attack. Attackers frequently target highly
    privileged accounts because that level of access allows rapid and efficient
    compromise of many systems at once, which increases the attacker's
    return on investment. Elevated protections organizations should implement include:

    -   **Protect privileged user accounts** -- with strong MFA, threat
        detection, and tagging accounts to ensure rapid response to
        anomalous events.

    -   **Protect workstations and devices** used by these accounts with
        Privileged Access Workstations (PAWs) and additional monitoring
        and response.

    -   **Protect intermediaries** that handle privileged accounts
        and sessions such as Virtual Private Networks (VPNs), PIM/PAM
        solutions, Domain Controllers, and more with elevated
        protections, security policy monitoring, threat detection, and
        more. For more information, see [securing privileged access](https://aka.ms/SPA).

-   **Prepare for ransomware and extortion attacks** - Ensure that you
    are mitigating the risk of ransomware attacks starting with the most
    impactful controls

    -   **Validate BC/DR process** - Ensure your business continuity and disaster recovery (BC/DR) process includes all
        business-critical systems in scope and a scenario for a ransomware/extortion attack. Also ensure that you have exercised this scenario
        recently. Without this, your ability to recover from this type of attack may be much slower and may not recover all
        business-critical systems.

    -   **Secure backups against sabotage** - Ensure that backups are protected against deliberate attacker erasure or encryption,
        which is a common attacker tactic. If your backups are not secure, you may not be able to recover critical business operations without
        paying for the ransom/extortion payment. Paying a ransom is much slower, has no guarantee of success, and incurs potential liability and
        other risks.

The Microsoft cloud security benchmark (MCSB) security controls contain many best practices for cybersecurity capabilities and controls, including both technical and non-technical capabilities and controls like processes. The table below lists several relevant security controls:


|MCSB Control Domain | Security Controls |
|---|---|
| Data Protection (DP)    | DP-1: Discover, classify, and label sensitive data<br>   <br>DP-2: Monitor anomalies and threats targeting sensitive   data<br>   <br>DP-3: Encrypt sensitive data in transit<br>   <br>DP-4: Enable data at rest encryption by default<br>   <br>DP-5: Use customer-managed key option in data at rest   encryption when required<br>   <br>DP-6: Use a secure key management process<br>   <br>DP-7: Use a secure certificate management process<br>   <br>DP-8: Ensure security of key and certificate repository    |
| Asset Management (AM)    |    <br>AM-1: Track asset inventory and their risks<br>   <br>AM-2: Use only approved services<br>   <br>AM-3: Ensure security of asset lifecycle management<br>   <br>AM-4: Limit access to asset management<br>   <br>AM-5: Use only approved applications in virtual machine    |
| Posture and Vulnerability Management (PV)    |    <br>PV-1: Define and establish secure configurations<br>   <br>PV-2: Audit and enforce secure configurations<br>   <br>PV-3: Define and establish secure configurations for   compute resources<br>   <br>PV-4: Audit and enforce secure configurations for compute   resources<br>   <br>PV-5: Perform vulnerability assessments<br>   <br>PV-6: Rapidly and automatically remediate vulnerabilities<br>   <br>PV-7: Conduct regular red team operations    |
| Endpoint Security (ES)    |    <br>ES-1: Use Endpoint Detection and Response (EDR)<br>   <br>ES-2: Use modern anti-malware software<br>   <br>ES-3: Ensure anti-malware software and signatures are   updated    |
| Backup and Recovery (BR)    |    <br>BR-1: Ensure regular automated backups<br>   <br>BR-2: Protect backup and recovery data<br>   <br>BR-3: Monitor backups<br>   <br>BR-4: Regularly test backup    |
| DevOps Security (DS)    |    <br>DS-1: Conduct threat modeling<br>   <br>DS-2: Ensure software supply chain security<br>   <br>DS-3: Secure DevOps infrastructure<br>   <br>DS-4: Integrate static application security testing into   DevOps pipeline<br>   <br>DS-5: Integrate dynamic application security testing into   DevOps pipeline<br>   <br>DS-6: Enforce security of workload throughout DevOps   lifecycle<br>   <br>DS-7: Enable logging and monitoring in DevOps    |
| Governance and Strategy (GS)    |    <br>GS-1: Align organization roles, responsibilities and   accountabilities<br>   <br>GS-2: Define and implement enterprise   segmentation/separation of duties strategy<br>   <br>GS-3: Define and implement data protection strategy<br>   <br>GS-4: Define and implement network security strategy<br>   <br>GS-5: Define and implement security posture management   strategy<br>   <br>GS-6: Define and implement identity and privileged access   strategy<br>   <br>GS-7: Define and implement logging, threat detection and   incident response strategy<br>   <br>GS-8: Define and implement backup and recovery strategy<br>   <br>GS-9: Define and implement endpoint security strategy<br>   <br>GS-10: Define and implement DevOps security strategy    |

For more information on the security controls in each of these areas,
see <https://aka.ms/benchmarkdocs>

These best practices in MCRA and Microsoft Cloud Security Benchmark can help you improve your security capabilities and controls.
