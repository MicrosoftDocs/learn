Consider the following scenario. Then choose the best response for each question that follows and select "Check your answers."

Before they migrate their existing e-commerce system from their datacenter to production environments on Azure, the Tailwind Traders team wants to first set up environments for development and testing.

<div style="background:yellow;">
TODO: If we like this scenario, create a diagram that shows the Dev and Test environments.

Each environment might contain a bank of VMs, a database, a network, and so on.

The Test environment might be more complete because it's one step closer to production than Dev.
</div>

An e-commerce system might require a website, the products database, a payment system, and so on. Because developers can't always run the entire service from their local development environment, the _Dev_ environment is the first place where everything the app needs comes together.

After the development team verifies changes to the _Dev_ environment, they promote changes to the _Test_ environment. The _Test_ environment is where the testing team verifies new app features and also verifies that no _regressions_, or breaks to existing features, happens as new features are added.

The team will map each component in their existing infrastructure to the appropriate Azure service.
