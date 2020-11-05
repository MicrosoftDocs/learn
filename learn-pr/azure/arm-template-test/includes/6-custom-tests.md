So far you've looked at how to run some tests on your templates. However, you might operate in a domain like a company or team that has its own set of rules. These rules might mean that you want to *customize* the test experience. You might have the following scenarios:

- **Run a specific test suite**. Upon installation of the test toolkit, you're given a set of tests that will be run. These tests are located at the following directory: *<install directory>/arm-ttk/testcases/deploymentTemplate*. 

  It's possible to customize this test run experience. One way to customize, as we've seen in the previous unit, is by using the parameter **-Test**. You can also edit what tests are being run by removing files in the directory.
- **Author and run domain-specific tests**. It's possible to author your own set of tests to enforce domain-specific rules. This unit will focus mostly on this scenario.

## Authoring and running your own tests

You've decided to author your own domain-specific test. There's a flow to authoring and running such a test:

1. Create a file in the directory *<install directory>/arm-ttk/testcases/deploymentTemplate*.
1. Author the file in PowerShell.
1. Run the file and inspect the results.

### Creating a custom test

A custom test needs to be placed in the correct directory: _<install directory>/arm-ttk/testcases/deploymentTemplate_. It also needs to follow a naming standard with dashes, a postfix of _.test_, and an ending in _.ps1_. A typical test file looks like this:

```bash
Domain-Specific.test.ps1
```

### Authoring

To author a test file name, you need to write it in PowerShell. The three pieces of a test file are:

- **Documentation**. This part is optional but highly advantageous to add. It resides at the top of the file and usually contains a set of comments that describe what the test is, what it does, and how to call it. The comments can look like the following example:

   ```powershell
   <#
   .Synopsis
       Ensures that all IDs use the resourceID() function.
   .Description
       Ensures that all IDs use the resourceID() function, or resolve to parameters or variables that use the ResourceID() function.
   .Example
       Test-AzTemplate -TemplatePath .\100-marketplace-sample\ -Test IDs-Should-Be-Derived-From-ResourceIDs
   #>
   ```

   The preceding example describes what the test does in a short description in a section called **.Synopsis**. There's also a longer description in a section called **.Description**. Last, there's a section called **.Example** that shows different ways to run the test.

- **Input parameters**. The test file can have a set of input parameters. This section is defined by the keyword **param** and parentheses. It can typically look like this:

   ```powershell
   param(
     [Parameter(Mandatory=$true)]
     [PSObject]$TemplateObject,

     [Parameter(Mandatory=$true)]
     [string]$TemplateFileName,

     [string]$SampleName = "$ENV:SAMPLE_NAME"
   )
   ```

   The preceding example shows three parameters: **$TemplateObject**, **$TemplateFileName**, and **$SampleName**. The first two parameters are mandatory, as shown by the **Parameter[(Mandatory = $true)]** decoration. The parameters are named according to their meaning. **$TemplateObject** contains an object representation of the template file, and **TemplateFileName** contains the name of the file being tested.  
- **Test logic**. The last part of a test is the test logic. Most tests usually want to do the following steps:

   1. Iterate through the template.
   1. Verify one or more conditions.
   1. Raise an error if something is incorrect.

### Code helpers

There are plenty of helpers that will help you find the content you need and report any errors. Here are two examples of code helpers:

- **Find-JsonContent**. Helps you locate a specific element with a specific value. Here's an example:

   ```powershell
   Find-JsonContent -Key apiVersion -Value * -Like
   ```

   The preceding code helps find a JSON attribute with the name **apiVersion** and a value of *, which essentially means all attributes named **apiVersion**. It would match a JSON like this:

   ```json
   { "apiVersion": "1.01" }
   ```

- **Write-Error**. Helps you communicate to the test runner that something is incorrect in the template. You can use it to express an error message and interpolate a string expression with any variables you need. Here's an example of how to use it:

   ```powershell
    Write-Error "Resource $($resource.Name) Location must be located in westeurope'" -TargetObject $resource
   ```

### Run the test

At this point, you've authored your file. It will be run together with all other files in the same directory.

As with the other test, you can opt to run only your specific test file by using the **-Test** parameter. As an argument, you'd give it the test file name stripped of the file extensions. **Custom-Test.test.ps1** would then be run by itself through `Test-AzTemplate -TemplatePath /path/to/template -Test Custom-Test`.
