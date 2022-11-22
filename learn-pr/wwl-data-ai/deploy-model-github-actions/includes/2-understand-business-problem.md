To get value from a machine learning model, you'll have to **deploy** it. Whenever you deploy a model you can generate predictions whenever necessary to give you insights. 

At Proseware, a start-up in health care, you've been helping with the development of a web application that will help practitioners diagnose diseases in patients more quickly. When a practitioner enters a patient's medical information, the app will be able to give insights in the probability of that patient having a disease. 

The first use case is to help practitioners diagnose diabetes more quickly. After researching medical data, the data science team has trained a model to diagnose whether a patient is likely to have diabetes. The model is accurate enough for implementation. Now, the challenge is to use the model in the web app to generate predictions. 

As the model and the app are designed to help the health care practitioner when needed, *you don't want use the model on all the patients*. Instead, you want to give the practitioner the possibility to enter the patient's data into the web app whenever there's reason to belief that patient may have diabetes. To prevent costly and unnecessary tests, the model's predictions on the probability of a patient having diabetes will serve as a first filter to decide who should get tested and who shouldn't. 

In the future, more machine learning models to help with diagnosing diseases will be added to the web app. All in order to help the practitioner make more data-driven decisions on which tests should be run to validate that a patient has an illness. 

The purpose of the first project is to ensure that a practitioner can enter an individual's medical information in the app, and get a *direct* prediction on the probability of that patient having diabetes. By receiving a direct prediction, the practitioner can use the web app during a consultation with the patient to quickly reach a decision on next steps. 

In other words, you need to deploy the model to a **real-time endpoint**. The web app should be able to send the patient's data to the endpoint and get a prediction in return. The prediction should then be visualized in the web app to aid the practitioner.

To deploy a model, you'll want to:

- Register the model.
- Deploy the model.
- Test the deployed model.