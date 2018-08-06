# Understanding Azure solutions for public, private and hybrid cloud

You work at a healthcare company. You have legacy systems, LOB systems, and future plans for new systems. You see advantages to using cloud computing. How do you choose the best deployment model for different solutions public, private, hybrid cloud.

## What is cloud computing?

Cloud computing is the provisioning of services and applications on demand over the internet. Servers, applications, data, and other resources are provided as a service. 

To the user, the details of the services are abstracted. You can quickly provision computing resources and use the service with minimal managment. You shouldn't think of cloud computing as a data-center available through the internet. Cloud computing uses virtualization, commodity hardware, and automated processes to provide a self-service user experience to customers similar to a public utility. 

There are three deployment models for cloud computing: public, private, hybrid.

![Cloud deployment models](../media/2-cloud-deployment.png)

## Public cloud

Public clouds are the most common way of deploying cloud computing. Services are offered over the public Internet and available to anyone who wants to purchase them. The cloud resources such as servers and storage are owned and operated by a third-party cloud service provider and delivered over the Internet. Services may be free or sold on-demand, allowing customers to pay only per usage for the CPU cycles, storage, or bandwidth they consume. Microsoft Azure is an example of a public cloud. 

Let's think back to our healthcare company. You need a website. The site needs to scale and be responsive during peak enrollment various times during the year. Users are global. 

During development, developers want to create and destroy sandbox environments. Devs need VMs for sandboxed environment to develop a solution. can provision and depro

Another scenario, analyst needs SQL server database. Can request, provision themselves.

### Why public cloud?

 Public clouds can also be deployed faster than on-premises infrastructures and with an almost infinitely scalable platform. Every employee of a company can use the same application from any office or branch using their device of choice as long as they can access the Internet. While security concerns have been raised over public cloud environments, when implemented correctly, the public cloud can be as secure as the most effectively managed private cloud implementation if the provider uses proper security methods, such as intrusion detection and prevention systems (IDPS).

**On-demand service consumption through as needed or subscription**

Scale without needing accurate projections

**No upfront investment of hardware**

Public clouds can save companies from the expensive costs of having to purchase, manage, and maintain on-premises hardware and application infrastructure. The cloud service provider is held responsible for all management and maintenance of the system.
 
You only pay for the portion of CPU, storage, etc that you actually use (or, in some cases the portion that you reserve to use)

Staged migration. decommisioning old stuff
 
**Automation**

Can create test machines, etc as part of build/other scripts

**Sandbox testing**

**Geographic dispersity**

Can put data close to where it needs to be without having many of your own data-centers

?- Complete solutions available
?- born in cloud solution
?- Geo-Resiliency

## Private cloud

A private cloud consists of computing resources used exclusively by select users from one business or organization. The private cloud can be physically located at your organization’s on-site datacenter, or it can be hosted by a third-party service provider. Private cloud isn't old school on-prem datacenters. Completely leverages on-prem infrastructure and services. Runs some abstraction platform: could be 'cloud-like' like Kubernetes clusters or a full-fledged cloud environment like Azure Stack. The organization is reponsible for the purchase, configuration, and maintenance of the hardware. Communication between the systems is usually on network infrastructure the business owns and maintains. For example, a private internal network or provisioned - dedicated fiber optic connection between buildings.

You work at health x you need and have an application that is in use at one of the datacenters.  The operating environment can't be replicated in the public cloud.  Need to access data with database at another datacenter. Database needs to remain at the other site because of regulatory compliance.

Use a couple concrete examples, show diagrams for each:
- Optional: Include simple all on-prem
- Include all on prem, two data-centers connected via physical dedicated line
- Include VPN to hosting provider, but where there is a dedicated set of machines / sub-net owned by 

### Scenario:
- two datacenters
- VPN over the internet.  

### Scenario2:
- owned datacenter
- hosting provider
- dedicated link between datacenters

### Why private cloud?

**Pre-existing enviroment**
Leverage existing investment in hardware and employees with expertise. Usually used by very large orgs with enough computing resources to commoditize

**legacy apps**
Legacy applications that can't easily be physically relocated 

**Data sovereignty and security**
Political borders, legal requirements may dictate where data can physically exist.

**Regulatory compliance / certification**
PCI, HIPAA, etc. May have certified on-prem data-center, may not want to or be able to re-do that work

**Conservative risk profile**
?

## Hybrid cloud

A hybrid cloud is a computing environment that combines a public cloud and a private cloud by allowing data and applications to be shared between them. When computing and processing demand fluctuates, hybrid cloud computing gives businesses the ability to seamlessly scale their on-premises infrastructure up to the public cloud to handle any overflow - without giving third-party datacenters access to the entirety of their data. Organizations gain the flexibility and computing power of the public cloud for basic and non-sensitive computing tasks, while keeping business-critical applications and data on-premises, safely behind a company firewall.

Using a hybrid cloud not only allows companies to scale computing resources, it also eliminates the need to make massive capital expenditures to handle short-term spikes in demand as well as when the business needs to free up local resources for more sensitive data or applications. Companies will pay only for resources they temporarily use instead of having to purchase, program, and maintain additional resources and equipment that could remain idle over long periods of time. 

Integration generally through a secure VPN between cloud provider like Azure and on-prem datacenter

You work at healthcare x where customers info needs to be exposed. the data needs to remain at a physical location but the web site needs to be highly scalable because there are lots of users.

### Scenario 1:

- on-prem database cluster
- High availability but no redundancy
- Need availability in the case of an outage.
- Dedicated link to public cloud

### Scenario 2:

- Public cloud web app
- On-prem database
- DB has to be on-prem for regulatory requirement.
- VPN between on-prem and public cloud


### Why hybrid cloud

- Existing investment
- Regulation
- Public cloud can't replicate legacy operating environment

- Best of both worlds, components that must be / should be on-prem can be, everything else can take advantage of flexibility of public cloud
- Geo-resiliency for on-prem data-store

