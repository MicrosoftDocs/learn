TODO: Intro paragraph

TODO: Update image

:::image type="content" source="../media/8-migrate-bicep.png" alt-text="Diagram of the recommended workflow for migrating Azure resources to Bicep." border="false":::

## Convert phase

In the _convert_ phase of migrating your resources to Bicep, the goal is to capture an initial representation of your Azure resources. The Bicep file you create in this phase isn't complete, and it's not ready to be used. However, the file gives you a starting point for your migration.

The convert phase consists of two steps:

1. Capture a JSON representation of your Azure resources.
1. Convert the JSON representation to Bicep using the _decompile_ command.

## Migrate phase

In the _migrate_ phase of migrating your resources to Bicep, the goal is to create the first draft of your deployable Bicep file, and to ensure it defines all of the Azure resources that are in scope for the migration.

The migrate phase consists of four steps:

1. Create a new empty Bicep file.
1. Copy each resource from your decompiled template.
1. Identify and recreate any missing resources.
1. Add parameters to make your Bicep file reusable.

## Refactor Phase

TODO: Intro paragraph

The deploy phase consists of eight steps:

1. Review resource API versions
1. Review the linter suggestions in your new Bicep file
1. Revise parameters, variables, and symbolic names
1. Simplify expressions
1. Review child and extension resources
1. Modularize
1. Add comments
1. Follow Bicep best practices

## Test phase

In the _test_ phase of migrating your resources to Bicep, the goal is to verify the integrity of your migrated templates and to perform a test deployment.

The test phase consists of two steps:

1. Run the ARM template deployment what-if operation.
1. Perform a test deployment.

## Deploy phase

TODO: Intro paragraph

The deploy phase consists of four steps:

1. Prepare a rollback plan.
1. Run the what-if operation against production.
1. Deploy manually.
1. Run smoke tests.
