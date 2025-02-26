When we have our prerequisites to deliver our software continuously, we need to start thinking about a deployment pattern.

Traditionally a deployment pattern was straightforward.

:::image type="content" source="../media/classic-deployment-pattern-8d085442.png" alt-text="Diagram showing classic deployment pattern. Dev, test, staging, production.":::


The software was built, and when all features had been implemented, the software was deployed to an environment where a group of people could start using it.

The traditional or classical deployment pattern was moving your software to a development stage, a testing stage, maybe an acceptance or staging stage, and finally a production stage.

The software moved as one piece through the stages.

The production release was, in most cases, a Big Bang release, where users were confronted with many changes at the same time.

Despite the different stages to test and validate, this approach still involves many risks.

By running all your tests and validation on non-production environments, it's hard to predict what happens when your production users start using it.

You can run load tests and availability tests, but in the end, there's no place like production.
