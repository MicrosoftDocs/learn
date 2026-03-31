Imagine that you're an IT decision maker for a global retail and apparel manufacturing company. Your legacy device deployment systems are slow, complicated, and create frustration across global teams. You're looking for a modern solution to simplify IT, strengthen security, and keep creativity flowing.

With Windows 11 Pro, Microsoft Intune, and Copilot+ PC devices, you can secure, configure, and manage devices from the cloud. This modernization creates a consistent and reliable experience for users with expanded access to the AI-powered capabilities of Microsoft 365. Your teams can now collaborate faster, make smarter decisions, and bring greater functionality to every task. On the user level, Windows 11 Pro offers user experience improvements, hardware and operating system optimization, and enhanced performance with Copilot+ PCs. Let's explore this in more detail.

## Hardware and operating system optimizations

:::image type="content" border="true" source="../media/windows-hardware.jpeg" alt-text="Illustration of Windows 11 Pro hardware components including CPU, GPU, and NPU.":::

Copilot+ PCs use a trio of processors to optimize performance. They are:

- **CPU (central processing unit):** The CPU is the general-purpose workhorse of the computer—capable of managing a wide range of tasks. It excels at sequential processing and low-latency tasks—making it ideal for tasks that require quick decision-making. The CPU can also execute complex instructions and manage the operating system and applications. An example case is running multiple applications like a web browser, word processor, and email client simultaneously.
- **GPU (graphics processing unit):** Specialized for parallel processing—making it powerful for tasks that can be divided into smaller, simultaneous operations. GPUs are useful for a wide range of graphics, analytics, and AI workloads including simulating environments for training large language or vision models faster, multimedia generation, and  analyzing large data sets. A use case for the GPU is rendering high-resolution graphics in video games or performing complex calculations in scientific simulations.
- **NPU (neural processing unit):** A purpose-built processor built for AI—especially for high-speed inference tasks like natural language processing or image enhancement. NPUs are more energy-efficient than CPUs and GPIs for AI tasks. An example of the use case of this processor is real-time image recognition or running AI models for voice assistants.

## User experience consistency

Regarding maximizing productivity, consistent experiences and operating system elements are crucial. By making visual elements consistent throughout Windows 11 Pro, improving settings navigation, and simplifying Snap layouts, users can reduce cognitive load and improve their efficiency. Let's explore some of these features and how to use them.

:::image type="content" border="true" source="../media/dark-mode.gif" alt-text="Animation demonstrating turning on Dark Mode in Windows 11 Pro.":::

**Consistent Dark Mode:** Dark Mode is a popular visual setting in many social media apps and web browsers. Many users may not know that it's also an available feature in operating systems. Dark mode offers an experience for reduced eye strain, is better for darker or dimly lit environments, and helps to preserve battery life.

These are all benefits that help to foster better working experience for business users. Dark mode is present throughout Windows 11 Pro, enabling a seamless visual look that helps business users be their most focused and productive selves. Here's how to turn on Dark mode on your Windows 11 Pro PC:

- From the **Start menu**, navigate to **Settings,** and select **Personalization**.
- Select **Colors** followed by **Choose your mode**.
- You can choose between **Light**, **Dark**, or **Custom**.
- If you select Custom, you have the option to choose one default Windows mode and a different default app mode.
- In the same menu, you'll also find options to change accent colors and turn on **Transparency effects**.

**Settings navigation:** The Settings menu in Windows 11 Pro helps you quickly find and manage device preferences. It has a navigation panel with labeled categories. Each category is represented by an icon and a name, such as **System**, **Bluetooth & devices**, and **Privacy & Security**.

On Copilot+ PCs, you can use natural language to find what you need, whether it be a specific setting or trying to solve a problem. In our scenario, you're looking to simplify experiences for a diverse workforce. Easily navigable settings go a long way to streamline configuring setup—allowing business users to find what they're looking for quickly and efficiently.

Let's say that an employee needs to view their available storage to install a new application. In the past, this required digging through menus to find the information they needed. With Improved search, simply describe what you want to do in your own words such as: "**view storage usage**." This opens storage settings—saving users time to get back to their work.

:::image type="content" border="true" source="../media/snap-layouts.gif" alt-text="Animation showing how to use Snap layouts in Windows 11 Pro.":::

**Snap layouts:** Part of being productive and efficient comes down to staying organized. Snap layouts allow users to maximize multitasking and save time searching for windows that you need. Snap layouts are preconfigured ways to organize windows on your screen. You can choose from two windows side by side, both using one half of the screen, or four windows, each using one quarter of the screen. Here's are the ways to open and use Snap layouts:

- Select Windows logo key + Z to launch the Snap layout box.
- Hover over the minimize or maximize button in the upper-right corner of your window to launch the Snap layout box.
- Drag a window to the top center of your screen to launch the Snap layout box.

Snap layouts help to foster productivity. Here are some examples of how business users can increase their productivity by using this feature:

- **Multitask on video calls:** While on a call, Snap layouts can help to pull up notes alongside your video call. This allows you to still see your colleagues' video feeds while keeping track of the agenda.
- **Research:** When collecting data or taking notes for a project, Snap layouts can help you optimize your process by having research material in one window and notes and data in another for a seamless process.
- **View code in real time:** For users that edit code, Snap layouts allow them to view their code editor and the page that's being updated at the same time—creating a more fluid workflow.

## Reliability features

In a world filled with ever evolving cyberattacks, it's important for organizations to deploy solutions that protect crucial data while minimizing user disruptions. In our scenario, you're an IT decision-maker for a large global brand. This reach means that the organization is vulnerable to a myriad of cyberattacks. Windows 11 Pro helps keep them protected through various methods, but let's focus on two Windows update mechanisms: Hotpatch updates and Windows Autopatch.

:::image type="content" border="true" source="../media/windows-update.png" alt-text="Screenshot of Windows Update settings in Windows 11 Pro.":::

**Hotpatch updates:** Install and take effect without requiring users to restart their devices. By minimizing the need to restart, these updates help ensure faster compliance—making it easier for organizations to maintain security while keeping workflows uninterrupted. Hotpatch updates offer the following key benefits:

- Streamline the installation process and enhance compliance efficiency.
- No changes are required to existing update ring configurations—they're honored alongside Hotpatch policies.
- The Hotpatch quality update report provides a per policy level view of the current update statuses for all devices that receive Hotpatch updates.
- Hotpatch package size is smaller than the standard cumulative updates—allowing them to install faster and consume less network bandwidth.

:::image type="content" border="true" source="../media/hotpatch-demo.gif" alt-text="Animation demonstrating how to enroll devices for Hotpatch updates in the Intune admin center.":::

To enroll devices to receive Hotpatch updates, follow these steps:

- Go to the **Intune admin center**.
- Select **Devices** from the left navigation menu.
- Under the **Manage updates** section, select **Windows updates**.
- Go to the **Quality updates** tab.
- Select **Create**, and then select **Windows quality update policy**.
- Under the **Basics** section, enter a name for your new policy and select Next.
- Under the **Settings** section, ensure that the option **When available, apply without restarting the device (Hotpatch)** is set to **Allow**. Then, select **Next**.
- Select the appropriate Scope tags or leave as **Default**. Then, select **Next**.
- Assign the devices to the policy and select **Next**.
- Review the policy and select **Create**.
- You can also edit the existing Windows quality update policy and set the **When available, apply without restarting the device (Hotpatch)** to **Allow**.

These steps ensure that targeted devices, which are eligible to receive Hotpatch updates, are configured properly.

**Windows Autopatch:** Embedded natively in Microsoft Intune, Windows Autopatch aims to update 95% of devices by their target compliance date. Autopatch allows organizations to control which Windows updates get deployed to managed devices. For each content type, IT decision makers can choose to either deploy those updates automatically or require manual approval.

The easiest way to set up a safe rollout and configure the approval strategy for a group of devices is to create a Windows Autopatch group. They help you do three things:

- Distribute devices into Microsoft Entra groups on an ongoing basis.
- Define your approval strategy for content types.
- Set your rollout schedule for each ring.

Once a device is a member of a policy, Windows Autopatch provides reporting on both quality and feature updates. Client devices reflect changes in under four hours. Reports allow managers to see both trends over time and detailed status for each device. Device alerts help you understand any issues preventing a device from updating.

These features help business users keep their devices updated—ensuring secure protocols and maximizing productive work.
