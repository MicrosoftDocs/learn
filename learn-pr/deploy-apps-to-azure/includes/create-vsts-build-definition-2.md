The starting point for setting up CI and CD for your applications is having your source code in a *version control system*. Team Services supports two forms of version control: *Git* and *Team Foundation Version Control*. The *Build* service integrates with both of these version control systems. 

After you configure CI, any changes that you push to your version control repository are automatically built and validated. You can also manage your source code by using Subversion, Bitbucket, GitHub, or any other Git repository. The Build service integrates with all of these version control systems.

To configure CI, create a build definition. A build definition is a representation of the automation process that you want to run to build and test your application. The automation process is defined as a collection of tasks. 

Team Services has various tasks that you can use to build and test your application. For example, you can use tasks to build .NET, Java, Node, Android, Xcode, and C++ applications. Team Services also has tasks that run tests by using various testing frameworks and services. You can also run command-line, PowerShell, or Shell scripts in your automation.

To try this out and commit code to a Team Services project, select **Next**.