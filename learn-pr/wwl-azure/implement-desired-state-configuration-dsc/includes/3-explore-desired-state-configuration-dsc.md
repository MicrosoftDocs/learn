**Desired State Configuration** (DSC) is a configuration management approach that you can use for configuration, deployment, and management of systems to ensure that an environment is maintained in a state that you specify (*defined state*) and doesn't deviate from that state.

DSC helps eliminate configuration drift and ensures the state is maintained for compliance, security, and performance.

Windows PowerShell DSC is a management platform in PowerShell that provides desired State.

PowerShell DSC lets you manage, deploy, and enforce configurations for physical or virtual machines, including Windows and Linux.

For more information, visit [Windows PowerShell Desired State Configuration Overview](/powershell/dsc/overview).

## DSC components

DSC consists of three primary parts:

 -  Configurations. These are declarative PowerShell scripts that define and configure instances of resources. Upon running the configuration, DSC (and the resources being called by the configuration) will apply the configuration, ensuring that the system exists in the state laid out by the configuration. DSC configurations are also *idempotent*: The Local Configuration Manager (LCM) will ensure that machines are configured in whatever state the configuration declares.
 -  Resources. They contain the code that puts and keeps the target of a configuration in the specified state. Resources are in PowerShell modules and can be written to a model as generic as a file or a Windows process or as specific as a Microsoft Internet Information Services (IIS) server or a VM running in Azure.
 -  Local Configuration Manager (LCM). The LCM runs on the nodes or machines you wish to configure. It's the engine by which DSC facilitates the interaction between resources and configurations. The LCM regularly polls the system using the control flow implemented by resources to maintain the state defined by a configuration. If the system is out of state, the LCM calls the code in resources to apply the configuration according to specified.

There are two methods of implementing DSC:

 -  Push mode - A user actively applies a configuration to a target node and pushes out the configuration.
 -  Pull mode is where pull clients are automatically configured to get their desired state configurations from a remote pull service. This remote pull service is provided by a *pull server* that acts as central control and manager for the configurations, ensures that nodes conform to the desired state, and reports on their compliance status. The pull server can be set up as an SMB-based pull server or an HTTPS-based server. HTTPS-based pull-server uses the Open Data Protocol (OData) with the OData Web service to communicate using REST APIs. It's the model we're most interested in, as it can be centrally managed and controlled. The following diagram provides an outline of the workflow of DSC pull mode.

:::image type="content" source="../media/dsc2-6e218006.png" alt-text="Diagram showing three Pull Clients. Pull Client 1, 2, and 3 are on the left. Each Pull Client has a box labeled Apply Configuration, and LCM. Arrows labeled Get Configuration point from each pull client to a Pull Server on the right. The Pull server has four boxes DSC OData Endpoint, IIS Service, Configurations, and Resources. Arrows labeled Send Configuration point left from the Pull Server back to the three Pull Clients.":::
