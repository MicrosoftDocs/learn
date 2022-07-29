Today, organizations need a new security model that effectively adapts to the complexity of the modern environment, embraces the mobile workforce, and protects people, devices, applications, and data wherever they're located.

This is the core of **Zero Trust**. Instead of believing everything behind the corporate firewall is safe, the Zero Trust model assumes breach, and verifies each request as though it originated from an uncontrolled network. Regardless of where the request originates or what resource it accesses, the Zero Trust model teaches us to "never trust, always verify."

## Guiding principles of Zero Trust

There are three foundational principles of Zero Trust:

* **Verify explicitly** - Always authenticate and authorize based on all available data points.
* **Use least privilege access** - Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.
* **Assume breach** - Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

This is the core of Zero Trust. Instead of believing everything behind the corporate firewall is safe, the Zero Trust model assumes breach and verifies each request as though it originated from an uncontrolled network. Regardless of where the request originates or what resource it accesses, the Zero Trust model teaches us to "never trust, always verify."

The following diagram visually illustrates the zero trust principles:

:::image type="content" source="../media/zero-trust-principles.png" alt-text="Diagram showing zero trust principles." lightbox="../media/zero-trust-principles.png":::

## Technology pillars of Zero Trust

A Zero Trust approach should extend throughout the entire digital estate and serve as an integrated security philosophy and end-to-end strategy. This is done by implementing Zero Trust controls and technologies across six foundational elements. Each of these is a source of signal, a control plane for enforcement, and a critical resource to be defended.

The Zero Trust approach can be organized around six key technological pillars:

:::image type="content" source="../media/zero-trust-security.png" alt-text="Diagram showing zero trust principles." lightbox="../media/zero-trust-security.png":::

* **Secure identity with Zero Trust** - Identities, whether they represent people, services, or IoT devices—define the Zero Trust control plane. When an identity attempts to access a resource, verify that identity with strong authentication, and ensure access is compliant and typical for that identity. Follow
least privilege access principles.
* **Secure endpoints with Zero Trust** - Once an identity has been granted access to a resource, data can flow to a variety of different endpoints—from IOT devices to smartphones, BYOD to partner-managed devices,
and on-premises workloads to cloud-hosted servers. This diversity creates a massive attack surface area. Monitor and enforce device health and compliance for secure access.
* **Secure applications with Zero Trust** - Applications and APIs provide the interface by which data is consumed. They may be legacy on-premises, lifted-and-shifted to cloud workloads, or modern SaaS applications. Apply controls and technologies to discover shadow IT, ensure appropriate in-app permissions, gate access based on real-time analytics, monitor for abnormal behavior, control user actions, and validate secure configuration options.
* **Secure data with Zero Trust** - Ultimately, security teams are protecting data. Where possible, data should remain safe even if it leaves the devices, apps, infrastructure, and networks the organization controls. Classify, label, and encrypt data, and restrict access based on those attributes.
* **Secure infrastructure with Zero Trust** - Infrastructure—whether on-premises servers, cloud-based VMS, containers, or micro-services — represents a critical threat vector. Assess version, configuration, and JIT access to harden defense. Use telemetry to detect attacks and anomalies, and automatically block and flag risky behavior and take protective actions.
* **Secure networks with Zero Trust** - All data is ultimately accessed over network infrastructure. Networking controls can provide critical controls to enhance visibility and help prevent attackers from moving laterally across the network. Segment networks (and do deeper in-network micro-segmentation) and
deploy real-time threat protection, end-to-end encryption, monitoring, and analytics.

In our Zero Trust guides, we define the approach to implement an end-to-end Zero Trust methodology across identities, endpoints and devices, data, apps, infrastructure, and network. These activities increase your visibility, which gives you better data for making trust decisions. With each Of these individual areas generating their own relevant alerts, we need an integrated capability to manage the resulting influx of data to better defend against threats and validate trust in a transaction. So we define and additional overarching capability of **Visibility, automation, and orchestration**.

With Zero Trust, we move away from a trust-by-default perspective to a trust-by-exception one. An integrated capability to automatically manage those exceptions and alerts is important so you can more easily find and detect threats, respond to them, and prevent or block undesired events across your organization.