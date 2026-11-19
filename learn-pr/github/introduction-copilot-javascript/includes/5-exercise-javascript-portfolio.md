Use GitHub Copilot to change the name and title on a React portfolio and animate its footer icons on hover. Check both changes in the live preview.

> [!NOTE]
> If you closed the tab from setup, the [quick-start page](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-javascript?quickstart=1) offers the most recent matching codespace for the sample repository's default branch. Check its name. If it's your exercise codespace, resume it there to open VS Code for the web. If the name doesn't match or the page only offers to create a codespace, find your original by name on [Your Codespaces](https://github.com/codespaces). Selecting its name on that dashboard opens your default editor. If that isn't the browser, select **…** > **Open in** and choose the browser option instead.

## Customize your JavaScript portfolio

Check that the portfolio home page loads. You can use the preview inside the editor for this check. If it doesn't open or load, follow the [preview check from setup](/training/modules/introduction-copilot-javascript/3-exercise-setup#check-the-portfolio-preview). In **Ports**, use the number Parcel reports. Port **1234** is labeled **Application**; another port might not have a label. If the reported port isn't listed, forward it and keep it private.

Open `src/App.jsx` and find [the starter's `siteProps` object](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/App.jsx#L26-L36). Only the three properties you'll change are shown here. Leave the other properties in your file.

```javascript
const siteProps = {
  name: "Alexandrie Grenier",
  title: "Web Designer & Content Creator",
  gitHub: "microsoft",
};
```

Follow [where `App` uses those values](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/App.jsx#L45-L48): it passes `name` and `title` to `Home` for the headings and passes the profile values to `Footer` for the links. Practice with the sample data; don't enter or publish personal contact details.

The [footer component](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/Components/Footer.jsx#L63-L118) builds the GitHub link from `siteProps.gitHub`. In the unmodified starter, `microsoft` gives `https://github.com/microsoft`.

If you're using the embedded preview, right-click the portfolio's private port in **Ports** and select **Open in Browser**. Before editing, check the GitHub icon's current destination in the footer of the portfolio tab: hover to read the URL or copy the link address. If you resumed an edited portfolio, the URL might differ or the icon might be absent. Don't reset your edits to match the starter.

To change the destination, edit the username in `siteProps`, not the link in `Footer`. The footer expects these formats:

- `gitHub`, `instagram`, `medium`, and `twitter` take usernames without a leading `@`, such as `microsoft` for `gitHub`. The footer adds the `@` for Medium.
- `linkedIn` takes the part of the profile URL after `/in/`.
- `youTube` takes the part after `/c/` in an [existing custom channel URL](https://support.google.com/youtube/answer/6180214), not an `@handle`. Leave it blank if you don't have a compatible slug.
- `email` takes a bare address such as `alex@example.com`. The footer adds `mailto:`.

Use `""` for any unused service to omit its icon, as the sample does for `medium`.

### Change the profile with Copilot Chat

Ask Copilot for the new profile values, then check your edits in the browser:

1. In the browser editor, open Copilot Chat and select **Ask** in the agent picker. Drag `src/App.jsx` from Explorer into the chat input and confirm that **App.jsx** appears as an attachment.
1. Use this prompt for a fictitious profile: “Show me the three property values to change in the existing `siteProps` object: `name` to `Mina Chen`, `title` to `JavaScript Developer`, and `gitHub` to `octocat`. Return a snippet only; don't edit any files.”

   If this prompt reports a policy or usage limit, follow the [Chat access guidance in setup](/training/modules/introduction-copilot-javascript/3-exercise-setup#check-a-javascript-inline-suggestion) for your plan or organization. You don't need a new codespace.
1. Review the snippet. If it changes anything else, narrow the request and try again. If an earlier chat edited `App.jsx`, review its diff in **Source Control** before copying anything. In the existing `siteProps` object, update only the requested values that don't already match. Keep your other edits and save the file. Don't add a second `siteProps` declaration.
1. At the top of the live preview, check that the heading reads **Mina Chen** and the subheading reads **JavaScript Developer**.
1. In the portfolio's browser tab, copy the GitHub icon's link address from the footer. It should now be `https://github.com/octocat`, not `https://github.com/microsoft`. Keep this tab open for the hover checks.

## Animate the footer icons on hover

For an inline suggestion, type this comment at the end of `src/styles.css` and press **Enter**. To use Chat instead, select **Ask**, drag `src/styles.css` into the chat input, and confirm that **styles.css** is attached. Use the comment as your prompt and ask for CSS only, without file edits.

```css
/* Pulse img.socialIcon repeatedly on hover, but only if the user hasn't requested reduced motion. Leave other images unchanged. */
```

If no inline suggestion appears, run **Trigger Inline Suggestion** from the Command Palette. If it still doesn't appear, follow the [sign-in and usage checks in setup](/training/modules/introduction-copilot-javascript/3-exercise-setup#check-a-javascript-inline-suggestion) for your plan or organization. This time, make sure inline suggestions are enabled for CSS.

Here's one way to [respect the visitor's motion preference](https://www.w3.org/WAI/WCAG22/Techniques/css/C39):

```css
@keyframes socialIconPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.2); }
}

@media (prefers-reduced-motion: no-preference) {
  img.socialIcon:hover {
    animation: socialIconPulse 0.5s ease-in-out infinite;
  }
}
```

Review the suggestion. Only the hovered social icon should animate, and only inside the media query. If it animates other images or leaves a hover animation outside the query, narrow the prompt and try again.

If an earlier chat edited the stylesheet, review its diff in **Source Control** first. Keep or correct an existing animation rather than adding a duplicate. If it's missing, accept a suitable inline suggestion with **Tab** or insert the reviewed CSS from Chat once. Save `src/styles.css`. Equivalent CSS is fine if it passes these checks:

1. In the portfolio tab, with no reduced-motion preference, hover over the GitHub icon. It should grow and shrink repeatedly while the neighboring icon stays still. Move the pointer off the GitHub icon and check that it stops pulsing. If your edited portfolio has no neighboring icon, use the desk photo in the next step for comparison.
1. With the same motion preference, hover over the desk photo in the **Portfolio** section. The photo should stay still. If the photo or the neighboring icon pulses, narrow the hover selector to `img.socialIcon:hover`, save, and repeat both checks.
1. Enable reduced motion in your operating system. In Microsoft Edge, you can instead [emulate `prefers-reduced-motion: reduce` in the portfolio tab's DevTools](/microsoft-edge/devtools/accessibility/reduced-motion-simulation). Hover over the GitHub icon again: it should stay still. Select it to confirm the link still opens `https://github.com/octocat`. Restore your original motion preference after the check.

If you want to keep your edits, follow the [preservation steps in the summary](/training/modules/introduction-copilot-javascript/7-summary#stop-or-delete-the-exercise-codespace) before stopping or deleting this codespace.

Return to Microsoft Learn for the module assessment and summary. To [record your progress and completion badge](/training/support/faq#do-i-need-to-create-a-profile-to-use-microsoft-learn), sign in to your Microsoft Learn profile and complete the module.
