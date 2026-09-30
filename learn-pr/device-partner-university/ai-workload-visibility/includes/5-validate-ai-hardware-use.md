Now that you know what Task Manager can show, you can use those metrics to investigate how an AI workload is being processed. Comparing expected behavior with what Task Manager reports can help administrators and developers identify unexpected processing paths and determine where further investigation might be needed.

Continuing the Studio Effects example, suppose the administrator expects the feature to use an NPU on a supported device. By comparing expected behavior with observed activity in Task Manager, the administrator can assess whether the workload appears to be using the intended processing path.

## Investigating AI workload behavior

When using Task Manager to assess AI workloads, a useful approach is to:

1. Establish expectations by understanding which hardware the workload is expected to use.
2. Reproduce the workload while the feature or application is active.
3. Observe AI-related metrics in Task Manager.
4. Correlate activity across the Processes, Performance, and Details tabs.
5. Investigate any differences between expected and observed behavior.

## Establish the expected processing path

Before reviewing Task Manager, assess which hardware the application or feature is expected to use. Knowing the expected processing path gives you a baseline for interpreting the activity shown in Task Manager.

## Verify that the workload reaches the intended hardware

Run the AI-enabled application or feature, and then review the Processes or Details tab. Look for activity associated with the application in the relevant NPU and GPU columns.

For example, if a feature is expected to use the NPU, check whether:

- The application or one of its associated processes shows NPU utilization in the Processes tab.
- Overall NPU utilization increases in the Performance tab while the workload is active.
- The NPU engine column identifies an active NPU engine for that process in the Details tab.

Using the tabs together provides a more complete picture. The Processes and Details tabs help associate activity with an application or process, while the Performance tab shows how heavily the hardware is being used across the system.

## Identify potential workload fallback

In some situations, an application might not use the NPU or GPU neural engine as expected. Instead, some or all of the workload might use the CPU or a conventional GPU processing path.

Potential signs of fallback include:

- The application shows little or no activity in the NPU columns when NPU activity is expected.
- The NPU engine column doesn't identify an active engine for the process.
- The GPU engine column identifies a conventional GPU engine instead of the expected GPU neural engine, in GPUs where a neural engine is available.
- CPU utilization increases during AI processing while the expected accelerator remains inactive.

These indicators don't establish the cause on their own. However, they can show that the observed processing path differs from the expected one, giving administrators and developers a starting point for further investigation.

If you identify a potential fallback condition, review the application's requirements and verify that the appropriate AI hardware is available and supported on the device. This can help determine whether the observed processing path is expected or whether further investigation is needed.

## Investigate possible causes

An AI workload may use an alternative processing path for several reasons, including:

- Missing or incompatible drivers
- Hardware or driver limitations
- Operations that aren't supported by the intended accelerator
- Data types or model components that aren't compatible with the available hardware

For example, if part of a model can't run on the intended accelerator, the application may use another available processing path so that the workload can continue. Comparing activity across the CPU, GPU, GPU neural engine, and NPU can help identify where that processing is occurring.

## Review NPU memory usage

The Details tab can provide additional insight through the Dedicated NPU Memory and Shared NPU Memory columns. Review these values for the process you're investigating to understand how it uses available NPU memory.

An increase in shared NPU memory can indicate that the workload requires memory beyond the dedicated NPU memory currently available. Reviewing both values can provide useful context when investigating performance or resource pressure.

> [!TIP]
> When reviewing NPU memory metrics, compare dedicated and shared memory usage for the process you're investigating:
>
> - **Dedicated NPU Memory** shows how much memory reserved for the NPU is being used by the process.
> - **Shared NPU Memory** shows how much shared system memory is being used for NPU processing.

## Correlate activity across Task Manager

No single metric provides the complete picture. A practical investigation combines information from multiple Task Manager views:

- Use **Processes** to identify the application using AI resources.
- Use **Details** to examine the associated processor, processing engine, and NPU memory use.
- Use **Performance** to observe overall utilization and changes over time.
- Compare what you observe with the workload's expected processing path.

By correlating these views, administrators and developers can identify whether a workload appears to be using the expected hardware, identify possible fallback behavior, and gather information for further troubleshooting.

In the next unit, you'll explore how AI hardware utilization can affect power consumption, battery life, and overall system efficiency.
