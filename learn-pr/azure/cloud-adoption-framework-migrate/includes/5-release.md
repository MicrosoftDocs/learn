In this phase, you [release your workload](/azure/cloud-adoption-framework/migrate/release/) to production. 

:::image type="content" source="../media/migrate-release.svg" alt-text="Diagram that shows the steps of the Migrate methodology." border="false":::

You deployed your resources to Azure. Now you need to complete the migration steps, communicate the upcoming changes to other teams, make final change approvals, clean up resources, and do a retrospective.

## Communicate changes

[Inform your organization](/azure/cloud-adoption-framework/migrate/release/change-communication) about upcoming changes to ensure that everyone that the migration might affect knows the process. Communicate changes for each workload because each one has [dedicated users and operators](/azure/cloud-adoption-framework/migrate/release/change-communication#audience-for-change-communication).

You should answer the following questions in your [change communication](/azure/cloud-adoption-framework/migrate/release/change-communication#change-communication-content):

- What are the critical dates for the migration?

- Whose work is disrupted, when is it disrupted, and for how long?
- What work should each role complete before the change in order to be ready?
- What work should each role complete after the change to confirm functionality?
- Who should individuals reach out to if they have questions or challenges?

## Perform business testing

Business users of your workload should [test your new solution](/azure/cloud-adoption-framework/migrate/release/business-test). Your [migration team](/azure/cloud-adoption-framework/migrate/release/business-test#migration-team-activities-during-business-testing) can facilitate workload testing, develop testing plans, and automate testing.

To test your workload, [identify users](/azure/cloud-adoption-framework/migrate/release/business-test#business-activities-during-business-testing) that your changes might affect most. Inform those users of your business objectives, desired outcomes, and expected changes to business processes. Get feedback from the users, and ensure that the IT staff understand the feedback and prioritize it based on its impact. If the feedback requires changes to the workload, communicate the changes to all necessary teams.

During the feedback stage, the migration team collects feedback and manages the resultant technical actions. Create a [testing plan](/azure/cloud-adoption-framework/migrate/release/business-test#example-testing-plan) to track the feedback and action steps.

## Complete the migration

After you promote your asset and all of its dependencies to production, you can reroute production traffic. Then the on-premises assets are obsolete, and you can decommission them.

You must perform [various tasks](/azure/cloud-adoption-framework/migrate/release/complete-migration#migration-window-playbook) depending on your workload architecture.

- Send communication to inform parties that you began the promotion.

- Verify that all staged resources are functioning properly.
- Do replication for recent data.
- Hydrate resources after you do replication. Stage any other components, like load balancing rules.
- Turn off source servers so that they don't interfere with your migration.
- Do isolated testing.
- Update your networking components so that users can access your application's new location.
- Do promotion testing again to confirm that your workload works as expected.
- Get final approval from stakeholders.
- Communicate to the necessary parties that the promotion was successful.

## Optimize cost after migration

After your migration, [optimize your workload](/azure/cloud-adoption-framework/migrate/release/optimize-cost-after-migration) based on its live data, and decommission retired assets.

When you shut down and [decommission assets](/azure/cloud-adoption-framework/migrate/release/optimize-cost-after-migration#decommission-retired-assets):

- **Continue monitoring**: [Monitor assets](/azure/cloud-adoption-framework/migrate/release/optimize-cost-after-migration#continue-monitoring) that are scheduled for retirement to ensure that production traffic is correctly routed. Disabled assets can still use storage, network, and other infrastructure resources. If you turn them back on, unexpected problems can occur. Monitor for activity to ensure that assets are no longer in use.

- **Establish testing and outage windows**: Identify an inactive [testing window](/azure/cloud-adoption-framework/migrate/release/optimize-cost-after-migration#testing-windows-and-dependency-validation) to perform test cases that match real activities that users perform. During this window, you can also disable assets that you flag for decommission. Schedule the maintenance window, and inform users of your plan.
- **Consider a holding period**: [Keep a retired asset](/azure/cloud-adoption-framework/migrate/release/optimize-cost-after-migration#holding-period-and-data-validation) for at least 30 days to serve as a temporary backup of data in case you miss any data during replication. Your organization's data governance team might have other requirements that necessitate a holding period that's more than 30 days.

## Conduct a retrospective

Do a [retrospective](/azure/cloud-adoption-framework/migrate/release/retrospective) after your migration to discover what went well, what could have been better, and what you learned. Get insight from each member of your team so that you can apply the [lessons](/azure/cloud-adoption-framework/migrate/release/retrospective#lessons-learned) that you learned to future migrations. Identify a team member to [organize](/azure/cloud-adoption-framework/migrate/release/retrospective#example-retrospective-output) the process. And choose a method to track and organize the ideas that you gather.