# Introduction

Working on an application means you will write code to implement business requirements. For the sake of speed and reliability you and your team might not write all of that code yourselves. You might rely on external code, libraries that someone else wrote. The advantages are many:

- **Time to market**, the ability to create and deploy an application faster than the competition could be the difference between having customers and not having it. Being fast to create and update an app is therefore crucial. A way to be fast is by using pre-built libraries when developing your application.
- **Use a 3rd party library in this case**, there are some things you shouldn't write yourself, unless you got extensive experience in that field. An example of such an area is authentication and authorization. There are so many things that can go wrong, so many cases to cover to ensure the app's resources are protected. You should be looking into 3rd party libraries that already solves this for you. Libraries that are battle tested, patched for security flaws etc.
- **Reuse**, when you build an app you might create code that future projects could benefit from. Being able to move such code out to a library means you can not only standardize how you solve certain problems within the business, but it allows you to move faster.

## Dependencies in Node.js

Node.js is just a runtime and NPM is a software registry. A global software registry that you can download libraries from. It's also possible to create your own libraries and push them to NPM, although that's outside the scope of this module.

### Dependency management

So you have access to a big global dependency like NPM, now what? Now you need to think about managing dependencies and there's more to it than simply downloading a dependency and add it to your application. You need to consider these factors:

- **Download and Installation**, downloading and installing is certainly an important part of dependency management. A thing to consider is what type of dependency you are downloading like a dependency that your app relies on to work or is it more helping you develop your app? Should you handle those differently? You should, let's explore how in this module.
- **Updating**, no code is perfect, there might be flaws in the code that needs to be patched or there might be features that are added later. When your dependency is updated you might want to get the latest version of it. You need to consider if you can use the latest and what the impact will be of doing so. Performing an *upgrade* might lead to not only upgrading that particular dependency but a set of other dependencies you rely on. This in turn might be a lot of work. Fortunately *updates* are defined in different categories, all from tiny changes that are safe to upgrade to, to major changes thar breaks your code.
- **Removing**, it might happen that a dependency has outlived it's usefulness and you no longer want it. You don't want unused dependencies to hang around in your codebase so knowing how to *clean up* is an important skill to have.

### Manifest file

To keep track of all the dependencies your app consist of your Node.js project has a manifest file. The manifest specifies the dependencies by name but also what exact version you are using. There are also other *meta* information in the manifest file like author, title, description, licensing and more. Additionally the manifest file is the center point of your application as it can be used to host scripts to manage application flows like testing and building your code.

## Learning Objectives

In this module, you will:

- Install and Uninstall dependencies
- Know the difference between global and local installs
- Manage your dependencies and update them in a predictable way
- Leverage a package.json file to describe your projects, manage dependencies run scripts and more

## Prerequisites

- Git and Node.js installed on your computer
- Familiarity with editing text and code files in any text editor
- Experience using the command line, including Git operation
