> [!Note]
> To complete this exercise, read the case study that follows. At the end, you're asked to give advice by answering the knowledge check questions.

Welcome to Proseware! You're hired as the *lead data scientist* to help us design a machine learning training solution.

## Understand the problem

:::image type="content" source="../media/mock-up-app.png" alt-text="Show the mobile application." lightbox="../media/mock-up-app.png":::

At Proseware, we're developing a **mobile application** that helps doctors diagnose diseases in patients faster. A doctor can enter the patient's medical data into the app to get a diagnosis on the patient.

Our first planned feature is that the app tells the doctor *whether the patient should be further screened or treated for diabetes*.

We already collected data that correlates with diabetes, such as the number of pregnancies, age, and body mass index (BMI). We also have a team of data scientists working on training a model that can classify whether a patient is likely to have diabetes.

We need your help deciding how to train and deploy the model to integrate it with our mobile application.

## Consider the requirements

In conversations with your team of data scientists, you learned the following things to take into consideration:

- **Consider the team**: You have a team of data scientists who are familiar with training a classification model. They're used to working with Python and have no experience with SQL or Spark.
- **Consider the preferred tooling**: Your team prefers not to use a UI. You want your data scientists to train the model with notebooks and scripts. When we get audited, we need to show exactly how a model is trained. You also want your data scientists to have full control over how a model is trained.
- **Consider the compute**: You want our data scientists to get started with Jupyter notebooks, which is what they’re familiar with.

You also talked to the end-users, namely the doctors:

- **Consider the frequency**. The plan is that a doctor enters a patient's information into the app, like their age and BMI. Once a doctor enters the info, they can select the `Analyze` button, after which the model should predict whether or not a patient is likely to have diabetes.
- **Consider the compute**. A doctor consultation typically takes less than 10 minutes. If we want doctors to use this app, we need the answers to be returned as quickly as possible. The deployed model should always be available as we don't know when a doctor wants to use it.
- **Consider the size**. A doctor only uses the app to get a prediction on an individual's situation. There's no need for generating the predictions of multiple patients at once.

## Propose a solution
