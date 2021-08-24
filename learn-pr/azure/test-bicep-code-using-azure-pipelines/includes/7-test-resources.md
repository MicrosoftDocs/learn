By validating and previewing your Bicep deployment, you were able to build up confidence that your Bicep files would successfully deploy. But this isn't the whole story. After the deployment completes, it's also helpful to check that your deployment did what you expected. In this unit, you'll learn about tests you can run after your deployment completes. You'll also learn about rolling back your deployment, if things don't turn out as you expected.

## Testing your resources once they're deployed

When you define resources in a Bicep file, your goal isn't just to create resources in Azure - it's to deliver some sort of value to your organization. When you validate and preview your Bicep files, you gain confidence that the resource definitions are valid. But you don't necessarily know that the resources will actually do what you want.

For example, imagine that you deploy a new Azure SQL server by using a Bicep deployment pipeline. Your Bicep definition for the SQL server is valid, so it passes the linter and preflight validation stages. The what-if command shows that a server will be created, which is what you expect. The deployment also completes successfully. But at the end of the deployment process, there are many reasons why you still might not have a working database server that's ready to use, such as:

- You haven't configured firewall rules to allow network traffic to reach your server.
- You have enabled Azure Active Directory authentication on your server when you shouldn't have, or vice versa.

Even when you're just deploying basic Bicep files, it's worth considering how you can validate that the resources you deploy actually work and meet your requirements. Here are some examples of how you can apply this principle:

- When you deploy a website, try to reach the web application from your pipeline. Verify that your pipeline connects to the website successfully and receives a valid response code.
- When you deploy a database server and database, try to connect to the database. Run a basic query. Ensure you get the response you expect.

It's also a good idea to perform *negative testing*. Negative testing helps you to confirm that your resources don't have undesired behavior. For example, when you deploy a virtual machine, it's good practice to use Azure Bastion to access the virtual machine securely. You could add a negative test to your pipeline to verify that you can't access the virtual machine directly using Remote Desktop Connection or SSH.

> [!NOTE]
> TODO: don't want to test the tools. e.g. don't check that each resource is created. Instead, check they behave as you expect.

### Other test types

*Functional tests* are often used to validate that the resources deployed are behaving as you expect. In a future module, you'll see how functional tests can be added to your pipeline.

<!-- TODO Application functional tests Load testing, automated penetration testing, and other forms of testing that you can add -->

## Rolling back and rolling forward

In case the changes you made are not as you expected, there is always the option to rollback to the last version that you deployed. 

- Rolling back by re-executing the pipeline, or re-running the last successful deployment
- Complexities of rollback when you have other components, especially those with state
- Rolling forward
