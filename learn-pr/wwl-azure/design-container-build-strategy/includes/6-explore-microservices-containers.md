:::image type="content" source="../media/devops-ci-image-009-2abf2532.png" alt-text="The monolithic approach is shown with one app. The microservices approach is shown with multiple apps.":::


The most immediately lucrative use for containers has been simplifying DevOps with easy developer-to-test-to-production flows for services deployed in the cloud or on-premises.

But there's another fast-growing scenario where containers are becoming compelling.

Microservices is an approach to application development. Every part of the application is deployed as a fully self-contained component, called a microservice, that can be individually scaled and updated.

Containers lend themselves well to this style of development.

## Example scenario

Imagine that you're part of a software house that produces an extensive monolithic financial management application to migrate to a series of microservices.

The existing application would include the code to update the general ledger for each transaction, and it would have this code in many places throughout the application.

If the schema of the general ledger transactions table is modified, it would require changes throughout the application.

By comparison, the application could be modified to make a notification that a transaction has occurred.

Any microservice that is interested in the transactions could subscribe. In particular, a separate general ledger microservice could subscribe to the transaction notifications and then do the available ledger-related functionality.

If the table schema that holds the general ledger transactions is modified, only the general ledger microservice should be updated.

If a particular client organization wants to run the application and not use the general ledger, that service could be disabled. No other changes to the code would be required.

## Scale

In a dev/test environment on a single system, while you might have a single instance of each microservice, in production, you might scale out to different numbers of instances across a cluster of servers depending on their resource demands as customer request levels rise and fall.

If different teams produce them, the teams can also independently update them.

Microservices isn't a new programming approach, nor is it tied explicitly to containers, but the benefits of Docker containers are magnified when applied to a complex microservice-based application.

Agility means that a microservice can quickly scale out to meet the increased load.

The namespace and resource isolation of containers prevent one microservice instance from interfering with others. And the Docker packaging format and APIs unlock the Docker ecosystem for the microservice developer and application operator.

With a good microservice architecture, customers can solve a container-based service's management, deployment, orchestration, and patching needs with reduced risk of availability loss while maintaining high agility.
