You needed to build a shopping list web app that is secure and offers good performance for a globally distributed customer base. Your primary concerns were to limit the amount of infrastructure work and focusing on the business features and user experience.

Azure Static Web Apps are a great fit for this scenario:

- Performance and Scale: Your web assets are globally distributed, putting them closer to your users, to minimize latency and business logic is run on Azure Functions that scale automatically to meet demand.
- Productivity: You get an automated build pipeline with CI/CD while.
- Security: The web app is secured with an SSL certificate.

Without Azure Static Web Apps, you could deploy your web assets to cloud storage, create, and assign your own SSL certificate, create your API, establish a reverse proxy that allows your app to make calls to the API, distribute the app globally, and set up your own CI/CD process.

Azure Static Web Apps gives you all of these benefits. This lets you spend your time on building new features and optimizing the user experience rather than creating and maintaining site infrastructure.

## Additional resources

Here are several resources where you can learn more about Azure Static Web Apps, Visual Studio Code, and other concepts covered in this module.

- [Azure Static Web Apps on Microsoft Docs](https://docs.microsoft.com/azure/static-web-apps)
- Use [Angular](https://code.visualstudio.com/docs/nodejs/angular-tutorial), [React](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial), and [Vue](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial) in Visual Studio Code
