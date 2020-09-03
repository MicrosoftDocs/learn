Azure Resource Manager (ARM) templates use things like parameters, variables, functions, and more to create the templates. These constructs allow you to save time, as you don't need to create a new template per environment, you get consistent naming and so on.

You are the person on a software team authoring these templates. You plan to deploy the described infrastructure in the templates. As you author these templates you care about having a fast feedback loop. It's important that you can be made aware of any issues prior to deployment. Issues that can occur while authoring can be things such as errors in the template/s or violation against best practices or that you simply aren't deploying what you think you are deploying.

You decide to evaluate the existing set of tools that addresses the above issues.

In this module, you gain an understanding to what practices are beneficial to follow and why it's important. You also practice using the *What-if* command as well as the Testing toolkit to correct issues on your templates.

## Learning objectives

In this module you will:
- Evaluate the *What-if* operation so you can preview the changes that will happen as you deploy your templates. 
- Use the ARM Template Test Toolkit to check templates for standards.
- Create a custom test for an ARM Template to implement domain-specific rules.
