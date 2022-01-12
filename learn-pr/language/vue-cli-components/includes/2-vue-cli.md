Vue CLI provides a suite of tools for development, including project scaffolding, a development server, and rapid prototyping. It helps you quickly create a starter application so you can focus on coding, not on configuring libraries and other settings.

## Bootstrapping

The core usage of Vue CLI is to bootstrap an application. The *create* script provides a wizard where you can select from some of the most common configurations, including:

- **Linting options**: Ensure that all code looks consistent. These options can also help uncover errors.
- **Application type**: Choose whether to add Progressive Web Apps support.
- **Babel support**: Babel's job is to convert newer JavaScript syntax to older forms of JavaScript, if your app needs to be used in older browsers.
- **Language**: Choose JavaScript or TypeScript. Either option is fine, though TypeScript brings you types among other features and might be a good option as your application grows. Vue itself is built in TypeScript.

## Build process

Vue CLI is designed to work with single-file Vue components, or *.vue* files. A *module bundler* or *bundler* manages the process of converting the specialized syntax in *.vue* files into the appropriate JavaScript, HTML, and CSS, so browsers can read the files. 

Vue CLI uses [webpack](https://webpack.js.org/?azure-portal=true) as its default bundler. The default configuration of webpack will work for most scenarios. By using Vue CLI, you can skip the steps required for configuring a bundler and instead use the provided setup.

## Development server

Developing any type of application requires trial and error. You'll make a few changes, load the page in the browser, test it, and make a few more changes. Then you'll repeat this process until everything behaves as you expect. 

You want to minimize the number of steps involved in this process. To streamline development, Vue CLI includes a development server. Each time you save a file, the development server will detect file changes, rebuild (or rebundle) the project, and allow you to test the page in the browser.
