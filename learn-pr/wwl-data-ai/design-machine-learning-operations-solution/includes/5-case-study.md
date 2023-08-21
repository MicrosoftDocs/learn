


> [!Note]
> To complete this exercise, read the case study. At the end, you'll be asked to give advice by answering the knowledge check questions. 

Welcome to Proseware! You've been hired as the *lead data scientist* to help us design a machine learning deployment solution. 

## Understand the problem

:::image type="content" source="../media/mock-up-app.png" alt-text="Screenshot of the mobile application to diagnose patients with diabetes." lightbox="../media/mock-up-app.png":::

At Proseware, we're developing a **mobile application** that helps doctors diagnose diseases in patients faster. A doctor can enter the patient's medical data into the app to get a diagnosis for the patient. 

Our first planned feature is that the app tells the doctor *whether the patient should be further screened or treated for diabetes*.

We have already collected data that correlates with diabetes, such as the number of pregnancies, age, and body mass index (BMI). We also have a team of data scientists working on training a model that can classify whether a patient is likely to have diabetes. 

We need your help deciding how to design for bringing the model to production.

We're looking forward to your advice on **how to design the machine learning operations (MLOps) solution**!

## Consider the requirements

- **Consider the environments**. Currently, we're working in a small team and you're the only data scientist involved. We want to see whether this project is successful before actually scaling up and getting a large team involved.
- **Consider the model**. As the model is used to help doctors, accuracy is important to us. The model should only be in use when we know it's performing as expected.
- **Consider the data**. We're starting small and will mostly use the deployed model to test our application. The data the deployed model generates predictions on shouldn't be used to retrain the model as it may be biased.