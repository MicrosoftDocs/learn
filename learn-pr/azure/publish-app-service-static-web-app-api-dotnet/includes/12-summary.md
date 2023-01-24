You needed to build a shopping list web app that is secure, and offers solid performance for a globally distributed customer base. Your primary concerns were to limit the amount of infrastructure work, and focus on the business features and user experience.

Azure Static Web Apps provides these features as a great fit for this scenario:

- Performance and scale: Your web assets are globally distributed, putting them closer to your users to minimize latency. Your business logic runs on Azure Functions that scales automatically to meet demand.
- Productivity: You get an automated build pipeline with CI/CD.
- Security: Your web app is secured with an SSL certificate.

_Without_ Azure Static Web Apps, you would need to:

- Deploy your web assets to cloud storage.
- Create and assign your own SSL certificate.
- Create your API.
- Establish a reverse proxy that allows your app to make calls to the API.
- Distribute the app globally.
- Set up your own CI/CD process.

Taking advantage of Azure Static Web Apps provides all these benefits. It enables you to spend your valuable time building new features and optimizing the user experience, rather than creating and maintaining site infrastructure.

## Additional resources

Here are several resources where you can learn more about Azure Static Web Apps, Visual Studio Code, and other concepts covered in this module.

- Learn how to [Publish an Angular, React, Svelte, or Vue JavaScript app with Azure Static Web Apps](/training/modules/publish-app-service-static-web-app-api/)
- Learn how to [Publish an API to Azure Static Web Apps](/training/modules/publish-static-web-app-api-preview-url/)
- Learn how to [Authenticate users with Azure Static Web Apps](/training/modules/publish-static-web-app-authentication/)
- [Azure Static Web Apps](/azure/static-web-apps)
- Learn how to [Deploy to Azure Using Azure Functions](/azure/developer/javascript/how-to/with-web-app/azure-function-resource-group-management/deploy-azure-function-with-visual-studio-code)
- [Overview of Blazor](/aspnet/core/blazor/?view=aspnetcore-3.1)
- Use [Angular](https://code.visualstudio.com/docs/nodejs/angular-tutorial), [React](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial), and [Vue](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial) in Visual Studio Code
