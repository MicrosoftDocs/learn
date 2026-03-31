:::image type="complex" source="../media/git-hub-copilots-contractual-protections.png" alt-text="Screenshot of a futuristic, neon-colored depiction of GitHub Copilot represented as a stylized robotic helmet.":::
"Screenshot of a futuristic, neon-colored depiction of GitHub Copilot represented as a stylized robotic helmet. Copilot is portrayed alongside abstract graphics of orbs and atomic-like structures. The text of GitHub Copilot's contractual protections is in bold white at the bottom."
:::image-end:::

To help ensure that your organization remains compliant with legal requirements, you should understand how contractual protections and GitHub Copilot features can help safeguard your code and data.

## Contractual protections

To help ensure that your organization remains compliant with legal requirements, GitHub Copilot offers:

- **IP indemnity**: The GitHub Copilot Business and Enterprise plans include IP indemnity, which provides legal protection against intellectual property claims related to the use of Copilot suggestions. With IP indemnity, if any suggestion from GitHub Copilot is challenged as infringing on third-party IP rights, GitHub assumes legal responsibility. For GitHub to assume legal responsibility, the **Matching public code** setting must be blocked.
- **Data Protection Agreement (DPA)**: GitHub offers a DPA that outlines the measures taken to protect your data and ensure compliance with data privacy regulations. These agreements provide transparency and assurance that your data is handled securely and responsibly.
- **GitHub Copilot Trust Center**: The GitHub Copilot Trust Center provides detailed information about how GitHub Copilot works, including security, privacy, compliance, and intellectual property safeguards. This resource helps organizations feel confident using GitHub Copilot while adhering to best practices and legal requirements.

## Filtering out matching public code

GitHub Copilot can help minimize potential code overlap by identifying and filtering out code suggestions that match publicly available code. This feature is essential for maintaining the originality and security of your codebase. It can reduce the risk of incorporating nonsecure or noncompliant code into your projects.

### Key distinctions

| Scope | Who can manage | What it controls | Notes |
|-------|----------------|----------------|-------|
| **Organization (Business/Enterprise plans)** | Admins | Public Code filter for all members; required for IP indemnity | Organization admins can block suggestions matching public code for all members. This is required to activate Intellectual Property Indemnity. |
| **Personal account (Free, Pro, Pro+) – individually paid** | Individual user | Toggle to Allow or Block suggestions matching public code | Users who purchase their own Copilot license can fully control this setting in their personal account under **Copilot → Features → Privacy**. |
| **Personal account (Free, Pro, Pro+) – org-provided** | Individual user | Toggle to Allow or Block suggestions matching public code | If your seat is assigned by an organization, the toggle may be **locked** and will reflect the organization’s policy. |

### Managing the organizational public code filter

For organizations on **Business or Enterprise plans**, admins can control whether Copilot blocks suggestions that match public code. This is important for compliance and to enable IP indemnity.

**Steps for organization admins:**

1. In the upper-right corner of GitHub, click your **profile picture**, then select **Your enterprises** or **Your organizations**.
2. Next to the enterprise or organization you want to configure, click **Settings**.
3. In the left sidebar, click **Copilot** under **Code, planning, and automation**.
4. Click **Features**, then scroll to the **Privacy** section.
5. Locate **Suggestions matching public code** and choose the desired option (e.g., **Block** to prevent matching suggestions across the organization).
6. Click **Save** to apply the changes.


### Managing public code suggestions for personal users

If you are paying for your own Copilot license (Free, Pro, or Pro+), you can control suggestions matching public code directly in your account.

**Steps for personal license holders:**

1. In the upper-right corner of GitHub, click your **profile picture**, then select **Settings**.
2. In the left sidebar, click **Copilot** under **Code, planning, and automation**.
3. Click **Features**, then scroll to the **Privacy** section.
4. Locate **Suggestions matching public code** and toggle between **Allow** or **Block** according to your preference.
5. Your choice will immediately affect the suggestions Copilot provides in your personal environment.

Now let's explore managing content exclusion from an internal lens.
