If you have a list of queries that you'd like to run then evaluate, the `evaluate` function also supports a target parameter, which can send queries to an application to collect answers then run your evaluators on the resulting query and response. A target can be any callable class in your directory.

## Scenario

An Ask Wiki app is provided that uses the Wikipedia API to answer questions using information available in Wikipedia articles.

## Instructions

In this exercise, you assess the relevance of the chatbot’s responses given a query. Open the `evaluate-target.ipynb` file to get started.