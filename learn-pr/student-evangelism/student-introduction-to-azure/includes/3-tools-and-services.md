As a student, you likely have many projects to complete. To ensure you deliver high quality work on time you need great tools, the right set of skills, and resources to overcome any challenge that comes your way.

In this unit, we'll explore tools and services that can help you succeed in your projects.

:::image type="icon" source="../media/github-logo.png" border="false":::

## GitHub

GitHub is a hosted service that allows companies, single developers, and students to host and collaborate on projects using Git. GitHub has an Octocat as its logo, which you may have encountered if you’ve visited a user group or conference. In fact, there’s even a story about the Octocat penned by the daughter of one of the developers working for GitHub. Here’s the story:

_Once upon a time, there was a curious cat named Monalisa Octocat. She discovered GitHub, a magical ocean of coding and collaboration. With GitHub's help, she explored exciting projects, collaborated with developers worldwide, and showcased her own coding creations. It became her favorite playground, where she could unleash her creativity and left her pawprints in the digital world._

When we love the tools we use, we take the time to learn all the features to be faster and more productive. In some cases, we even make up stories. The point is, it's worth spending time becoming proficient in a tool, whether that’s Visual Studio Code, GitHub or something else.

### Scenario: Code collaboration

Imagine you're a computer science student eager to learn how to effectively collaborate on coding projects using Git and GitHub. You decide to create your first GitHub repository to track assignments. You initiate a local Git repository on your machine, add project files, and commit your initial changes. Next, you create a new repository on GitHub and link it to your local repository using the provided Git remote commands. You push your code to GitHub, enabling you to access your project from anywhere. You share the repository URL with your classmates, allowing them to clone the repository, make changes, and propose improvements through pull requests. With Git and GitHub, you can easily collaborate, manage versions, and merge changes to create an impressive final project.

:::image type="icon" source="../media/vs-code-logo.png" border="false":::

## Visual Studio Code

Visual Studio Code is a free integrated development environment (IDE) that runs on most operating systems and is compatible with GitHub. An IDE is a software application that provides a comprehensive environment for software development. The purpose of an IDE is to make it easier for developers to write and debug code by providing a centralized interface for all the tools they need.

Visual Studio Code has a rich ecosystem of extensions you can install that will enhance your coding experience. It also pairs nicely with GitHub as it has great support for it. This tool can make coding and debugging a breeze.  

### Scenario: Build a website

Imagine you’re building a web page as part of your group project. You need to add HTML for the appearance, JavaScript code to make it interactive, and CSS to make it fun and appealing to use. Using Visual Studio Code, you can add extensions that let you type all you need for your website even faster. Visual Studio Code can check your syntax, suggests snippets of code, and preview your website to ensure you’re happy with the outcome before you publish it. With Visual Studio Code, you can build a website faster and better than you thought possible.

:::image type="icon" source="../media/copilot-logo.png" border="false":::

## GitHub Copilot

GitHub Copilot is a tool that uses AI to give you suggestions based on a typed text instruction, or **prompt**. This tool helps you by providing code suggestions, answers to questions and fixes or optimizations for your code, empowering you to write code faster and with greater precision.

For example, when provided with the prompt: `create a web page with styles and javascript`. Copilot responded with the HTML below:

```html
<html> 

  <head> 

    <link href=”css/styles.css”> 

    <script src=”src/script.js”> 

  </head> 

  <body> 

  </body> 

</html> 
```

A student working on a web app project can leverage GitHub Copilot throughout the development process. From setting up the project to writing code (HTML, CSS, and JavaScript). GitHub Copilot provides helpful suggestions and code snippets, saving time and improving code quality. It also assists with testing, debugging, and even helps set up continuous integration and deployment. With GitHub Copilot, you can complete coding projects with ease, deliver a high-quality application efficiently and enhance your overall coding experience.

## GitHub Codespaces

Every time you’re on a new developer machine, you likely need to install the runtime for your programming language, add environment variables and do all sorts of configuration so you can start developing. You might even need to do these configurations for each new project.  

GitHub Codespaces addresses this problem by providing a fully configured, cloud-hosted development environment. You can set up GitHub Codespaces to have everything installed so you can work on a data science project or configure an environment to be used for web development with Java, for example. Having this capability is great both for your projects as well as use in a classroom setting where you can start with exercises right away instead of first performing installations and configurations. Additionally, you can customize your Codespace environment to match your preferences.

GitHub Codespaces has many examples of pre-configured environments for common developer scenarios like web development and machine learning, but the service also allows you to define an environment yourself. To create your own GitHub Codespace environment, you create a directory with files like so:

`.devcontainer/`

  `Dockerfile`

  `devcontainer.json`

In the _Dockerfile_, you specify the runtimes you need, for example: downloading and installing Python. The _devcontainer.json_ file is used to configure settings in your environment, including extensions you want to be pre-installed. Here's example code instructing Codespaces to install an extension called `streetsidesoftware.code-spell-checker`:

```json
{
  "image": "mcr.microsoft.com/devcontainers/typescript-node",

  "customizations": {
    "vscode": {
      "extensions": ["streetsidesoftware.code-spell-checker"]
    }
  },
  "forwardPorts": [3000]
}
```

### Scenario: Develop a project without dependencies

You’re a Python developer that needs to install a bunch of libraries: pandas, Keras, matplotlib and more.  

Using Codespaces, you don’t need to wade through installations. Instead, you create a devcontainer configuration, a _Dockerfile_, where you define the runtimes you need, and a _devcontainer.json_ file, where you specify extensions you want pre-installed. Next, you check in those files to a repository in GitHub. Finally, you use GitHub Codespaces to start up your repo and you’re met with a Visual Studio Code environment running in your browser, containing the runtimes you specified in the _Dockerfile_ and the extensions installed that you configured in the _devcontainer.json_ file. The next time you want to develop in Python, you start up your Codespaces environment and you're able to start working right way, avoiding any more manual installations.

By utilizing both GitHub and Visual Studio, you have access to a powerful set of tools for writing, debugging, and testing code with speed and efficiency. Collaborating with others is made easy through GitHub, while GitHub Copilot can assist you in writing code more quickly. Additionally, GitHub Codespaces provides a fully configured development environment in the cloud, allowing you to begin development immediately.
