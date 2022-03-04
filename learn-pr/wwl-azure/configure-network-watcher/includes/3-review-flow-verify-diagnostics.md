**IP Flow Verify Purpose**: Checks if a packet is allowed or denied to or from a virtual machine. For example, confirming if a security rule is blocking ingress or egress traffic to or from a virtual machine.

**Example**

When you deploy a VM, Azure applies several default security rules to the VM. These rules allow or deny traffic to or from the VM. You might override Azure's default rules or create additional rules. At some point, a VM may become unable to communicate with other resources, because of a security rule.

The IP Flow Verify capability enables you to specify a source and destination IPv4 address, port, protocol (TCP or UDP), and traffic direction (inbound or outbound). IP Flow Verify then tests the communication and informs you if the connection succeeds or fails. If the connection fails, IP Flow Verify identifies which security rule allowed or denied the communication. With this information, you can then resolve the problem.

:::image type="content" source="../media/flow-verify-d136d78d.png" alt-text="Screenshot of the IP Flow Verify page. A check of packet details shows access denied.":::


> [!NOTE]
> IP Flow Verify is ideal for making sure security rules are being correctly applied. When used for troubleshooting, if IP Flow Verify doesn’t show a problem, you will need to explore other areas such as firewall restrictions.
