While it's possible to create an entire Vue.js application in a single JavaScript file, it will become unmanageable in all but the smallest of applications. To support breaking your application into smaller units, Vue allows you to create components. Components are reusable building blocks from which you can create your application.

Components can be created as JavaScript files, or through a single-file component with a *.vue* extension. Single-file components use a *special syntax* that browsers can't read. It must be converted into the appropriate JavaScript, HTML, and CSS. The process of converting specialized syntax into something able to be read by a browser is known as *bundling*, and requires extra tooling such as webpack.

Fortunately, Vue also provides a command-line interface (CLI), which can be used to bootstrap an application. The CLI configures all of the necessary tooling, including a bundler and development server.

In this module we'll explore how to:

- Use Vue CLI to create an application.
- Create single-file components.
- Use props to pass values into components.

Prerequisites:

- A basic understanding of Vue.js
- Knowledge of HTML and CSS
- Knowledge of JavaScript
- Familiarity with Vue.js and directives
- [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Node.js](https://nodejs.org/en/?azure-portal=true)

> [!NOTE]
> To get the code for this module, you can clone the repository by executing the following in a command or terminal window:
>
> ```bash
> git clone https://github.com/MicrosoftDocs/mslearn-vue/
> cd mslearn-vue/code/4-cli-components
> code .
> ```
