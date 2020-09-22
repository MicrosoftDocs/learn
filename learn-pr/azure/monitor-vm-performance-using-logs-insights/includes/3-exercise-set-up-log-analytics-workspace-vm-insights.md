
Follow these steps:

## Configure Analytics workspace and VM Insights

1. Log into Azure portal

1. At the top, select "All services." In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select Log Analytics workspaces.

1. Provide a name for the new Log Analytics workspace. The name must be globally unique.

1. Select a subscription, resource group, and location.

1. Once deployed, change to a resource-centric model.

1. Deploy 2 VMs from portal and connect to Log Analytics workspace.

1. After both VMs are connected to Log Analytics workspace, onboard both to VM Insights. Select "Insights" on the far left and select "Enable."

1. Once enabled, go into the "Insights" section of each VM underneath the Monitoring area. Onboarding VM Insights takes a few minutes.

1. Once the pane opens and onboarding is finished, select "Performance."

1. Explore the different graphs for: Logical Disk Performance, CPU Utilization, Available Memory, Logical Disk IOPS, Logical Disk MB/s, Logical Disk Latency (ms), Max Logical Disk Used %, Bytes Sent Rate, and Bytes Received Rate.

1. Experiment with different settings. Move from "Avg", to "Min", to "Max", and so on.

1. Take note of how easy it's to drill into Log Events on the far right-hand side of the page.

