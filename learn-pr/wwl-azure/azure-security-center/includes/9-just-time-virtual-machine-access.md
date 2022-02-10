Just-in-time (JIT) virtual machine (VM) access is used to lock down inbound traffic to your Azure VMs, reducing exposure to attacks while providing easy access to connect to VMs when needed.

When you enable JIT VM Access for your VMs, you next create a policy that determines the ports to help protect, how long ports should remain open, and the approved IP addresses that can access these ports. The policy helps you stay in control of what users can do when they request access. Requests are logged in the Azure activity log, so you can easily monitor and audit access. The policy will also help you quickly identify the existing VMs that have JIT VM Access enabled and the VMs where JIT VM Access is recommended.

### How JIT VM Access works

To use Just-in-Time VM access, you must enable Microsoft Defender for Cloud.

:::image type="content" source="../media/az500-just-in-time-7f0c02ba.png" alt-text="Screenshot of Azure Defender features.":::


After you enable Defender, you can view which virtual machines have JIT configured. Enable JIT on any virtual machine that is not Healthy.

:::image type="content" source="../media/az500-just-in-time-2-5c2f4bd7.png" alt-text="Screenshot of the recommended virtual machines page.":::


For each virtual machine, you are recommended specific ports and access.

:::image type="content" source="../media/az500-just-in-time-3-351a10c2.png" alt-text="Screenshots of port recommendations.":::


You can accept the recommendations or **Add** other ports of your choosing.

:::image type="content" source="../media/az500-just-in-time-4-9ceff860.png" alt-text="Screenshot of adding a port with recommended access.":::


Once everything is in place, users must request access to the virtual machine. You can also monitor the usage of each virtual machine.

:::image type="content" source="../media/az500-just-in-time-5-f6f0f004.png" alt-text="Screenshot of requesting access to a virtual machine.":::


For more information, [Secure your management ports with just-in-time access](/azure/security-center/security-center-just-in-time?tabs=jit-config-asc%2Cjit-request-asc).
