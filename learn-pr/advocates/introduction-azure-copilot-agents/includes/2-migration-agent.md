The [Azure Catalyst agent](/azure/migrate/azure-copilot-migration-agent?view=migrate&preserve-view=true) helps you use project data to decide what to move to Azure, which target fits, and which workloads should move together. Azure Catalyst is the [new name for Azure Migrate](/azure/migrate/whats-new?view=migrate&preserve-view=true#update-november-2026); you can keep using an existing project without recreating it.

## Start with a project and inventory

Open **Azure Copilot > New chat > Catalyst agent** and select your team's project. For planning, the [Azure Migrate Decide and Plan Expert role](/azure/migrate/prepare-azure-accounts?view=migrate&preserve-view=true#operations-allowed-per-user-role) at the project's resource group or subscription lets you import inventory and create assessments, but not create projects or execute migrations. If you need a new project, ask someone with [Azure Migrate Owner or higher permissions](/azure/migrate/quickstart-create-project?view=migrate&preserve-view=true#verify-permissions) at that scope to create it. The role names in Azure IAM still use *Azure Migrate*.

Opening chat doesn't discover servers or collect utilization data. VMware is the documented guided scenario; the agent can also help with migration tasks for Hyper-V and physical servers already discovered in the project. See [supported resource types](/azure/copilot/migration-agent#supported-resource-types).

Suppose an order-processing app runs on VMware. Choose the discovery method that fits the decision you need to make:

- **For initial inventory**, use the [RVTools import (preview)](/azure/migrate/tutorial-import-vmware-using-rvtools-xlsx?view=migrate&preserve-view=true) for a configuration snapshot. You don't need an appliance, but the export doesn't show demand over time. Microsoft doesn't own or support RVTools. If you need to install it, use the vendor's official distribution, verify the installer against its published hash, and scan it before running it.

  Before uploading the VMware export, confirm that you're in the intended project and have permission to share this inventory with it. The [RVTools importer](/azure/migrate/tutorial-import-vmware-using-rvtools-xlsx?view=migrate&preserve-view=true#prerequisites) requires fewer than 20,000 servers per `.xlsx` file and supports **General** sensitivity or **Any user** file protection. If the file or its classification isn't eligible, agree on an approved discovery method with the data owner instead. Don't remove protection or lower the label to import the file.

  If the export is eligible and approved, upload it in the project chat and ask, “Import this RVTools file.” Check that the expected servers appear in the project inventory. Discovery and assessment can show one disk for an imported VM that has several because the importer uses total configured and used storage. Use those totals for initial planning. Verify the individual disks with the VMware owner before choosing the target layout.

- **For performance-based sizing**, generate a project key. If key generation fails and your planning role is scoped to the resource group, ask the subscription owner to check the [required resource provider registrations](/azure/migrate/prepare-azure-accounts?view=migrate&preserve-view=true#guidance-for-role-assignments-at-the-resource-group-scope). Have the appliance administrator deploy the VMware discovery appliance and register it with the key using your approved identity method. [User-based registration](/azure/migrate/prepare-azure-accounts?view=migrate&preserve-view=true#operations-allowed-per-user-role) requires the Microsoft Entra **Application Developer** role. [Arc-based registration](/azure/migrate/how-to-register-appliance-using-arc-agent?view=migrate&preserve-view=true) has different prerequisites and doesn't support Private Link.

  The vCenter discovery credentials are separate from the identity used to register the appliance in Azure. Enter those credentials in the appliance configuration manager, not in chat. Add the vCenter source, map the authorized credentials, validate connectivity, and select [**Start discovery**](/azure/migrate/tutorial-discover-vmware?view=migrate&preserve-view=true#start-continuous-discovery). Verify that the expected servers appear and wait for data covering representative demand, such as the month-end order peak, before using it to size the workload.

## Assess VM readiness and sizing

Ask “Summarize my discovered workloads,” then request a readiness assessment for the app's servers. Compare rehosting on Azure VMs with moving to Azure VMware Solution. Before using a recommended VM size, check the [readiness result in the Azure VM assessment](/azure/migrate/assessment-report?view=migrate&preserve-view=true#understanding-azure-readiness):

- **Readiness unknown:** Identify the missing metadata, correct discovery where possible, and reassess.
- **Conditionally ready for Azure:** Check the stated support condition and what you need to do to meet it.
- **Not ready for Azure:** Resolve the reported blocker or choose another supported target.
- **Ready for Azure:** The server meets the assessed requirements for this target. That doesn't mean the app has passed a test migration.

Review sizing and cost estimates against the data you supplied.

For appliance-discovered servers, open the performance-based **Azure VM assessment**. In the [assessment settings](/azure/migrate/assessment-properties?view=migrate&preserve-view=true#assessment-settings), check whether **Performance history** includes the month-end order peak and which **Percentile utilization** was used for sizing. Check [performance coverage](/azure/migrate/assessment-report?view=migrate&preserve-view=true#performance-coverage-performance-based) for missing samples. Even full coverage of a quiet week doesn't represent the peak. If the peak was collected but falls outside the assessment window, adjust the window and recalculate. If key samples are missing, fix collection or wait for representative data, then recalculate before accepting the VM size.

**Business-case and return-on-investment analysis is in preview**: check assumptions such as the on-premises costs and expected Azure usage before treating projected savings as a reason to move. See the [VMware planning and assessment walkthrough](/azure/migrate/how-to-plan-analyze-migration-with-agent?view=migrate&preserve-view=true).

## Decide what to modernize

An RVTools-only project can help you plan a move to VMs, but it doesn't discover the databases or web apps inside them. To evaluate the order-processing app's individual tiers, use a project that has [discovered those workloads](/azure/migrate/discovery-methods-modes?view=migrate&preserve-view=true#choose-a-discovery-method). On the VMware appliance path, configure software inventory and supply the appropriate guest and SQL discovery credentials in the appliance.

- **SQL Server:** Run an [Azure SQL assessment](/azure/migrate/tutorial-assess-sql?view=migrate&preserve-view=true). In the [readiness report](/azure/migrate/review-sql-assessment?view=migrate&preserve-view=true#sql-server-migration-scenarios), compare individual databases with Azure SQL Database, and instances with Azure SQL Managed Instance or SQL Server on an Azure VM. Ask about blockers, sizing and estimated cost for the chosen target. Without SQL Server credentials, a VM size recommendation isn't evidence that a database is compatible with a platform as a service (PaaS) target. Use the migration service for the chosen source and target to move the data.
- **ASP.NET or Java web app:** Select the discovered web app and choose [**Add code insights**](/azure/migrate/add-copilot-code-insights?view=migrate&preserve-view=true). For example, have a developer generate a compatible GitHub Copilot modernization scan report, upload the report ZIP (not the source repository), and map the report to the web app. If its assessment is marked outdated, select **Recalculate** before asking which findings affect App Service readiness. Code insights aren't supported through private endpoints. Developers use [GitHub Copilot modernization](/azure/developer/github-copilot-app-modernization/overview) to make and test code changes; Catalyst doesn't refactor or deploy the app in this workflow.

## Prepare the target and move a wave

If you need a shared Azure foundation, give the agent your governance, identity, region, and networking requirements. It can generate a [platform landing zone design and Terraform package](/azure/migrate/platform-landing-zone?view=migrate&preserve-view=true). The package describes the platform, not the order-processing app or its database. Have the platform team review and deploy it separately before relying on that environment.

Wave planning and execution are in preview. Once the workload assessment is complete, open [**Plan > Wave plan**](/azure/migrate/how-to-configure-wave-plan?view=migrate&preserve-view=true) in the project. Select the assessment and migration path. Ask the agent why it grouped the workloads, then check the proposed sequence with their owners: can the order API still reach the database while each tier moves? Adjust the groups and commit the waves you accept. Committing a wave doesn't start replication or authorize cutover.

As the planner, hand the committed wave to an operator with **Azure Migrate Owner** or **Azure Migrate Execute Expert** on the project. The operator [configures the wave's migration methods and step inputs](/azure/migrate/configure-customize-wave?view=migrate&preserve-view=true#prerequisites) and handles approval steps during execution.

For a [wave created on or after November 11, 2026](/azure/migrate/migration-execution-overview?view=migrate&preserve-view=true), Catalyst generates an execution plan. A wave committed from your wave plan already has target services and migration methods. Review them and complete any missing step inputs. For a manually created wave, supply a target and method for each workload before expecting a plan. Earlier waves use the classic task workflow; servers can also migrate directly without a wave.

Open the new wave under **Execute > Waves** and review its **Execution plan**. Finalize the workloads, targets, and methods before customizing it. Changing any of them after generation makes the plan out of date. [Regenerating the plan](/azure/migrate/configure-customize-wave?view=migrate&preserve-view=true#regenerate-the-execution-plan) replaces custom steps, dependencies, and inputs. Record what you need to keep, then reapply and review those changes before starting.

For the VMware VM, identify which steps in the plan handle the test, test cleanup, and production migration. Check their workload scope and [**Depends on** settings](/azure/migrate/configure-customize-wave?view=migrate&preserve-view=true#add-steps-if-needed). Wave-managed cleanup must wait for test acceptance, and production migration must wait for a separate cutover approval. If a required approval is missing, have the wave operator add it. Before starting the wave, make sure each action depends on its approval; an approval alone doesn't block an independent step.

Check the [migration methods the wave can run](/azure/migrate/wave-migrations-overview?view=migrate&preserve-view=true#supported-migrations). For example, it can move a VMware VM to an Azure VM using agentless migration, or migrate a SQL Server database offline to Azure SQL Managed Instance using Azure Database Migration Service.

An App Service readiness assessment doesn't automate a web app move. At the initial manual step, the wave operator acknowledges that the app will move outside Catalyst, not that it has moved. The application team performs and validates the move. Only then does the authorized wave operator record completion at the approval step in the app's step group.

You can stop at the reviewed plan. An RVTools-only inventory supports planning, but you can't replicate a VM from its imported record. Before proceeding with VMware agentless migration, have the appliance administrator check the [vSphere requirements for replication](/azure/migrate/migrate-support-matrix-vmware-migration?view=migrate&preserve-view=true#vmware-vsphere-requirements-agentless):

- Verify that a VMware appliance registered with this project discovered the source VM.
- On that appliance, verify that **Configure the appliance for migration** is enabled and that the installed VMware Virtual Disk Development Kit (VDDK) is compatible with your vCenter version.
- Confirm that the appliance's vCenter account has the required replication privileges. Read access for discovery alone isn't enough.

Before execution, check the Azure permissions for the operator and the project managed identity separately:

- An operator who directly runs VMware agentless replication, test migration, or cutover needs [**Azure Migrate Owner** or **Azure Migrate Execute Expert**](/azure/migrate/concepts-vmware-agentless-migration?view=migrate&preserve-view=true#required-permissions) on the source project's resource group and on the target resource group if it differs. Assignments on the enclosing subscriptions also apply.
- Ask an administrator to verify the [project managed identity's role assignments](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#prerequisites). It needs both **Azure Migrate Execute Expert** and **Contributor** on the Catalyst resource group and on every target subscription the wave uses.

> [!NOTE]
> A wave execution has a [90-day overall limit](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#pause-and-resume-the-wave-if-needed), including pauses and time waiting for approvals. This is not an inactivity timer: pausing or resuming doesn't reset the window. Before starting, allow for approval delays and business holds. During a hold, check the run's elapsed time and plan the remaining work within that window. Don't approve an unready workload just to avoid the timeout.

Before the first run, finish setup if the wave status is **Pending configuration** and verify that it reaches **Not Started**. Start only in the approved migration window and after predecessor waves have reached the agreed state. A [wave dependency warning](/azure/migrate/configure-customize-wave?view=migrate&preserve-view=true) doesn't block an out-of-order start. Confirming [**Start execution**](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#start-the-run) starts the **whole wave**.

If the [wave shows **Needs action**](/azure/migrate/reference-wave-migrations?view=migrate&preserve-view=true#wave-execution-status), the wave operator checks **Execution runs**. For a step that needs attention, open **Step details** and check its status and type:

- **Needs action (approval):** At an [approval step](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#approve-ready-workloads-at-approval-steps), all ready workloads are selected by default. Select only the intended batch, then select **Approve**. Withholding approval holds dependent work; independent workloads can continue.
- **Needs action (manual work):** Read the [manual step description](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#complete-manual-work-when-requested). If it asks for an acknowledgement, confirm what it describes. If it calls for work outside Catalyst, finish that work first. Then select **Mark as complete > Complete**.
- **Failed** or **Partially succeeded**: Review **Errors** and **Workloads** and fix the cause. For a recoverable step in an active run that isn't paused, select [**Retry step**](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#retry-failed-work). A workload-scoped retry includes all failed workloads in the step and none that succeeded. A step that isn't workload-scoped retries as a whole job.

For a pause or cancellation, use the run status rather than the step status:

- **Paused run:** When authorized to continue, select **Resume execution**. This resumes scheduling in the same run.
- **Canceled run:** You can't resume it. Inspect operations in the underlying migration tool and verify the actual state of each affected workload. Review the execution plan with the workload owners and update it as needed. Start a [new run](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#cancel-and-start-a-new-run-if-needed) only if that review supports it. It starts from the beginning; it doesn't undo completed work.

[Pausing or canceling a wave](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#pause-and-resume-the-wave-if-needed) stops Catalyst from scheduling new work. Neither action rolls back a cutover or immediately stops a migration operation already running. If replication or cutover must stop immediately, have the migration operator check the underlying tool, use its supported controls, and verify what actually stopped.

### Test and cut over the VMware VM

:::image type="content" source="../media/migration-gate.svg" alt-text="Diagram that shows an isolated VMware test, source shutdown before cutover approval, and order validation before switching traffic.":::

Once initial replication finishes and delta sync begins, [test the VMware VM on an approved, isolated Azure virtual network](/azure/migrate/tutorial-migrate-vmware?view=migrate&preserve-view=true#track-and-migrate-replicating-servers). If the wave runs the test, use its test step rather than starting another test directly. Leave the production source running: it keeps serving orders and delta replication continues.

Have the application owner validate the isolated copy and confirm acceptance to the wave operator. If the wave manages test cleanup, the wave operator then releases cleanup for this VM and verifies the result in the run. Cutover approval stays on hold. Use [**Clean up test migration**](/azure/migrate/execute-server-migrations?view=migrate&preserve-view=true#track-and-migrate-replicating-servers) directly only if cleanup is outstanding, the wave isn't managing it, and the operator has direct migration permissions.

Before anyone stops taking orders for the production cutover, have the migration operator open [**Manage > Server replication**](/azure/migrate/execute-server-migrations?view=migrate&preserve-view=true#track-and-migrate-replicating-servers) for the intended VMware VM. Review replication health and the last sync, and confirm the VM shows **Ready to migrate**. With the appliance administrator, check that the planned start falls outside any [replication blackout window](/azure/migrate/concepts-vmware-agentless-migration?view=migrate&preserve-view=true#blackout-window) in the appliance's local time. If migration starts during a blackout, the final sync won't run. If any check fails, withhold cutover approval and reschedule while the source is still serving orders.

Once those checks pass, follow the [VMware agentless replication process](/azure/migrate/concepts-vmware-agentless-migration?view=migrate&preserve-view=true#replication-process):

1. Have the app and database owners stop accepting orders, let in-flight writes finish, and record the IDs of the last accepted orders.
2. After the owners confirm that writes have drained, keep cutover approval on hold while the authorized VMware operator shuts down the intended source VM and verifies that it's off. Only then does the wave operator approve production migration for that VM. Don't start a second migration from **Server replication**.
3. Wait for the final delta sync to finish and confirm that the migration job succeeded. Then have the database owner look up the recorded order IDs in the target database. If the sync or migration fails, or any order is missing, keep traffic off the target and consult the recovery owner.
4. Only after both checks pass and the switch is approved, redirect traffic to Azure. Submit a new test order through the app and verify that it saves to the target database and can be read back. The agent can explain the job status, but it can't verify that order for you.

After the owners accept the production VM, have the operator check the server's replication record and, for a wave-managed move, the wave's execution plan. If the wave handles cleanup, verify its result rather than repeating it. If cleanup is outstanding and no wave is handling it, an operator with direct migration permissions can select the migrated server under [**Manage > Server replication**](/azure/migrate/execute-server-migrations?view=migrate&preserve-view=true#track-and-migrate-replicating-servers) and choose **Complete migration**. This removes the [intermediate replication disks](/azure/migrate/common-questions-server-migration?view=migrate&preserve-view=true#what-happens-if-i-dont-select-complete-migration-after-a-migration), which can incur charges until cleanup. Disks attached to the migrated VM stay in place.

For a wave, the wave operator finishes outstanding steps and resolves failures before [final sign-off](/azure/migrate/execute-wave-migration?view=migrate&preserve-view=true#complete-finalization-and-sign-off). At the sign-off step, select **Mark as complete > Complete**, then confirm the wave shows **Completed**. Successful completion permanently locks its workloads and execution plan; you can't run that wave again.
