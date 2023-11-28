When you build an application, you write code to implement business requirements. For the sake of speed and reliability, you and your team might not write all the code yourselves. You might rely on external _packaged_ code that someone else wrote.

A dependency on external, packaged code allows you to:

* **Build your app faster** by building on top of existing packages. An common example of this is using a JavaScript front-end (React, Angular, Vue) or back-end (Express.js, Restify.js) framework.
* **Integrate with Cloud services faster** by using packages provided by the Cloud provider. For example, you can use the Azure SDK for JavaScript to integrate with Azure services.
* **Use best practices** by using packages that are written by experts. For example, you can use the Microsoft Authentication Library (MSAL) to integrate with Azure Active Directory (Azure AD) for authentication and authorization. MSAL is written by experts in authentication and authorization.
* **Offload development tasks** by using packages that provide tasks such as linting and transpiling. For example: ESLint, Babel, TypeScript, and Webpack.
* **Testing** by using packages that provide testing frameworks. For example: Jest and Playwright.

In this module, you'll use the **npm command-line tool** and the **npm global registry** to add packages to your application code. You'll also be learn about package updates and mitigating issues.

## Learning objectives

After you complete this module, you'll be able to:

- Use a dev container for your development environment 
- Initialize Node.js projects
- Understand what the manifest file package.json consists of and use it to your advantage
- Add packages to and remove packages from your Node.js project
- Manage your package dependencies and update them in a predictable way

## Prerequisites

- Familiarity with editing text and code files in a text editor
- Experience with using the command line, including using it for Git operations
- Experience using JavaScript functions and variables
- Development environment, either one of these:
    - GitHub account to use GitHub Codespaces to use a browser-based environment
    - Visual Studio Code and Docker to use local environment

