## Overview

Computer Use in Copilot Studio enables agents to **interact with applications and websites on behalf of users**, performing tasks such as clicking buttons, filling forms, navigating interfaces, and extracting information. This capability allows organizations to automate workflows that previously required manual UI interaction.

This unit equips solution architects to design, configure, and evaluate agents that use Computer Use safely, reliably, and efficiently.

By the end of this unit, learners will be able to:

Explain how Computer Use works in Copilot Studio

Identify business scenarios suitable for UIbased automation

Design agent behaviors that safely interact with apps and websites

Configure Computer Use actions and constraints

Evaluate reliability, governance, and user experience considerations

## 1. Understanding Computer Use in Copilot Studio

### Computer Use allows agents to:

Control the mouse and keyboard

Navigate websites and desktop apps

Read onscreen text and UI elements

Perform multistep tasks

Automate repetitive or structured workflows

### Key Capabilities

Click, type, scroll, and navigate

Extract text from the screen

Follow multistep UI sequences

Use reasoning to determine next actions

Execute tasks across multiple apps

### How It Works

The agent receives a user request

It analyzes the UI using vision and reasoning

It generates a stepbystep plan

It performs actions through the Computer Use channel

It validates results and reports back to the user

## 2. Identify Scenarios Suitable for Computer Use Automation

Computer Use is ideal when:

### A. No API or connector exists

Examples:

Legacy systems

Vendor portals

Desktoponly applications

### B. Tasks are repetitive and UIdriven

Examples:

Data entry

Form submission

Copy/paste workflows

### C. Tasks require navigating multiple apps

Examples:

Pulling data from a website and entering it into a CRM

Downloading reports from portals

Updating spreadsheets based on UI data

### D. Humanlike reasoning is needed

Examples:

Identifying the correct button on a dynamic page

Navigating menus that change based on context

## 3. Designing Agents for Computer Use

### A. Define the Task Clearly

Agents perform best when the task is:

Specific

Goaloriented

Structured

Example: "Log into the vendor portal, download the latest invoice, and save it to SharePoint."

### B. Provide Context and Constraints

Agents need guardrails such as:

Which apps or sites they may access

What data they may interact with

What actions are prohibited

Time limits or retry limits

**C. Break Tasks into Steps**

Even though the agent can reason, designing a clear workflow improves reliability.

Example steps:

Open website

Log in

Navigate to invoices

Download file

Upload to SharePoint

### D. Design for Variability

UI elements may change. Train agents to:

Use descriptive instructions ("Click the blue ‘Submit' button")

Validate results after each step

Handle errors gracefully

## 4. Configuring Computer Use in Copilot Studio

### A. Enable Computer Use

Turn on Computer Use in the agent settings

Configure permissions and allowed applications

### B. Add Computer Use Actions

Agents can:

Click elements

Type text

Scroll

Extract text

Navigate pages

### C. Use Reasoning Mode

Computer Use leverages reasoning to:

Interpret UI layouts

Identify relevant elements

Decide next steps

### D. Test Interactions

Use the Copilot Studio test canvas to:

Watch the agent perform actions

Validate UI navigation

Debug failures

## 5. Governance, Safety, and Reliability Considerations

### A. Security & Access Control

Limit which apps the agent can access

Avoid sensitive data entry unless necessary

Use leastprivilege principles

### B. Responsible AI

Ensure transparency: users should know what the agent is doing

Avoid automating harmful or risky actions

Log all actions for auditability

### C. Reliability

UI changes can break automation

Build monitoring and fallback plans

Use Computer Use only when APIs are unavailable

## 6. Professional Visuals (TextBased)

### Visual 1 — Computer Use Architecture

User Request ↓ Agent Reasoning ↓ Computer Use Actions ↓ UI Interaction ↓ Validation & Response 

### Visual 2 — When to Use Computer Use

No API Available | UI-Driven Tasks | Multi-App Workflows | Human-Like Reasoning Needed 

### Visual 3 — Agent Design Framework

Define Task → Add Context → Break Steps → Add Guardrails → Test → Refine 

## References

[https://learn.microsoft.com/en-us/microsoft-copilot-studio/computer-use](/microsoft-copilot-studio/computer-use) 