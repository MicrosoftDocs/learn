Effective security programs must protect against both insider risk as
well as attacks by external threat actors. You can find best practices
for protecting from insider and external attacks throughout the MCRA and
ASB. While all security controls should reduce risk in one or both of
these scenarios, this section will focus primarily on insider risk
aspects and the security operations elements of external attacks

An attack chain describes insider and external attacks - An attack chain
describes the typical chain of events during an attack that leads to
organizational damage. This includes technical and non-technical steps
taken by adversaries or insiders during the attack. It's important to
note that there is no single linear path for either insider risk or
external attacks. There are many common elements across attacks, but
each one can take a unique path.

The MCRA includes an attack chain diagram that depicts common techniques
related to both external attacks and insider risks, as shown in Figure
10-2

![](media/image2.png){width="5.147916666666666in"
height="2.9006944444444445in"}

**Figure 10-2**  MCRA Attack Chain Diagram

F10XX02: A screenshot of the attack chain slide from MCRA depicting both
external attacks and insider risks.

The top portion of this diagram represents common steps seen in many
external attacks and the Microsoft capabilities that map to each area.
The bottom portion shows the insider risk leading indicators and how the
Microsoft Purview Insider Risk Management helps quickly identify,
triage, and act on risky user activity.

Most external attacks include common steps and follow common patterns
that are depicted in Figure 10-#. Most of the variation in an external
attack comes from the attackers using different entry points (compromise
a user account with password spray or social engineering, send a
phishing email with a malicious link, compromising an internet of things
(IoT) device, watering hole attack where malware is hosted on a site the
target user regularly visits, implanting malware on a cloud application,
etc.). Attacks also differ based on the different objectives of the
attackers like stealing data, encrypting data, or disrupting business
for either ransomware/extortion or for other means of attacker
monetization/benefit.

Most external attacks that result in a major incident include some form
of privilege escalation using credential theft, which is mitigated by
securing privileged access (covered in the MCRA section of the same name
and documented in detail at <https://aka.ms/SPA>).

Lockheed Martin created one of the first adaptations of the 'kill chain'
military concept to cybersecurity. While this first effort no longer
describes current attack patterns well, it helped mature how
organizations understand attacks and plan security controls by viewing
attacks as a sequential chain of events -- an attack chain. Many
organizations use the MITRE ATT&CK framework today for detailed control
planning like threat detection coverage.

Figure 10-# describes how these relate to each other and to a simple
Prepare-Enter-Traverse-Execute (PETE) model that Microsoft developed to
improve communications with business leaders and non-security
professionals.

![](media/image3.png){width="5.147916666666666in"
height="1.74375in"}**Figure 10-3**  Attack Chain Mapping

F10XX03: A visual illustration of how MITRE ATT&CK, PETE, and Lockheed
Martin kill chain map to each other.

Attackers can frequently choose from using different types of techniques
(phishing, credential theft, exploiting software vulnerability) to
achieve each goal of prepare, enter, traverse, and execute objectives.
Attackers may also use a combination of techniques or the same technique
over and over again iteratively to achieve their objectives.

All of the security best practices in the MCRA and ASB are intended to
reduce risk of attackers succeeding (either directly or indirectly via
effective governance, role organization, etc.). Several MCRA best
practices focus directly on the security operations aspects of external
attacks -- detect, respond, recover.

These best practices include:

-   **Continuous improvement toward complete coverage** -- Ensure you
    are always working to continuously improve coverage of the attack
    chain to remove blind spots with no visibility and highly vulnerable
    areas with no preventive controls.

-   **Balanced control investments** -- Ensure you are balancing
    investment into security controls across the full lifecycle of
    identify, protect, detect, respond, and recover

-   **From SIEM for everything to "XDR + SIEM"** -- The primary tool for
    security operations to detect attacks and respond to them has been
    the Security Information and Event Management (SIEM) capability.
    Once introduced, extended detection and response (XDR) tools quickly
    became indispensable for the platforms they monitor (starting with
    Endpoint Detection and Response (EDR) for endpoints) because they
    quickly reduce false positives that waste scarce analyst time and
    attention. These tools do not cover the breadth of sources that the
    SIEM does, but they greatly simplify and increase effectiveness of
    detection and response for technologies covered by XDR. Security
    best practices then shifted to reflect the strengths of SIEM (Broad
    visibility and correlation across all tools and technology) and of
    XDR tooling (simple high quality threat detection on covered
    assets), and the collective need for both types of tooling in
    security operations.

-   **SOAR Automation and Modern Analytics** -- Reduce the amount of
    manual effort in security operations by integrating the use of
    security orchestration, automation, and response (SOAR), Machine
    Learning (ML -- an Artificial Intelligence technology), and User
    Entity Behavioral Analytics (UEBA) technologies. SOAR technology
    automates manual efforts that distract and tire human analysts
    during detection, investigation, and other response tasks. ML
    greatly improves detection by allowing computers to extend human
    expertise over large datasets and spot anomalies that could be
    attacker activity. UEBA improves detection and investigation by
    profiling the individual user accounts and entities that attackers
    compromise, rather than attempting to find patterns in the full set
    of raw log data.

-   **Adapt processes to Operational Technology (OT)** -- As you
    integrate OT environments into your security program, adjust your
    tools and processes to adapt to the unique constraints of that
    environment. These environments prioritize safety and update and
    often have older systems (which don't have patches available and may
    crash from an active scan). Focusing on approaches like passive
    network detections for threats/discovery and isolation of systems is
    often the best approach.

-   **Build appropriate controls for Insider Risk as a distinct focus
    area** -- While some of the objectives for insider risk attacks are
    similar to external attacks (and external attackers can sometimes
    recruit insiders), reducing insider risk is different than reducing
    risk from external attacks. Insider risks can include elements like:

    -   Leaks of sensitive data and data spillage

    -   Confidentiality violations

    -   Intellectual property (IP) theft

    -   Fraud

    -   Insider trading

    -   Regulatory compliance violations

The ASB includes many best practices that help protect from insider and
external attacks including the security controls listed in Table 10-2
focused on security operations related topics:

Table 10-2 ASB Best practices for security operations

+---------------------+------------------------------------------------+
| ASB Control Domain  | Security Controls                              |
+=====================+================================================+
| Incident Response   | IR-1: Preparation - update incident response   |
| (IR)                | plan and handling process                      |
|                     |                                                |
|                     | IR-2: Preparation - setup incident             |
|                     | notification                                   |
|                     |                                                |
|                     | IR-3: Detection and analysis - create          |
|                     | incidents based on high-quality alerts         |
|                     |                                                |
|                     | IR-4: Detection and analysis - investigate an  |
|                     | incident                                       |
|                     |                                                |
|                     | IR-5: Detection and analysis - prioritize      |
|                     | incidents                                      |
|                     |                                                |
|                     | IR-6: Containment, eradication and recovery -  |
|                     | automate the incident handling                 |
|                     |                                                |
|                     | IR-7: Post-incident activity - conduct lesson  |
|                     | learned and retain evidence                    |
+---------------------+------------------------------------------------+
| Logging and Threat  | LT-1: Enable threat detection capabilities     |
| Detection (LT)      |                                                |
|                     | LT-2: Enable threat detection for identity and |
|                     | access management                              |
|                     |                                                |
|                     | LT-3: Enable logging for security              |
|                     | investigation                                  |
|                     |                                                |
|                     | LT-4: Enable network logging for security      |
|                     | investigation                                  |
|                     |                                                |
|                     | LT-5: Centralize security log management and   |
|                     | analysis                                       |
|                     |                                                |
|                     | LT-6: Configure log storage retention          |
|                     |                                                |
|                     | LT-7: Use approved time synchronization        |
|                     | sources                                        |
+---------------------+------------------------------------------------+

For more information on the security controls in each of these areas,
see <https://aka.ms/benchmarkdocs>

These best practices in MCRA and ASB can help you improve your security
program effectiveness for both insider risk as well as attacks by
external threat actors.
