Some governance requirements go beyond what's included in a Fabric license. For these, Microsoft Fabric relies on **Microsoft Purview**—a family of governance, risk, and compliance solutions.

The important thing to understand is that Purview isn't a separate tool you navigate to for most of these capabilities. Once your organization has the right Purview licenses, the capabilities surface directly inside Fabric: sensitivity labels appear on items, DLP policy tips show up in reports, and governance insights land in the OneLake catalog. Your job as a data engineer or analyst is to understand what's available, recognize when it's in effect, and know when to escalate to an admin or compliance team.

This unit covers the governance capabilities that require a Microsoft Purview license and explains how each one works within Fabric.

## Classify and label sensitive data

**The problem:** How do you know which Fabric items contain sensitive data—and how do you communicate and enforce that sensitivity consistently?

**What Purview adds:** Microsoft Purview Information Protection introduces **sensitivity labels** to Fabric. Labels like *Confidential* or *Highly Confidential* can be applied to any Fabric item—lakehouses, warehouses, reports, semantic models. Once applied, a label travels with the data: if a user exports a labeled dataset to Excel, the label follows it.

Admins can configure **auto-labeling policies** to detect sensitive content automatically—credit card numbers, national identification numbers, health record identifiers—and apply the appropriate label without manual intervention. **Default label policies** ensure every new item in a workspace starts with a minimum classification.

Labels also enable **protection policies**: if an item's label exceeds a sensitivity threshold, Purview can restrict who can access it, enforce encryption, or block export. This moves labeling from informational to enforceable.

## Prevent unauthorized data sharing

**The problem:** Even with labels applied, users can still share or download sensitive data unless something actively stops them.

**What Purview adds:** Microsoft Purview Data Loss Prevention (DLP) policies monitor structured data in Fabric—lakehouses, warehouses, databases, and semantic models—and enforce rules based on sensitivity labels and content patterns. When a policy triggers, it can:

- Display a **policy tip** warning the user that the item contains sensitive data
- Restrict access to the item until a compliance review is completed
- Generate an alert for your security team

DLP policies are configured by compliance admins and evaluated continuously. Fabric users see the effects in the items they work with—a policy tip on a report, or a restriction on a semantic model — without needing to interact with the Microsoft Purview portal directly. 

## Build a searchable data catalog

**The problem:** With dozens of workspaces and hundreds of items, how does someone find the right dataset for a business question?

**What Purview adds:** The Microsoft Purview Unified Catalog provides a searchable, curated inventory of all your data assets. Fabric item metadata appears in the Unified Catalog automatically through **live view**—no configuration needed. Organizations that need richer metadata—including column-level classification and lineage from non-Fabric sources—can register their Fabric tenant and run periodic scans.

The Unified Catalog supports **glossary terms** so business users can search by domain language rather than technical item names. It also supports **data product publication workflows**, letting data teams package related assets into a governed, self-service data product for consumers across the organization.

## Detect insider threats

**The problem:** Legitimate users with access to sensitive data can still misuse it—intentionally or accidentally.

**What Purview adds:** Microsoft Purview Insider Risk Management (IRM) monitors user behavior patterns across Microsoft 365 and Fabric. IRM includes Fabric-specific risk indicators: Power BI activities, lakehouse access patterns, and data exfiltration scenarios such as bulk downloads or copying data to external locations.

When IRM detects a concerning pattern, it generates an alert for your security team to investigate. This doesn't change what users see day-to-day, but it gives your organization a safety net for unusual behavior before it becomes a breach.

## Govern AI interactions

**The problem:** Fabric includes Copilot features that let users ask natural language questions about their data. How do you ensure AI interactions don't surface sensitive data to unauthorized users, or generate responses that violate compliance requirements?

**What Purview adds:** Purview extends its governance controls to Fabric Copilots and agents—monitoring prompts and responses for sensitive or regulated content, capturing audit logs for AI interactions, and applying retention and eDiscovery policies to AI-generated content. The same sensitivity controls that govern underlying items apply to the AI responses derived from them.

## Keep a compliance audit trail

**The problem:** When something goes wrong—or a regulator asks—you need a complete record of who did what, when, and to which data.

**What Purview adds:** Microsoft Purview Audit captures all user and admin activities across Fabric—lakehouse access, Power BI report views, pipeline runs, sensitivity label changes, and more. The audit log is available in the Microsoft Purview portal and can be queried for investigations or exported for regulatory reporting. Extended audit retention and advanced search capabilities require a Purview Audit license.

## Where you see all of this in Fabric

Each of these capabilities is configured by compliance admins or security teams, typically through the Microsoft Purview portal. But the effects surface inside Fabric—and the place where you get a complete picture of your governance posture is the **OneLake catalog Govern tab**. That's where sensitivity label coverage, DLP policy evaluation, endorsement status, and recommended actions come together in one dashboard. In the next unit, you'll explore the Govern tab and learn how to use it.
