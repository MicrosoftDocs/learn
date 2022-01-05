Operating system patching, installing security updates, and rebooting VMs are recommended to keep the underlying OS up to date. HDInsight is a PaaS service and at time of writing this document the underlying operating system in HDInsight VMs is Ubuntu 16.0.4 LTS. Updated information of HDInsight OS versions is available at the [component versioning](/azure/hdinsight/hdinsight-component-versioning) 
documentation page. 
Post patching, Linux VMs need to be rebooted for the patches to be applicable and may lead to HDInsight nodes getting rebooted which may interfere with customer plans and workload executions. 

There are two main ways by which you can ensure that underlying base images in the VMs are up to date. 

## Periodically drop and recreate older clusters

Irrespective of HDInsight version, every time you create a new HDInsight cluster it gets the latest base OS version updated with the most secure base image. Periodical dropping, and recreation of HDInsight clusters is recommended in workloads when this is feasible. 

## Shell script for updating the clusters

For long running workloads, or highly configured or interconnected clusters. Periodical dropping, or recreating of clusters pose a challenge and, in many cases, may not be feasible. In those circumstances, HDInsight provides you with two configurable shell scripts that can be used to patch the operating system and schedule reboots. 

### Script name

install-updates-schedule-reboots.sh 	

### Parameters

Argument 1
0: Enable kernel updates only or 

1: Enable kernel and security updates only 

2: Enable all updates

Default: 0 

Argument 2
0: Disable reboot

1: Enable scheduled reboot

2: Enable immediate reboot

Default: 0 

### Script name

schedule-reboots.sh

### Parameters

1: Enables a reboot between 12 – 24 hours

2: Enables immediate restart (in 5 minutes)

Default: 1 

> [!NOTE]
> If reboot was disabled when install-updates-schedule-reboots.sh was executed you can use schedule-reboots.sh to execute the reboot at a later time of your choosing. 




 
