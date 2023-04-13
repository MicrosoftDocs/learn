The ThisOrThat web app uses a machine learning model built using the Custom Vision AI service to differentiate between similar images.

You have a web app built that can consume machine learning models, but you don't want a complicated process to rebuild the app when you need to import a fresh model. In addition, you need this app to work offline, so you need to avoid API calls.

In this module, we'll train a custom machine learning model on some similar tagged images, then we'll import that model into a web app. Finally, we'll create a GitHub Action to create a continuous integration workflow so that when you push a new model to your repo, you'll rebuild the app.

## Learning objectives

In this module, you will:

- Train a model with tagged images using Custom Vision AI service.
- Test the model for accuracy.
- Export model assets for use in a web app.
- Build a Vue.js web app to host the model assets.
- Use these assets to perform inference using hard-to-distinguish images.
- Build a GitHub Action to create a continuous delivery workflow.
- Swap the model assets for fresh assets to test the workflow.
