In earlier units, we explored how AI and agents appear in familiar Windows surfaces and support everyday workflows. This unit focuses on what makes those experiences perform reliably in real environments: the device itself.

Copilot+ PCs are designed to support AI workloads directly on the device. By combining Windows features with purpose-built hardware—including a dedicated Neural Processing Unit (NPU)—these devices enable AI experiences that are responsive, predictable, and suitable for everyday use in managed environments.

## Why device-based AI matters

Running AI directly on the device changes how AI can be used day to day. Instead of relying entirely on cloud round trips, Copilot+ PCs can process certain AI tasks locally.

Local AI processing helps reduce latency, so responses feel immediate instead of delayed. Sensitive data can remain on the device, supporting privacy and compliance requirements. Some AI-assisted experiences continue to work even when connectivity is limited or unavailable. And because fewer tasks depend on constant network calls, overall responsiveness improves—especially when users are multitasking.

Together, these factors help AI move from something that feels experimental to something users can rely on during everyday work.

## Understanding the hardware difference

Copilot+ PCs are not simply faster versions of existing devices. They use a different balance of compute resources, with each processor type handling a specific kind of workload.

:::image type="content" source="../media/understanding-processors-for-ai.svg" alt-text="Infographic titled 'Understanding Processors for AI' comparing CPU, GPU, and NPU roles. The CPU handles general-purpose computing but isn’t optimized for sustained AI workloads. The GPU accelerates graphics and some AI tasks through parallel processing but can be power‑intensive. The NPU provides efficient, low‑power on‑device AI inference using specialized hardware.":::

By offloading AI workloads to the NPU, Copilot+ PCs can run AI-assisted features without competing with everyday productivity tasks. This helps maintain consistent performance and battery life while AI actions run in the background.

> [!TIP]
> CPUs keep Windows running, GPUs handle visuals, and NPUs quietly power AI features behind the scenes.

## How Copilot+ PCs change everyday AI experiences

Copilot+ PCs don’t just enable new AI features—they change *how* certain tasks are performed by moving key AI workloads onto the device.

Two experiences highlight this shift clearly: **Click to Do** and **Windows Search**.

## Click to Do: Local, contextual actions powered by the NPU

[Click to Do](/windows/client-management/manage-click-to-do) uses the on-device NPU to surface quick, contextual actions based on what appears on screen.

For example, a user receives a PDF containing a table of data that needs to be analyzed in Excel. With Click to Do, the user can select the table and instantly transform it into a structured Excel spreadsheet—preserving headers, rows, and formatting.

From there, the user can add an *Actuals* column and initiate Agent Mode in Excel to reason over the dataset. What begins as a static document becomes an analyzable asset in just a few steps.

From an IT perspective:

- AI actions run locally, reducing latency
- Sensitive content stays on the device
- Users complete tasks without installing additional tools

## Windows Search: Semantic Search across local and cloud files

On Copilot+ PCs, [Windows Search](/windows/win32/search/-search-3x-wds-overview#introduction) **uses semantic understanding** to help users find content by describing it rather than remembering filenames or locations.

Search results can include both **local files** and files stored in **OneDrive for Business and SharePoint**, presented in a single experience.

Key implications:

- Local semantic indexing powered by the NPU
- Faster, more responsive search
- Reduced reliance on exact metadata
- Consistent behavior across managed devices

Because search runs efficiently on the device, it remains usable even when connectivity is limited.

> [!IMPORTANT]
> Feature availability varies by device, region, language, and licensing. Some Copilot+ PC capabilities are in preview and subject to change.

## Why this matters for IT teams

These experiences move AI from *assistive* to *operational*.

By handling AI tasks locally:

- Performance remains predictable
- Privacy and data handling are easier to manage
- Support scenarios become easier to diagnose
- Users gain confidence in AI-assisted workflows

Copilot+ PCs expand what users can do—while allowing IT teams to maintain governance and control.

## Real-world example: Suncorp Group

### The challenge

[Suncorp Group](https://www.microsoft.com/en/customers/story/25628-suncorp-group-windows-11) supports a geographically distributed workforce. As hybrid work expanded, IT teams needed to provision devices quickly while maintaining consistent performance.

Legacy environments slowed deployment and increased setup time.

### The solution

Suncorp standardized on Windows 11 and introduced Copilot+ PCs for eligible roles, managed through Microsoft Intune.

By pairing modern hardware with Windows features and Microsoft 365 Copilot, the organization enabled AI-assisted workflows that ran efficiently on the device.

### The outcome

Suncorp reduced device setup time by approximately 30 percent. IT teams spent less time on provisioning and troubleshooting, while employees benefited from a more responsive experience.

## Key takeaway

Copilot+ PCs provide the hardware foundation that makes device-based AI practical, reliable, and governable—enabling organizations to adopt AI at scale without sacrificing control.