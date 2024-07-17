Model manipulation occurs during the model training phase. The two primary vulnerability types in this category are model poisoning and data poisoning.

## Model poisoning.

Model poisoning is the ability to poison the trained model by tampering with the model architecture, training code, or hyperparameters. Examples of model poisoning attack techniques include:

**Availability Attacks**: These aim to inject so much bad data into the system that the model's learned boundary becomes useless. This can lead to a significant drop in accuracy, even under strong defenses.

**Integrity (Backdoor) Attacks**: These sophisticated attacks leave the classifier functioning normally but introduce a backdoor. This backdoor allows the attacker to manipulate the model's behavior for specific inputs, potentially leading to private information leakage or system breakdown.

**Adversarial Access Levels**: The effectiveness of poisoning attacks depends on the level of adversarial access, ranging from most to least dangerous[4](https://edgeservices.bing.com/edgesvc/chat?udsframed=1&form=SHORUN&clientscopes=chat,noheader,udsedgeshop,channelstable,wincopilot,ntpquery,devtoolsapi,udsinwin11,udsdlpconsent,udsfrontload,cspgrd,&shellsig=36363b5201e0b23d742924dcfa3824cb980ee08d&setlang=en-US&lightschemeovr=1). Attackers can use strategies like boosting malicious updates or alternating minimization to maintain stealth and improve attack success.

## Data poisoning

Data poisoning is similar to model poisoning, but involves modifying the data on which the model is trained and/or tested on before training takes place.

This occurs when an adversary intentionally injects bad data into an AI or machine learning (ML) model's training pool. The goal is to manipulate the model's behavior during decision-making processes. 

Four examples of data poisoning include:

- Backdoor poisoning
- Availability attacks
- Model inversion attacks
- Stealth attacks

### Backdoor Poisoning:

In this attack, an adversary injects data into the training set with the intention of creating a hidden vulnerability or "backdoor" in the model. The model learns to rely on this backdoor, which can later be exploited by the attacker to manipulate its behavior.

For example, imagine a spam filter trained on email data. If an attacker subtly introduces spammy keywords into legitimate emails during training, the filter might inadvertently classify future spammy emails that contain these keywards as legitimate.

### Availability Attacks:

Availability attacks aim to disrupt the availability of a system by contaminating its data during training. For instance:

- An autonomous vehicle's training data includes images of road signs. An attacker could inject misleading or altered road sign images, causing the vehicle to misinterpret real signs during deployment.
- Chatbots trained on customer interactions might learn inappropriate language if poisoned data containing imaginative expletives is introduced. This may lead to the chatbot providing answers that are inappropriate.

### Model Inversion Attacks:

Model inversion attacks exploit the model's output to infer sensitive information about the training data. For example, a facial recognition model is trained on a dataset containing both celebrities and private individuals. An attacker could use model outputs to reconstruct private individuals' faces, violating privacy.

### Stealth Attacks:

Stealthy poisoning techniques aim to evade detection during training. Attackers subtly modify a small fraction of the training data to avoid triggering alarms. For example, altering a few pixels in images of handwritten digits during training could cause a digit recognition model to misclassify specific digits.

Model manipulation attacks can be mitigated by several security controls:

- Protecting the AI model itself from being poisoned with rogue data, this is achieved by limiting access to the model itself via identity, network and data security controls.
- Preventing an AI models' training data from being tampered with by restricting access to the data, once again using identity, network and data security controls.
- Detecting model inversion attacks with outbound content filters.