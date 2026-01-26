SQL Server enabled by Azure Arc provides an integrated migration assessment experience that simplifies the process of evaluating your SQL Server instances for migration to Azure. This feature automatically generates assessments without requiring additional tools or downloads.

## What is SQL Server enabled by Azure Arc?

[SQL Server enabled by Azure Arc](/sql/sql-server/azure-arc/overview) extends Azure management capabilities to SQL Server instances hosted anywhere—on-premises, in your datacenter, at the edge, or in multicloud environments. Once connected to Azure Arc, your SQL Server instances gain access to Azure services, including automatic migration assessments.

The assessment feature provides:

- **Automatic readiness evaluation**: Identifies compatibility issues and migration blockers
- **Azure SQL recommendations**: Suggests the optimal Azure SQL deployment option (SQL Database, SQL Managed Instance, or SQL Server on Azure VM)
- **Right-sizing guidance**: Recommends appropriate service tiers and configurations
- **Cost estimation**: Provides monthly cost projections for running in Azure
- **Continuous monitoring**: Assessments can be refreshed as your environment changes

## Review prerequisites

Before you can assess SQL Server instances using Azure Arc, ensure you have:

- SQL Server 2012 or later installed on a Windows-based system
- Azure subscription with appropriate permissions
- Network connectivity to Azure services
- Azure Extension for SQL Server version 1.1.2594.118 or later

## Connect SQL Server to Azure Arc

To enable assessment capabilities, you first need to connect your SQL Server instances to Azure Arc.

### Automatic connection

We recommend using the automatic connection method for at-scale deployments:

- **Configure automatic connection**: Set up Azure Connected Machine agent with the SQL Server extension enabled
- **Deploy using your preferred method**:
  - [Group Policy](/sql/sql-server/azure-arc/automatically-connect#group-policy)
  - [Configuration Manager](/sql/sql-server/azure-arc/automatically-connect#configuration-manager)
  - [Azure Policy](/sql/sql-server/azure-arc/automatically-connect#azure-policy)
  - [PowerShell script](/sql/sql-server/azure-arc/automatically-connect#powershell)

## Access migration assessments

Once your SQL Server instance is connected to Azure Arc and the extension is installed, assessments are automatically generated.

To view assessment results:

1. In the Azure portal, navigate to your SQL Server enabled by Azure Arc resource
2. In the left navigation menu, under **Migration**, select **Assessments**
3. Review the assessment dashboard, which displays:
   - **Migration readiness**: Overall readiness status for migration to Azure
   - **Recommended target**: Suggested Azure SQL deployment option
   - **Compatibility issues**: List of blockers and warnings
   - **Feature parity**: Comparison of feature availability across Azure SQL targets
   - **Cost estimation**: Projected monthly costs for recommended configuration

:::image type="content" source="../media/4-arc-assessment-overview.png" alt-text="Screenshot of SQL Server enabled by Azure Arc migration assessment overview page." lightbox="../media/4-arc-assessment-overview.png":::

## Understanding assessment results

The assessment provides detailed information organized into several categories:

- **Ready**: No blockers identified; migration can proceed
- **Ready with conditions**: Minor issues that can be addressed post-migration
- **Not ready**: Critical blockers that must be resolved before migration

### Review compatibility issues

The assessment identifies issues in two categories:

- **Migration blockers**: Features or configurations not supported in the target Azure SQL platform that must be resolved before migration
- **Warnings**: Features that work differently or have limitations in Azure SQL

For each issue, the assessment provides:

- Description of the incompatibility
- Affected database objects
- Recommended remediation steps
- Documentation links for more information

### Azure SQL deployment recommendations

Based on your SQL Server configuration and workload characteristics, the assessment recommends one of three Azure SQL deployment options:

- **Azure SQL Database**: For most modern cloud applications
- **Azure SQL Managed Instance**: For near 100% SQL Server compatibility
- **SQL Server on Azure Virtual Machines**: For maximum compatibility and OS-level access

### Right-sizing and cost estimation

The assessment provides:

- **Recommended service tier**: Based on your workload requirements
- **Compute recommendations**: vCores or DTUs needed
- **Storage recommendations**: Database and log storage requirements
- **Monthly cost estimate**: Projected costs for the recommended configuration

> [!NOTE]
> Cost estimates are based on list prices and may vary based on your specific Azure agreement, region, and reserved capacity purchases.

## Implement best practices

When using SQL Server enabled by Azure Arc for migration assessment:

- **Enable automatic connection**: Use Azure Policy or Group Policy to automatically onboard SQL Server instances at scale
- **Regular assessment refreshes**: Schedule periodic assessment refreshes to track changes
- **Address blockers early**: Review and resolve migration blockers before planning migration timelines
- **Compare targets**: Evaluate assessment results for all three Azure SQL deployment options to choose the best fit
- **Verify pricing**: Use the Azure Pricing Calculator to verify cost estimates based on your specific Azure agreement
- **Plan remediation**: Create a remediation plan for identified issues before migrating
- **Test in non-production**: Validate the assessment process in development or test environments first

## Next steps

After completing your assessment with SQL Server enabled by Azure Arc:

- Review and remediate any identified compatibility issues
- Compare recommendations across different Azure SQL deployment options
- Validate cost estimates and obtain budget approval
- Plan your migration approach based on assessment insights
- Proceed with migration using [Azure Database Migration Service](/azure/dms/dms-overview) or other migration tools

For complete automation scenarios, refer to the [Azure Arc for SQL Server documentation](/sql/sql-server/azure-arc/overview).