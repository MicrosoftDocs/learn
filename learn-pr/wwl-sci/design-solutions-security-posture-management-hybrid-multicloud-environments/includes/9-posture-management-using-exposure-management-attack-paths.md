Microsoft Security Exposure Management is a security solution that provides a unified view of security posture across company assets and workloads. Security Exposure Management enriches asset information with security context that helps you to proactively manage attack surfaces, protect critical assets, and explore and mitigate exposure risk.

## Attack paths overview

Microsoft Security Exposure Management helps you to manage your company attack surface and exposure risk. Attack paths combine assets and techniques to show end-to-end paths that attackers can create to get from an entry point of an organization to critical assets.

## Identifying and resolving attack paths

Here's how Security Exposure Management helps you to identify and resolve attack paths.

- **Attack path generation**: Security Exposure Management automatically generates attack paths based on the data collected across assets and workloads. It simulates attack scenarios, and identifies vulnerabilities and weaknesses that an attacker could exploit.
- **Attack path visibility**: The attack path graph view uses enterprise exposure graph data to visualize the attack path to understand how potential threats might unfold.
  - Hovering over each node and connector icon provides you with additional information about how the attack path is build. For instance, from an initial virtual machine containing TLS/SSL keys all the way to permissions to storage accounts.
  - The enterprise exposure map extends how you can visualize attack paths. Along with other data, it shows you multiple attack paths and choke points, nodes that create bottlenecks in the graph or map where attack paths converge. It visualizes exposure data, allowing you to see what assets are at risk, and where to prioritize your focus.
- **Security recommendations**: Get actionable recommendations to mitigate potential attack paths.
- **Choke point identification**: To manage choke points:
  - Security Exposure Management provides a way to group choke point nodes through which multiple attack paths flow, or where multiple attack paths intersect on the way to a critical asset.
  - Choke point visibility enables you to focus mitigation efforts strategically, addressing multiple attack paths by securing these critical points in the network.
  - Ensuring that choke points are secure protects your assets from threats.