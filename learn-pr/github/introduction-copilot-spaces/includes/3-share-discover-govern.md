To ensure your Space delivers lasting value, it must be easy to find, securely shared, and well-maintained. This unit focuses on how to manage visibility, follow GitHub permissions, and keep content fresh as your codebase evolves. You'll also learn lightweight governance strategies—from assigning ownership and adding usage guidance to setting up a review cadence—to ensure your Space remains accurate, discoverable, and aligned with team needs.

In this unit, you’ll learn:
- How to manage visibility and sharing within your organization
- How GitHub permissions secure and govern access to linked content
- Why naming conventions and descriptions boost discoverability
- Best practices for Space ownership, freshness, and review cycles


## Visibility and sharing

Successful Spaces are easy to find, safe to share, and clearly "owned." When you create a Space, set visibility according to how broadly you intend others to use it. Depending on your environment, options may include keeping it under your personal ownership or making it visible to your organization.

Share the Space by link and, where available, rely on org-level browsing or catalogs to improve discoverability. Use a clear, purpose‑driven title, and a short description that states the scope ("one job per Space"), intended audience, and expected outputs so teammates immediately know when to use it.

## Security and access

Security follows GitHub's existing permissions. A Space doesn't grant new access; it only surfaces content that viewers are already entitled to see. If a Space links to private repositories, issues, or pull requests, only users with the appropriate repo permissions see that material reflected in answers. This helps you share confidently across an organization while keeping sensitive information protected. As a best practice, avoid pasting sensitive data into free‑text notes; prefer linking to version‑controlled files where normal review and permissions apply.

## Versioning and freshness

Spaces stay fresh by referencing live GitHub sources. Linked files reflect the repository's default branch, and attached issues and pull requests evolve as they change, reducing the need to copy content into separate documents. If you need branch‑specific guidance or a historical snapshot, consider narrowing your references to the relevant files, adding a brief example in free text, or—if supported in your environment—attaching a text file that captures the exact content you want the Space to use. Keep the scope small so updates remain predictable and grounded.

## Governance

Treat governance as lightweight but intentional. Assign an owner who maintains the Space, add a short "How to use this Space" note at the top of the instructions, and include 1–3 canonical examples that define "good" output. Establish naming conventions (for example, "ServiceName—Onboarding Helper") and review cadence (for example, at each release) to prune stale sources and keep instructions aligned with reality. When a Space grows beyond a single job, split it into smaller Spaces so discoverability stays high and answer quality remains consistent.

Use this checklist when creating or updating a Space to keep it easy to find, safe to share, and reliably useful. Options (for example, org ownership, uploads) may vary by environment.

Naming and Purpose

- [ ] Choose a clear, purpose‑driven title (for example, "ServiceName—Onboarding Helper"); keep "one job per Space."
- [ ] Write a 1–2 sentence description that states scope, intended audience, and expected outputs.
- [ ] Add a brief "How to use this Space" note at the top of the instructions.

Ownership and Visibility

- [ ] Set the correct owner (individual or organization, if available).
- [ ] Select appropriate visibility (private, org‑visible, etc.).
- [ ] Verify access with a non‑owner who expected GitHub permissions (Spaces inherit repo/issue/PR permissions).
- [ ] Share the URL and, where available, add collaborators.

Security and Privacy

- [ ] Don't paste sensitive data into free‑text; prefer linking version‑controlled files where normal review/permissions apply.
- [ ] Ensure all attached sources are suitable for the chosen visibility.
- [ ] If uploads are supported, limit the text content you’re comfortable sharing.
- [ ] Remove obsolete or confidential materials.

Discoverability and Docs

- [ ] Use consistent naming conventions across Spaces (team/service prefixes help).
- [ ] Add tags/keywords in the description to aid search.
- [ ] Announce or catalog the Space in your org’s preferred directory/channel.

Review Cadence and Governance

- [ ] Assign a maintainer/owner responsible for updates.
- [ ] Set a review cadence (for example, monthly or per release).
- [ ] At each review: validate links, test 2–3 representative prompts, update examples, prune noisy sources, and confirm visibility.
- [ ] Track feedback and improvement requests (issues, discussion, or a simple checklist in the description).
