Imagine you're working at Proseware, a start-up focused on helping health care practitioners be more successful in their work. To help practitioners, a new web application is being developed to help diagnose patients more quickly based on medical information. 

A diabetes classification model is trained and ready to be integrated with the web app. An important long-term goal of Proseware is to continuously improve the app and the model's accuracy in the future. 

You've joined the team as a machine learning engineer and are asked to standardize the continuous integration of the model with the app. One important aspect of standardization is ensuring the code used to train the model is verified. 

To verify the code used to train the diabetes classification model, you'll want to run:

- **Linting**: Checking for programmatic or stylistic errors in Python or R scripts.
- **Unit testing**: Checking for the performance of the contents of the code.

To help the data science team understand the code quality standards, they'll be able to verify their code when developing locally in Visual Studio Code. 

However, you want to automate the code verification to check that all code pushed to production has no issues and works as expected. Together with the data science team, you decide to run linting and unit testing whenever a pull request is created by using GitHub Actions.