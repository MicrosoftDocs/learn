Application Masking manages access to Applications, Fonts, and other items based on criteria. The Application Rules Editor is used to Describe the item, such as application, to be managed. The Editor is also used to define criteria rules are managed by.

Things you can do with the Apps Rules Editor:

 -  Create new Rule Sets.
 -  Edit existing Rule Sets.
 -  Manage the user and group assignments for Rule Sets.
 -  Temporarily test rule-sets.

Before using the Application Rules Editor, FSLogix must be [installed](/fslogix/install-ht).

## Rule Types

FSlogix supports four rule types:

**Hiding Rule - hides the specified items using specified criteria.**

:::image type="content" source="../media/manage-hiding-rules-1-35cab33b.png" alt-text="An image of Hiding Rule - hides the specified items using specified criteria.":::


**Redirect Rule - causes the specified item to be redirected as defined.**

:::image type="content" source="../media/manage-hiding-rules-2-d073dfd6.png" alt-text="An image of Redirect Rule - causes the specified item to be redirected as defined.":::


**App Container Rule - redirects the specified content into a VHD.**

:::image type="content" source="../media/manage-hiding-rules-3-775a14ba.png" alt-text="An image of App Container Rule - redirects the specified content into a VHD.":::


**Specify Value Rule - assigns a value for the specified item.**

:::image type="content" source="../media/manage-hiding-rules-4-807083c5.png" alt-text="An image of Specify Value Rule - assigns a value for the specified item.":::


## Create a new Rule Set

1.  Open the Apps Rule Editor. The first time you enter the Apps Rules Editor there won't be any rule sets in the left panel. In this example, one rule set has already been created named Contoso\_1 with GitHub Desktop added.
2.  Click **File** then **New** to create a new Rule Set.
3.  Provide a name for the Rule Set and click **Enter Filename.**
4.  After a filename is entered, a selection is made for the type and content of the rule.
5.  After specifying the parameters wanted, click **Scan** to create a rule (In this example, GitHub Desktop is selected)

## Create a new rule

 -  Select an existing Rule Set from the left panel.
 -  Select **Edit** then **New Rule.**
 -  Specify the [type of rule.](/fslogix/application-masking-rules-ht)
 -  Enter the required parameters.
 -  Click **OK.**

## Delete a rule

 -  Select an existing Rule Set from the left panel.
 -  Select one or more Rules from the right panel.
 -  Select **Edit** then Delete Rule.

## Edit a rule

 -  Select an existing Rule Set from the left panel.
 -  Select an existing Rule from the right panel.
 -  Select **Edit** then Edit Rule.

## Redirecting to a network

Files and directories can be redirected to resources located on a network. The user must have appropriate rights to the network resource. To redirect to a network location, enter the path (in UNC format) into the Destination field.

## Deploying Rule Sets

Application Masking and Java Version Control rely on Rules and Rule Sets.

By default, Rules and Rule Sets are accessed from **C:\\Program Files\\FSLogix\\Apps\\Rules.**

The location where Rules and Rule Sets are accessed differ if the FSLogix installation location is changed.

To deploy a rule set, use any method to copy rule files (.fxr) and assignment files (.fxa) to the rules directory.
