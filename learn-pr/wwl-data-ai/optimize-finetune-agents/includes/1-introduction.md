Your team has deployed an AI agent and validated its performance through structured evaluation. Now you face the next challenge: the agent handles general hiking inquiries well, but customers request specific expertise in niche domains like winter mountaineering safety protocols or ultralight backpacking gear selection. Base model prompting alone doesn't capture the nuanced expertise needed, and you don't have sufficient real-world training data in these specialized areas.

Effective fine-tuning requires making critical design decisions rather than simply following procedural steps. You must evaluate when fine-tuning offers better value than prompt engineering, assess which fine-tuning approach matches your quality and cost constraints, recognize what makes training data effective versus problematic, and determine whether model performance improvements justify the investment.

**Adventure Works**, an outdoor adventure company, operates a Trail Guide Agent that helps customers plan hiking trips with trail recommendations, accommodation bookings, and gear suggestions. After evaluating their agent's baseline performance, the team identifies opportunities to specialize the model for advanced technical queries about gear specifications and safety equipment recommendations. They need to design a fine-tuning strategy that improves domain expertise without degrading general performance, prepare training data that meets format and quality requirements for their chosen method, and design an optimization strategy that produces measurable improvements.

This module develops your professional judgment for advanced model customization decisions. You learn to evaluate and select appropriate fine-tuning methods based on use case requirements, recognize agent quality problems and match them to the right fine-tuning approach, prepare training data that meets format and quality standards, and design optimization strategies using hyperparameter configuration and iterative evaluation.

## Learning objectives

By the end of this module, you've learned to:

- **Evaluate and select fine-tuning methods** including supervised fine-tuning (SFT), reinforcement fine-tuning (RFT), and direct preference optimization (DPO) based on quality requirements, data availability, and cost constraints.
- **Recognize agent quality problems** and determine which fine-tuning approach addresses the root cause for format inconsistency, tone misalignment, or reasoning failures.
- **Prepare training data** by validating format requirements for each fine-tuning method and applying quality principles to create effective datasets.
- **Design an optimization strategy** by evaluating baseline performance, setting measurable targets, splitting your dataset, and configuring hyperparameters for your chosen method.

Let's start by exploring how to evaluate and select fine-tuning methods for your use case.
