You've learned so far how *what-if* can be used to preview changes that you are about to apply to your deployments. There's another aspect that it's important to test for as well, namely *best practices*. So what are these *best practices* and why are they important for your templates?

> [!NOTE]
> Lets get one thing clear, these are recommendations, not requirements. You are highly encouraged to follow these recommendations however.

There are recommendations on different levels, everything from parameters and variables to things applying to your resources. Let's try to look at these from a high level and see what can be gained from adhering to these recommendations:

- **Maintainability**, as you develop your template, from authoring it the first time to updating it, over time it's important to *keep a clean house*. As your template grows so does constructs like parameters and variables and it's important to ensure that you understand what each of them are used for, and that they are used properly. Imagine you have scenario where the parameter name is badly named and you are struggling to understand what it does just by looking at it. Or let's imagine you are using a hardcoded value where you shouldn't and something changes in your operations and IT services goes down. The point is, all this constitutes a cognitive load of having to understand and later dismiss what you are looking at. Being very disciplined with how you name things, and clean things up, can help mitigate the effects of those scenarios.
- **Correctness**, say you have taken all precautions to name things good but there's just too many rules to keep track of. This is where you want a tool that enforces all these rules and regulations.
- **Flexibility**, you want to ensure that your template are flexible enough to be used in any environment.
- **Domain specific rules**. You need a way to apply domain specific rules that only make sense in the domain you work in. This is not something a tool or script can know of but it can support running customized scenarios.

## The test toolkit

For the reasons mentioned above, using a testing tool is a really good idea so you can focus on authoring while knowing that something has your back. There is such a testing tool called the ARM Template Test toolkit or **arm-ttk** for short.

It addresses the problems mentioned above by running a series of tests. The tests can be grouped into the following categories:

- **Validating the users intent**. This category looks at whether the declared variables and parameters are all used and warns if they're not.
- **Security practices**. Another important aspect is ensuring that nothing is returned from the template that might be sensitive like API secrets for example.
- **Using appropriate language constructs**. There exist language constructs or helper functions that can help you construct the values that you need instead of relying on hard coded values.

### Installing the tool

The tool is a PowerShell script. To be able to run it you would need to go through the following steps:

1. **Install the PowerShell Core**, this is done differently depending if you are on Linux, Mac or Windows. See this link for more details on [installing PowerShell Core](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit)
1. **Download the script**. The script can be found at the GitHub [repository](https://aka.ms/arm-ttk-latest)
1. **Import the script**. This is just a one-liner instruction that you enter in a terminal window and looks like this:

   ```bash
   Import-Module .\arm-ttk.psd1
   ```

   Ensure you are standing in the directory of **arm-ttk.psd1** when you run this command.

Now you are ready to run the tests on your template.

### Running the tests

To run the test you enter the following command:

```bash
Test-AzTemplate.sh -TemplatePath $TemplateFolder
```

You need to replace **$TemplateFolder** with a folder name. The toolkit expects there to exist a starter template file called either  **azuredeploy.json** or **maintemplate.json**. It tests that file first and then goes on to test the template files in the current directory and any templates in sub folders.

A typical output from running a test can look like this:

```output
[+] adminUsername Should Not Be A Literal (24 ms)
[+] apiVersions Should Be Recent (18 ms)
[+] artifacts parameter (16 ms)
[+] DeploymentTemplate Schema Is Correct (17 ms)
[+] IDs Should Be Derived From ResourceIDs (15 ms)
[-] Location Should Not Be Hardcoded (41 ms)
     azuredeploy.json must use the location parameter, not resourceGroup().location (except when used as a default value in the main template)
```

Successful tests are encoded in green and is prefixed by a **[+]**. Failed tests are encoded in red with the following prefix **[-]**.

### Configure your test run with test parameters

You can configure how your tests are run using test parameters. There are two test parameters **-File** and **-Test**.

The parameters can be used in the following ways:

- **Run tests on a single file**. You might want to only run tests on a single file you are currently working on. If that's your scenario run the following command in the terminal:

   ```bash
   Test-AzTemplate -TemplatePath $TemplateFolder -File cdn.json
   ```

   The above usage of the parameter **-File** ensures that tests are only run on `cdn.json`. A heads up though is that it still expect **azuredeploy.json** or **maintemplate.json** to exist.

- **Run a single type of test on all files**. Sometimes you might want to run only a single type of test to ensure you are fulfilling the criteria for just that scenario. You can accomplish this task by typing the following command in the terminal:

   ```bash
   Test-AzTemplate -TemplatePath $TemplateFolder -Test "Resources Should Have Location"
   ```  

   The usage of the test parameter **-Test** above ensure only the test called **Resources Should Have Location** is run.
