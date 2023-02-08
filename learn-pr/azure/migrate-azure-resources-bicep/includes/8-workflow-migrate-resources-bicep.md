In this module, you've learned about the five phases of the recommended workflow for migrating your Azure resources to Bicep. The five phases are: convert, migrate, refactor, test, and deploy. For quick reference, here's a summary of the process.

:::image type="content" source="../media/8-migrate-bicep-numbers.png" alt-text="Diagram of the recommended workflow for migrating Azure resources to Bicep." border="false":::

## Phase 1: Convert

In the convert phase of migrating your resources to Bicep, the goal is to capture an initial representation of your Azure resources. The Bicep file you create in this phase isn't complete, and it's not ready to be used. However, the file gives you a starting point for your migration.

The convert phase consists of two steps:

1. Capture a representation of your Azure resources.
1. Convert the JSON representation to Bicep using the `decompile` command.

## Phase 2: Migrate

In the migrate phase of migrating your resources to Bicep, the goal is to create the first draft of your deployable Bicep file, and to ensure it defines all of the Azure resources that are in scope for the migration.

The migrate phase consists of three steps:

1. Create a new empty Bicep file.
1. Copy each resource from your decompiled template.
1. Identify and recreate any missing resources.

## Phase 3: Refactor

The main focus of the refactor phase is to improve the quality of your Bicep code. These improvements can include changes, such as adding code comments, that align the template with your template standards.

The refactor phase consists of eight steps:

1. Review resource API versions.
1. Review the linter suggestions in your new Bicep file.
1. Revise parameters, variables, and symbolic names.
1. Simplify expressions.
1. Review child and extension resources.
1. Modularize.
1. Add comments and descriptions.
1. Follow Bicep best practices.

## Phase 4: Test

In the test phase of migrating your resources to Bicep, the goal is to verify the integrity of your migrated templates and to do a test deployment.

The test phase consists of two steps:

1. Run the ARM template deployment what-if operation.
1. Do a test deployment.

## Phase 5: Deploy

In the deploy phase of migrating your resources to Bicep, the goal is to deploy your final Bicep file to production. Prior to the production deployment, there a couple of things to consider.

The deploy phase consists of four steps:

1. Prepare a rollback plan.
1. Run the what-if operation against production.
1. Deploy manually.
1. Run _smoke tests_.
