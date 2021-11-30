**Puppet** is a deployment and configuration management toolset that provides you with enterprise tools that you need to automate an entire lifecycle on your Azure infrastructure. It also provides consistency and transparency into infrastructure changes.

Puppet provides a series of open-source configuration management tools and projects. It also provides Puppet Enterprise, a configuration management platform that allows you to maintain state in both your infrastructure and application deployments.

## Puppet architectural components

Puppet operates using a client-server model and consists of the following core components:

 -  Puppet Master. The **Puppet Master** is responsible for compiling code to create agent catalogs. It's also where Secure Sockets Layer (SSL) certificates are verified and signed. Puppet Enterprise infrastructure components are installed on a single node, the master. The master always contains a compile master and a Puppet Server. As your installation grows, you can add extra compile masters to distribute the catalog compilation workload.
 -  Puppet Agent. **Puppet Agent** is the machine (or machines) managed by the Puppet Master. An agent that is installed on those managed machines allows them to be managed by the Puppet Agent.
 -  Console Services. **Console Services** is the web-based user interface for managing your systems.
 -  Facts. **Facts** are metadata related to the state. Puppet will query a node and determine a series of facts, which it then uses to determine the state.
