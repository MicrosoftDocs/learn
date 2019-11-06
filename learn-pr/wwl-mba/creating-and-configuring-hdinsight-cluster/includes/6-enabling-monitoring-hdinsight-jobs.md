Monitoring of an HDInsight cluster is of interest to both data engineers and IT administrators, so they can monitor the following areas of the cluster: 

- Cluster health and availability
- Resource utilization and performance
- Workload information and logs

IT admins will use monitoring to view the cluster health and availability, as well as monitoring the security of the cluster. Data engineers are interested in the following:

- Workload information and logs
- Watching for the job’s failures or successes
- Performance of the cluster
- Viewing workloads using logs 

There are two main tools that can be used to monitor: Apache Ambari and Azure Monitor.

## Apache Ambari

This tool is used for open source cluster management and monitoring. It provides a dashboard with a series of widgets that enable you to view the health of an HDInsight cluster from a hardware perspective at both the cluster and the node level. The dashboard is accessible from the overview screen of the HDInsight cluster in the Azure portal.

![Accessing Apachi Ambari from the Azure portal](../media/6-img01.png)

Apache Ambari opens in a web browser that provides a dashboard of monitoring tools.

![The Apachi Ambari dashboard](../media/6-img02.png)

Many areas of Apache Ambari are useful to both IT admins and Data Engineers. The initial dashboard is useful for IT admins to monitor cluster health in real time. There are additional areas, such as the YARN screen, that enable Data Engineers to view queue capacities, jobs, and associated logs to monitor workloads on the cluster. Also, alert capabilities enable you to identify malfunctioning components so that you can be proactive in your support of the cluster. 

## Monitoring

Azure Monitor is an Azure-wide monitoring tool which can be used on HDInsight clusters to monitor the health of your service. Aspects of Azure Monitor are exposed in the Azure portal directly:

![The monitoring options in the Azure portal](../media/6-img03.png)

## Alerts

Alerts are a useful tool to proactively monitor a resource in Azure, and to act based on a condition. An alert can be set against a given resource – such as an HDInsight cluster – to determine the threshold of a condition that would dictate whether an alert is fired. A condition could include is AutoScale enabled. This condition could be either true or false. Actions can range from sending an email, to restarting a service depending on how the condition is defined.

## Metrics

Metrics are a component of Azure Monitor that enable you to set up visual charts specific to what you want to monitor. Using visual charts enables you to view, measure, and correlate data points to help determine if a service is performing in an acceptable range. HDInsight metrics include Gateway Requests to see the load on your cluster, and the number of active workers, which allows you to keep an eye on your cluster size of the HDInsight cluster

## Diagnostic Settings

These settings enable you to select a target (either a storage account, Event Hub service or Log Analytics account) to receive diagnostic data about the service you have enabled. Logs are sent to your chosen target, which enables you to log service activity over time and analyze later. These settings should be set only if you want to do an in-depth analysis of the service.

## Azure Monitor

There is a direct link to Azure Monitor so that you can use the full capabilities Azure monitor provides.

## Resource health

This dashboard is standard across all services in Azure, and it enables you to view the health of the HDInsight service on a given day. There are no notifications from this area, and you must investigate this yourself. Resource health can provide you with an overview of health information.