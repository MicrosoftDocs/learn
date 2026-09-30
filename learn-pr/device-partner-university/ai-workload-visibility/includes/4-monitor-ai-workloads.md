Windows Task Manager has long provided visibility into system resources such as CPU, memory, storage, networking, and graphics activity. As AI workloads become more common, Task Manager has evolved and now provides information about dedicated AI processing resources on supported devices.

On supported devices, Task Manager can display AI-related metrics across several tabs, providing both a high-level view of AI resource utilization and detailed information about individual applications.

> [!NOTE]
> The AI-related metrics available in Task Manager depend on the Windows version, device hardware, installed drivers, and hardware-vendor implementation. Availability of specific metrics and views can vary across supported devices and hardware configurations. Refer to current Microsoft documentation for requirements and support information.

To investigate the Studio Effects workload, the administrator enables features such as Background Blur or Eye Contact during a Teams call and then reviews Task Manager. The metrics in Task Manager can help the administrator observe AI-related hardware activity while the workload is active.

## View AI activity in the Processes tab

The **Processes** tab provides a real-time view of resource consumption by running applications. In addition to traditional metrics such as CPU and memory usage, supported devices can display AI-related metrics as shown in this table.

| AI-related metrics | What it tells you |
| ------------------- | ------------------- |
| NPU utilization | The percentage of NPU resources currently being used. |
| NPU engine activity | Information about the NPU engine being used to execute the workload. |
| GPU utilization | The percentage of GPU resources currently being used. |
| GPU engine activity | Information about the GPU engine executing the workload, such as a 3D engine, compute engine, video engine, or GPU neural engine on supported hardware. |

These metrics can help identify applications or processes using NPU or relevant GPU resources while an AI-enabled feature is active. For example, an AI-enabled application might display activity in the NPU column or show that it's using the GPU neural engine. However, Task Manager activity alone might not identify the specific feature or operation responsible for that usage. This distinction is especially important when a single process hosts multiple features.

By monitoring these metrics, administrators and users can determine whether applications are using available AI processing resources at any given moment. The expected values will vary depending on the application and the task being performed. In general, AI-related activity should increase when an application is actively using AI features and decrease when those features aren't being used.

For example, if a user enables Background Blur during a video call, they might observe increased NPU utilization while the application and feature are active. However, Task Manager activity alone doesn't identify the specific operation responsible for that utilization.

If no NPU activity is observed while a feature is active, don’t assume that fallback has occurred. Confirm that the feature is expected to use the NPU on the tested configuration, reproduce the workload, observe it over an appropriate interval, and compare activity across the relevant processes and hardware views.

:::image type="content" source="../media/processes.png" alt-text="Screenshot of Task Manager Processes tab showing NPU and GPU activity for running applications." lightbox="../media/processes.png":::

## View overall AI utilization in the Performance tab

The **Performance** tab provides a system-wide view of hardware utilization over time. Unlike the Processes tab, which shows activity associated with individual applications, the Performance tab shows overall utilization across the device.

On supported devices, this includes dedicated views for:

- NPU activity
- GPU activity, including neural engine utilization

These views show how heavily AI-capable hardware is being used overall and how utilization changes over time as workloads run.

For example, the NPU performance graph can show whether overall NPU utilization increases during periods of AI activity and help you identify usage patterns over time.

:::image type="content" source="../media/performance.png" alt-text="Screenshot of Task Manager on the Performance tab displaying hardware utilization information." lightbox="../media/performance.png":::

## View detailed AI resource information in the Details tab

The **Details** tab provides a more granular view of how individual processes use system resources.

Users can add columns that display:

- NPU utilization
- NPU engine activity
- GPU utilization
- GPU engine activity
- Dedicated NPU memory
- Shared NPU memory

> [!TIP]
> Some columns may not be visible by default. To add them, right-click a column header and select Select columns. Then choose the columns you want to display in the Details tab.

These metrics can help identify which processes are consuming AI resources and how much memory those workloads require.

## Understanding AI memory usage

Task Manager can also display information about AI-related memory allocation.

**Dedicated NPU memory** reports memory associated with the process that the system identifies as dedicated to the NPU.

**Shared NPU memory** reports shared system memory associated with NPU processing.

Higher shared NPU memory usage indicates that more system memory is being used for NPU-related processing. This metric can provide additional context when investigating workload behavior, like if users report that an AI-powered feature becomes less responsive when working with large files or complex inputs. However, shared NPU memory usage alone doesn't establish the cause of a performance issue. Additional analysis is needed to determine whether memory usage is contributing to the observed behavior.

> [!NOTE]
> Availability of NPU memory metrics can vary depending on the NPU and hardware implementation.

The following example illustrates how AI-related resource information might appear in the **Details** tab. Notice that most processes show no NPU activity. This is typical because only a small number of applications actively use dedicated AI hardware at any given time. Processes that are using AI hardware display values in the **NPU**, **NPU Engine**, **Dedicated NPU Memory**, and **Shared NPU Memory** columns.

> [!NOTE]
> **Illustrative example only**: The process names and values in this table are simulated to demonstrate how fields might be interpreted. They are not expected values, benchmarks, or evidence of how these applications behave on every configuration.

| Process | GPU | GPU Engine | NPU | NPU Engine | Dedicated NPU Memory | Shared NPU Memory |
| --------- | ----- | ------------ | ----- | ------------ | ---------------------- | ------------------- |
| dwm.exe | 0.3 | GPU 0 - 3D | 0 | - | 0 K | 0 K |
| SearchHost.exe | 0.0 | - | 0.2 | NPU 0 - Compute | 8 MB | 16 MB |
| RuntimeBroker.exe | 0.0 | - | 0 | - | 0 K | 0 K |
| explorer.exe | 0.0 | - | 0 | - | 0 K | 0 K |
| Widgets.exe | 0.0 | - | 0 | - | 0 K | 0 K |
| ms-teams.exe | 0.4 | GPU 0 - 3D | 1.1 | NPU 0 - Compute | 64 MB | 128 MB |
| msedge.exe | 0.1 | GPU 0 - 3D | 0 | - | 0 K | 0 K |
| OneDrive.exe | 0 | - | 0 | - | 0 K | 0 K |

In this example, most processes show no NPU utilization. This is typical because only a small number of applications are actively using dedicated AI hardware at any given time. Microsoft Teams and SearchHost.exe are actively using the NPU, while the remaining processes rely on traditional CPU or GPU resources.

## Why these metrics matter

The different Task Manager views provide complementary information about AI processing.

They can help answer questions such as:

- Which applications are using AI hardware?
- Is an AI workload reaching the NPU?
- Is a workload using the GPU neural engine?
- How much memory is an AI workload consuming?
- How is AI activity affecting overall system utilization?

For example, suppose you're testing Windows Studio Effects during a Microsoft Teams call and want to confirm that the feature is using dedicated AI hardware. Each Task Manager view provides insight into a different aspect of the workload.

| Tab | Answers the question | Example |
| ----- | ---------------------- | --------- |
| Processes | *Which application is using AI resources?* | Is Microsoft Teams using the NPU or GPU neural engine while Windows Studio Effects features are active? |
| Performance | *How heavily is AI hardware being used across the system?* | Does overall NPU utilization increase when Windows Studio Effects features such as Background Blur, Eye Contact, or Voice Focus are active during a Teams call? |
| Details | *How are individual processes using AI resources?* | Which Teams process shows NPU activity, and what AI resources is it consuming? |
| Details (Dedicated NPU Memory) | *How much dedicated NPU memory is a process using?* | How much dedicated NPU memory is the Teams process consuming while Windows Studio Effects features are active? |
| Details (Shared NPU Memory) | *How much shared system memory is being used by NPU workloads?* | Is the Teams process using shared NPU memory in addition to dedicated NPU memory while Windows Studio Effects features are active? |

In the next unit, you'll learn how to use these metrics to validate AI hardware utilization and identify workload fallback scenarios.
