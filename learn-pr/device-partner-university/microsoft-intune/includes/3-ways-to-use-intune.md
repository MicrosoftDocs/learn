## Enable secure access to email on devices

Many organizations need a reliable way to secure email access for employees using internet-connected devices. With Intune’s Conditional Access solution, email stays protected by ensuring only devices enrolled in Intune can access it—and there’s no need to set up a gateway machine at the edge of the network to make this happen.

Intune also supports secure access to services and apps using Intune-managed certificates, a standard VPN gateway or proxy, and [Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access). There are also non-Microsoft options available, often referred to as Zero Trust Network Access (ZTNA) or Secure Access Service Edge (SASE) solutions—all helping to maintain robust security while providing flexible and secure access to resources.

![A photograph of an employee smiling while working on a laptop at a desk in an office building.](../media/intune-worker.png)

## Issue corporate-owned devices to employees

Windows Autopilot provides bulk provisioning and integrates with Intune for ongoing device management—streamlining deployment and management processes for large numbers of devices. For instance, when an employee powers on their new company-owned device, they go through a corporate-branded setup process where they must authenticate themselves. Once authenticated, the device is seamlessly configured with the necessary security policies, apps, and other admin configured settings. After this, the employee can launch the Intune Company Portal app to install the optional corporate apps available to them.

## Issue limited-use shared devices to employees

Employees sometimes use shared devices for tasks like processing sales or checking inventory. These devices typically run in kiosk mode, which restricts what the user can interact with to just a single line-of-business app. By using Intune, you can easily secure and centrally manage these devices, ensuring they’re configured to operate in kiosk mode. This provides greater control over how devices are used—giving you confidence that your systems are protected.

## Explore Intune data using natural language

Using natural language—in your own words—you can query and explore your Intune data. An intelligent search matches your request to query views available in Intune.

Some queries can have parameter inputs that you enter, such as platform type or specific device details. Copilot provides a summary of the results and might offer recommendations based on what it finds.

This feature is helpful for tasks like locating specific devices, identifying users with compliance issues, finding devices that need updates, or finding particular apps or policies. You can use these insights to support troubleshooting and decision-making.

You can also take action from the query results, such as adding users or devices to groups or creating custom reports. For example, you might find devices that are noncompliant and past their grace period, add them to a group, and then target apps or policies to that group.

Learn more about [Explore Intune data using natural language](/intune/intune-service/copilot/copilot-intune-explorer).

## Security Copilot agents in Intune

Security Copilot agents in Intune are AI-powered assistants that enhance enterprise security. They automate tasks for endpoint protection, identity management, threat intelligence, and device configuration. They help IT teams quickly address vulnerabilities, policy gaps, and emerging threats.

Agents are built on Microsoft Security Copilot's generative AI and automation capabilities. They observe, reason, and act with oversight and review from your administrators. Each agent is tailored to a specific use case, operates within the Intune admin center, and uses role-based access controls.

The following agents are available:

- **Change Review Agent**: Evaluates the impact of approval requests in Intune and provides recommendations for actions you can take.

- **Device Offboarding Agent**: Identifies stale or misaligned devices across Intune and Microsoft Entra ID, delivers actionable insights, and requires admin approval before offboarding any devices.

- **Policy Configuration Agent**: Allows you to import documents or write instructions in plain language. The agent matches this input to settings in the Intune settings catalog, recommends appropriate values, and can help you create a policy using those settings.

- **Vulnerability Remediation Agent**: Uses Microsoft Defender data to monitor vulnerabilities and prioritize remediation through AI-driven risk assessments.

Learn more about [Security Copilot agents in Intune](/intune/agents/).