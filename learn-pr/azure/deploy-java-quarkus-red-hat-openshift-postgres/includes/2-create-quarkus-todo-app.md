In this module, you'll embark on a new learning journey to scaffold a new Todo application using Quarkus. You'll also seamlessly implement the entitiy class to map Java beans with the relational database. In the end, you'll create REST services to retrieve the Todo items from the database and store a new Todo item to the database.

Here is a summary of the key developer tools you'll learn in this module.

## Quarkus, Supersonic Subatomic Java

[Quarkus](https://quarkus.io) is a modern Java framework designed to build fast, efficient, and container-native applications. It is optimized for GraalVM, a high-performance Java virtual machine, which can compile Java code into native executables. This results in significantly reduced startup times and memory consumption compared to traditional Java applications.

Key features of Quarkus include:

* **Fast startup**: Quarkus applications start up in milliseconds, making them ideal for microservices architectures and serverless environments.
* **Low memory footprint**: Quarkus is designed to have a small memory footprint, allowing you to run more applications on a given hardware configuration.
* **Developer-friendly**: Quarkus provides a familiar development experience for Java developers, with support for popular frameworks and tools.
* **Container-native**: Quarkus is optimized for deployment in containers, making it easy to build and deploy cloud-native applications.
* **Extensible**: Quarkus is highly extensible, allowing you to add new features and functionality using extensions.

## Quarkus CLI

Quarkus offers multiple options for project creation, including _Maven_, _Gradle_, the [online project generator](https://code.quarkus.io/), and the _Quarkus CLI_. In this lab, we'll focus on the **Quarkus CLI**, a convenient tool easily installable as a JAR using [JBang](https://jbang.dev/). JBang allows us to execute the CLI directly without prior installation.

Run the following commands based on your operation system.

* On Linux, macOS, and Windows (using WSL or bash compatible shell like Cygwin or MinGW)

```bash
curl -Ls https://sh.jbang.dev | bash -s - trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/
curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio
```

* On Windows using Powershell:

```bash
iex "& { $(iwr https://ps.jbang.dev) } trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/"
iex "& { $(iwr https://ps.jbang.dev) } app install --fresh --force quarkus@quarkusio"
```

If JBang has already been installed, you can directly use it:

```bash
jbang app install --fresh --force quarkus@quarkusio
```

Once installed *quarkus* will be in your *$PATH* and if you run *quarkus --version* it will print the installed version:

```bash
quarkus --version
3.14.4
```

The version might be different when you run the command.

Let's see all these developer tools in action by creating the Todo application using Quarkus CLI.
