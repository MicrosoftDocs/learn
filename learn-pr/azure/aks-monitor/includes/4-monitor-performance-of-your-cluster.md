Once Container insights is enabled on a cluster, you can monitor the performance and health status of the cluster components and their workloads. Start with a summary view of all of your monitored clusters and then drill into the details of a particular cluster using built-in workbooks.

    :::image type="content" source="../media/image4.png" lightbox="../media/image4.png" alt-text="Screenshot of a list of all containers and their status in Container insights." border="true":::

On the **Monitored clusters** tab, you learn the following for each of your monitored clusters:

- How many clusters are in a critical or unhealthy state, versus how many are healthy or not reporting.
- Whether all of the AKS deployments are healthy.
- How many nodes and user and system pods are deployed per cluster.
- How much disk space is available and if there's a capacity issue.

The health statuses included are:

- **Healthy**: No issues are detected for the VM, and it's functioning as required.
- **Critical**: One or more critical issues are detected that must be addressed to restore normal operational state as expected.
- **Warning**: One or more issues are detected that must be addressed or the health condition could become critical.
- **Unknown**: If the service wasn't able to make a connection with the node or pod, the status changes to an Unknown state.
- **Not found**: Either the workspace, the resource group, or subscription that contains the workspace for this solution was deleted.
- **Unauthorized**: User doesn't have required permissions to read the data in the workspace.
- **Error**: An error occurred while attempting to read data from the workspace.
- **Misconfigured**: Container insights wasn't configured correctly in the specified workspace.
- **No data**: Data hasn't reported to the workspace for the last 30 minutes.

Health state calculates overall cluster status as the _worst of_ the three states with one exception. If any of the three states is Unknown, the overall cluster state shows **Unknown**.

The following table provides a breakdown of the calculation that controls the health states for a monitored cluster on the multi-cluster view.

| Monitored cluster | Status | Availability |
|:---|:---|:---|
| **User pod** | Healthy<br>Warning<br>Critical<br>Unknown | 100%<br>90 - 99%<br><90%<br>If not reported in last 30 minutes |
| **System pod** | Healthy<br>Warning<br>Critical<br>Unknown | 100%<br>N/A<br><100%<br>If not reported in last 30 minutes |
| **Node** | Healthy<br>Warning<br>Critical<br>Unknown | >85%<br>60 - 84%<br><60%<br>If not reported in last 30 minutes<br>If not reported in last 30 minutes |
