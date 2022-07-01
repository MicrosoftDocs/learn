The Tailspin team noted that some cards in the delivery plans have :::image type="icon" source="../media/6-dependency-green-icon.png" border="false"::: green icons or  :::image type="icon" source="../media/6-dependency-red-icon.png" border="false"::: red icons attached. Here they learn about how these icons showcase the dependencies that exist between work items and how to resolve dependency issues.  
 
The Tailspin team created dependencies between several work items using the **Predecessor/Successor** link type. The links they've created automatically appear in the delivery plan they created. Now they need to review these dependencies and address any dependencies that have issues.  

To do this, you:

> [!div class="checklist"]
> * Review delivery plans for dependencies.
> * Identify work items with dependency issues. 
> * Resolve dependencies that have issues.

## View work items with dependencies 

The first thing the team notices when they open the delivery plan is that link icons appear. Cards with a :::image type="icon" source="../media/6-dependency-green-icon.png" border="false"::: green icon indicate there are no dependency issues. Cards with a :::image type="icon" source="../media/6-dependency-red-icon.png" border="false"::: red icon indicate there are issues with one or more dependencies. 

Dependency issues arise when a predecessor work item is scheduled to finish after a successor work item. 


:::image type="content" source="../media/6-view-dependencies-delivery-plans.png" alt-text="A screenshot showing the delivery plan with dependencies. ":::

## View dependency lines for a work item


:::image type="content" source="../media/6-view-dependency-across-teams-no-issues-delivery-plans.png" alt-text="A screenshot showing the dependency line between teams with no issues.":::


Click the bottom of the card with a dependency icon showing. For example, here we click *Update privacy policy* card. A dependency line is drawn between the work item in the Web Team and the Engine Team. 

:::image type="content" source="../media/6-view-dependency-across-teams-with-issues-delivery-plans.png" alt-text="A screenshot showing the dependency line between teams with issues.":::


## Open the dependency dialog  

To review details of the Push beta work item, choose the card's icon to open the Dependencies dialog. The first dependency indicates an issue where the *Update site branding* work item requires the *Push beta* work to be completed first. The second dependency listed shows no issue. 

:::image type="content" source="../media/6-open-dependency-dialog-with-issues-delivery-plans.png" alt-text="Dependency dialog for a work item with issues.":::


## Resolve dependencies that have issues

The team decides to change the order of the work in order to resolve the dependency issues. They perform the following actions:  

- **Web team**:  
    - Drag *Create a Git-based workflow* card from **Sprint 1** to **Sprint 2**  
    - Drag *Check open source code for vulnerabilities and licensing terms* card from **Sprint 2** to **Sprint 1**  
    - Drag *Update site branding* card from **Sprint 4** to** Sprint 6**  

- **Engine team**:
  - Drag *Push beta* card from **Sprint 6** to **Sprint 5**.  

> [!TIP]
> If the icons don't update as expected, refresh your browser.

Once these changes have been made, the team sees that all dependency issues have been resolved. 

:::image type="content" source="../media/6-all-dependency-issues-resolved-delivery-plans.png" alt-text="A screenshot showing the delivery plan with dependencies. ":::