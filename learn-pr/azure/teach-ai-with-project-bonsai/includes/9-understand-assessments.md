In Machine Teaching, assessment means evaluating how well your AI enacts a policy across scenarios (episode configurations).

Assessment lets you determine the quality and robustness of the learned behavior in the simulated environment with data logging and live visualizations for simulations that support it.

Assessing your Brain is a crucial step throughout your Machine Teaching Experimentation process. Before considering deployment, you should ensure that your brain effectively controls the simulated environment for whichever scenarios of interest.

Bonsai assessments come in two types:

- **Automatic assessments** configured and run by Bonsai as part of the brain training process. Each training session will generate automatic assessments to evaluate brain performance for each explored policy throughout training.
- **Custom assessments** configured by users, codified in a config file, and run on demand through the Bonsai UI or Bonsai CLI.

Automatic assessments help understand how the Brain is learning. They help the platform evaluate and save better performing policies during training, the so-called champions. When a new policy is found to be better than any of the previous ones, this new policy is saved and considered the new brain champion. The Bonsai UI exposes high-level automatic assessment results in the Training chart and Assessments list so users can view the training progress. The lesson configuration used for training is reused to initialize the automatic assessments.

Custom assessments are user-defined and provide a more detailed picture of the Brain's performance. Specific scenarios of interest can be defined –different from the ones defined in the lesson if needed– and state-action pairs for each episode are collected and displayed in the Bonsai UI for review. Run custom assessments during or after training to get an in-depth picture of brain performance. Additionally, note that custom assessments are automatically stored in Log Analytics (Azure). This enables you to extract the state-action pairs for each assessed episode for custom computation of brain performance using the customer’s desired metrics in whichever units they care about.

Every assessment consists of test episodes where the Brain is asked to evaluate the policy it is training against. Each episode receives its score (goal satisfaction or total rewards), and the platform calculates an average across these scores to determine the overall assessment results.

