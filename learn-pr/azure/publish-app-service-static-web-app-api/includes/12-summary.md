You needed to build a shopping list web app that is secure and offers good performance for a globally distributed customer base. Your primary concerns were to limit the amount of infrastructure work and focusing on the business features and user experience.

Azure Static Web Apps is a great fit for this scenario:

- Performance and Scale: Your web assets are globally distributed, putting them closer to your users, to minimize latency. Business logic is run on Azure Functions that scale automatically to meet demand.
- Productivity: You get an automated build pipeline with CI/CD.
- Security: The web app is secured with an SSL certificate.

Without Azure Static Web Apps, you could deploy your web assets to cloud storage, create and assign your own SSL certificate, create your API, establish a reverse proxy that allows your app to make calls to the API, distribute the app globally, and set up your own CI/CD process.

Azure Static Web Apps gives you all of these benefits. They let you spend your time on building new features and optimizing the user experience rather than creating and maintaining site infrastructure.

## More resources

Here are several resources where you can learn more about Azure Static Web Apps, Visual Studio Code, and other concepts covered in this module.

- Watch the Video series: [Deploy websites to the cloud with Azure Static Web Apps](https://aka.ms/azure/beginnervideos/learn/swa)
- Learn how to [Publish an API to Azure Static Web Apps](/training/modules/publish-static-web-app-api-preview-url/)
- Learn how to [Authenticate users with Azure Static Web Apps](/training/modules/publish-static-web-app-authentication/)
- [Azure Static Web Apps](/azure/static-web-apps)
- Use [Angular](https://code.visualstudio.com/docs/nodejs/angular-tutorial), [React](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial), and [Vue](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial) in Visual Studio Code
