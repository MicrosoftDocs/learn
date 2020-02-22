Machine learning in all its aspects is permeating mobile and web app development. To create modern, interactive apps that can evolve over time, it's a good idea to learn how to leverage machine learning models. In this module, you will learn how to create a simple web app using Vue.js and embed a machine learning model trained using the Custom Vision AI service. You don't have to use Vue.js (a JavaScript framework) to build your app, but this module gives a sample of how to build such an app.

## What is Vue.js?

Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. Vue is designed from the ground up to be incrementally adoptable. The core library is focused on the view layer only, and can be integrated with other libraries or existing projects. Vue is also capable of powering sophisticated Single-Page Applications when used in combination with modern tooling and supporting libraries. For more information about Vue, visit [the project's docs](https://vuejs.org/v2/guide). You don't have to use Vue.js to create apps using machine learning models, but this example app demonstrates that particular framework's methodology.

## What is a machine learning model?

[Machine learning](https://en.wikipedia.org/wiki/Machine_learning) (ML), a subset of artificial intelligence, is the scientific study of algorithms and statistical models that computer systems use to perform a specific task without using explicit instructions, relying on patterns and inference instead. Machine learning algorithms are used in a wide variety of applications, such as email filtering and computer vision, where it is difficult or infeasible to develop a conventional algorithm for effectively performing a given task.

## Why create a web app including a ML model?

In this module, you'll create a web app that hosts a machine learning model locally, performing inference with it, and set up a service to perform "CI/CD" or Continuous Integration/Continuous Delivery" of fresh content whenever you push new code to your web app's codebase on GitHub. This is the process you often see in production apps that prompt the user that a fresh model is available for use.

While in a business context you might need to confirm that various line of business oriented images are properly identified, asking such questions as, "is this screw properly aligned?" or "is the pipe broken?" in this example app, we will build something much simpler (and perhaps more fun) - a way to differentiate between images that are somewhat tricky to decipher. Inspired by the work of Karen Zack (@teenybiscuit on Instagram and Twitter), we will train a model on Custom Vision AI using images of dalmatians and chocolate chip ice cream. We will then use images from the collages she created to test the model.

![Barn owl or apple?](../media/barnowl-apple.jpg)

An example of some of Karen Zack's collages of tricky images.

## What architecture will work for this project?

When building a web app using machine learning technologies, you have a few choices on how to use the models that are produced in a training process. You could host the model externally in the cloud and use an API to query it using the data with which you want to perform inference. Alternately, you could host the model itself within the web app's codebase. An advantage to doing the latter is that your app will perform inference offline, as no API calls to an internet-connected service are made. Instead, the app leverages the model that is included in the build process of the web app. A disadvantage to using a local model is that when you edit a model by retraining it, perhaps refining it or changing it entirely, you are obliged to rebuild your web app to refresh the model. In this module, we will create an architecture for this web app such that a GitHub Action will rebuild the app if any code is pushed to its repository.

## What is a GitHub Action?

A GitHub Action is a tool available within GitHub's repositories that helps to automate software workflows. With GitHub Actions, you can build, test, and deploy your code from within GitHub. For the purposes of this module, you will use a GitHub Action to be triggered when new code is pushed to your app's repository to rebuild the app.
