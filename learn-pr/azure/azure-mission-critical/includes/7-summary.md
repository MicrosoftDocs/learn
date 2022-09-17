Contoso Shoes is an online shoe store that wants to be highly available during an upcoming launch. They migrated their on-premises deployments to the cloud two years ago and have benefitted by adopting the OpEx model. In the last six months, they've experienced issues with availability and the operators aren't able to troubleshoot issues quickly. The organization now wants to invest in making the workload mission critical and focus on enhancing the overall reliability and observability of the system. 

In the previous architecture, the application was deployed in a single region and **wasn't able to withstand a regional outage**. Azure App Service and the external monitoring tools **didn't have a way to check the health status** of the application itself. This gap led to traffic being routed to unhealthy App Service instances resulting in failed requests. The team wasn't able to see the **cascading impact of an issue** resulting from an API component affecting its platform dependencies.

By completing this challenge, you've explored a mission critical design at a high level. You've applied your  experience by using the exercises to meet Contoso's needs: 

The improved design **detects the degraded performance of one or more components using a health model** that might lead to a full outage. The SRE team can now quickly identify and resolve issues. Now that the solution is **deployed in multiple regions in an active-active model**, it can withstand a complete regional outage while giving more system health insights to their operations. Contoso has also improved their customer experience by **serving clients faster in a region geographically closer to them**.

Congratulations on completing this Challenge Project and validating yours skills in applying the learnings to an example mission-critical solution.

## Learn more

For more information on architecting solutions on Azure, visit the [Azure Well-Architected Framework](/azure/architecture/framework) guide in the Azure Architecture Center.

Explore these reference architectures as a way to expand your design:

- [Mission-critical baseline architecture](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-intro)
- [Mission-critical baseline architecture with network controls](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-network-architecture)