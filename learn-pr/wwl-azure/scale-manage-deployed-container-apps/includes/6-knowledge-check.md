## Multiple Choice
What is a revision in Azure Container Apps?
( ) A version of your container app that can be deleted. {{Incorrect. A revision is an immutable snapshot of your container app.}}
( ) A snapshot of your container app that can be edited. {{Incorrect. A revision is an immutable snapshot of your container app.}}
(x) An immutable snapshot of your container app. {{Correct. A revision is an immutable snapshot of your container app.}}

## Multiple Choice
What is the purpose of using revisions in Azure Container Apps?
(x) To manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app. {{Correct. Revisions help you manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app. You can control which revisions are active, and the external traffic that is routed to each active revision.}}
( ) To merge multiple versions of your app into one. {{Incorrect. Revisions are used to manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app.}}
( ) To delete previous versions of your app. {{Incorrect. Revisions are used to manage the release of updates to your container app by creating a new revision each time you make a revision-scope change to your app.}}

## Multiple Choice
What is the purpose of enabling ingress in Azure Container Apps?
( ) To enable outgoing HTTP requests or TCP traffic. {{Incorrect. Enabling ingress controls incoming HTTP requests or TCP traffic.}}
(x) To control the routing of external and internal traffic to your container app. {{Correct. Enabling ingress allows you to enforce a set of rules that control the routing of external and internal traffic to your container app.}}
( ) To create an Azure Load Balancer. {{Incorrect. Enabling ingress does not require creating an Azure Load Balancer.}}

## Multiple Choice
Which of the following statements is true about scaling in Azure Container Apps?
( ) Adding or editing scaling rules creates a new revision of your container app. {{Incorrect. This statement is true, but it does not provide a complete answer.}}
( ) Scaling is defined by the combination of limits, rules, and behavior. {{Incorrect. This statement is true, but it does not provide a complete answer.}}
(x) Azure Container Apps manages automatic horizontal scaling through a set of declarative scaling rules. {{Correct. Azure Container Apps manages automatic horizontal scaling through a set of declarative scaling rules.}}

## Multiple Choice
Which of the following is NOT supported by Azure Container Apps ingress settings?
( ) External and internal ingress. {{Incorrect. Azure Container Apps supports both external and internal ingress.}}
( ) HTTP and TCP ingress types. {{Incorrect. Azure Container Apps supports both HTTP and TCP ingress types.}}
(x) SMTP and UDP ingress types. {{Correct. Azure Container Apps does not support SMTP and UDP ingress types.}}
