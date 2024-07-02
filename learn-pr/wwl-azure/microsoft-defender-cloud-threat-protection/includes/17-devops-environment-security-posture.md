With an increase of cyber attacks on source code management systems and continuous integration/continuous delivery pipelines, securing DevOps platforms against the diverse range of threats identified in the DevOps Threat Matrix is crucial. Such cyber attacks can enable code injection, privilege escalation, and data exfiltration, potentially leading to extensive impact.

DevOps posture management is a feature in Microsoft Defender for Cloud that:

 -  Provides insights into the security posture of the entire software supply chain lifecycle.
 -  Uses advanced scanners for in-depth assessments.
 -  Covers various resources, from organizations, pipelines, and repositories.
 -  Allows customers to reduce their attack surface by uncovering and acting on the provided recommendations.

## DevOps scanners

To provide findings, DevOps posture management uses DevOps scanners to identify weaknesses in source code management and continuous integration/continuous delivery pipelines by running checks against the security configurations and access controls.

Azure DevOps and GitHub scanners are used internally within Microsoft to identify risks associated with DevOps resources, reducing attack surface and strengthening corporate DevOps systems.<br>

Once a DevOps environment is connected, Defender for Cloud autoconfigures these scanners to conduct recurring scans every 24 hours across multiple DevOps resources, including:<br>

 -  Builds<br>
 -  Secure Files
 -  Variable Groups
 -  Service Connections
 -  Organizations
 -  Repositories

## DevOps threat matrix risk reduction

DevOps posture management assists organizations in discovering and remediating harmful misconfigurations in the DevOps platform. This leads to a resilient, zero-trust DevOps environment, which is strengthened against a range of threats defined in the DevOps threat matrix. The primary posture management controls include:

 -  Scoped secret access: Minimize the exposure of sensitive information and reduce the risk of unauthorized access, data leaks, and lateral movements by ensuring each pipeline only has access to the secrets essential to its function.<br>
 -  Restriction of self-hosted runners and high permissions: prevent unauthorized executions and potential escalations by avoiding self-hosted runners and ensuring that pipeline permissions default to read-only.<br>
 -  Enhanced branch protection: Maintain the integrity of the code by enforcing branch protection rules and preventing malicious code injections.<br>
 -  Optimized permissions and secure repositories: Reduce the risk of unauthorized access, modifications by tracking minimum base permissions, and enablement of secret push protection for repositories.<br>

## DevOps threat matrix

Our goal for developing the threat matrix for DevOps is to build a comprehensive knowledgebase that Defenders can use to keep track of and build defenses against relevant attack techniques. Using the MITRE ATT&CK framework as a base, we collected techniques and attack vectors associated with DevOps environments and created a matrix dedicated to DevOps attack methods.

It is worth noting that the tactics in this matrix must be looked at from the DevOps perspective. For example, execution techniques in a Virtual Machine running Windows or Linux OS are different from the Execution in a DevOps pipeline. In the Linux case, execution means running code in the OS. When we talk about DevOps environments, it means running code in the pipeline or DevOps resources. In addition to using this threat matrix to categorize attacks and corresponding defense methods, Defenders can work alongside red teams to continuously test assumptions and find new potential attack techniques.

## MITRE ATT&CK Defined

The MITRE ATT&CK matrix is a publicly accessible knowledge base for understanding the various tactics and techniques used by attackers during a cyberattack.

The knowledge base is organized into several categories: pre-attack, initial access, execution, persistence, privilege escalation, defense evasion, credential access, discovery, lateral movement, collection, exfiltration, and command and control.

Tactics (T) represent the "why" of an ATT&CK technique or sub-technique. It is the adversary's tactical goal: the reason for performing an action. For example, an adversary may want to achieve credential access.

Techniques (T) represent "how'" an adversary achieves a tactical goal by performing an action. For example, an adversary may dump credentials to achieve credential access.

Common Knowledge (CK) in ATT&CK stands for common knowledge, essentially the documented modus operandi of tactics and techniques executed by adversaries.

### Initial access

The initial access tactic refers to techniques an attacker may use for gaining access to the DevOps resources – repositories, pipelines, and dependencies. The following techniques may be a precondition for the next steps:

Source Code Management (SCM) authentication – Access by having an authentication method to the organization’s source code management. It may be a personal access token (PAT), an SSH key, or any other allowed authentication credential. An example of a method an attacker can use to achieve this technique is using a phishing attack against an organization.<br>

Continuous Integration (CI) and Continuous Delivery (CD) service authentication – Similar to SCM authentication, an attacker can leverage authentication to the CI/CD service in order to attack the organization’s DevOps.

Organization’s public repositories – Access to the organization’s public repositories that are configured with CI/CD capabilities. Depending on the organization’s configuration, these repositories may have the ability to trigger a pipeline run after a pull request (PR) is created.<br>

Endpoint compromise – Using an existing compromise, an attacker can leverage the compromised developer’s workstation, thus gaining access to the organization’s SCM, registry, or any other resource the developer has access to.

Configured webhooks – When an organization has a webhook configured, an attacker could use it as an initial access method into the organization’s network by using the SCM itself to trigger requests into that network. This could grant the attacker access to services that are not meant to be publicly exposed, or that are running old and vulnerable software versions inside the private network.

### Execution

The execution tactic refers to techniques that may be used by a malicious adversary to gain execution access on pipeline resources – the pipeline itself or the deployment resources. Some of the techniques in this section contain explanations about the different ways to perform them, or what we call sub-techniques:

Poisoned pipeline execution (PPE) – Refers to a technique where an attacker can inject code to an organization’s repository, resulting in code execution in the repository’s CI/CD system. There are different sub-techniques to achieve code execution:

 -  Direct PPE (d-PPE) – Cases where the attacker can directly modify the configuration file inside the repository. Since the pipeline is triggered by a new PR and run according to the configuration file – the attacker can inject malicious commands to the configuration file, and these commands are executed in the pipeline.<br>
 -  Indirect PPE (i-PPE) – Cases where the attacker cannot directly change the configuration files, or that these changes are not taken into account when triggered. In these cases, the attacker can infect scripts used by the pipeline in order to run code, for example, make-files, test scripts, build scripts, etc.
 -  Public PPE – Cases where the pipeline is triggered by an open-source project. In these cases, the attacker can use d-PPE or i-PPE on the public repository in order to infect the pipeline.

Dependency tampering – Refers to a technique where an attacker can execute code in the DevOps environment or production environment by injecting malicious code into a repository’s dependencies. Thus, when the dependency is downloaded, the malicious code is executed. Some sub-techniques that can be used to achieve code execution include:

 -  Public dependency confusion – A technique where the adversary publishes public malicious packages with the same name as private packages. In this case, because package search in package-control mechanisms typically looks in public registries first, the malicious package is downloaded.
 -  Public package hijack (“repo-jacking”) – Hijacking a public package by taking control of the maintainer account, for example, by exploiting the GitHub user rename feature.
 -  Typosquatting – Publishing malicious packages with similar names to known public packages. In this way, an attacker can confuse users to download the malicious package instead of the desired one.

DevOps resources compromise – Pipelines are, at the core, a set of compute resources executing the CI/CD agents, alongside other software. An attacker can target these resources by exploiting a vulnerability in the OS, the agent’s code, other software installed in the VMs, or other devices in the network to gain access to the pipeline.

Control of common registry – An attacker can gain control of a registry used by the organization, resulting in malicious images or packages executed by the pipeline VMs or production VMs.

### Persistence

The persistency tactic consists of different techniques that an attacker may use for maintaining access to a victim environment:

Changes in repository – Adversaries can use the automatic tokens from inside the pipeline to access and push code to the repository (assuming the automatic token has enough permissions to do so). They can achieve persistency this way using several sub-techniques:<br>

 -  Change/add scripts in code – we can change some of the initialization scripts/add new scripts, so they download a backdoor/starter for the attacker, so each time the pipeline is executing these scripts, the attacker’s code will be executed too.<br>
 -  Change the pipeline configuration – we can add new steps in the pipeline to download an attacker-controlled script to the pipeline before continuing with the build process.
 -  Change the configuration for dependencies locations – to use attacker-controlled packages.

Inject in Artifacts – some CI environments have the functionality for creating artifacts to be shared between different pipeline executions. For example, in GitHub we can store artifacts and download them using a GitHub action from the pipeline configuration.

Modify images in registry – In cases where the pipelines have permissions to access the image registry (for example, for writing back images to the registry after build is done) the attacker could modify and plant malicious images in the registry, which would continue to be executed by the user’s containers.<br>

Create service credentials – A malicious adversary can leverage the access they already have on the environment and create new credentials for use in case the initial access method is lost. This could be done by creating an access token to the SCM, to the application itself, to the cloud resources, and more.<br>

### Privilege escalation

The privilege escalation techniques are used by an attacker to elevate the privileges in the victim’s environment, gaining higher privileges for already compromised resources:

Secrets in private repositories – Leveraging an already gained initial access method, an attacker could scan private repositories for hidden secrets. The chances of finding hidden secrets in a private repo are higher than in a public repository, as, from the developer’s point of view, this is inaccessible from outside the organization.<br>

Commit/push to protected branches – The pipeline has access to the repository that may be configured with permissive access, which could allow to push code directly to protected branches, allowing an adversary to inject code directly into the important branches without team intervention.<br>

Certificates and identities from metadata services – Once an attacker is running on cloud-hosted pipelines, the attacker could access the metadata services from inside the pipeline and extract certificates (requires high privileges) and identities from these services.<br>

### Credential access

Credential access techniques are used by an attacker to steal credentials:

User credentials – In cases where the customer requires access to external services from the CI pipeline (for example, an external database), these credentials reside inside the pipeline (can be set by CI secrets, environment variables, etc.) and could be accessible to the adversary.<br>

Service credentials – There are cases where the attacker can find service credentials, such as service-principal-names (SPN), shared-access-signature (SAS) tokens, and more, which could allow access to other services directly from the pipeline.<br>

### Lateral movement

The lateral movement tactic refers to techniques used by attackers to move through different resources. In CI/CD environments, this may refer to moving to deployment resources, to build artifacts and registries, or to new targets.

Compromise build artifacts – As in other supply chain attacks, once the attacker has control of the CI pipelines, they can interfere with the build artifacts. This way, malicious code could be injected into the building materials before building is done, hence injecting the malicious functionality into the build artifacts.<br>

Registry injection – If the pipeline is configured with a registry for the build artifacts, the attacker could infect the registry with malicious images, which later would be downloaded and executed by containers using this registry.<br>

Spread to deployment resources – If the pipeline is configured with access to deployment resources, then the attacker has the same access to these resources, allowing the attacker to spread. This could result in code execution, data exfiltration and more, depending on the permissions granted to the pipelines.<br>

### Defense evasion

Defense evasion techniques could be used by attackers to bypass defenses used in a DevOps environment and allow attacks to continue under the radar:

Service logs manipulation – Service logs enable Defenders to detect attacks in their environment. An attacker running inside an environment (for example, in the build pipelines) could change the logs to prevent Defenders from observing the attack. This is similar to an attacker changing the history logs on a Linux machine, preventing any observer from seeing the commands executed by the attacker.<br>

Compilation manipulation – if an attacker wishes to leave no traces in the SCM service, the attacker may change the compilation process in order to inject the malicious code. This may be done in several ways:<br>

 -  Changing the code on the fly – Changing the code right before the build process begins, without changing it in the repository and leaving traces in it.<br>
 -  Tampered compiler – Changing the compiler in the build environment to introduce the malicious code without leaving any traces before that process begins.

Reconfigure branch protections – Branch protection tools allow an organization to configure steps before a PR/commit is approved into a branch. Once an attacker has admin permissions, they may change these configurations and introduce code into the branch without any user intervention.

### Impact

The impact tactic refers to the techniques an attacker could use for exploiting access to the CI/CD resources for malicious purposes, and not as another step in the attack, as these techniques could be noisy and easy to detect:

Distributed Denial-of-Service (DDoS) – An adversary could use the compute resources they gained access to in order to execute distributed denial of services (DDoS) attacks on external targets.<br>

Cryptocurrency mining – The compute resources could be used for crypto mining controlled by an adversary.<br>

Local Denial-of-service (DoS) – Once the attacker is running on the CI pipelines, the attacker can perform a denial service attack from said pipelines to customers by shutting down agents, rebooting, or by overloading the VMs.<br>

Resource deletion – An attacker with access to resources (cloud resources, repositories, etc.) could permanently delete the resources to achieve denial of services.<br>

### Exfiltration

The exfiltration tactic refers to different techniques that could be used by an attacker to exfiltrate sensitive data from victim environment:

Clone private repositories – Once attackers have access to CI pipelines, they also gain access to the private repositories (for example, the GITHUB\_TOKEN can be used in GitHub), and therefore could clone and access the code, thus gaining access to private IP.<br>

Pipeline logs – An adversary could access the pipeline execution logs, view the access history, the build steps, etc. These logs may contain sensitive information about the build, the deployment, and in some cases even credentials to services, to user accounts and more.<br>

Exfiltrate data from production resources – In cases where the pipelines can access the production resources, the attackers will have access to these resources as well. Therefore, they can abuse this access for exfiltrating production data.

## DevOps posture management recommendations

When the DevOps scanners uncover deviations from security best practices within source code management systems and continuous integration/continuous delivery pipelines, Defender for Cloud outputs precise and actionable recommendations. These recommendations have the following benefits:

 -  Enhanced visibility: Obtain comprehensive insights into the security posture of DevOps environments, ensuring a well-rounded understanding of any existing vulnerabilities. Identify missing branch protection rules, privilege escalation risks, and insecure connections to prevent attacks.<br>
 -  Priority-based action: Filter results by severity to spend resources and efforts more effectively by addressing the most critical vulnerabilities first.
 -  Attack surface reduction: Address highlighted security gaps to significantly minimize vulnerable attack surfaces, thereby hardening defenses against potential threats.
 -  Real-time notifications: Ability to integrate with workflow automations to receive immediate alerts when secure configurations alter, allowing for prompt action and ensuring sustained compliance with security protocols.
