Work item integration functionality allows you to easily create work items in Azure DevOps with relevant Application Insights data embedded in them.

It's straightforward to configure this association and begin creating work items (this process should only take a minute or two).

## Configuring work item integration

To configure work item integration for an Application Insights resource, navigate to your settings blade for that resource.

You'll note that a new item in the "Configure" section of the settings blade says, "Work Items."

:::image type="content" source="../media/configure-work-items-199a7cd8.png" alt-text="Configure work items.":::


Click on it, and the configuration blade for work items will open.

All you need to do is fill out the information about the Azure DevOps system to which you want to connect, along with the project where you want to write your work items:

:::image type="content" source="../media/configuration-blade-55546081.png" alt-text="Configuration blade.":::


Once that information is in place, you can click on the Authorization button, where you'll be redirected to authorize access in your selected Azure DevOps system so that work items can be written there:

:::image type="content" source="../media/authorize-application-13071a7f.png" alt-text="Authorize application.":::


Once you've completed the authorization process, you can set defaults for "area path" and "assigned to."

Only area path is required (if you have not set up specific area paths in your project, that is ok. Just use the name of the project, as it's the top-level area path.

Click OK, and assuming you have entered everything correctly, you'll see a message stating "Validation Successful," and the blade will close. You're now ready to start creating work items!

## Creating work items

Creating work items from Application Insights is easy.

There are currently two locations where you can create work items: Proactive detection and individual instances of activity (that is, exceptions, failures, requests, and so on.). I'll show you a simple example of the latter, but the functionality is identical in either case.

In this example, we're looking at a test web app that we published to Azure. We started to drill into the activity for this app by looking at the Failures blade (but we could also get to this same information through the Search button or the Metrics Explorer):

:::image type="content" source="../media/failures-blade-9cc4d124.png" alt-text="Failures blade.":::


We can see that I have several exceptions that fired when the user clicked on the Home/About tab on this web app. If I drill into this group of exceptions, I can see the list and then choose an individual exception:

:::image type="content" source="../media/drill-into-exceptions-5c616c45.png" alt-text="Drill into exceptions.":::


Looking at the detailed blade for this exception, we see that there are now two buttons available at the top of the blade that read "New Work Item" and "View Work Items."

To create a work item, I click on the first of these buttons, and it opens the new work item blade:

:::image type="content" source="../media/detail-blade-dc3872ef.png" alt-text="Detail blade.":::


As you can see, just about everything you need in your average scenario has been filled out for you.

The default values for "area path" and "assigned to" that you chose in the initial configuration are set, and all the detailed information we have available for this exception has been added to the details field.

You can override the title, area path, and assigned to fields in this blade if you wish, or you can add to the captured details.

When you're ready to create your work item, click on the "OK" button, and your work item will be written to Azure DevOps.

## Viewing work items

Once you have created more work items in Application Insights, you can quickly view them in Azure DevOps.

The detailed blade for the event associated with the work item(s) will have the "View Work Items" button enabled if you are in the Azure portal. To see the list, click the button:

:::image type="content" source="../media/view-work-items-f909533a.png" alt-text="View work items.":::


If you click the link for the work item that you want to view, it will open in Azure DevOps:

:::image type="content" source="../media/azure-devops-view-83b1d19c.png" alt-text="Azure DevOps.":::


## Advanced Configuration

Some of you may have noticed that there's a switch on the configuration blade that is labeled "Advanced Configuration."

We have provided another functionality to help you configure your ability to write to Azure DevOps in scenarios where you've changed or extended some of the out-of-the-box settings.

An excellent example of it is choosing more required fields. There's no way to handle this other-required mapping in the standard config, but you can handle it in advanced mode.

If you click on the switch, the controls at the bottom of the blade will change to look like this:

:::image type="content" source="../media/advanced-configuration-1470c990.png" alt-text="Advanced configuration.":::


You can see that you're now given a JSON-based editing box where you can specify all the settings/mappings that you might need to handle modifications to your Azure DevOps project.

## Next steps

We think that it's an excellent start to integrating work item functionality with Application Insights.

But please keep in mind that it's essentially the 1.0 version of this feature set.

We have much worked planned, and you'll see a significant evolution in this space over the upcoming months.

Just for starters, let me outline a few of the things that we already have planned or are investigating:

 -  *Support for all work item types* – You probably noticed that the current feature set locks the work item type to just "bug." Logging bugs was our primary ask for this space, so that is where we started, but we certainly don't think that is where things should end. One of the more near-term changes you'll see is handling all work item types for all supported processes in Azure DevOps.
 -  *Links back to Application Insights* – It's great to create a work item with App Insights data in it, but what happens when you are in your ALM/DevOps system and looking at that item and want to quickly navigate back to the source of the work item in App Insights? We plan to rapidly add links to the work items to make this as fast and easy as possible.
 -  *More flexible configuration* – Currently, our standard configuration only handles scenarios where users haven't modified/extended their project in Azure DevOps. Today, if you have made these kinds of changes, you'll need to switch to advanced configuration mode. In the future, we want to handle everyday things that people might change (for example, making more fields require, adding new fields) in the standard configuration wherever possible. It requires some updates from our friends on the Azure DevOps team, but they're already working on some of these for us. Once they're available, we'll begin to make the standard configuration more flexible. In the meantime (and in the future), you can always use the advanced configuration to overcome limitations.
 -  *Multiple profiles* – Setting up a single configuration means that in shops where there are several ways users commonly create work items, the people creating work items from Application Insights would have to override values frequently. We plan to give users the capability to set up 1:n profiles, with common values specified for each so that when you want to create a work item with that profile, you can choose it from a drop-down list.
 -  *More sources of creation for work items* – We'll continue to investigate (and take feedback on) other places in Application Insights where it makes sense to create work items.
 -  *Automatic creation of work items* – There are certainly scenarios we can imagine where we might want a work item to be created for us based upon criteria. It is on the radar, but we're spending some design time to limit the possibilities of super-noisy or runaway work item creation. We believe that this is a powerful and convenient feature, but we want to reduce the potential for spamming the ALM/DevOps system as much as possible.
 -  *Support for other ALM/DevOps systems* – Hey, we think that Azure DevOps is an excellent product, but we recognize that many of our users may use some other product for their ALM/DevOps, and we want to meet people where they are. So, we're working on other first-tier integrations of popular ALM/DevOps products. We also plan to provide a pure custom configuration choice (like advanced config for Azure DevOps) so that end users will hook up Application Insights to virtually any ALM/DevOps system.
