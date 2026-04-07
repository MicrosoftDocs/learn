## Unit Overview

Generative capabilities in Power Apps now allow makers—especially code-first developers—to create model-driven app pages using natural language. Combined with an **agent feed**, organizations can deliver dynamic, personalized, and adaptive app experiences that respond in real-time to business data, user actions, and AI-generated insights. This unit introduces how generative pages work, how developers can architect "code-first" enhancements, and how agent feeds add intelligence to business applications.

## Learning objectives

By the end of this unit, learners will be able to:
- Describe the purpose of **generative pages** in model-driven apps.
- Propose when to use **code-first extensions** with generative pages.
- Explain the role and value of an **agent feed** in responsive app experiences.
- Recommend appropriate use cases for generative pages and agent driven functionality

## 1. Understanding generative pages in model-driven apps

Generative pages allow app makers to **describe a requirement in natural language**, and Power Apps automatically creates a page layout, data experiences, and UI structure. This accelerates solution development by removing repetitive scaffolding steps.

**How It Works**

Maker enters natural language prompt: *"Create a customer overview page showing recent orders, open cases, and a satisfaction score."*

- Power Apps analyzes available Dataverse data.

- A generative engine creates a page layout, bindings, and forms.

- Maker optionally adjusts the page using codefirst or low-code features.

- The system generates content aligned with enterprise-grade security and governance.

## 2. Code-first extensions for generative pages

Even though generative pages reduce design time, many enterprise apps require deeper customization. Codefirst developers enhance generated pages using:

- **JavaScript event handlers**

- **Custom PCF controls**

- **Dataverse business logic**

- **Reusable components and services**

- **Security aware data pipelines aware data pipelines**

- **Why Use Code-first with Generative Pages?**

| **Need** | **Code-first BenefitFirst Benefit** |
|---|---|
| Complex business rules | Implement logic not expressible through prompts alone |
| Highly customized UI | Add PCF components, advanced layouts |
| Cross system integrationsystem integration | Build connectors, plugins, service calls |
| Performance optimization| Finetune load patterns, caching, batching |
| Compliance and governance | Embed rules, validations, safe compute patterns compute patterns |

## 3. The role of an agent feed in apps

An **agent feed** introduces an AI-powered layer that provides real-time insight and recommendations inside apps.

**Agent Feed Capabilities**

- Summaries of records or processes.

- Suggestions for actions such as *"follow-up with this customer"*.

- Notifications when anomalies are detected.

- Contextual insights based on model driven app data-driven app data.

- Guided steps and automation triggers.

**How an Agent Feed Works**

The agent monitors app context, user actions, and records.

It surfaces insights directly in the app.

The agent provides next-best actions aligned with business goals.

## 4. When to use generative pages + agent feed together

| **Scenario** | **Recommended Use** |
|---|---|
| Need rapid creation of data driven screensdriven screens | Use generative pages |
| Require dynamic, insight-driven agent guidance | Add agent feed |
| App needs automated suggestions | Agent feed triggers |
| Developer must extend or override generated UI | Code-first enhancements-first |
| High-volume workflow automation volume workflow automation | Combine all three (generative + agent + code-first) |

Together, they create intelligent, fast to build, enterprise-ready apps.

## 5. Chart: Comparing prompt-first vs code-first vs agent-driven apps

| **Approach** | **Strengths** | **Best Use Cases** |
|---|---|---|
| Prompt First (Generative) | Fast creation, natural language, guided layouts | Rapid prototyping, early drafts, citizen developer apps-developer apps |
| Code-first | Full control, extensibility, complex logic | Enterprise apps with custom workflows |
| Agent Driven | Insightful, adaptive, AI-assisted | Decision support, operational intelligence |

## 6. References

Use these links for more detail and hands on practice:

- **Introducing the new Power Apps generative experiences**<https://www.microsoft.com/power-platform/blog/power-apps/introducing-the-new-power-apps-generative-power-meets-enterprise-grade-trust/>.

- **Generative Pages FAQ (GitHub)**<https://github.com/MicrosoftDocs/powerapps-docs/blob/main/powerapps-docs/maker/common/faq-generative-pages-model-driven.md>.
