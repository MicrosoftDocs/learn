When you and members of your team are each responsible developing and maintaining different parts of your Fabric environment, a best practice is to work in isolated development environments until you're ready to combine your development efforts and publish your changes to a particular pre-production environment. When you're ready to publish your changes, you need to make sure that your changes don't break existing code or interfere with changes made by other developers. There's also a need to ensure that code changes are saved and can be reverted if there are issues. The built-in continuous integration and continuous delivery capabilities in Fabric can help facilitate this.

 Continuous integration and continuous delivery is a process for integrating code contributions from multiple developers into a main codebase. Contributions are frequently committed, and automated processes build and test the new code. Code is continuously moving into production, reducing feature development time.

### Continuous integration
If developers work on separate code branches on their local machines for long periods of time and only merge their changes to the main codebase once their work is finished, this increases the likelihood of conflicts and bugs that might only be identified in later development stages and can slow down delivery of features to users.  

Continuous integration (CI) helps you avoid bugs and code failures and lets you continuously develop and release functionality. In CI, you frequently commit code to a shared code branch or trunk in a version control system and once it's merged, changes are validated by a build process and automated testing. Conflicts between new and existing code are identified earlier in the development process and are easier and faster to fix.

### Continuous delivery
Continuous delivery happens after continuous integration. Once CI is complete, code is deployed to a staging environment where more automated testing is performed before code is released into production.

### Continuous deployment
Continuous deployment is a process that automatically releases updates into production environments through structured deployment stages, once they pass automated tests.  
 
## Use CI/CD in Fabric
Managing the lifecycle of Fabric items using CI/CD has two parts: integration and deployment. Integration is implemented using Git. Deployment is implemented using Fabric deployment pipelines. Automation of deployment or integration is implemented using Fabric REST APIs.  

- **Git:** Lets your team collaborate using branches, and provides version control. It helps you manage incremental code changes, and see code history.
- **Deployment pipelines:** Lets you promote code changes to different environments like development, test, and production.
- **Fabric REST APIs:** Enables automation and lets you programmatically manage CI/CD processes.