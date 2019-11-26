# Module design

## Title

Monitor the health of your Azure Virtual Machine by collecting and analyzing diagnostic data

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Virtual Machine

## Prerequisites

Familiarity with virtualization and Azure virtual machines

## Summary

Evaluate monitoring options for an Azure Virtual Machine (VM). Enable client diagnostics to get client data. View VM metrics and create an alert to monitor performance.

## Learning objectives

1. Identify metrics and diagnostic data that you can collect for virtual machines
1. Configure monitoring for a virtual machine
1. Use monitoring data to diagnose problems

## Chunk your content into subtasks

Identify the subtasks of *Monitor the health of your Azure Virtual Machine by collecting and analyzing diagnostic data*:

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify how to monitor the health of the virtual machine | Identify metrics that you can use to monitor the health of  virtual machines | Knowledge Check | 1 | Yes |
| Evaluate the diagnostic data options  | Identify diagnostic data that you can collect for virtual machines | Knowledge Check | 2 | Yes |
| Set up monitoring for a virtual machine | Configure monitoring for a virtual machine | Exercise | 1 & 2 | Yes |

## Outline the units

1. **Introduction**

    If you use an Azure Virtual Machine (VM) to run an important workload, you'll need to monitor that VM's performance and behavior to make sure that it's always available.

    Suppose you're an administrator for your band's website. You want to host the site on an Azure VM and  make sure that it is always accessible to your fans, especially while your band is on tour next month. You want a simple way to monitor the health of the VM.

    In this module, you will create a VM and then set up several ways to monitor its health and performance.

    By the end of this module, you will be able to use tools in Azure to obtain detailed information about a VM's state.

1. **Monitor the health of the virtual machine**

    - Overview of monitoring options:
        - Boot diagnostics
        - Host metrics. Include a discussion of some of the metrics that are available and plotting their values, using metric rules
        - The Azure diagnostics extension

    - How to configure monitoring during VM creation:
        - Boot diagnostics is enabled by default
        - Adding the Azure diagnostics extension

    2 to 3 knowledge check questions, such as:

    - What do you have to create in order to store diagnostic logs in Azure? 

1. **Exercise - Set up a VM with boot diagnostics**

   In this exercise, students install a Linux VM and monitor it by using boot diagnostics and host metrics. These types of monitoring do not require the Azure diagnostics extension.

   *Use the Azure portal for this exercise.*

   1. Deploy a new Linux VM. (Note that boot diagnostics is enabled by default)
   1. View boot diagnostics
   1. View host metrics

1. **View host metrics**

    Azure metrics are numerical values available from the Azure portal that help you understand the health, operation, and performance of your VM systems. You can choose specific metrics and get a great graph of that metric. You can get data such as:

    - CPU Usage
    - Inbound Flows
    - Outbound Flows
    - Network in
    - Network out 
    - OS disk write bytes per second

    There are more metrics available to plot. You can choose multiple metrics and plot them on the graph to get better understanding of the traffic hitting your webserver. Azure also offers a flexible timeline range; you can choose the last 30 minutes, the last hour, the last 4 hours, and more going back up to 30 days. This data enables you to see trends or patterns. You can also choose a custom time range. Azure also lets you pin these graphs to your dashboard and view the health of your servers at a quick glance.

    You can add a metric rule, choose a metric, specify a threshold, and then specify time period for the threshold. For the action, you can choose:

    - **Get email notification** - so you are notified when CPU threshold crossed certain percentage. You can view the logs and make sure the traffic is genuine, and it’s not a malicious attack.
    - **Run a runbook from the alert**
    - **Run a Logic app from the alert**

    Compare boot diagnostics and host metrics. Note that these tools can be used without installing the Azure diagnostics extension on your VM and the student will use them in the first exercise unit.

    2 - 3 knowledge check questions such as:
    - You want to initiate the IT department's procedure for adding storage capacity whenever your VM's disk space is more than 80% full. What should you do?

1. **Configure the Azure diagnostic extension**

   Describe what the Azure diagnostic extension is and why you would choose to install it. 

   Mention the event logs and crash dumps tabs in the diagnostic extension but do not go into depth.

   Describe how to configure: The Azure diagnostic extension.

1. **Exercise - Configure the Azure diagnostic extension**

   1. Enable Operating system Guest Diagnostic (this extension enables the IaaS Diagnostics extension, which enables you to collect metrics every minute for your virtual machine)
   1. Add the following custom performance counters – 
      - \Processor(*)\% Processor Time
      - \Processor(*)\Interrupts/sec
      - \Processor(*)\% Interrupt Time
      - \Processor(*)\% Idle Time
      - \LogicalDisk(C:)\Disk Write Bytes/sec
      - \LogicalDisk(C:)\Disk Read Bytes/sec
      - \Memory\Available MBytes
      - \Web Service(_Total)\ISAPI Extension Requests/sec
      - \Web Service(_Total)\Bytes Total/Sec-
      - \ASP.NET Applications(__Total__)\Requests/Sec
      - \ASP.NET Applications(__Total__)\Errors Total/Sec
      - \ASP.NET\Requests Queued
      - \ASP.NET\Requests Rejected 
   1. For the Event Logs, enable the following level of logging 
      - Application - Critical, Error, Warning, information
      - Security – Audit Success and Audit Failure 
      - System - Critical, Error, Warning, information
   1. Enable Crash dumps 

1. **Use diagnostic data**

    Describe how to use the data you have generate to diagnose problems. Give two or three scenarios and show how the data can be used for the diagnosis.

    Alerts notify you of critical conditions and potentially take corrective automated actions based on triggers from metrics or logs. For example, for your webserver you can use the CPU load metric for a VM. You can create an alert with a critical condition: You spot a pattern, VM CPU spikes every day around 03.00, you can spin up another VM to load balance and help meet the spike in demand. As the demand decreases, the second VM can be terminated to save money. You can automate the whole process.
    
    In Azure if you go to your VM resource, click the **Monitoring tab**, and then click on **Alerts**.
    
    Knowledge check questions:

      - What type of metric will help to identify if your webserver is experiencing a DDOS attack?
      - What type of metric will help to identify if you need to add another webserver? 
      - What do you have to enable to get metrics every minute for your VM? 

1. **Exercise - Use diagnostic data**

   1. Generate some activity on the monitored VM. It might be helpful to supply a bash script that generates requests.
   1. View the graphs that were configured in the previous exercise.
   1. View data from the Event Logs that were configured in the previous exercise.
   1. Create an alert based on CPU usage – if the CPU Usage goes above 3% for 5 mins then you get a notification (in the real world the number would be around 70-80% but for the exercise, use a lower number so that we can trigger the alert easily)
   1. Again, generate some CPU activity on the VM.
   1. Receive and examine the alert.

1. **Summary**

   In this module, we identified metrics and diagnostic data that you can collect for virtual machines. We viewed VM metrics available to measure performance & how we can create alerts if the metric is triggered. We configured monitoring on VM, added the relevant performance counters and set up a trigger. 

## Notes

- Use Linux VM for exercises. Monitoring is essentially the same for both Windows and Linux. But per SMEA it's more common for customers to be using VMs that run Linux.
- Use Azure portal for exercises. Mention that you can do steps in CLI or PowerShell where appropriate.
- Module should use sandbox environment.
- Module is for monitoring single VM. But we should mention at a high level, other more scalable options to monitor multiple VMs.

Phil - Exercise 6 can't setup these as they are all for Windows VM not Linux, so suggest adding some linuc and create a KPI dashboard using the guest-os metrics.

## Resources

- [How to monitor virtual machines in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/monitor)
- [Tutorial: Monitor and update a Linux virtual machine in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/tutorial-monitoring)
- Related module: [Keep your virtual machines updated](https://docs.microsoft.com/learn/modules/keep-your-virtual-machines-updated/2-update-management-solution-on-a-vm)

