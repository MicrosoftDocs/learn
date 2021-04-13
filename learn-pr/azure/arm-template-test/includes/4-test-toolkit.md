You've learned so far how you can use the what-if command to preview changes to your existing deployment. What-if can help you build confidence as you create and edit your templates. But there are other ways we can make it easier to create valid templates and provide recommendations to improve their quality. What are these recommendations, and why might they be beneficial for your template to adhere to?

> [!NOTE]
> These are recommendations, not requirements. But we highly encourage you to follow them.

There are recommendations on different levels, everything from parameters and variables to things applying to your resources. Let's look at these recommendations from a high level and see what can be gained from adhering to them:

- **Maintainability**. As you develop a template, from authoring it the first time to updating it, keeping it clean and orderly becomes challenging over time. As your template grows, so do constructs like parameters and variables. It's important that you understand what each of them is used for, and how to use them appropriately. 

  Imagine a scenario where the parameter name is badly named and you're struggling to understand what it does, just by looking at it. Or you're using a hardcoded value where you shouldn't, and something changes in your operations and IT services go down. All these issues constitute a cognitive load of having to understand and later dismiss what you're looking at. Being disciplined with how you name things, and clean things up, can help mitigate the effects of those scenarios.
- **Correctness**. Say you've taken all precautions to name things in a good way, but there are too many rules to keep track of. Such situations call for a tool that enforces all these rules and regulations.
- **Flexibility**. Ensure that your templates are flexible enough to be used in any environment.
- **Extensibility**. Sometimes you want to add your own recommendations. The domain that you work in as a company or team might have domain-specific rules. You want a way to apply these domain-specific rules. However, there's a limit to what a tool or script can do when it's looking for and highlighting issues.

## The test toolkit

Using a testing tool is a good idea, so you can focus on authoring while knowing that the tool will find any issues and make your templates better. There is such a tool: the ARM template test toolkit. It addresses the problems mentioned earlier by running a series of tests. The tests can be grouped into the following categories:

- **Validating the user's intent**. This category looks at whether the declared variables and parameters are all used and warns if they're not.
- **Following security practices**. Another important aspect is ensuring that nothing is returned from the template that might be sensitive, like API secrets.
- **Using appropriate language constructs**. You should use language constructs or helper functions so that you're not relying on hard-coded values.

### Installing the tool

The tool is a PowerShell script. To be able to run it, use the following steps:

1. **Install the PowerShell Core**. This task is done differently depending on whether you're on Linux, Mac, or Windows.
1. **Download the script**. The script is hosted in a GitHub repository. You can download it from there or fetch it via a `git clone` command.
1. **Import the script**. This step is just a one-liner instruction that you enter in a terminal window.

Now you're ready to run the tests on your template.

### Running the tests

Running the tests involves invoking the script with the appropriate arguments. `-TemplatePath` is a mandatory argument that expects a string that points to the location of the starter deployment template. The template is either *azuredeploy.json* or *maintemplate.json*. A typical test run can therefore look like the following command:

```powershell
Test-AzTemplate.sh -TemplatePath path/to/template
```

The tool goes on to test the starter template and then any templates in the same directory and its subfolders.

A typical output from a test run can look like this:

```output
[+] adminUsername Should Not Be A Literal (24 ms)
[+] apiVersions Should Be Recent (18 ms)
[+] artifacts parameter (16 ms)
[+] DeploymentTemplate Schema Is Correct (17 ms)
[+] IDs Should Be Derived From ResourceIDs (15 ms)
[-] Location Should Not Be Hardcoded (41 ms)
     azuredeploy.json must use the location parameter, not resourceGroup().location (except when used as a default value in the main template)
```

Successful tests are encoded in green and are prefixed by **[+]**. Failed tests are encoded in red with the prefix **[-]**.

### Configure your test run with test parameters

You've seen so far how including the parameter **-TemplatePath** is mandatory when you're running the tool. The tool also accepts optional parameters. These parameters allow you to run specific files or specific tests. Using these parameters gives you more granular control in both authoring and debugging your templates.

The parameter **-File** is used to run a specific file. The parameter **-Test** allows you to specify a test scenario to run.

You can use the arguments in the following ways:

- **Run tests on a single file**. You might want to run tests on only a single file that you're currently working on. The reason is that it's easier to concentrate on authoring a specific template file. An additional benefit is that the output would contain less noise and show you only what you're interested in. By using the flag `-File` with a path to a file (including the file name), you can run the tests on just that file.

   > [!IMPORTANT]
   > The flag still expects *azuredeploy.json* or *maintemplate.json* to exist at the specified location.

- **Run a single type of test on all files**. Sometimes you might want to run a single type of test to ensure that you're fulfilling the criteria for just that scenario. You can accomplish this task by using the flag `-Test`. The flag expects the full name of the test; for example, **Resources Should Have Location**.
