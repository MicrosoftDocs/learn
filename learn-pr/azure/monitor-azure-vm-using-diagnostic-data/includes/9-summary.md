When you create and host your virtual machines on Azure, you're given basic metrics without having to install any additional software. You've seen the additional monitoring options available to you after you install the Azure Diagnostics extension.

You viewed the various metrics, built a dashboard, and created an alert to monitor performance. When the alert criteria were triggered, you got an email notification. You've seen how to use tools in Azure to get detailed information about a virtual machine's state.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [Supported metrics with Azure Monitor - Microsoft.Compute/virtualMachines](https://docs.microsoft.com/azure/azure-monitor/platform/metrics-supported#microsoftcomputevirtualmachines)
- [Use Linux Diagnostic Extension to monitor metrics and logs](https://docs.microsoft.com/azure/virtual-machines/extensions/diagnostics-linux#metrics-supported-by-the-builtin-provider)
- [Set-AzVMDiagnosticsExtension](https://docs.microsoft.com/powershell/module/az.compute/set-azvmdiagnosticsextension): PowerShell cmdlet to install the Azure Diagnostics extension 