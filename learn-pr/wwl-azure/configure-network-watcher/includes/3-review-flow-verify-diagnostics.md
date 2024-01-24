The **IP flow verify** feature in Azure Network Watcher checks connectivity from or to the internet, and from or to your on-premises environment. This feature helps you identify if a security rule is blocking traffic to or from your virtual machine or the internet.

:::image type="content" source="../media/flow-verify-d136d78d.png" alt-text="Screenshot of the IP flow verify feature in the Azure portal." border="false":::

### Things to know about IP flow verify

Let's examine the configuration details and functionality of the IP flow verify feature in Azure Network Watcher.

- You configure the IP flow verify feature with the following properties in the Azure portal:
   - Virtual machine and network interface
   - Local (source) port number
   - Remote (destination) IP address, and remote port number
   - Communication protocol (TCP or UDP)
   - Traffic direction (Inbound or Outbound)

- The feature tests communication for a target virtual machine with associated network security group (NSG) rules by running inbound and outbound packets to and from the machine.

- After the test runs complete, the feature informs you whether communication with the machine succeeds (allows access) or fails (denies access).

- If the target machine denies the packet because of an NSG, the feature returns the name of the controlling security rule.

### Things to consider when using IP flow verify

The IP flow verify feature is ideal for helping to ensure correct application of your security rules. 

When you deploy a virtual machine, Azure applies several default security rules to your machine. The security rules allow or deny traffic to or from your virtual machine. You can override Azure's default rules or create other rules.

At some point, your virtual machine might be unable to communicate with other resources because of a security rule. You can use the IP flow verify feature to troubleshoot your NSG rules.

If test runs fail, but the IP flow verify feature doesn't indicate the issue is related to your NSG rules, you need to explore other areas, such as firewall restrictions.