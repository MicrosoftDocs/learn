Here you review the dependencies between work items shown in a delivery plan and use it to determine what adjustments need to be made to the schedule in Azure DevOps.

The Tailspin team has created dependencies between several work items using the Predecessor/Successor link type. The links they've created automatically appear in the delivery plan they created. Now they need to review these dependencies and address any dependencies that have issues.  

To do this, you:

> [!div class="checklist"]
> * Review delivery plans for dependencies.
> * Identify work items with dependency issues. 
> * Resolve dependencies that have issues.

## View work items with dependencies 

The first thing the team notices when they open the delivery plan is that link icons appear. Cards with a :::image type="icon" source="../media/dependencies/6-dependency-green-icon.png" border="false"::: green icon indicate there are no dependency issues. Cards with a :::image type="icon" source="../media/dependencies/6-dependency-red-icon.png" border="false"::: red icon indicate there are issues with one or more dependencies. 

Dependency issues arise when a predecessor work item is scheduled to finish after a successor work item. 


:::image type="content" source="../media/6-view-dependencies-delivery-plans.png" alt-text="A screenshot showing the delivery plan with dependencies. ":::

## View dependency lines for a work item


:::image type="content" source="../media/6-view-dependency-across-teams-no-issues-delivery-plans.png" alt-text="A screenshot showing the dependency line between teams with no issues.":::


Click the bottom of the card with a dependency icon showing. For example, here we click *Update privacy policy* card. A dependency line is drawn between the work item in the Web Team and the Engine Team. 

:::image type="content" source="../media/6-view-dependencies-delivery-plans.png" alt-text="A screenshot showing the dependency line between teams with issues.":::


## Open the dependency dialog  


:::image type="content" source="../media/6-open-dependency-dialog-with-issues-delivery-plans.png" alt-text="A screenshot showing the dependency line between teams with issues.":::


## Resolve dependencies that have issues

The team decides to change the order of the work in order to resolve the dependency issues. 


 