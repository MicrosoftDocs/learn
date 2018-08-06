# IaaS, PaaS & SaaS

Explain acronyms. Different service models. 

You choose based on shared responsibility model.

## Shared responsibility model

Define/Explain

![Shared responsibility model](../media/3-shared-responsibility.png)

Outsourcing Risk/Responsibility. Exists on a spectrum.
- No Shared responsibility: own your own datacenter
- Least outsourced: IaaS, you outsource Network, Servers, most physical / foundational layers
- Middle Paas: outsourcing to cloud provider some responsibility for software: OS, middleware, runtime engines.
- Most outsource: You are simply a consumer of an internet based service. Entire responsibility for managing service is outsourced: OneDrive, Outlook, Movie streaming sites are examples.

## IaaS

- Define/Explain

- Lowest level. Essentially an abstraction over hardware allowing virtual point and click servers and appliances. Allows you to set up a "computing environment" including VMs, Storage (can be looked at as virtual NAS), virtual subnet, firewalls, VPN's, Load Balancing.
- On top of this infrastructure you can essentially build anything.
    Linux VM with node server
    Windows VM with Sql Server
    Both, talking to each other over secure subnet

- No need to manage physical servers and appliances there is still a lot of direct management required as you are responsible for configuring firewalls, updating VM OS's, updating DBMS's, runtimes, etc
- Creating several VMs in a subnet, accessing Azure Files, and connects over VPN to your on-prem datacenter would be leveraging all IaaS
- Should make a scenario out of this. Maybe hospital based scenario where the Azure files are x-rays and the VMs are load balanced PMS or EMR 

### Pros/Benefits/Use Cases

You work at company where "event" which creates "problem"

- Almost always using *some* IaaS services in any cloud architecture

    Explain that combining can be very powerful, setting up a secure subnet with firewalls and VPN connection, but then using PaaS offerings like Web Apps and Azure Sql inside the subnet, means giving you a dial you can turn blending power and ease of use however you want

    show scenario(s), simple suggestion: VPN Connection between web app and on-prem datacenter. VPN is web app is PaaS, VPN is IaaS

- Where you need more control or where an appropriate PaaS offering doesn't exist, some possible examples:

    Need a VM that runs a single seat of some desktop software

- Where you have a significant sunk cost investment in the skills or infrastructure to manage your VM's and Network.

## PaaS

Define/Explain

- PaaS provides ready-made environments for delivering your own services which run on the provided "platform"
- Each "Platform" that is offered as a service is necessarily very unique, but the commonalities is that OS, middleware, and server engines are abstracted away.

You work at company where "event" which creates "problem"
 
- Define some example services, make it clear they are examples, (feel free to use examples other than what is listed here): 
    Web App: If you want a "PHP web site", not only do you not need to create your VM, install a server, install PHP, etc. Instead you just run a command to "create a web app", you needed even care or know what OS it runs on, let alone what physical hardware. 
        From there just add a .php file (for instance via FTP) and you have a running website (maybe link out to a quickstart like this if we have one)

    Database: Azure supports a huge set options for databases, but Azure Sql is a common choice: With azure Sql you can create databases with a couple commands. You can then connect from your web apps, or SSMS, or any other way you use Sql Server, but you don't worry about Updates, or Security patches, or optimizing physical storage for Reads / Writes

    Functions
    ?

### Pros/Benefits/Use Cases



## SaaS

Define, point out it's more of a final product than a "cloud offering", iow: they've heard the acronym, we want to clarify it, but beyond that it's not really relevant 

You work at company where "event" which creates "problem"

### Pros/Benefits/Use Cases

Just software
- Office 365, Sharepoint, Outlook
- Anything any website does for you
- An example or two along the line of: If you create a X you are offering X as a service could get into what Multitenancy is and that software that is offered "as a service" is multi-tenant, but it's a hard thing to be pithy about and no need to spend a lot of time on this one

Grey Area, Optional, fun/interesting extra information
- CaaS - Azure Fabric, AKS, ACI sit in a middle ground between IaaS and Paas, this is coming to be known as CaaS or Containers As A Service.

