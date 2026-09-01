Now that the Adventure Works team has specified and designed their agent, they need a way to take it from a working prototype to a reliable production service. That shift from prototype to production is what the **Generative AI Operations** (**GenAIOps**) lifecycle organizes.

If you've applied DevOps to software, or **MLOps** to machine learning, GenAIOps builds on the same idea. It's a specialized domain within MLOps for applications that integrate language models. The difference is *what* you manage. Instead of building models from scratch, you work with pretrained models, prompts, agents, and data connectors, and you evaluate them with new quality and safety measures like coherence, groundedness, and cost per request, rather than accuracy alone.

:::image type="content" source="../media/operations-layers.png" alt-text="Diagram that shows GenAIOps building on MLOps, which builds on DevOps, each layer adding capabilities and evaluation measures.":::

With that connection in mind, let's focus on the lifecycle itself.

## Explore the GenAIOps lifecycle

The GenAIOps lifecycle is complex, and anything but linear. It's an iterative process, reflecting the multifaceted nature of real-world applications. It includes three primary loops, all unified by a fourth overarching loop.

:::image type="content" source="../media/lifecycle.png" alt-text="Diagram that shows the language model lifecycle in loops.":::

- **Explore:** Where you *define* the business need, or use case, and *design* the architecture, including necessary prompts and models.
- **Build:** Where you *develop* the initial application and *evaluate* it iteratively to reach quality and safety targets.
- **Operationalize:** Where you *deploy* the application for real-world use, and *deliver* reliable and responsible service.

Overarching all these phases is the **management loop**, which focuses on governance, security, and compliance. It's a framework that balances speed in deliverables with strict adherence to standards.

Think about the Adventure Works agent: the specification and design work you saw earlier belong to the **Explore** and **Build** loops. Which loop do you think a sudden spike in wrong recommendations would send the team back to?

Next, you delve into the tools that support each phase of the GenAIOps lifecycle.
