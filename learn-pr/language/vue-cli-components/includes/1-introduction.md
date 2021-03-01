While it's possible to create an entire Vue.js application in a single JavaScript file, it will become unmanageable in all but the smallest of applications. To support breaking your application into smaller units, Vue allows you to create components. Components are reusable building blocks from which you can create your application.

Components can be created as JavaScript files, or through a single-file component with a *.vue* extension. Single-file components use a *special syntax* which cannot be read by a browser and must be converted into the appropriate JavaScript, HTML and CSS. The process of converting specialized syntax into something able to be read by a browser is known as *bundling*, and requires additional tooling such as webpack.

Fortunately, Vue also provides a command line interface (CLI) which can be used to bootstrap an application. The CLI will configure all of the necessary tooling, including a bundler and development server.

In this module we will explore how to:

- use Vue CLI to create an application
- create single-file components
- use props to pass values into components

Prerequisites:

- A basic understanding of Vue.js
- Knowledge of HTML and CSS
- Knowledge of JavaScript
- Familiarity with Vue.js and directives
- [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Node.js](https://nodejs.org/en/?azure-portal=true)

> [!NOTE]
> To obtain the completed code for this module, you can clone the repository by executing the following in a command or terminal window:
>
> ```bash
> git clone [INSERT REPO HERE]
> git clone [INSERT STARTER DIRECTORY HERE]
> code .
> ```
