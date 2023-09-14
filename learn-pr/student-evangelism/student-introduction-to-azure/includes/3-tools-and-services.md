As a student, you likely have many projects to complete. To ensure you deliver high quality work on time, you need great tools, the right set of skills, and resources to overcome challenges that come your way.

In this unit, we'll explore tools and services that can help you succeed in your projects.

## Microsoft Learn

Microsoft Learn is a learning platform that’s free to use and consists of a wide variety of topics presented in training modules. Each module guides you through concepts, and in many cases exercises that allow you to practice the concepts you were taught. Microsoft Learn is an extensive library of interactive courses and hands-on learning experiences, empowering you to master new technical skills at your own pace.

### Gamification

To make your learning fun, Microsoft Learn has a gamification system, meaning that you get points for each completed module or completed path, which are groups of training modules on a specific topic.  

You can also keep track of your progress via your profile. There you can find information about your module learning progress, achievements, cloud skill challenges, and much more.

:::image type="content" source="../media/track-progress.png" alt-text="Screenshot showing a Microsoft Learn profile with progress tracked.":::

### Scenario: Learn Python

To be an app developer, you typically need skills in at least one programming language. Python is a great choice of language to learn because it can be used for many purposes, including data science, app development, IoT, and more.

In the path [Python for beginners](../../../paths/beginner-python/index.yml) you’ll be taken through the fundamentals of the language as well as more advanced topics like working with Python in a Notebook or managing many files and dependencies as part of a project.

## GitHub :::image type="icon" source="../media/github-logo.png" border="false":::

GitHub is a hosted service that allows companies, single developers, and students to host and collaborate on projects using Git. GitHub has an Octocat as its logo, which you may have encountered if you’ve visited a user group or conference. In fact, there’s even a story about the Octocat penned by the daughter of one of the developers working for GitHub. Here’s the story:

_Once upon a time, there was a curious cat named Monalisa Octocat. She discovered GitHub, a magical ocean of coding and collaboration. With GitHub's help, she explored exciting projects, collaborated with developers worldwide, and showcased her own coding creations. It became her favorite playground, where she could unleash her creativity and leave her pawprints in the digital world._

When we love the tools we use, we take the time to learn all the features to be faster and more productive. In some cases, we even make up stories. The point is, it's worth spending time becoming proficient in a tool, whether that’s Visual Studio Code, GitHub, or something else.

### Scenario: Code collaboration

Imagine you're a computer science student eager to learn how to effectively collaborate on coding projects using Git and GitHub. You decide to create your first GitHub repository to track assignments. You initiate a local Git repository on your machine, add project files, and commit your initial changes. Next, you create a new repository on GitHub and link it to your local repository using the provided Git remote commands. You push your code to GitHub, enabling you to access your project from anywhere. You share the repository URL with your classmates, allowing them to clone the repository, make changes, and propose improvements through pull requests. With Git and GitHub, you can easily collaborate, manage versions, and merge changes to create an impressive final project.

## Visual Studio Code :::image type="icon" source="../media/visual-studio-code-logo.png" border="false":::

Visual Studio Code is a free integrated development environment (IDE) that runs on most operating systems and is compatible with GitHub. An IDE is a software application that provides a comprehensive environment for software development. The purpose of an IDE is to make it easier for developers to write and debug code by providing a centralized interface for all the tools they need.

Visual Studio Code has a rich ecosystem of extensions you can install that will enhance your coding experience. It also pairs nicely with GitHub as it has great support for it. This tool can make coding and debugging a breeze.  

### Scenario: Build a website

Imagine you’re building a webpage as part of your group project. You need to add HTML for the appearance, JavaScript code to make it interactive, and CSS to make it fun and appealing to use. Using Visual Studio Code, you can add extensions that allow you to type all you need for your website even faster. Visual Studio Code can check your syntax, suggest snippets of code, and preview your website to ensure you’re happy with the outcome before you publish it. With Visual Studio Code, you can build a website faster and better than you thought possible.

## GitHub Copilot :::image type="icon" source="../media/copilot-logo.png" border="false":::

GitHub Copilot is a tool that uses AI to give you suggestions based on a typed text instruction, or *prompt*. This tool helps you by providing code suggestions, answers to questions, and fixes or optimizations for your code, empowering you to write code faster and with greater precision.

For example, when provided with the prompt `create a web page with styles and javascript`, Copilot responded with the following HTML:

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

A student working on a web app project can use GitHub Copilot throughout the development process, from setting up the project to writing code (HTML, CSS, and JavaScript). GitHub Copilot provides helpful suggestions and code snippets, saving time and improving code quality. It also assists with testing and debugging and even helps set up continuous integration and deployment. With GitHub Copilot, you can complete coding projects with ease, deliver a high-quality application efficiently, and enhance your overall coding experience.

## GitHub Codespaces

Every time you’re on a new developer machine, you likely need to install the runtime for your programming language, add environment variables, and do all sorts of configuration so you can start developing. You might even need to perform these configurations for each new project.  

GitHub Codespaces addresses this problem by providing a fully configured, cloud-hosted development environment. You can set up GitHub Codespaces to have everything installed so you can work on a data science project or configure an environment to be used for web development with Java, for example. Having this capability is great both for your projects and for use in a classroom setting where you can start with exercises right away instead of first performing installations and configurations. Additionally, you can customize your Codespaces environment to match your preferences.

GitHub Codespaces has many examples of preconfigured environments for common developer scenarios like web development and machine learning, but the service also allows you to define an environment yourself. To create your own GitHub Codespaces environment, you create a directory with files:

`.devcontainer/`

  `Dockerfile`

  `devcontainer.json`

In the _Dockerfile_, you specify the runtimes you need, for example, downloading and installing Python. The _devcontainer.json_ file is used to configure settings in your environment, including extensions you want to preinstall. Here's example code that instructs Codespaces to install an extension called `streetsidesoftware.code-spell-checker`:

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

You’re a Python developer who needs to install a bunch of libraries: pandas, Keras, matplotlib, and more.  

Using Codespaces, you don’t need to wade through installations. Instead, you create a devcontainer configuration, a _Dockerfile_ where you define the runtimes you need, and a _devcontainer.json_ file where you specify extensions you want to preinstall. Next you check in those files to a repository in GitHub. Finally, you use GitHub Codespaces to start up your repo. You see with a Visual Studio Code environment running in your browser, containing the runtimes you specified in the _Dockerfile_ and the installed extensions that you configured in the _devcontainer.json_ file. The next time you want to develop in Python, you start up your Codespaces environment and you can start working right way, avoiding manual installations.

By using both GitHub and Visual Studio, you have access to a powerful set of tools for writing, debugging, and testing code with speed and efficiency. Collaborating with others is made easy through GitHub, while GitHub Copilot can assist you in writing code more quickly. Additionally, GitHub Codespaces provides a fully configured development environment in the cloud, allowing you to begin development immediately.
