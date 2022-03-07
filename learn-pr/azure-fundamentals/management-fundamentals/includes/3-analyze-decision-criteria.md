In this unit, you'll analyze the criteria that experts employ to help them decide which Azure management tools to use to address their business needs. Understanding the criteria can help you to better understand the nuanced differences among the products.

### Do you need to perform one-off management, administrative, or reporting actions?

Azure PowerShell and the Azure CLI are Azure management tools that allow you to quickly obtain the IP address of a virtual machine (VM) you've deployed, reboot a VM, or scale an app. You might want to keep custom scripts for both tools handy on your local hard drive for certain operations that you need to perform multiple times.

By contrast to the Azure CLI and PowerShell, Azure Resource Manager templates (ARM templates) define the infrastructure requirements in your application for repeatable deployments. Although ARM templates aren't intended for one-off scenarios, it's possible to use them for this purpose. However, for one-off scenarios, you may prefer more agile tools like PowerShell, Azure CLI scripts, or the Azure portal.

Keep in mind that ARM templates can include both PowerShell and/or Azure CLI scripts, which will give you the ability to utilize scripts for tasks that may not be possible with the ARM template itself. The ability to combine Azure management tools gives flexibility in choosing the right tool(s) for your particular need.

The Azure portal can perform most, if not all, management and administrative actions. If you're just learning Azure and/or need to set up and manage resources infrequently (or prefer a visual interface for viewing reports), it makes sense to take advantage of the visual presentation that the Azure portal offers.

However, if you're in a cloud management or administrative role, it's less efficient to rely solely on visual scanning and clicking. To quickly find the settings and information you want to work with, the Azure CLI or PowerShell will give you the most flexibility for repeatable tasks.

The last management tool to discuss is the Azure mobile app, which you can access via an iOS or Android phone or tablet. Because it's full featured, it's likely the best choice when a laptop isn't readily available and you need to view and triage issues immediately.

### Do you need a way to repeatedly set up one or more resources and ensure that all the dependencies are created in the proper order?

ARM templates define your application's infrastructure requirements for a repeatable deployment that is done in a consistent manner. A validation step ensures that all resources can be created in the proper order based on dependencies, in parallel, and idempotent.

By contrast, it's entirely possible to use either PowerShell or the Azure CLI to set up all the resources for a deployment. However, there's no validation step in these tools. If a script encounters an error, the dependency resources can't be rolled back easily, deployments happen serially, and only some operations are idempotent.

### When you're scripting, do you come from a Windows administration or Linux administration background?

If you or your cloud administrators come from a Windows administration background, it's likely you'll prefer PowerShell. If you or your cloud administrators come from a Linux administration background, it's likely you'll prefer the Azure CLI. In practice, either tool can be used to perform most one-off administration tasks.
