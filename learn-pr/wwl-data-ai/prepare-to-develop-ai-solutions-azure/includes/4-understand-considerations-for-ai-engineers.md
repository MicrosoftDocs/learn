![A software engineer](../media/ai-engineer.png)

Increasingly, software solutions include AI features; so software engineers need to know how to integrate AI capabilities into their applications and services.

The advances made in machine learning, together with the increased availability of large volumes of data and powerful compute on which to process it and train predictive models, has led to the availability of prepackaged software services that encapsulate AI capabilities. Software engineers can take advantage of these services to create applications and agents that use the underlying AI functionality, using them as building blocks to create intelligent solutions.

This means that software engineers can apply their existing skills in programming, testing, working with source control systems, and packaging applications for deployment, without having to become data scientists or machine learning experts.

However, to fully capitalize on the opportunities of AI, software engineers do require at least a conceptual understanding of core AI and machine learning principles.

## Model training and inferencing

 Many AI systems rely on predictive models that must be *trained* using sample data. The training process analyzes the data and determines relationships between the *features* in the data (the data values that will generally be present in new observations) and the *label* (the value that the model is being trained to predict).

 After the model has been trained, you can submit new data that includes known *feature* values and have the model predict the most likely *label*. Using the model to make predictions is referred to as *inferencing*.

 Many of the services and frameworks that software engineers can use to build AI-enabled solutions require a development process that involves training a model from existing data before it can be used to inference new values in an application.

## Probability and confidence scores

 A well-trained machine learning model can be accurate, but no predictive model is infallible. The predictions made by machine learning models are based on *probability*, and while software engineers don't require a deep mathematical understanding of probability theory, it's important to understand that predictions reflect statistical likelihood, not absolute truth. In most cases, predictions have an associated *confidence score* that reflects the probability on which the prediction is being made. Software developers should make use of confidence score values to evaluate predictions and apply appropriate thresholds to optimize application reliability and mitigate the risk of predictions that may be made based on marginal probabilities.

## Responsible AI and ethics

It's important for software engineers to consider the impact of their software on users, and society in general; including ethical considerations about its use. When the application is imbued with artificial intelligence, these considerations are particularly important due to the nature of how AI systems work and inform decisions; often based on probabilistic models, which are in turn dependent on the data with which they were trained.

The human-like nature of AI solutions is a significant benefit in making applications user-friendly, but it can also lead users to place a great deal of trust in the application's ability to make correct decisions. The potential for harm to individuals or groups through incorrect predictions or misuse of AI capabilities is a major concern, and software engineers building AI-enabled solutions should apply due consideration to mitigate risks and ensure fairness, reliability, and adequate protection from harm or discrimination.
