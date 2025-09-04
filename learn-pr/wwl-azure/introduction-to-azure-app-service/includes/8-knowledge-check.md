

## Multiple Choice
Which of the following App Service plan categories provides the maximum scale-out capabilities?
( ) Dedicated compute {{Incorrect. The Dedicated compute category does not provide the maximum scale-out capability.}}
(x) Isolated {{Correct. The Isolated category provides network and compute isolation, and has the maximum scale-out capability.}}
( ) Shared compute {{Incorrect. The Shared compute category does not provide the maximum scale-out capability.}}

## Multiple Choice
Which of the following networking features of App Service can be used to control outbound network traffic?
( ) App-assigned address {{Incorrect. App-assigned address is an inbound network feature.}}
(x) Hybrid Connections {{Correct. Hybrid Connections are an outbound network feature.}}
( ) Service endpoints {{Incorrect. Service endpoints are an inbound network feature.}}

## Multiple Choice
What is the purpose of the Azure App Service Environment feature?
( ) It provides a shared infrastructure for running App Service apps. {{Incorrect. The Azure App Service Environment provides a fully isolated and dedicated environment, not a shared one.}}
( ) It allows for the deployment and running of containerized web apps on Windows and Linux. {{Incorrect. While Azure App Service does support containerized web apps, this is not the specific purpose of the App Service Environment feature.}}
(x) It provides a fully isolated and dedicated environment for running App Service apps with improved security at high scale. {{Correct. The Azure App Service Environment is designed to provide an isolated and dedicated environment for running App Service apps securely at high scale.}}

## Multiple Choice
What determines the set of compute resources for a web app to run in Azure App Service?
( ) The geographical region where the app is deployed {{Incorrect. While the geographical region does affect where the resources are created, it does not determine the set of compute resources for a web app.}}
( ) The pricing tier of the app {{Incorrect. The pricing tier affects the features and cost of the plan, but it does not directly determine the set of compute resources for a web app.}}
(x) The App Service plan {{Correct. The App Service plan defines the set of compute resources for a web app to run.}}

## Multiple Choice
What is the purpose of using deployment slots in Azure App Service?
(x) To deploy an app to a staging environment and then swap staging and production slots, eliminating downtime {{Correct. Deployment slots are used to deploy an app to a staging environment first and then swap it with the production slot, thus minimizing downtime.}}
( ) To increase the storage capacity of the application {{Incorrect. Deployment slots are not used to increase storage capacity, they are used for staging and production deployment.}}
( ) To add up to nine sidecar containers for each sidecar-enabled custom container app {{Incorrect. Sidecar containers are used to deploy extra services and features, not for staging and production deployment.}}