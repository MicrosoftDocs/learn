Custom evaluators are useful when you need to score behavior that the built-in catalog doesn't cover, such as brand tone, answer formatting, or a domain-specific rubric. In this exercise, you use a prompt-based evaluator stored in a `.prompty` file (a YAML-fronted prompt template that the SDK can load as a callable evaluator) to score how friendly the chatbot sounds, and then run it through the Azure AI Evaluation SDK alongside the built-in evaluators.

## Scenario

Contoso Airways is developing a customer support chatbot to assist customers with managing their flight reservations, offering real-time help with booking changes, cancellations, and seat selection. The AI-powered chatbot is designed to provide quick, accurate responses, streamlining the travel experience and reducing wait times for customer service inquiries.

## Instructions

In this exercise, you assess the friendliness of the customer support chatbot based on how the model responds during a customer interaction. Open the `evaluate-custom-evaluator.ipynb` file to get started.

For more information about the evaluator model behind this pattern, see [Custom evaluators](/azure/foundry/concepts/evaluation-evaluators/custom-evaluators).
