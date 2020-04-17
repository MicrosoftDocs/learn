We are about to deploy our application to the Cloud. To help us with this task we have the Azure Service Static apps. The service expects our code to live in a GitHub repository. Currently it sits in directory on our machine. We will therefore need to carry out a few steps before being able to *deploy* namely: 

1. Create a Git repository, currently our Gatsby project is a bunch of files living on our local computer
2. Create a GitHub repository, we need to push our local Git repository to GitHub
3. Deploy to the Cloud, for this part we will use the Static apps service. All we need for this step is the URL to our GitHub repository and the name for the sub directory where the static files live in our project. In Gatsby's case, this directory is called `public/`

