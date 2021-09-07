NSGs are evaluated independently, and an “allow” rule must exist at both levels otherwise traffic will not be allowed.

:::image type="content" source="../media/security-groups-7a9d5c84.png" alt-text="A NSG is shown controlling traffic to a subnet. Inside the subnet another NSG is shown controlling traffic to a virtual machine NIC.":::


In the above example, if there was incoming traffic on port 80, you would need to have the NSG at the subnet level ALLOW port 80. You would also need another NSG with an ALLOW rule on port 80 at the NIC level.

For incoming traffic, the NSG set at the subnet level is evaluated first, then the NSG set at the NIC level is evaluated. For outgoing traffic, it is the reverse.

If you have several NSGs and are not sure which security rules are being applied, you can use the **Effective security rules** link. For example, you could verify the security rules being applied to a network interface.

:::image type="content" source="../media/effective-security-rules-d93ab464.png" alt-text="Screenshot of the Networking blade in the Azure portal. The Effective security rules link is highlighted.":::
