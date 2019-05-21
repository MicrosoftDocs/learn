
Show how the app now calls an API instead of an internal service.

Need a diagram of what we're updating and deploying

## Refactor application

1. Pull out the code from the monolith into a microservice project
1. Refactor to expose APIs where reliance on the microservice exits in the existing monolithic application.
    1. Could be handled by creating a proxy service for non-HTTP calls, and redirect clients to the proxy. Can then track and deprecate dependant service calls.
1. Commit code changes to app.

## Redeploy monolith with updates

How do we want to do this, update the code, and redeploy or just redeploy an already updated app and show the changes in code snippets?