Consider the following scenario. Then choose the best response for each question that follows, and select **Check your answers**.

Before they migrate their existing e-commerce system from their datacenter to production environments on Azure, the Tailwind Traders team wants to first set up environments for development and testing.

Here's a diagram that shows the basic compute, database, and networking components found in each environment:

:::image type="content" source="../media/7-dev-test-environments.svg" alt-text="A diagram of the development and test environments. Each environment contains virtual machines, a database, and a virtual network. The development environment includes three virtual machines. The test environment contains six virtual machines." border="false":::

An e-commerce system might require a website, the products database, a payment system, and so on. Because developers can't always run the entire service from their local development environment, the _Dev_ environment is the first place where everything the app needs comes together.

After the development team verifies changes to the Dev environment, they promote changes to the Test environment. The Test environment is where the testing team verifies new app features and also verifies that no _regressions_, or breaks to existing features, happen as new features are added.

The team will map each component in their existing infrastructure to the appropriate Azure service.
