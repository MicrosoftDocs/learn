The starting point for configuring CI and CD for your applications is to have your source code in a version control system. VSTS supports two forms of version control: Git and Team Foundation Version Control. The Build service integrates with both of these version control systems. 

After you configure CI, any changes that you push to your version control repository are automatically built and validated. You can also manage your source code by using Subversion, Bitbucket, GitHub, or any other Git repository. The Build service integrates with all of these version control systems.

To configure CI, create a build definition. A build definition is a representation of the automation process that you want to run to build and test your application. The automation process is defined as a collection of tasks. 

VSTS has various tasks that you can use to build and test your application. For example, you can use tasks to build .NET, Java, Node, Android, Xcode, and C++ applications. VSTS also has tasks that run tests by using various testing frameworks and services. You can also run command-line, PowerShell, or Shell scripts in your automation.

Let's try this out and commit code to a VSTS project. Click **Next** to continue.