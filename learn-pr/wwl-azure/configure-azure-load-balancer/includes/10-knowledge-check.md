Choose the best response for each question. Then select Check your answers.

## Multiple Choice
A company provides customers a virtual network in the cloud. There are dozens of Linux virtual machines in another virtual network. Which Azure load balancer should be used to direct traffic between the virtual networks.
( ) An external load balancer. {{That's incorrect.  Azure has two types of load balancers: public and internal.}}
(x) An internal load balancer. {{That's correct. An internal load balancer directs traffic only to resources that are inside a virtual network or that use a VPN to access Azure infrastructure.}}
( ) A public load balancer. {{That's incorrect. A public load balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of the VM.}}

## Multiple Choice
What is the default distribution type for traffic through a load balancer?
( ) Source IP affinity {{That's incorrect. Affinity specifies that successive requests from the same client IP address and protocol combination will be handled by the same virtual machine.}}
( ) Three-tuple hash {{That's incorrect. A three-tuple hash is not the distribution type. }}
(x) Five-tuple hash {{That's correct.The load balancer uses a five-tuple (source IP, source port, destination IP, destination port, and protocol type) hash to map traffic to available servers.}}

## Multiple Choice
Which configuration is required to configure an internal load balancer?
(x) Virtual machines should be in the same virtual network. {{That's correct. The virtual machines that use a load balancer to distribute a load to must be in the same virtual network.}}
( ) Virtual machines must be publicly accessible. {{That's incorrect. Virtual machines that are behind an internal load balancer shouldn't be accessed publicly. The load balancer provides the access point.}}
( ) Virtual machines must be in an availability set. {{That's incorrect. Although this configuration is an option, it's not a requirement.}}

