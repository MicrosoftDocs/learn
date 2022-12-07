---
title: Exercise - Design a deployment solution
durationInMinutes: 10
---

Welcome to Proseware! You've been hired as the *lead data scientist* to help us design a machine learning deployment solution. 

## Understand the problem

:::row:::
    :::column span="":::
        :::image type="content" source="../media/mock-up-app.png" alt-text="Show the mobile application." lightbox="../media/mock-up-app.png":::
    :::column-end:::    
    :::column span="2":::
        At Proseware, we're developing a **mobile application** that will help doctors diagnose diseases in patients faster. A doctor can enter the patient's medical data into the app to get a diagnosis on the patient.

        Our first planned feature is that the app will tell the doctor *whether the patient should be further screened or treated for diabetes*.

        We have already collected data that correlates with diabetes, such as the number of pregnancies, age, and body mass index (BMI). We also have a team of data scientists working on training a model that can classify whether a patient is likely to have diabetes. 

        We need your help deciding how to deploy the model to integrate it with our mobile application.

        We're looking forward to your advice on **how to design the model's deployment solution**!
    :::column-end:::
:::row-end:::

## Consider the requirements

| Consideration | Description |
|---|---|
|:::image type="icon" source="../media/01-frequency.png":::|**Consider the frequency**. The plan is that a doctor enters a patient's information into the app, like their age and BMI. After entering, a doctor can select the `Analyze` button, after which the model should predict whether or not a patient is likely to have diabetes.|
|:::image type="icon" source="../media/02-costs.png":::|**Consider the compute**. A doctor consultation typically takes less than 10 minutes. If we want doctors to use this app, we need the answers to be returned as quickly as possible. The deployed model should always be available as we don't know when a doctor may use it.|
|:::image type="icon" source="../media/03-size.png":::|**Consider the size**. A doctor will only use the app to get a prediction on an individual's situation. There's no need for generating the predictions of multiple patients at once.|

## Propose a solution