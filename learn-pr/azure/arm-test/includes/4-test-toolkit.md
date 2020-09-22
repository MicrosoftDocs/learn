You've learned so far how the *what-if* command can be used to preview changes to your existing deployment. *What-if* can help you build confidence as you create and edit your templates, but there are other ways we can make it easier to create valid templates and provide recommendations to improve their quality. So what are these recommendations and why might they be beneficial for your template to adhere to?

> [!NOTE]
> Lets get one thing clear, these are recommendations, not requirements. You are highly encouraged to follow these recommendations however.

There are recommendations on different levels, everything from parameters and variables to things applying to your resources. Let's try to look at these recommendations from a high level and see what can be gained from adhering to them:

- **Maintainability**, as you develop your template, from authoring it the first time to updating it, keeping your templates clean and orderly becomes challenging over time. As your template grows so does constructs like parameters and variables and it's important you understand what each of them are used for, and that they are used appropriately. Imagine a scenario where the parameter name is badly named and you are struggling to understand what it does, just by looking at it. Or you are using a hardcoded value where you shouldn't, and something changes in your operations and IT services goes down. The point is, all these issues constitutes a cognitive load of having to understand and later dismiss what you are looking at. Being disciplined with how you name things, and clean things up, can help mitigate the effects of those scenarios.
- **Correctness**, say you have taken all precautions to name things in a good way, but there's too many rules to keep track of. Such situations are where you want a tool that enforces all these rules and regulations.
- **Flexibility**, you want to ensure that your templates are flexible enough to be used in any environment.
- **Extensibility**. Sometimes you want to add your own recommendations. Your domain you work in as a company or team might have domain-specific rules. You want a way to apply these domain-specific rules. There's however a limit to what a tool or script can do, when looking for and highlighting issues.

## The test toolkit

For the reasons mentioned above, using a testing tool is a good idea so you can focus on authoring while knowing that a tool will find any issues and make your templates better. There is such a testing tool called the ARM Template Test toolkit or **Test Toolkit** for short.

It addresses the problems mentioned above by running a series of tests. The tests can be grouped into the following categories:

- **Validating the user's intent**. This category looks at whether the declared variables and parameters are all used and warns if they're not.
- **Security practices**. Another important aspect is ensuring that nothing is returned from the template that might be sensitive, like API secrets for example.
- **Using appropriate language constructs**. There exist language constructs or helper functions that you should use so that you're not relying on hard-coded values.

### Installing the tool

The tool is a PowerShell script. To be able to run it, you would need to go through the following steps:

1. **Install the PowerShell Core**, this task is done differently depending if you are on Linux, Mac, or Windows.
1. **Download the script**. The script is hosted in a GitHub repository and can be downloaded from there or fetched via a `git clone` command.
1. **Import the script**. This step is just a one-liner instruction that you enter in a terminal window.

Now you are ready to run the tests on your template.

### Running the tests

Running the tests involves invoking the script with the appropriate arguments. The `-TemplatePath` is a mandatory argument that expects a string that points to the location of the starter deployment template, which is either `azuredeploy.json` or `maintemplate.json`. A typical test run can therefore look like the below command:

```powershell
Test-AzTemplate.sh -TemplatePath path/to/template
```

The tool then goes onto to test the starter template and then any templates in the same directory and its sub folders.

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

Successful tests are encoded in green and are prefixed by a **[+]**. Failed tests are encoded in red with the following prefix **[-]**.

### Configure your test run with test parameters

You've seen so far how the parameter **-TemplatePath** is a mandatory parameter to include when running the tool. Additionally the tool accepts optional parameters. These parameters allow you to run specific files or specific tests. Using these parameters gives you a more granular control and makes it easier in both authoring or debugging your templates.

The parameter **-File** is used to run a specific file and the parameter **-Test** will allow you to specify a specific test scenario to run.

The arguments can be used in the following ways:

- **Run tests on a single file**. You might want to only run tests on a single file you are currently working on. To test out a single file run the following command in the terminal:

   ```powershell
   Test-AzTemplate -TemplatePath path/to/starter/template -File cdn.json
   ```

   The above usage of the parameter **-File** ensures that tests are only run on the file `cdn.json`. A heads up though is that it still expect **azuredeploy.json** or **maintemplate.json** to exist at the specified location.

- **Run a single type of test on all files**. Sometimes you might want to run only a single type of test to ensure you are fulfilling the criteria for just that scenario. You can accomplish this task by typing the following command in the terminal:

   ```powershell
   Test-AzTemplate -TemplatePath path/to/starter/template -Test "Resources Should Have Location"
   ```  

   The usage of the test parameter **-Test** above ensure only the test called **Resources Should Have Location** is run.
