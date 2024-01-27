Choose the best response for each question. Then select **Check your answers**.

## Multiple Choice
What is the primary distinction between continuous delivery and continuous deployment?
(x) Continuous deployment implements full automation, including the production environment, while continuous delivery requires a manual approval for the final delivery. {{Correct. Continuous deployment and continuous delivery are closely related DevOps concepts with very similar names and the same acronym. The primary distinction between them is that continuous deployment implements full automation, including the production environment, while continuous delivery requires a manual approval for the final delivery.}}
( ) Continuous deployment focuses on minimizing time to deploy and time to mitigate, while continuous delivery strives to implement full automation. {{Incorrect. This answer describes the characteristics of continuous delivery and continuous deployment, but does not provide the primary distinction between them.}}
( ) Continuous delivery automates the entire software delivery process, while continuous deployment requires manual approval for the final delivery. {{Incorrect. This answer describes the primary distinction between continuous delivery and continuous deployment incorrectly.}}

## Multiple Choice
What is the purpose of progressive exposure techniques in CD practices?
(x) To minimize potential damage caused by programming errors that were not detected by CI-based code analysis, reviews, and automated testing. {{Correct. Progressive exposure techniques aim to control the blast radius of programming errors that were not detected by CI-based code analysis, reviews, and automated testing.}}
( ) To increase the number of users who can access the application at once. {{Incorrect. This answer does not align with the purpose of progressive exposure techniques.}}
( ) To eliminate all potential programming errors. {{Incorrect. This answer is too extreme and does not align with the purpose of progressive exposure techniques.}}

## Multiple Choice
What is the main principle of IaC that ensures consistency of the target environment and precludes the possibility of unintended side effects of intermediary changes?
( ) Automation {{Incorrect. Automation enhances efficiency, consistency, and scalability, but does not ensure consistency of the target environment.}}
(x) Idempotence {{Correct. Idempotence designates the characteristic of an action where the outcome is always the same, regardless of the number of times the action is performed. This ensures the consistency of the target environment and precludes the possibility of unintended side effects of intermediary changes.}}
( ) Version control {{Incorrect. Version control facilitates tracking changes to infrastructure in the same manner as tracking software versions.}}

## Multiple Choice
What is the purpose of a GitHub Actions workflow?
(x) To implement software delivery workflows by leveraging the capabilities of the GitHub platform {{Correct. A GitHub Actions workflow provides the mechanism for implementing software delivery workflows by leveraging the capabilities of the GitHub platform.}}
( ) To create a new repository in GitHub {{Incorrect. This is not the purpose of a GitHub Actions workflow.}}
( ) To store and reuse data across steps in a workflow {{Incorrect. This is the purpose of a variable in a GitHub Actions workflow.}}