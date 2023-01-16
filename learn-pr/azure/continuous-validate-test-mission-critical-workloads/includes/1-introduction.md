Azure mission-critical design methodology requires *continuous validation* to make sure the workload stays operational, even when failures and unexpected situations happen. It involves testing changes and releases regularly in a controlled environment. Such tests can include sustained user load and injecting faults. The goal is to test the workload's resiliency and its ability to handle faults before deploying to production.

Continuous validation is implemented as a set of processes and tools. It's integrated into a pipeline or workflow to enable developers and operations teams to run the validation regularly. For example, you can run continuous validation before every release or major code change. 

As part of continuous validation, you'll do these tasks:

- Run tests under production-like conditions.
- Define tests based on user and system flows, and their expected performance.
- Establish baselines for various scenarios and stages.
- Evaluate and adjust baselines and thresholds regularly.
- Implement Azure services in automated pipelines.

Microsoft Azure provides these services to implement load testing and chaos engineering:

- [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) is a managed service for generating synthetic, real-world traffic to test the application and underlying infrastructure and services.
- [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that provides chaos engineering capabilities to systematically inject failures into key components of the application.

You can run these two services simultaneously by embedding them in an Azure DevOps continuous integration and continuous delivery (CI/CD) pipeline. Doing so can help you validate the impact of application changes under realistic conditions at any time in the development cycle.

## Example scenario

This module incorporates continuous validation to the existing example introduced as part of the learning path. We recommend that you familiarize yourself with the example, especially these aspects.

- [About the example](/training/modules/azure-mission-critical/1-introduction#example-scenario)
- [Architecture](/training/modules/design-health-model-mission-critical-workload/3-exercise-layered-model#example-architecture)

