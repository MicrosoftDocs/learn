An Azure Arc-enabled SQL Managed Instance (MI) deployment out of the box provides the ability to monitor the environment locally using Azure Data Studio and Grafana. In this exercise, we look at how to access Grafana and what metrics are captured and provided by default. 

Utilizing the Grafana dashboards locally in your Arc-enabled SQL MI environment will provide you insights into the infrastructure (Kubernetes Cluster) as well as the performance of the Arc-enabled SQL MI.

1. Open Azure Data Studio.
2. Expand the Connections Tab.
3. Expand Azure Arc Controllers.
4. Expand your Arc data controller.
5. Right-click on your Arc-enabled SQL MI and select Manage.

![Image of Azure Monitor – Arc-enabled SQL MI Manage - Grafana endpoint](../media/Arc-enabled-dataservices-module-3-ADS-grafanaendpoint-1.png)

6. Click on Grafana Endpoint.
7. Enter your `Metrics and Logs Dashboard credentials`
8. Discover the performance metric graphs for your Arc-enabled SQL MI:
    - Transactions/sec

![Image of Grafana transactions/sec](../media/Arc-enabled-dataservices-module-3-ADS-grafana-transactions-2.png)

    - Batch Requests/sec

![Image of Grafana Arc-enabled SQL MI - Batch Requests/sec](../media/Arc-enabled-dataservices-module-3-ADS-grafana-batch-requests-3.png)

    - Wait Statistics

![Image of Grafana Arc-enabled SQL MI - Wait Stats](../media/Arc-enabled-dataservices-module-3-ADS-grafana-wait-stats-4.png)

    - Memory Broker Clerks

![Image of Grafana Arc-enabled SQL MI - Memory Broker Clerks](../media/Arc-enabled-dataservices-module-3-ADS-grafana-memory-clerks-5.png)

    - Database Activity

![Image of Grafana Arc-enabled SQL MI - Database Activity](../media/Arc-enabled-dataservices-module-3-ADS-grafana-database-activity-6.png)

    - SQL Server Activity

![Image of Grafana Arc-enabled SQL MI - SQL Server Activity](../media/Arc-enabled-dataservices-module-3-ADS-grafana-SQLServer-activity-7.png)

    - Buffer Cache - Memory

![Image of Grafana Arc-enabled SQL MI - Buffer Cache Memory](../media/Arc-enabled-dataservices-module-3-ADS-grafana-buffer-cache-7.png)

    - Memory Manager

![Image of Grafana Arc-enabled SQL MI - Memory Manager](../media/Arc-enabled-dataservices-module-3-ADS-grafana-memory-manager-8.png)

9. Swap to another deployed Arc-enabled SQL MI. Select the drop-down for Host.

![Image of Grafana monitored Arc-enabled SQL MI](../media/Arc-enabled-dataservices-module-3-ADS-grafana-monitored-sqlmi-9.png)

10. Investigate the Kubernetes Host Node Metrics.

![Image of Grafana Host Node Metrics](../media/Arc-enabled-dataservices-module-3-ADS-grafana-host-node-metrics-10.png)

11. Investigate the Kubernetes Pods and Containers Metrics

![Image of Grafana Pods and Container Metrics](../media/Arc-enabled-dataservices-module-3-ADS-grafana-pods-container-metrics-11.png)
