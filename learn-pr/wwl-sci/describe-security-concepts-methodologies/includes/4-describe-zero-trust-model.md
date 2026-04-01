
Zero Trust is a security strategy—not a single product or technology. It operates on the principle of "**trust no one, verify everything.**" Instead of assuming that everything inside a corporate network is safe and trustworthy, Zero Trust requires that every request for access be authenticated and authorized, regardless of where the request originates.

Traditional security approaches often relied on a "castle-and-moat" model: strong perimeter controls kept untrusted traffic out, and everything inside the network was assumed to be safe. This model worked reasonably well when employees worked from a fixed office and data lived entirely on-premises. But that environment no longer describes most organizations.

Today, work happens from anywhere. Employees use personal and corporate devices, connect from home networks and public locations, and access data across multiple cloud services. Corporate data moves between on-premises datacenters, cloud platforms, and third-party applications. In this environment, the network perimeter alone is no longer a reliable security boundary. Attackers routinely bypass perimeter controls through phishing, credential theft, and application vulnerabilities—and once inside, they can move through the network if the inside is assumed to be trusted by default.

Zero Trust addresses this reality by assuming that no network, device, user, or application should be trusted by default, even those that have already authenticated or are connected to a trusted network.

## Zero Trust guiding principles

The Zero Trust model is built on three guiding principles that shape how security decisions are made in every part of an organization.

This video introduces the Zero Trust methodology:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=5881f412-3b50-43dc-9d03-794d4348603b]

- **Verify explicitly**: Always authenticate and authorize based on all available signals, not just a single factor like a password or network location. Signals include the user's identity, their sign-in location, the device they're using and its compliance status, the service or application being accessed, the classification of the data involved, and any anomalies such as unusual sign-in times or locations. The more signals you can evaluate, the more confident you can be that the right person is accessing the right resource.

- **Use least privileged access**: Grant users and systems only the minimum access they need to do their job, for only as long as they need it. This principle is implemented through just-in-time (JIT) access—granting access only when it's needed and revoking it afterward—and just-enough-access (JEA)—granting only the specific permissions required for a task, rather than broad permissions "just in case." Risk-based adaptive policies can also automatically limit access when unusual or risky activity is detected.

- **Assume breach**: Design your security strategy as if an attacker will eventually get through your defenses. When you assume breach, you segment access so that a compromised account or device can't freely reach everything else. You encrypt data end-to-end so that intercepted data is unreadable. You deploy monitoring and analytics so that when a breach happens, you detect it quickly, understand what was accessed, and can limit the damage.

These three principles guide how every aspect of security is implemented: how users authenticate, how devices are trusted, how applications are authorized, and how data is protected.

## Seven foundational pillars

In the Zero Trust model, security is implemented across seven interconnected pillars. Six of these pillars are signal sources, a control plane for enforcement, and critical resources to be defended. The seventh pillar collects signals from all six and provides the visibility, automation, and orchestration needed to respond to and mitigate threats.

- **Identities** may be users, services, or devices. When an identity attempts to access a resource, it must be verified with strong authentication before access is granted. After authentication, access is governed by least-privilege principles—granting only the access needed for the specific task. Identity is the primary control plane for modern security, because almost all successful attacks eventually rely on compromising or abusing an identity.

- **Devices** create a large attack surface as data flows from devices to on-premises workloads and the cloud. Every device that accesses your resources represents a potential entry point for attackers. Monitoring devices for health status and compliance—and making access decisions based on that status—is an important aspect of Zero Trust. Devices that are out of compliance or show signs of compromise can be blocked or given restricted access.

- **Applications** are the way that data is consumed. In a Zero Trust strategy, you need visibility into all the applications being used in your environment, including unsanctioned applications—sometimes called shadow IT—that employees use without formal approval. This pillar also includes managing the permissions that applications request from platforms, and the permissions users grant to applications that access their data.

- **Data** should be classified, labeled, and encrypted based on its attributes and sensitivity. Security efforts across all the other pillars ultimately serve to protect data. Data must carry its own protection—through classification and encryption—so it stays secure even outside the environments your organization controls.

- **Infrastructure**, whether on-premises or cloud based, represents a significant attack surface. In Zero Trust, infrastructure is continuously assessed for version currency, configuration compliance, and unusual behavior. Just-in-time access to administrative interfaces limits the window of exposure. Telemetry from infrastructure allows teams to detect attacks and anomalies and respond automatically.

- **Networks** should be segmented so that a compromise in one part of the network doesn't provide unrestricted access elsewhere. This includes deeper in-network micro-segmentation that creates boundaries within network zones, not just at the perimeter. Real-time threat protection, end-to-end encryption of network traffic, continuous monitoring, and analytics should all be applied at the network layer.

- **Visibility, automation, and orchestration** is the seventh pillar and the integrating layer that ties all the others together. Each of the six pillars generates its own signals and alerts. Without a way to aggregate, correlate, and act on those signals centrally, security teams face an overwhelming volume of separate alerts—a problem that leads to missed threats and analyst fatigue. This pillar provides an integrated capability to manage that influx of data, giving security teams better information for making trust decisions and enabling automated responses to detected threats. Security information and event management (SIEM) and security orchestration, automated response (SOAR) technologies are central to this pillar—a SIEM ingests and correlates signals across all pillars to detect threats, while a SOAR uses those detections to trigger automated response playbooks.


:::image type="content" source="../media/diagram-zero-trust-security-elements.png" alt-text="Diagram showing the seven pillars of Zero Trust, with Visibility, Automation, and Orchestration at the center integrating signals from Identities, Devices, Applications, Data, Infrastructure, and Networks." lightbox="../media/diagram-zero-trust-security-elements.png":::
-->

### Zero Trust in practice

The seven pillars don't operate in isolation. Consider a real-world scenario: a user signs in from an unfamiliar location on an unmanaged personal device and attempts to access a sensitive financial application.

In a Zero Trust environment, signals from multiple pillars are evaluated simultaneously. The identity pillar checks the user's credentials and detects the unusual sign-in location as a risk signal. The devices pillar finds the device isn't enrolled or compliant. The applications pillar enforces a policy requiring compliant device access for sensitive apps. The network pillar monitors the connection and logs the attempt. The data pillar ensures the financial data is encrypted and access-controlled at the data layer. The infrastructure pillar records the access attempt in telemetry.

The visibility, automation, and orchestration pillar integrates all of these signals. Rather than each pillar independently logging a low-severity event, the combined signals are correlated into a high-confidence risk detection. Automated policies—guided by the "assume breach" and "verify explicitly" principles—step up authentication requirements, block access to the sensitive application, and alert the security team, all without manual intervention.

This is what Zero Trust in practice looks like: continuous verification across every pillar, automated responses that limit damage, and centralized visibility that gives security teams the full picture of what happened and why.
