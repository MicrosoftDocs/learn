You're part of a development team at the company Tailwind Traders. As part of that work, you need to author Azure Resource Manager (ARM) templates to deploy and manage resources in the cloud. You want to ensure that the templates follow some sound practices before the resources are deployed. You elect to use the ARM Template Test Toolkit to help you analyze your templates, so you can rectify any problems. 

## Set up your testing environment

The tool is a PowerShell module. To be able to run it, use the following steps:

- **Install PowerShell module**. This task is done differently depending on whether you're on Linux, Mac, or Windows.
- **Download the module**. The module is hosted in a GitHub repository. You can download it from there or fetch it via a `git clone` command.
- **Import the module**. This step is just a one-line instruction that you enter into a PowerShell session which will make the ARM-TTK commands available.

### Install PowerShell

::: zone pivot="linux"

[!include[](./os/5-exercise-test-toolkit-linux.md)]

::: zone-end

::: zone pivot="macos"

[!include[](./os/5-exercise-test-toolkit-macos.md)]

::: zone-end

::: zone pivot="windows"

[!include[](./os/5-exercise-test-toolkit-windows.md)]

::: zone-end

Now you're ready to run the tests on your template.
