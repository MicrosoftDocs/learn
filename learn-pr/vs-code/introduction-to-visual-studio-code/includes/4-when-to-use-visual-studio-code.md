
How do you know whether Visual Studio Code is the right choice for your development work? It depends. You have a lot of choices when it comes to code editors and IDEs. In this section, we'll explore ways to help you make an evaluation.

## Decision criteria

We've created a table containing  criteria to help you decide whether Visual Studio Code is right for your scenario.

| Factor | Description |
| ----| ---- |
| Is there an official IDE for the language or framework I'm using? | There may be many different editors available for the language you want to work in. For example, you can edit HTML in just about any code editor or IDE. However, for some specialized use cases such as iOS and Android development, you may want to choose an official editor. |
| Does the IDE support the language I want to use? | Out-of-the-box, Visual Studio code supports HTML, CSS, JavaScript, TypeScript, and few other languages. With hundreds of different language extensions to choose from, Visual Studio Code can be configured to meet most programming needs. Language support means that Visual Studio Code can provide features such as code completion (IntelliSense) as you're editing and debugging capabilities for code written in that language. |
| Do I want an IDE with a small download? | The installation footprint of Visual Studio Code is very small, letting you download, install, and get started working quickly. Visual Studio Code is lightweight. You install only those extensions that you need to work and don't have to load any unnecessary components that can slow you down. |
| Do I want source control integrated with my IDE? | Visual Studio Code has integrated source control management (SCM) and includes Git and GitHub support out-of-the-box. You can integrate with other SCM providers such as Subversion or Bitbucket by installing extensions from the marketplace. |

## Apply the criteria

Now let's apply the decision criteria to our restaurant scenario. Recall that we're building a web application in Node.js, an inventory application in C++, and a data analytics tool using Python and Jupyter notebooks.

Let's add one more requirement to our scenario. The restaurant manager likes the work you're doing and has made an additional request: the restaurant would like to see if you can develop mobile apps for patrons to place pickup and takeout orders. So we'll also apply the criteria to mobile app development for iOS and Android development.

| Factor | Web development | C++ development | Data science | iOS/Android Development |
| ---- | ----| ---- | ----| ---- |
| Is there an official IDE for this language or framework? | No | No | No | Yes |
| Does Visual Studio Code support the language or framework I'm using? | Yes | Yes | Yes | Yes |
| Do I want an IDE with a small footprint? | Yes | Yes | Yes | Yes |
| Do I need source control integration with my IDE? | Yes | Yes | Maybe | Yes |
| Use Visual Studio Code? | Yes | Yes | Yes | Maybe |

After applying the criteria, you determine that Visual Studio Code is a good choice for your web development, C++, and data science projects for the restaurant. Although Visual Studio Code does have extensions to support iOS and Android development, you may prefer to use the full-featured official iOS (XCode) and Android (Android Studio) IDEs for mobile app development.