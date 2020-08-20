In this unit, you'll analyze the criteria experts employ when choosing which Azure management tool to use for a given business need.  Understanding the criteria can also help you better understand the nuanced differences between each product.

## Do you need to perform one-off management / administrative / reporting actions?

Use either PowerShell or the Azure CLI if you need to quickly obtain the IP address of a VM you deployed, need to reboot a VM, or scale an app.  You may keep custom scripts handy on your local hard drive for these types of operations that you perform occasionally.

By contrast, ARM Templates express the infrastructure requirements for your application for a repeatable deployment.  ARM Templates not intended for one-time or one-off scenarios, though depending on the scenario it's possible to use them for this purpose.  Still, you should prefer PowerShell / Azure CLI scripts (or the Azure Portal).

Also, ARM Templates can include PowerShell / Azure CLI scripts, and PowerShell / Azure CLI scripts can trigger the execution of ARM Templates, so you have flexibility in choosing the right tool for your particular needs.

You could perform most (if not all) management and administrative actions via the Azure Portal. If you're just learning Azure, or infrequently need to set up and manage resources, or prefer the visual interface to view reports, then it makes sense to take advantage of the visual presentation of data and settings of the Azure Portal.

However, if you're a in cloud management or administrative role, relying solely on the Azure Portal would require visual scanning and clicking to find the settings or information you want to work with. In these cases, it is often quicker and more repeatable to use Azure CLI or PowerShell.

The last option in this case is the Azure Mobile App, which can be accessed via iOS or Android phone or tablet.  While it is full featured, it's likely the best choice when a laptop is not readily available and you need to view and triage issues.

## Do you need a way to repeatedly set up one or more resources and ensure that all the dependencies are created in the proper order?

ARM Templates express the infrastructure requirements for your application for a repeatable deployment.  A validation step ensures that all resources can be created, then the resources are created in the proper order based on dependencies, in parallel, and are idempotent.

By contrast, it is entirely possible to use PowerShell / Azure CLI to set up all of the resources for a desired deployment.  However, there's no validation step, so if a script encounters an error, you cannot easily roll back the dependency resources, deployments happen serially, and only some operations are idempotent.

## When scripting, do you come from a Windows administration or Linux administration background?

If you or your cloud administrators come from a Windows administration background, it's likely they will prefer PowerShell.  If you or your cloud administrators come from a Linux administration background, it's likely they will prefer the Azure CLI.  Pragmatically, either one can be used to perform most one-off administration tasks.