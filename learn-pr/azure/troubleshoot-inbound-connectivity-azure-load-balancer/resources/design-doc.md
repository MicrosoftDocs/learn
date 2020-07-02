# Module design

## Title

Troubleshoot inbound network connectivity for Azure Load Balancer

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Load Balancer
- Azure Monitor

## Prerequisites

- Basic understanding of Azure Load Balancer
- Familiarity with Azure Virtual Machines (VMs)
- Basic understanding of Azure Monitor

## Summary

Review multi-dimensional metrics for the load balancer in Azure Monitor Metrics, and check health probe status for the Load Balancer.

## Learning objectives

1. Identify common Load Balancer inbound connectivity issues
1. Identify steps to resolve issue when VMs aren't responding to health probe

## Chunk your content into subtasks

Identify the subtasks of *Troubleshoot network connectivity for Azure Load Balancer*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Review Azure Load Balancer and Health Probes | Review the concepts and components of a standard Load Balancer | Knowledge Check | Identify common Load Balancer inbound connectivity issues | Yes |
| Use metrics and health diagnostics to diagnose problems in Standard Load Balancer | Health check probes are failing  | Knowledge Check | Identify steps to resolve issue when VMs aren't responding to health probe| Yes |
| Troubleshoot Azure Load Balancer | Health check probes are failing | Exercise | Identify steps to resolve issue when VMs aren't responding to health probe | Yes |

## Outline the units

### 1. Introduction

You're an administrator for a large retail company that uses Azure Load Balancer to distribute inbound internet traffic to your virtual machines. You have an alert configured in Azure Monitor to notify you when a virtual machine fails a Load Balancer health check. Recently, another administrator made some changes to the virtual network configuration. You get several alerts that the health checks for all virtual machines behind the Load Balancer are failing.

### 2. Troubleshoot Azure Load Balancer

Azure Load Balancer which directs level 4 HTTP traffic to a pool of VMs. Azure Load Balancer uses a health probe to determine the availability of each VM in the backend pool. Load Balancer will only send requests to VMs that indicates that they are healthy.

By the end of this unit, you'll be able to:

- Describe a typical configuration of Azure Load Balancer and the various components involved in routing requests to VMs.
- Explain common problems that can cause Load Balancer to fail to distribute requests to VMs.

Cover the following points:

- Describe the deployment of a Standard Public Load Balancer used to load balance HTTP / TCP traffic. Focus on the role of the following items (include a diagram):
  - Backend pool (Contains the IP addresses of the virtual NICs connected to the load balancer)
  - Load balancer rule (rule to determine how traffic is distributed to VMs)
  - Network Security Group rule (Type of Firewall, and the impact it has upon health check)
  - Health probe (Dynamically adds/removes VMs from the Load Balancer rotation based upon their response to health checks)
  - Protocol, Port, Interval, Unhealthy threshold
- Summarize common symptoms that indicate failure, and their possible causes:
  - Symptoms:
    - Unreachable application
    - Unreachable VM (failed TCP Ping / unable to RDP)
    - Slow responses
    - Requests timing out
  - Possible causes
    - Probing issues:
      - NSG blocking probe IP or port
      - Incorrect probe config (wrong URL, wrong port)
      - VM not responding to probe (application issue, port not open etc)
    - Data path issue:
      - NSG / FW blocking data ports
      - VM is down (turned Off, security config like cert expiry etc)
      - Application is not responding (VM overloaded, App listening on incorrect LB port, APP down etc)

Add three knowledge check questions to verify the student's understanding of the content:

- What happens if a health probe has not been configured and a VM fails? (Load Balancer will not notice the failure and will continue to route traffic to the failed VM, causing requests to timeout)
- You have closed a port in an NSG used by a virtual network that hosts the VMs in the Load Balancer pool. How might this affect load balancing (if the port was being used to send traffic to the VMs in the pool, then this traffic will be blocked and all requests will timeout and eventually fail) (If this was a probe port, this VM will be removed from rotation.)

### 3. Diagnose issues by reviewing configurations and metrics

You need to monitor the performance of your load-balanced system to ensure that the performance meets requirements. If the performance trails off, and connections to VMs start to fail, you need to troubleshoot the system to determine the cause and rectify the problem. By the end of this unit, you will be able to:

- Describe the the metrics available for measuring the throughput and performance of a load-balanced system
- Use the resource health page in Azure portal to monitor the health of your system
- Explain how to resolve common problems in a load-balanced system

Explain how to use the diagnostic capabilities of Azure Monitor to monitor, manage, and troubleshoot load balancer resources. Cover the following topics:

- Aggregations for these metrics
- How to use VIP availability alongside health probe metrics to identify issues
- Service Health enabling

Describe possible investigatory and remediation steps for the following scenarios:

1. VMs behind Load Balancer not responding to traffic on the probe port
   1. Backend Pool not listening on the probe port
   2. NSG is blocking probe port on Load Balancer backed pool VM
   3. Attempt to access the Load Balancer from same VM and NIC (This is not related to probing, but is an unsupported data path scenario.)
   4. Attempt to access the Internet Load Balancer frontend from the participating Load Balancer backend pool VM

1. Backend VM in pool is unhealthy
   1. Log into VM to check VM is healthy and can respond to basic checks such as ping, rdp, tcp requests from another node in the backend pool
   2. Log into VM to check listening ports
      - Validate with netstat -an to see if port listed as LISTENING on the specified health check port. 
      - Either update the application configuration to reflect the port detailed in the health probe, or update the health probe to reflect the current port to probe.
   3. If there is a Firewall on the VM, it could be blocking the probe port causing the VM to not respond to the health probe.
      - Validate firewall configuration on the host to ensure it permitted to allow traffic on the probe port
      - Validate Network Security Group allows for ingress and egress  
      - Check for existence of a Deny all NSG on the NIC of VM which has higher priority than the default rule which allows LB probes & traffic



1. Misconfigurations in Load Balancer
    - Summarize different tools available to help diagnose.  PsPing, TCPing,  Netsh Trace and give examples for each.
    - For NetSH describe simultaneous trace while doing a Psping to capture a trace observing
      - If no incoming packets - potential network security issue or user-defined routing issue
      - If no outgoing packets - potential Application configuration issue or user-defined routing issue

1. Firewall or NSG blocking the port

    1. Verify that the target port is open and the app is listening on that port

       - Validate with netstat -an port in the LISTENING state
       - Validate application configuration and logs for any possible issues

    2. Verify whether the NSG is blocking the port (There is an option to check effective NSGs, that'd help check if something is blocked.)

       - List the NSG configured on backed VM and check
       - Is the *Deny All* NSG rule in effect
       - Verify whether any of the rules are blocking the traffic
  
Also summarize the current limitations of Azure Load Balancer - see [limitations](https://docs.microsoft.com/azure/load-balancer/load-balancer-overview#limitations). In these cases, it may be necessary to adopt and alternative approach, such as using a proxy or [Application Gateway](https://docs.microsoft.com/azure/application-gateway/application-gateway-introduction)

Add three knowledge check questions

### 4. Exercise - Identify and resolve inbound network connectivity

In this exercise, you will start with a pre-configured environment which has multiple health probe failures, and use the skills learned in this module to diagnose and rectify the issues to return the public facing standard load-balanced HTTP service back to full service.

This exercise will use the Azure portal.

1. Provide a script that creates a pre-configured environment. The environment should have errors which the student has to diagnose:

   - Missing or misconfigured health probe
   - Application is not started on one node
   - There is a DENY All on a Network Security Group
   - The Network Security rule to allow traffic to port 80 is disabled, blocking the health probe

2. The student should work through an analysis of Network Security Groups,  VM level netstat, and service checking to identify the configurational errors to be able to hit the HTTP endpoint from the Load Balancer.

> Notes: Use the following approach in the lab:
>
> - Setup environment
> - Show that it's not working.
> - Review health probe status and other related metrics
> - Check ports, firewall, and network security groups.
> - Collect traces and test connectivity.
> - Show it working.

### Unit 5: Summary + Cleanup

How did you solve the problem in the initial scenario with the knowledge learned in the module?

- Explained standard Load Balancers and health probes
- Described typical configurational issues with health probes and network security groups
- Configured a Public Load Balancer
- Understood metrics and health diagnostics available in Azure Monitor

Cleanup:
Remove any resources created in Sandbox.

## Notes

  - Sandbox should be available for this module. It appears that the Virtual Machine sandbox policy covers most of the resources needed for module except firewall.
  - Focus on Standard SKU Load Balancer not Basic.
  - Related module in development: Improve application scalability and resiliency with Azure Load Balancer

## Resources

- [Troubleshoot Azure Load Balancer](https://docs.microsoft.com/azure/load-balancer/load-balancer-troubleshoot)
- [Metrics and health diagnostics for Standard Load Balancer](https://docs.microsoft.com/azure/load-balancer/load-balancer-standard-diagnostics)
- [Load Balancer health probes](https://docs.microsoft.com/azure/load-balancer/load-balancer-custom-probe-overview)
- [Quickstart: Create a Standard Load Balancer to load balance VMs using the Azure portal](https://docs.microsoft.com/azure/load-balancer/quickstart-load-balancer-standard-public-portal)
