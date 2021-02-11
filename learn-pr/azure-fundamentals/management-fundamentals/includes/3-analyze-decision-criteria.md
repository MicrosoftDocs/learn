In this unit, you'll analyze the criteria that experts employ to help them decide which Azure management tools to use to address their business needs. Understanding the criteria can help you to better understand the nuanced differences among the products.

### Do you need to perform one-off management, administrative, or reporting actions?

Use either Azure PowerShell or the Azure CLI if you need to quickly obtain the IP address of a virtual machine (VM) you've deployed, reboot a VM, or scale an app.  You might want to keep custom scripts handy on your local hard drive for certain operations that you perform occasionally.

By contrast, Azure Resource Manager templates (ARM templates) express the infrastructure requirements for your application for a repeatable deployment.  ARM templates aren't intended for one-off scenarios but, depending on the scenario, it's possible to use them for this purpose. In these instances, you should prefer PowerShell, Azure CLI scripts, or the Azure portal.

Also, ARM templates can include PowerShell or Azure CLI scripts, which can trigger the execution of ARM templates. This gives you flexibility in choosing the right tool for your particular needs.

You could perform most, if not all, management and administrative actions via the Azure portal. If you're just learning Azure, need to set up and manage resources infrequently, or prefer a visual interface for viewing reports, it makes sense to take advantage of the visual presentation that the Azure portal offers.

However, if you're in a cloud management or administrative role, it's less efficient to rely solely on visual scanning and clicking. To find the settings and information you want to work with, it's often quicker and more repeatable to use the Azure CLI or PowerShell.

The last option in this case is the Azure mobile app, which you can access via an iOS or Android phone or tablet. Because it's full featured, it's likely the best choice when a laptop isn't readily available and you need to view and triage issues immediately.

### Do you need a way to repeatedly set up one or more resources and ensure that all the dependencies are created in the proper order?

ARM templates express your application's infrastructure requirements for a repeatable deployment.  A validation step ensures that all resources can be created, so that the resources are created in the proper order based on dependencies, in parallel, and idempotent.

By contrast, it's entirely possible to use either PowerShell or the Azure CLI to set up all the resources for a deployment.  However, there's no validation step in these tools. If a script encounters an error, the dependency resources can't be rolled back easily, deployments happen serially, and only some operations are idempotent.

### When you're scripting, do you come from a Windows administration or Linux administration background?

If you or your cloud administrators come from a Windows administration background, it's likely you'll prefer PowerShell.  If you or your cloud administrators come from a Linux administration background, it's likely you'll prefer the Azure CLI. In practice, either tool can be used to perform most one-off administration tasks.
