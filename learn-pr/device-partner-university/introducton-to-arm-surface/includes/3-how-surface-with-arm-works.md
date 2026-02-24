System on Chip (SoC) is an Integrated Circuit (IC) that consolidates most of the components of a computer. Manufacturers like Qualcomm and other ARM-based manufacturers have embraced this architecture for a more streamlined approach versus the Motherboard architecture of the past as illustrated below:

:::image type="content" border="true" source="../media/arm-architecture.svg" alt-text="Diagram illustrating the ARM architecture versus traditional motherboard architecture.":::

Due to the consolidation of hardware components being fabricated on the chip itself, Surface devices can be thinner, lighter, and more portable. Arm has been a part of the Surface story for many years. Let's explore how Surface evolved with Windows on ARM:

:::image type="content" border="true" source="../media/windows-on-arm-history.svg" alt-text="Diagram illustrating the history of Windows on ARM.":::

Surface devices have been built on Arm architecture since the very beginning—dating back to Surface RT in 2012, which was powered by a custom variant of Windows 8 designed for Arm-based processors called Windows RT. With the desire for a thin and light design, long battery life, and a touch-optimized experience, ARM was a perfect fit for that device, and it has been crucial to Surface devices ever since.

In the following years, Windows on ARM added emulation of x86 apps, allowing 64-bit apps to run on ARM chips, and the development of native ARM versions of Microsoft Edge and Office. With the combination of long-term native app development and x86 emulation, business users can utilize their preferred software tools. Let's explore a timeline of app emulation on Microsoft Surface:

- **2017:** Initial launch of Windows 10 on Arm with support for emulating 32-bit x86 apps
- **2019:** Introduction of SQ1 processor in Surface Pro X marks a significant performance boost in emulation capabilities.
- **2021:** Addition of 64-bit (x64) app emulation is introduced as part of Windows 11 on Arm.
- **2024:** Introduction of a new Windows emulation engine, Prism, offering a jump in emulation performance with Snapdragon® X Elite processors.
- **2025:** Continued improvements to compatibility and performance with AVX (Advanced Vector Extensions) emulation in Canary channel.

## Emulation on Arm

:::image type="content" border="true" source="../media/arm-prism.png" alt-text="Screenshot of Prism emulation on ARM Surface devices.":::

Emulation makes the rich ecosystem of Windows apps available on Arm, so business users can run essential apps without modifications to the app. Emulation is a part of Windows and doesn't require any extra components to be installed. Starting with Windows 11 24H2, Prism is included with Windows. As the new emulation standard, it offers significant optimizations that improve the performance and lower CPU usage of apps under emulation.

Prism is optimized and tuned specifically for Qualcomm Snapdragon® processors that run on ARM-powered Surface devices. Some performance features within Prism require hardware features only available in the Snapdragon® X series, but Prism is available for all supported Arm Surface devices with Windows 11 24H2. Let's explore how emulation on these devices works.

- **How emulation works:** Emulation compiles blocks of x86 instructions into Arm64 instructions with optimizations to improve performance of the emitted Arm64 code. A service caches these translated blocks to reduce overhead and allow for optimization when the code runs again. For x86 apps, the WOW64 layer of Windows allows x86 code to run on the Arm64 version of Windows. This means that x86 apps on Arm are protected with filesystem and registry redirection.
- **Detecting emulation:** An x86 app doesn't know that it's running on an Arm Surface, unless it calls specific APIs (Application Programming Interface) that are designed to convey knowledge of the Arm64 host. Apps under emulation that query processor details—including metadata or feature capabilities—receive details corresponding to the emulated virtual processor.

Application emulation is needed to run and translate x86 and x64 apps to maximize the native speed and performance possible with Arm-powered devices on Windows 11. It enables compatibility and flexibility for users who want to use their favorite Windows apps on different platforms.

Prism is the emulation engine on Surface devices that improves performance and offers a better emulation experience than previous versions. Prism emulation works well for line-of-business applications that aren't CPU-intensive or graphics-heavy. It also works well for productivity, education, and entertainment apps that are compatible with Windows 11. Where Prism doesn't work well is for the following:

- System drivers that need direct access to hardware or kernel.
- Games or apps that use OpenGL or DirectX 12.
- Apps that have anti-cheat or DRM (digital rights management) software that interferes with emulation.

## Using software and peripherals

ARM-based Surface devices should operate as you have grown to expect with Windows, but there are some different behaviors. As with any PC, keeping your ARM-based Surface up to date helps keep it running at its best. Windows 11 on ARM continues to evolve and improve as updates are delivered. To ensure that you have access to the latest features of Windows and Surface, do the following:

- Open **Settings**.
- Select **Windows Update**.
- Select **Check for updates**.

Most apps run smoothly on ARM-based Windows 11 PCs when they meet the following standards:

- **x86 Win32 apps:** Most run seamlessly on ARM-based Surface devices, benefiting from advanced emulation technology.
- **Native Arm64 and Microsoft Store apps:** These apps use the full native speed of the Arm-based processor while optimizing battery life. Native Arm64 app availability continues to grow, including popular applications like Adobe Photoshop and Adobe Lightroom.
- **Driver-supported apps:** Apps that rely on drivers designed for ARM-based Windows 11 PCs are fully supported.
- **X64 emulation:** Now generally available in Windows 11, x64 emulation allows broader app compatibility, enabling many x64 apps to run effectively on ARM-based devices.
