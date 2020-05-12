There are many ways to install Node.js. We list a few of the most common options:

- Install via executable, `https://nodejs.org/en/download/`. Here you can find different installation packages for your Operating System.
- Install via Brew, Brew is a popular package manager for Linux and Mac.
- Install via NVM, NVM stands for Node Version Manager. NVM will not only help you install a desired version of Node.js but help you manage your installation. Let's go deeper into what that means in this section.

Above you have three great options for install Node.js on your system. Let's now delve into more detail on what the required steps are to download it but also install it and verify that everything went well.

## Install via executable

Here's an excerpt from the Install page found at `https://nodejs.org/en/download/`

![Install page](../media/nodejs-install-page.png)

As you can see above there are various installers available to cater to different OSs like Windows, Mac and Linux. There's even source code available. What it also shows is how there are two different versions LTS and Current. What's that and which one should you choose?

- `LTS`, LTS stands for **Long-term **s**upport. Worth noting is how it comes with the description text `Recommended for most users`. LTS is meant for enterprise usage where frequent updates might not be possible or for various reasons are undesired.

- Current, this means it's under active development. Feature additions as well as breaking changes might happen. It should adhere to semantic versioning though [Semantic versioning](https://semver.org/)

So which one to go with? Well you know your company best. Can you update often and is there a desired feature in the Current version you need - then Current version might be for you.

To learn more about the different release types have a read here [Release types](https://github.com/nodejs/node#release-types).

## Install via package manager Brew

If you don't have Brew installed, then run this command in your Mac/Linux terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Once you have Brew installed, you can type the following command in your terminal to get the installation started:

```bash
brew install node
```

This will download all the needed binaries and also install Node.js on your system.

## Install via NVM

NVM stands for Node Version Manager and is great tool you can install to help you with the following:

- Install a specific version, this is great if we have different projects using different versions of node.
- Use a specific version, this works in tandem with being able to install different versions of the Node.js runtime. Being able to install different versions of Node.js and then *select* which versions to go with when running your Node.js application is a great feature.
- Update to a specific version, it's important to be able to update to a specific version as new features and/or patches are released.
- Uninstall a specific version, being able to *manage* what versions are installed on your machine is a great way to ensure that you only run the software you need.

As you can see it's so much more than just an installation tool.

Why would we need a tool that can do all that, isn't installation alone enough? If you work in a complex environment, you might have numerous projects you are maintaining. Not all of those projects might use the same version of Node.js for various reasons. Therefore you need to be able to have different versions of Node.js installed and you need to be able to choose which version of Node.js to run for which project.

If you have such a situation, NVM is for you.

## Verify installation

Once Node.js has finished installing, we can verify that everything is ok. One command we can run in our terminal is this command:

```bash
node --version
```

It should print out the current version in the following format:

```bash
v[major version].[minor version].[patch version]
```

The brackets `[]` above are to indicate that results may vary depending on what version you have installed on your system.
