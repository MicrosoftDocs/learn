Model manipulation is a category of attacks that target the integrity of an AI model itself or the data used to train it. Unlike prompt-based attacks that exploit the model at inference time (when it's processing requests), model manipulation attacks compromise the model during training or fine-tuning—before it's deployed. This makes them particularly dangerous because the corrupted behavior becomes part of the model's learned capabilities.

Model manipulation is cataloged as technique AML.T0022 (Data Poisoning) in MITRE ATLAS and appears in the OWASP Top 10 for LLM Applications as "Training Data Poisoning."

The two primary vulnerability types in this category are model poisoning and data poisoning.

:::image type="content" source="../media/model-manipulation-attack-surface.png" alt-text="Diagram of model manipulation attacks: data poisoning and model poisoning leading to a compromised model." lightbox="../media/model-manipulation-attack-surface.png":::

## Model poisoning

Model poisoning is the ability to corrupt a trained model by tampering with the model architecture, training code, or hyperparameters. Rather than modifying the training data, the attacker targets the model's structure or training process directly. Examples of model poisoning attack techniques include:

- **Availability attacks**: These aim to inject so much bad data or noise into the training process that the model's learned decision boundary becomes unreliable. This can lead to a significant drop in accuracy, making the model unusable.

- **Integrity (backdoor) attacks**: These sophisticated attacks leave the model functioning normally for most inputs but introduce a hidden backdoor. This backdoor allows the attacker to manipulate the model's behavior for specific inputs—for example, causing a content moderation model to always approve content that contains a specific hidden trigger phrase.

- **Adversarial access levels**: The effectiveness of poisoning attacks depends on the level of access the adversary has to the model, ranging from full access to the training pipeline (most dangerous) to limited access through API interactions only. Attackers can use strategies like boosting malicious model updates or alternating optimization techniques to maintain stealth.

## Data poisoning

Data poisoning is similar to model poisoning, but involves modifying the data on which the model is trained or tested before training takes place. This occurs when an adversary intentionally injects malicious data into an AI or machine learning (ML) model's training dataset. The goal is to manipulate the model's behavior during decision-making processes.

Four common types of data poisoning attacks include:

### Backdoor poisoning

In this attack, an adversary injects data into the training set with the intention of creating a hidden vulnerability or "backdoor" in the model. The model learns to associate a specific trigger with a specific outcome, which can later be exploited.

For example, imagine a spam filter trained on email data. If an attacker subtly introduces a specific phrase into legitimate emails during training, the filter might learn to classify future spam emails containing that phrase as legitimate.

### Availability attacks

Availability attacks aim to disrupt the usefulness of a system by contaminating its data during training. For instance:

- An autonomous vehicle's training data includes images of road signs. An attacker could inject misleading or altered road sign images, causing the vehicle to misinterpret real signs during deployment.
- Chatbots trained on customer interactions might learn inappropriate language if poisoned data containing offensive terms is introduced.

### Model inversion attacks

Model inversion attacks exploit the model's output to infer sensitive information about the training data. For example, a facial recognition model is trained on a dataset containing both public figures and private individuals. An attacker could use model outputs to reconstruct private individuals' faces, violating privacy.

### Stealth attacks

Stealthy poisoning techniques aim to evade detection during training. Attackers subtly modify a small fraction of the training data to avoid triggering alarms. For example, altering a few pixels in images of handwritten digits during training could cause a digit recognition model to misclassify specific digits without anyone noticing the change in the training data.

## Mitigating model manipulation

Model manipulation attacks can be mitigated through several security controls:

- **Protect model integrity**: Limit access to the model's training pipeline, architecture, and configuration using identity, network, and data security controls. Ensure only authorized personnel can modify training code or hyperparameters.
- **Protect training data**: Restrict access to training datasets using access controls and data governance. Validate data provenance and implement integrity checks to detect unauthorized modifications.
- **Validate model behavior**: Test models against known benchmarks before and after training to detect unexpected behavioral changes that might indicate poisoning.
- **Monitor model outputs**: Deploy outbound content filters to detect signs of model inversion attacks or other data leakage through model responses.
- **Use ML-BOM (Machine Learning Bill of Materials)**: Track the origin and transformations of data and models throughout the pipeline to maintain an audit trail.

