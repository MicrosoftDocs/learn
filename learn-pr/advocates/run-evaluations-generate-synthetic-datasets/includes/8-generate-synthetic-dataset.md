Synthetic data is artificially generated data designed to mimic real-world scenarios. It's used to supplement real-world data, especially when certain types of data are scarce or difficult to obtain. Synthetic data can be generated in large quantities, providing ample data for evaluation. In addition, synthetic data avoids potential privacy issues associated with user-generated data.

The Azure AI Evaluation SDK is equipped with a Simulator class which provides end-to-end synthetic data generation capabilities. This capability enables developers to effectively test their application’s responses to typical user queries, even in the absence of production data.

## Scenario

Contoso Zoo is developing an AI-powered smart guide app to enhance visitor’s experiences. The app aims to answer questions about wildlife. To evaluate the responses from the app, we need to create a comprehensive synthetic question-answer dataset that covers various aspects of wildlife, including animal behavior, habitat preferences, and dietary needs.

## Instructions

In this exercise, you generate a synthetic question-answer dataset for the Contoso Zoo app. The dataset includes standard question-answer pairs, and also incorporates conversation starters to simulate contextually relevant interactions. Open the `generate-synthetic-data.ipynb` file to get started.