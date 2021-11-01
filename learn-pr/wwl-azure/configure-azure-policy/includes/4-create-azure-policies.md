:::image type="content" source="../media/implement-azure-policy-b4a4a47c.png" alt-text="Diagram of implementing Azure policies. From left to right shows creating an Initiative Definition to group policy definitions which are then applied against resources for compliance purposes.":::


To implement Azure Policies, you can follow these steps.

1.  **Browse Policy Definitions**. A Policy Definition expresses what to evaluate and what actions to take. Every policy definition has conditions under which it is enforced. And, it has an accompanying effect that takes place if the conditions are met. For example, you could prevent VMs from being deployed if they are exposed to a public IP address.
2.  **Create Initiative Definitions**. An initiative definition is a set of Policy Definitions to help track your compliance state for a larger goal. For example, ensuring a branch office is compliant.
3.  **Scope the Initiative Definition**. You can limit the scope of the Initiative Definition to Management Groups, Subscriptions, or Resource Groups.
4.  **View Policy Evaluation results**. Once an Initiative Definition is assigned, you can evaluate the state of compliance for all your resources. Individual resources, resource groups, and subscriptions within a scope can be exempted from having policy rules affect it. Exclusions are handled individually for each assignment.

> [!NOTE]
> Even if you have only a few Policy Definitions, we recommend creating an Initiative Definition.
