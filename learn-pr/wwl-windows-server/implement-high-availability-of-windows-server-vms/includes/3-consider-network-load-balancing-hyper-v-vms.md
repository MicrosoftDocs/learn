Windows Server failover clustering is optimized for high availability of stateful workloads. For stateless workloads, you can use NLB.

## What is Hyper-V VMs NLB?

NLB is a Windows Server operating system feature. NLB works with Hyper-V VMs in the same way as it does with physical hosts. It distributes IP traffic to multiple instances of a TCP/IP-based service, such as a web server running on multiple members of the NLB cluster. NLB exposes that service to client applications by using a virtual host name or a virtual IP address. From the client perspective, the cluster seems to be a single server responding to requests, while, in reality, each response might originate from a different node of the NLB cluster.

Because of its stateless nature, NLB is a suitable solution for resources that don't rely on session state maintained by the server hosting the TCP/IP-based service. This applies to applications that transfer session state as part of the request-response exchange, for example, in the form of a cookie. Alternatively, session state can reside in a back-end data store that all NLB cluster members can access.

To make an application available via VM-based NLB, you need to:

- Install it on every VM that should be responding to requests targeting that application.
- Install the NLB Windows Server feature within the guest operating system of each VM.
- Create an NLB cluster consisting of these VMs.
- Configure the NLB cluster to make the application available via a virtual IP address.
- Optionally, assign to the application a virtual name.
