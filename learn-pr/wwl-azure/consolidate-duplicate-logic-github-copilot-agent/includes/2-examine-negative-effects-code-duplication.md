Duplicate code refers to identical or similar logic repeated across different parts of a codebase. It can be:

- Exact duplication: Copy-pasted code blocks.
- Semantic duplication: Code that performs the same function but is written differently.

Rushed development, poor communication, lack of documentation, and siloed teams are common causes of duplicate code.

## Hidden costs of duplicate code

Duplicate code increases maintenance effort and risk. Consider the following issues:

1. Maintenance overhead: Every time a bug is found or a feature changes, all instances of the duplicated code must be manually updated. This increases the risk of missing a spot, leading to inconsistent behavior and regressions.

    For example: Consider an e-commerce system that includes duplicate logic for email notifications across order and return services. Any change to email formatting would require updates in multiple places. Updating code in two locations consumes time and could lead to inadvertent code inconsistencies that mask code duplication. If different teams own the order and return services, the risk of code divergence is even greater.

1. Increased risk of bugs: Duplicated code fragments can evolve independently, making it harder to ensure consistent behavior. If a bug exists in one copy, it likely exists in others—but might go unnoticed.

1. Reduced readability and comprehension: A codebase littered with duplication becomes harder to understand. Developers must mentally track similar logic across files, which slows onboarding and increases cognitive load.

1. Security and compliance risks: In enterprise systems, duplicated audit logging or validation logic can lead to inconsistent enforcement of security policies. Inconsistent enforcement is especially dangerous in regulated environments.

    For example: In the same e-commerce system, audit logging was duplicated across services. When compliance requirements changed, some services failed to update their logic, exposing the system to regulatory risk.

1. Performance penalties: Redundant calculations or inefficient algorithms repeated across the codebase can degrade performance—especially in high-traffic systems.

Duplicate code increases code maintenance time, and maintenance costs dominate the software life cycle (up to 80% of total cost).

## The "don’t repeat yourself" (DRY) principle

DRY means you should avoid repeating the same logic, rule, or idea in multiple places. If two sections of code do the same thing, that’s a red flag—it’s better to consolidate them into a single, reusable method or class. But DRY goes beyond just code: it’s about knowledge duplication. If a business rule or validation logic is scattered across your system, any change to that rule becomes risky and time-consuming.

The goal of DRY is to have a single source of truth for any piece of logic or knowledge. A single source of truth makes maintenance easier, reduces bugs, and improves code clarity.

> [!NOTE]
> In the real world, perfect DRY is unattainable, and some duplication might be necessary. The goal is to minimize duplication where it makes sense, not to obsessively eliminate every instance. In rare cases, duplication can be justified for clarity or performance, but these cases should be exceptions, not the rule. For example, two microservices might each have a small amount of similar validation logic to remain decoupled. The key is to be intentional and document why duplication exists. Always weigh the trade-offs, but as a rule for maintainability, less duplication is better.

## Benefits of Consolidation

List out the positive outcomes of refactoring duplicate code:

- Easier maintenance: Fix a bug or add a feature once, and it applies everywhere.
- Consistency: The application behaves uniformly.
- Reduced bugs: Less surface area for errors. A bug fixed in the shared code is fixed system-wide.
- Improved readability: Future developers (or you, six months later) have a single place to understand a particular logic. This single source of truth can serve as definitive documentation of that behavior.
- Performance and security implications: While consolidation itself doesn’t magically improve performance, it prevents scenarios where duplicate code isn't optimized consistently. And critically, if a security vulnerability is found in a duplicated snippet (say input validation), consolidating it ensures a single patch secures the whole codebase. In essence, you minimize the chances of one part of the app remaining vulnerable.

## Signs of Duplicate Code

Here are some basic rules and patterns that can help you spot duplication.

1. Look for similar method bodies: If two or more methods contain mostly the same lines of code, they’re likely duplicates. Even if the method names differ, identical logic inside the method is a strong indicator. These "mostly duplicate" methods can be refactored by extracting shared logic into a helper method or base class.

1. Repeated business logic across classes: When the same business rule or algorithm (for example, calculating shipping costs or validating user input) appears in multiple classes, it’s a sign of duplication. This issue often happens when classes evolve independently over time or are copy-pasted from older projects.

1. Similar email or logging patterns: Audit logging and email formatting are common areas for duplication. If you see similar SendEmail() or LogActivity() methods across services, consider centralizing them into a shared utility or service layer.

1. Copy-paste code blocks: Literal copy-paste is the most obvious form of duplication. If you see identical code blocks repeated across files or functions, it’s time to refactor.

1. Same logic, different names: Sometimes duplication hides behind different variable or method names. If two functions do the same thing but use different names throughout the code, compare their logic closely. Semantic duplication is often hard to spot without tools.
