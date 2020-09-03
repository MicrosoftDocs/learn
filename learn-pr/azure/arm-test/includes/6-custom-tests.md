So far you've looked at how to run some tests on your templates. However, you might operate in a domain like a company or team that has its own set of rules. These rules could mean that you want to *customize* what the test experience is like. You might have the following scenarios:

- **Run specific test suite**. Upon install of the **arm-ttk** tool, you're given a set of tests that will be run. These tests are located at the following directory **<install directory>/arm-ttk/testcases/deploymentTemplate**. It is possible to *customize* this test run experience. One way to customize, as we've seen in the previous unit, is by using the parameter **-Test**. You can also edit what tests are being run by removing files in the mentioned directory.
- **Author and run domain-specific tests**. It is possible to author your own set of tests to enforce domain-specific rules. This unit will focus mostly on this scenario.

## Authoring and running your own tests

You've decided to author your own domain-specific test. There's a flow to how to author and run such a test namely:

1. **Create a file** in the directory **<install directory>/arm-ttk/testcases/deploymentTemplate**.
1. **Author** the file in PowerShell.
1. **Run** the file and inspect the results.

### Creating a custom test

A custom test needs to be placed in the correct directory *<install directory>/arm-ttk/testcases/deploymentTemplate*. It also needs to follow a naming standard with dashes and postfix of.test** and ending in **ps1**. A typical test file can therefore look like so:

```bash
Domain-Specific.test.ps1
```

### Authoring

To author a test file name, you need to write it in PowerShell. There are three different pieces to a test file that it's good to know about:

- **Documentation**. This part is optional but highly advantageous to add. It resides at the top of the file and is usually consisting of a set of comments describing the test, what it does and how to call it. It can look, for example,  like so:

   ```bash
   <#
   .Synopsis
       Ensures that all IDs use the resourceID() function.
   .Description
       Ensures that all IDs use the resourceID() function, or resolve to parameters or variables that use the ResourceID() function.
   .Example
       Test-AzTemplate -TemplatePath .\100-marketplace-sample\ -Test IDs-Should-Be-Derived-From-ResourceIDs
   #>
   ```

   The above describes what the test does in short description in a section called **.Synopsis**. There's also a longer description in a section called **.Description**. Lastly there's a section called **.Example** that shows different ways to run the specific test.

- **Input parameters**. The test file can have a set of input parameters. The parameters section is defined by the keyword **param** and a begin and close parenthesis. It can typically look like so:

   ```powershell
   param(
     [Parameter(Mandatory=$true)]
     [PSObject]$TemplateObject,

     [Parameter(Mandatory=$true)]
     [string]$TemplateFileName,

     [string]$SampleName = "$ENV:SAMPLE_NAME"
   )
   ```

   Above there are three different parameters, **$TemplateObject**, **$TemplateFileName** and **$SampleName**. The first two parameters are mandatory to have as seen by the **Parameter[(Mandatory = $true)]** decoration. The parameters also have special names that means something when named that way. The **$TemplateObject** contains an object representation of the template file and the **TemplateFileName** contains the name of the file being tested.  
- **Test logic**. The last part of a test is the actual test logic. Most tests usually want to do the following steps:

   1. **Iterate** through the template.
   1. **Verify** one or more conditions.
   1. **Raise an error** if finding something incorrect.

### Code Helpers

There are plenty of helpers that will help you find the content you need and also help report any errors. Here's some examples of existing code helpers:

- **Find-JsonContent**. This helper helps you locate a specific element with a specific value. Here's an example:

   ```powershell
   Find-JsonContent -Key apiVersion -Value * -Like
   ```

   The above code helps find a JSON attribute with the name **apiVersion** with value *, which essentially means all attributes named **apiVersion**. It would match a JSON like so:

   ```json
   { "apiVersion": "1.01" }
   ```

- **Write-Error**, This is a helper that helps you communicate to the test runner that something is incorrect in the template. You can use it to express an error message and interpolate said string expression with any variables you need. Here's an example of how to use it:

   ```powershell
    Write-Error "Resource $($resource.Name) Location must be be located in westeurope'" -TargetObject $resource
   ```

### Run the test

At this point, you've authored your file and it will be run together with all other files in the same directory.

Just like with the other test you can opt to only run your specific test file by using the **-Test** parameter. As an argument you would give it the test file name stripped of the file extensions, so **Custom-Test.test.ps1** would then be run by itself using the following `Test-AzTemplate -TemplatePath /path/to/template -Test Custom-Test`.
