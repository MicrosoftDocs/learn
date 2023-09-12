As a student, you have many college projects to complete and hand in. To ensure you deliver them on time and with high quality, you need great tools to get you there.

You need the right set of skills and resources to overcome any challenge that comes your way.

## Collaboration

As a student, you will often work in a group with other students to deliver a project. You might have an essay to write or an application to build. For the latter, you want to avoid sending files back and forth but make sure you can work in the same set of files and update those files as the application is being built. The solution is to use a version control system. Git is an example of a version control system and GitHub is a hosted service that allows you to use Git, in a collaborative way to create code and manage text.  

With GitHub, you can work quickly and efficiently, collaborating with others, on one of your student projects for example.

Additionally, Visual Studio Code is an Integrated Development Environment (IDE). It has a rich ecosystem of extensions you can install that will extend the capabilities of your IDE. It also pairs nicely with GitHub as it has great support for it. With GitHub and Visual Studio, you’ve got a combination of tools you need, to write, debug, and test code quickly and efficiently.

Let’s get started!

:::image type="icon" source="../media/vs-code-logo.png" border="false":::

## Visual Studio Code

Visual Studio Code is a great choice of IDE as it’s free and runs on most operating systems. Additionally, it has a wide range of extensions that can enhance your coding experience. This tool can make coding and debugging a breeze.  

### Scenario: Building a website faster and better than you thought possible

Imagine you’re building a web page. You need to add HTML for the appearance, JavaScript code to make it interactive and CSS to make it fun and appealing to use. Using Visual Studio Code, you can add extensions that let you type all you need for your website even faster. What makes you faster is Visual Studio Code’s capabilities that checks your syntax, suggests snippets of code and can even preview your website to ensure you’re happy with the outcome.  

:::image type="icon" source="../media/github-logo.png" border="false":::

## GitHub

GitHub is a hosted service allowing companies, single developers and students to host and collaborate on projects using Git. GitHub has an Octocat as its logo which you may have encountered if you’ve visited a user group or conference. In fact, there’s even a story about the Octocat penned by a daughter of one of the developers working for GitHub. Here’s the story below:

_Once upon a time, there was a curious cat named Monalisa Octocat. She discovered GitHub, a magical ocean of coding and collaboration. With GitHub's help, she explored exciting projects, collaborated with developers worldwide, and showcased her own coding creations. It became her favorite playground, where she could unleash her creativity and left her pawprints in the digital world._

:::image type="content" source="../media/octocat-story.jpg" alt-text="Screenshot of conceptual art showing Mona the octocat in a collaborative coding world. ":::

With tools we really love using, we tend to learn all the features, to make us even faster and more productive and in some cases, we even make up stories. The point is, it is worth spending time becoming proficient in a tool, whether that’s Visual Studio Code, GitHub or something else.

### Scenario: Collaborative Coding Platform for Students

Alice is a computer science student eager to learn how to effectively collaborate on coding projects using Git and GitHub. She decides to create her first GitHub repository to track her assignments. Alice initiates a local Git repository on her machine, adds her project files, and commits her initial changes. Next, she creates a new repository on GitHub and links it to her local repository using the provided Git remote commands. Alice pushes her code to GitHub, enabling her to access her project from anywhere. Now, she shares the repository URL with her classmates, allowing them to clone the repository, make changes, and propose improvements through pull requests. With Git and GitHub, Alice and her classmates can easily collaborate, manage versions, and merge changes to create an impressive final project.

:::image type="icon" source="../media/copilot-logo.png" border="false":::

## GitHub Copilot

GitHub Copilot is a tool that uses AI to give you suggestions based on a typed text instruction, or "prompt". This tool will help you by providing suggestions of code to write, answers to questions and can even help fix or optimize code, empowering you to write code faster and with greater precision. By using this power, you can achieve your goals faster.

```html
<!-- create a web page with styles and javascript --> 
<html> 

  <head> 

    <link href=”css/styles.css”> 

    <script src=”src/script.js”> 

  </head> 

  <body> 

  </body> 

</html> 
```

In the preceding code, the HTML comment is the prompt `create a web page with styles and javascript` and the result from Copilot is the HTML below:

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

### Scenario: Develop a Web App without hesitation

A student working on a web app project leverages GitHub Copilot throughout the development process. From setting up the project to writing code (HTML, CSS, and JavaScript), GitHub Copilot provides helpful suggestions and code snippets, saving time and improving code quality. It also assists with testing, debugging, and even helps set up continuous integration and deployment. With GitHub Copilot's support, a student successfully completes the project, delivering a high-quality application efficiently and enhancing their overall coding experience.

## GitHub Codespaces

Every time you’re on a new developer machine, you need to install the runtime for your programming language, add environment variables and do all sorts of configuration just so you can start developing. You might even need to do all this configuration for each new project.  

GitHub Codespaces addresses this problem by providing a fully configured, cloud-hosted development environment. You can for example set up GitHub Codespaces to have everything installed so you can work on a data science project including Anakonda, Notebook support or configure an environment to be used for web development with Java. Having this capability is great both for your projects as well as use in a classroom setting where you can start with exercises right away instead of first performing installations and configurations.

Additionally, you can customize your Codespace environment to match your preferences.

### Configuring a devcontainer

GitHub Codespaces has many examples of pre-configured environments for common developer scenarios like web development and machine learning, but the service also allows you to define an environment yourself. To create your own GitHub Codespace environment, you create a directory with files like so:

.devcontainer/

  Dockerfile

  devcontainer.json

In the Dockerfile, you specify the runtimes you need, for example: downloading and installing Python. The devcontainer.json file is used to configure settings in your environment, for example extensions you want to be preinstalled. Below is an example of instructing Codespaces to install an extension called `streetsidesoftware.code-spell-checker`:

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

### Scenario: Start developing projects without worrying about dependencies

You’re a Python developer that needs to install a bunch of libraries: pandas, Keras, matplotlib and many more.  

Using Codespaces, you don’t need to do all those installations. Instead, you create a devcontainer configuration, a Dockerfile, where you define the runtimes you need, and a devcontainer.json file, where you specify extensions you want pre-installed. Next, you check in those files to a repository in GitHub. Finally, you use GitHub Codespaces and start up your repo and you’re met with a Visual Studio Code environment running in your browser, containing all the runtime you specified in the Dockerfile and all the extensions installed that you configured in devcontainer.json. The next time you want to develop in Python, you start up your Codespaces environment and you avoid any more manual installations.
