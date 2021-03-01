The Vue CLI (command-line interface) provides a suite of tools for development including project scaffolding, a development server, and rapid prototyping. It allows you to quickly create a starter application so you can focus on coding, not on configuring libraries and other settings.

## Bootstrapping

The core feature of Vue CLI is to bootstrap an application. The *create* script provides a wizard that allows you to select from some of the most common configurations, including:

- **Linting options**. _Linting_ is something is a task you perform to ensure that all code looks consistent. It can also help uncover errors.
- **Application type**. You can choose whether to add Progressive Web Apps support.
- **Babel support**. Babel's job is to convert newer JavaScript syntax to older forms of JavaScript, should your app need to be used in older browsers.
- **Language** - JavaScript or TypeScript. It's perfectly fine to go with either option. TypeScript brings you types among other features and could be a good option as your application grows. Vue itself is built in TypeScript.

## Build process

The Vue CLI is designed to work with single-file Vue components, or *.vue* files. *.vue* files use a _special syntax_ that is unreadable to browsers, and needs to be converted into the appropriate JavaScript, HTML, and CSS. This process is managed by a *module bundler* or *bundler*. Vue CLI uses [webpack](https://webpack.js.org/?azure-portal=true) as its default bundler, and includes a default configuration which will work for most scenarios. By using Vue CLI you can skip the steps required for configuring a bundler and instead use the setup provided.

## Development server

Developing any type of application requires trial and error. You will make a few changes, load the page in the browser, test it, make a few more changes, and then repeat this process until everything behaves as you expect. You want to minimize the number of steps involved in this process. To streamline development, Vue CLI includes a development server. Each time you save a file, the development server will detect file changes, rebuild (or rebundle) the project, and allow you to test the page in the browser.
