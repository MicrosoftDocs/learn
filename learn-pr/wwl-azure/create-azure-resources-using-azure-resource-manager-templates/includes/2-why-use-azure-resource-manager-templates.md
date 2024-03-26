
Using Resource Manager templates will make your deployments faster and more repeatable.

For example, you no longer must create a VM in the portal, wait for it to finish, and then create the next VM. The Resource Manager takes care of the entire deployment for you.

Here are some other template benefits to consider:

 -  Templates improve consistency. Resource Manager templates provide a common language for you and others to describe your deployments. Despite the tool or SDK that you use to deploy the template, the template's structure, format, and expressions remain the same.
 -  Templates help express complex deployments. Templates enable you to deploy multiple resources in the correct order. For example, you wouldn't want to deploy a VM before creating an operating system (OS) disk or network interface. Resource Manager maps out each resource and its dependent resources and creates dependent resources first. Dependency mapping helps ensure that the deployment is carried out in the correct order.
 -  Templates reduce manual, error-prone tasks. Manually creating and connecting resources can be time-consuming, and it's easy to make mistakes. The Resource Manager ensures that the deployment happens the same way every time.
 -  Templates are code. Templates express your requirements through code. Think of a template as a type of Infrastructure as Code that can be shared, tested, and versioned like any other piece of software. Also, because templates are code, you can create a record that you can follow. The template code documents the deployment. Also, most users maintain their templates under revision control, such as GIT. Its revision history also records how the template (and your deployment) has evolved when you change the template.
 -  Templates promote reuse. Your template can contain parameters that are filled in when the template runs. A parameter can define a username or password, a domain name, and other necessary items. Template parameters also enable you to create multiple versions of your infrastructure, such as staging and production, while still using the same template.
 -  Templates are linkable. You can link Resource Manager templates together to make the templates themselves modular. You can write small templates that define a solution and then combine them to create a complete system.

Azure provides many quickstart templates. You might use it as a base for your work.
