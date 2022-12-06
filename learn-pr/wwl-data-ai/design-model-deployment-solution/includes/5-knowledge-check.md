Welcome to Proseware! We're a company determined to innovate health care by helping doctors to diagnose patients more quickly and reliably. 

## Understand the problem

:::row:::
    :::column span="":::
        :::image type="content" source="../media/mock-up-app.png" alt-text="Show the mobile application." lightbox="../media/mock-up-app.png":::
    :::column-end:::    
    :::column span="2":::
        We're working on several machine learning models that will help our business processes and those of our customers: health care providers. 

        One project we started is a mobile application, which allows a doctor to enter the patient's medical data. The app needs to quickly analyze the data and tell the doctor whether the patient should be further screened for diabetes. 
    :::column-end:::
:::row-end:::

---

## Consider the requirements
:::row:::
    :::column span="":::
        :::image type="icon" source="../media/02-blob.png":::
    :::column-end:::
    :::column span="2":::
        ### Consider the frequency
        The idea is that a doctor enters a patient's information into the app. After entering, a doctor can select the **Analyze** button, after which the model should predict whether or not a patient is likely to have diabetes.
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="":::
        :::image type="icon" source="../media/03-blob.png":::
    :::column-end:::
    :::column span="2":::
        ### Consider the costs
        A doctor consultation typically takes less than ten minutes. If we want doctors to use this app, we need the answers to be returned as quickly as possible. The deployed model should always be available as we don't know when a doctor may use it.
    :::column-end:::    
:::row-end:::
:::row:::
    :::column span="":::
        :::image type="icon" source="../media/04-blob.png":::
    :::column-end:::
    :::column span="2":::
        ### Consider the size 
        A doctor will only use the app to get a prediction on an individual's situation. There is no need for generating the prediction of multiple patients at once.
    :::column-end:::
:::row-end:::

---

## Propose a solution