## Overview

This unit equips **solution architects** with the expertise to identify, evaluate, and propose Microsoft Power Platform AI capabilities—including the **AI hub**, **Copilot experiences**, and **AI Builder**—as part of enterprisegrade, scalable AI solution designs.

You will learn how to map Power Platform AI features to business outcomes, integrate them within secure environments, and architect extensible solutions that support automation, content generation, predictions, and natural language interaction across business applications.

## 1. Understanding Power Platform AI Capabilities

### 1.1 Key AI Components

**AI experiences in Power Platform** provide intelligence across apps, flows, pages, and copilots.<br>Core components include:

**AI Hub**<br>The central experience for managing, discovering, and orchestrating AI within Power Platform—connecting models, copilots, and automation.

**Copilot in Power Platform**<br>Naturallanguage-driven creation of apps, flows, tables, controls, and logic.

**AI Builder**<br>A collection of prebuilt and customizable AI models for classification, prediction, extraction, detection, translation, and document understanding.

**Copilot Studio**<br>Lowcode conversational agent creation with extensibility into Microsoft 365 and external systems.

## 2. The AI Hub: Orchestration for Enterprise AI

### 2.1 Purpose of the AI Hub

The AI hub is a unified workspace for organizations to:

* Centralize AI features across Power Apps, Power Automate, and Copilot Studio

* Manage AI models, connectors, and copilots in a governed environment

* Promote consistent, secure, monitored use of AI at scale

* Provide guided paths for building AIdriven apps and flows

## 3. AI Builder: Extending Intelligence Across the Platform

AI Builder enables solution architects to incorporate intelligence into solutions using:

### Prebuilt Models

Useful for rapid prototyping or highvolume automation, including:

* Document processing

* Object detection

* Category classification

* Sentiment analysis

* Payment detection

* Business card reading

* Receipt and invoice extraction

### Custom Models

Configured with organizationspecific data for:

* Prediction (e.g., churn, lead scoring)

* Category classification

* Entity extraction

### Model Lifecycle Design

Solution architects must plan:

* Data acquisition and labeling

* Training and validation cycles

* Production deployment

* Monitoring model drift and accuracy

* Retraining and retirement triggers

## 4. Copilot and Generative AI in Power Platform

### 4.1 Copilot in Power Apps

* Generate app screens from natural language

* Create Dataverse tables, fields, and sample data

* Add logic with conversational prompts

* Automate UI modernization

### 4.2 Copilot in Power Automate

* Generate flows based on business intent

* Suggest triggers, actions, and connectors

* Summarize flow logic for governance and review

* Provide explanations of complex workflows

### 4.3 Copilot in Power Pages

* Build site pages with natural language

* Generate forms, data models, and automation

* Provide conversational editing and content refinement

### 4.4 Copilot Studio

* Build custom copilots with multiturn reasoning

* Integrate external data sources, APIs, and connectors

* Extend copilots into Teams, Microsoft 365, or websites

* Apply enterprise security, DLP, and audit policies

## 5. Solution Architect Responsibilities

Solution architects must ensure AI solutions meet enterprisegrade requirements:

### 5.1 Governance & Security

* Implement environment strategy

* Apply sensitivity labels and DLP rules

* Define rolebased access

* Validate connector usage

### 5.2 Data Strategy

* Determine data sources and quality

* Map business entities to Dataverse

* Ensure compliant model training data

* Establish data refresh and retention patterns

### 5.3 Extensibility & Integration

* Use Power Platform connectors

* Integrate business systems (CRM, ERP, HRIS, etc.)

* Design automation pipelines with Power Automate

* Connect AI Builder insights across apps and flows

### 5.4 Monitoring & Optimization

* Track model performance

* Monitor Copilot adoption and success metrics

* Review telemetry and usage patterns

* Implement iterative improvements

## 6. Charts

### 6.1 Feature Selection Matrix

| **Scenario Type** | **Copilot** | **AI Builder** | **AI Hub** | **Copilot Studio** |
|---|---|---|---|---|
| **Text generation** | ✔ | — | ✔ | ✔ |
| **Prediction** | — | ✔ | ✔ | — |
| **Document extraction** | — | ✔ | ✔ | — |
| **Conversational agent** | — | — | — | ✔ |
| **Automation creation** | ✔ | — | ✔ | — |

## References

[https://learn.microsoft.com/en-us/power-platform/copilot](/power-platform/copilot)

[https://learn.microsoft.com/en-us/ai-builder/overview](/ai-builder/overview)