Node.js is a popular JavaScript open-source, cross-platform runtime environment. Let's install it, along with the Node Package Manager (npm) and Express (a popular minimalist web app framework). After these tools are installed, we can use Express to create a web app framework and create a simple server.

## Using package managers for installation

Software is typically installed in the form of packages, which are kept in repositories. There are many package managers available for use with Linux. We'll take a quick look at three of them for our installations.

### apt and apt-get

Both Ubuntu and Debian come with a few package managers, including apt, apt-cache, apt-get, and dpkg, which all rely on the `.deb` format. The differences among these Advanced Packaging Tools (apt) are subtle. For the average Linux user, it's enough to know that apt provides commands for the most widely used features, and that apt-get, apt-cache, and dpkg provide more obscure features. If you're following instructions for the installation of a particular tool or framework, just use the command recommended in the instructions.

But packages in a stable release of a Linux distribution are often outdated. They might not include a package that you need. We recommend that you regularly perform a `sudo apt update`, which updates the list of available packages and their versions. You might also want to run `sudo apt upgrade`, which installs newer versions of the packages you already have installed. (You should always update before you upgrade.)

### cURL

cURL is a command-line tool that comes with many Linux distributions. It's used to download content from the internet. (It's also used for user authentication, HTTP POST, SSL connections, FTP uploads, and other tasks.) It uses URL syntax to transfer data to and from servers. (Wget is a similar tool.)

### NPM

Node Package Manager (npm), claims to be the world's largest software registry. It consists of three distinct components: the website, the command-line interface (CLI), and the registry (a large public database of JavaScript software).

## Install Node.js, npm, and Express

Open your Ubuntu command line and use the following commands to try the various package managers:

1) Use apt to ensure that you have a recent version of cURL: `sudo apt install curl`.

2) Use cURL to ensure that you get a recent version of Node.js and npm: `curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - `.

3) Use apt-get to install Node.js (as recommended in the download instructions that will appear after you run the cURL command): `sudo apt-get install -y nodejs`.

4) Install Express by using npm: `sudo npm install express-generator -g`.

5) Use `--version` to check that each package manager is installed and to get the version number, like this: `node --version`, `npm --version`, and `express --version`.

## Try using a Node.js module

Node.js has tools to help you develop server-side web apps, some built in and many more available via npm. These modules can help with many tasks:

|Tool               |Used for                                                                                                  |
|:----------------- |:---------------------------------------------------------------------------------------------------------|
|gm, sharp          |Image manipulation, including editing, resizing, compression, and so on, directly in your JavaScript code |
|PDFKit             |PDF generation                                                                                            |
|validator.js       |String validation                                                                                         |
|imagemin, UglifyJS2|Minification                                                                                              |
|spritesmith        |Sprite sheet generation                                                                                   |
|winston            |Logging                                                                                                  |
|commander.js       |Creating command-line applications                                                                       |

Let's use the built-in OS module to get some information about your computer's operating system:

1) Open the Node.js CLI by entering `node`. You'll see the `>` prompt.

2) To identify the platform in which you're currently using Node.js, enter `os.platform()`. You're using the Windows OS, but you're currently using the Ubuntu command line in the subsystem for Linux. The response will indicate that you're on the Linux platform.

3) Check your CPU's architecture by entering `os.arch()`.

4) View the the CPUs available on your system by entering `os.cpus()`.

5) Leave the Node.js CLI by entering `.exit` or by selecting Ctrl+C twice.

   > [!TIP]
   > You can use the Node.js OS module to do things like check the platform and return a platform-specific variable: Win32/.bat for Windows development, darwin/.sh for macOS/Unix, Linux, SunOS, and so on (for example, `var isWin = process.platform === "win32";`).

## Set up a basic web app framework by using Express

 Express is a minimal, flexible, and streamlined Node.js framework that makes it easier to develop a web app that can handle multiple types of requests, like GET, PUT, POST, and DELETE. Express comes with an application generator that will automatically create a file architecture for your app.

1) Create a simple Hello World app project by entering `express HelloWorld --view=pug`.

2) Examine the files and folders that Express included by entering `ls HelloWorld`.

   The files that Express generates will create a web app that uses an architecture that can appear a little overwhelming at first. Don't panic. You don't need to understand Express to follow this course, and there are plenty of resources available if you want to learn more. You'll see that the following files and folders have been generated:

   - `bin`. Contains the executable file that starts your app. It fires up a server (on port 3000 if no alternative is supplied) and sets up basic error handling.
   - `public`. Contains all the publicly accessed files, including JavaScript files, CSS stylesheets, font files, images, and any other assets that people need when they connect to your website.
   - `routes`. Contains all the route handlers for the application. Two files, `index.js` and `users.js`, are automatically generated in this folder to serve as examples of how to separate out your application’s route configuration.
   - `views`. Contains the files used by your template engine. Express is configured to look here for a matching view when the render method is called. The default template engine is Jade, but Jade has been deprecated in favor of Pug, so we used the `--view` flag to change the view (template) engine. You can see the `--view` flag options, and others, by using `express --help`.
   - `app.js`. The starting point of your app. It loads everything and begins serving user requests. It's basically the glue that holds all the parts together.
   - `package.json`. Contains the project description, scripts manager, and app manifest. Its main purpose is to track your app's dependencies and their respective versions.

3) Now that your Hello World project has been created, enter `cd HelloWorld` to get into the project. Use `sudo npm install` to install the dependencies of your project (the packages used for tasks like running the server, as defined in the `package.json` file).

   You can view a list of the packages that have been installed by using `npm list`. They'll be listed by depth (the number of nested directories deep). Packages that you installed will be at depth 0. That package's dependencies will be at depth 1, further dependencies at depth 2, and so on.

4) At this point you have the framework set up for a multiple-page web app that has access to a large variety of APIs and HTTP utility methods and middleware, making it easier to create a robust API. Let's start the Express app on a virtual server by using `DEBUG=HelloWorld:* npm start`. You can now view the running app by opening a web browser and going to **localhost:3000**.

   > [!NOTE]
   > Windows might display a firewall warning the first time you launch the web server. This warning is expected.

   ![Screenshot of Express app running in a browser](../media/express-app.png)

   > [!NOTE]
   > You can start the app by using just `npm start`, but specifying the `DEBUG` variable enables console logging/debugging.
