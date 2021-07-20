Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which workload option should be selected to run a network appliance on a virtual machine?
(x) Compute optimized {{That's correct. Compute optimized virtual machines are designed to have a high CPU-to-memory ratio. Suitable for medium traffic web servers, network appliances, batch processes, and application servers.}}
( ) Memory optimized {{That's incorrect. Memory optimized virtual machines are better for large in-memory business critical workloads requiring massive parallel compute power.}}
( ) Storage optimized {{That's incorrect. Storage optimized virtual machines are better for data warehousing applications and large transactional databases.}}

## Multiple Choice
An organization has a security policy that prohibits exposing SSH ports to the outside world. What is the best way to connect to the Azure Linux virtual machines and install software?
(x) Configure the Bastion service. {{That's correct. The Azure Bastion service is a new fully platform-managed PaaS service provisioned inside your virtual network. It provides secure and seamless RDP and SSH connectivity to your virtual machines directly in the Azure portal over SSL. W}}
( ) Configure a Guest configuration on the virtual machine. {{That's incorrect. The guest configuration is not a valid solution. Is there a better answer?}}
( ) Create a custom script extension. {{That's incorrect. Custom script extensions are for post deployment configuration, software installation, or any other configuration or management tasks.}}

## Multiple Choice
What is the effect of the default network security settings for a new virtual machine?
( ) Neither outbound nor inbound requests are allowed. {{That's incorrect. Outbound requests are allowed by default.}}
(x) Outbound request is allowed. Inbound traffic is only allowed from within the virtual network. {{That's correct. Outbound requests are considered low risk, so they are allowed by default. Inbound traffic from within the virtual network is allowed. By placing a VM in a virtual network, the VM owner is implicitly opting-in to communication among the resources in the virtual network. }}
( ) There are no restrictions: all outbound and inbound requests are allowed. {{That's incorrect. There are restrictions on inbound traffic.}}

