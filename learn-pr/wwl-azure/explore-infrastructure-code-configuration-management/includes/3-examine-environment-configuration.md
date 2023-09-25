**Configuration management** refers to automated configuration management, typically in version-controlled scripts, for an application and all the environments needed to support it.

Configuration management means lighter-weight, executable configurations that allow us to have configuration and environments as code.

For example, adding a new port to a Firewall could be done by editing a text file and running the release pipeline, not by remoting into the environment and manually adding the port.

> [!NOTE]
> The term *configuration as code* can also be used to mean configuration management. However, it isn't used as widely, and in some cases, infrastructure as code is used to describe both provisioning and configuring machines. The term *infrastructure as code* is also sometimes used to include *configuration as code*, but not vice versa.

## Manual configuration versus configuration as code

Manually managing the configuration of a single application and environment can be challenging.

The challenges are even more significant for managing multiple applications and environments across multiple servers.

Automated configuration, or treating configuration as code, can help with some of the manual configuration difficulties.

The following table lists the significant differences between manual configuration and configuration as code.

| **Manual configuration**                                              | **Configuration as code**                                               |
| --------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Configuration bugs are challenging to identify.                       | Bugs are easily reproducible.                                           |
| Error-prone.                                                          | Consistent configuration.                                               |
| More verification steps and more elaborate manual processes.          | Increase deployment cadence to reduce the amount of incremental change. |
| Increased documentation.                                              | Treat environment and configuration as executable documentation.        |
| Deployment on weekends to allow time to recover from errors.          |                                                                         |
| Slower release cadence to minimize the requirement for long weekends. |                                                                         |

## Benefits of configuration management

The following list is benefits of configuration management:

 -  Bugs are more easily reproduced, audit help, and improve traceability.
 -  Provides consistency across environments such as dev, test, and release.
 -  It increased deployment cadence.
 -  Less documentation is needed and needs to be maintained as all configuration is available in scripts.
 -  Enables automated scale-up and scale out.
 -  Allows version-controlled configuration.
 -  Helps detect and correct configuration drift.
 -  Provides code-review and unit-testing capabilities to help manage infrastructure changes.
 -  Treats infrastructure as a flexible resource.
 -  Promotes automation.
