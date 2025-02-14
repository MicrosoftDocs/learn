An Azure Arc-enabled SQL Managed Instance deployment provides the ability to monitor the environment locally using Azure Data Studio and Grafana out of the box. In this exercise, you'll learn how to access Grafana and what metrics are captured and provided by default. 

Utilizing the Grafana dashboards locally in your Arc-enabled SQL Managed Instance environment provides you with insights into the infrastructure (Kubernetes Cluster) as well as the performance of the Arc-enabled SQL Managed Instance.

> [!IMPORTANT]
> The modules in this learning path form a progression. To complete this exercise, you need to first complete the [preceding modules in this path](/training/paths/get-started-azure-arc-sql-managed-instance/).

1. Open Azure Data Studio.
1. Expand the **Connections** Tab.
1. Expand **Azure Arc Controllers**.
1. Expand your Arc data controller.
1. Right-click your Arc-enabled SQL Managed Instance and select **Manage**.

    ![Screenshot of Azure Monitor – Arc-enabled SQL Managed Instance Manage - Grafana endpoint.](../media/azure-data-studio-grafana-endpoint-1.png)

1. Select **Grafana Endpoint**.
1. Enter your `Metrics and Logs Dashboard credentials`
1. Discover the performance metric graphs for your Arc-enabled SQL Managed Instance:
    - Transactions/sec

    ![Screenshot of Grafana transactions/sec.](../media/azure-data-studio-grafana-transactions-2.png)

    - Batch Requests/sec

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Batch Requests/sec.](../media/azure-data-studio-grafana-batch-requests-3.png)

    - Wait Statistics

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Wait Stats.](../media/azure-data-studio-grafana-wait-stats-4.png)

    - Memory Broker Clerks

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Memory Broker Clerks.](../media/azure-data-studio-grafana-memory-clerks-5.png)

    - Database Activity

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Database Activity.](../media/azure-data-studio-grafana-database-activity-6.png)

    - SQL Server Activity

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - SQL Server Activity.](../media/azure-data-studio-grafana-sql-server-activity-7.png)

    - Buffer Cache - Memory

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Buffer Cache Memory.](../media/azure-data-studio-grafana-buffer-cache-7.png)

    - Memory Manager

    ![Screenshot of Grafana Arc-enabled SQL Managed Instance - Memory Manager.](../media/azure-data-studio-grafana-memory-manager-8.png)

1. Swap to another deployed Arc-enabled SQL Managed Instance. Select the **Host** drop-down.

    ![Screenshot of Grafana monitored Arc-enabled SQL Managed Instance.](../media/azure-data-studio-grafana-monitored-sqlmi-9.png)

1. Investigate the Kubernetes Host Node Metrics.

    ![Screenshot of Grafana Host Node Metrics.](../media/azure-data-studio-grafana-host-node-metrics-10.png)

1. Investigate the Kubernetes Pods and Containers Metrics.

    ![Screenshot of Grafana Pods and Container Metrics.](../media/azure-data-studio-grafana-pods-container-metrics-11.png)
