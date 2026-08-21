Building enterprise AI infrastructure requires balancing consistent governance with development-team autonomy. Microsoft Foundry separates resource-level management from project-level development. The top-level Foundry resource scopes networking, security, model deployments, and connections, while projects organize use-case assets and provide narrower access boundaries.

Connected Azure services remain separate governance boundaries. A project connection identifies the external resource and authentication method, while explicit role assignments and network controls authorize access. When multiple projects use one Azure AI Search service, create and authorize the required connections and plan for shared capacity, operations, and data-access controls.

## Next steps to advance your skills

Now that you understand Foundry resources, projects, roles, and connections, explore advanced networking configurations for production workloads. Evaluate private endpoints, DNS, and firewall requirements for both the Foundry resource and each connected Azure service.


- **Strengthen governance and security** by applying supported Azure Policy definitions for controls such as allowed regions, public network access, and diagnostic settings.

- **Manage and monitor AI costs** using Microsoft Cost Management budgets and alerts to track spending trends and notify stakeholders when usage exceeds defined thresholds.

- **Enable secure AI workloads** by connecting approved Azure services to Foundry projects and granting workload identities only the required permissions.


## Additional resources

- [Microsoft Foundry architecture](/azure/foundry/concepts/architecture)
- [Role-based access control for Microsoft Foundry](/azure/foundry/concepts/rbac-foundry)
- [Configure a private link for Microsoft Foundry](/azure/foundry/how-to/configure-private-link)
- [Microsoft Cost Management](/azure/cost-management-billing/costs/quick-acm-cost-analysis)
