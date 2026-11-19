Now that the portfolio is open in your codespace, you can give Copilot the same context you'd give a teammate: what you want to change, where it belongs, and how you'll know it worked.

## Developing with GitHub Copilot

Use inline suggestions when you're already writing code. Use GitHub Copilot Chat when you want to ask a question about existing code or discuss a proposed change.

### Prompt engineering

A *prompt* is input to Copilot. It can be a request typed in Chat, a comment describing the code you want, or code you start typing for Copilot to complete. Compare these example prompts; you don't need to change the footer in this unit.

```javascript
// Update the footer.
```

The first prompt could mean changing the layout, the links, or the styling. The second names a file, an observable result, and what should stay the same:

```javascript
// In App.jsx, hide only the portfolio's email icon by changing siteProps.email.
// Leave the footer component and the other icons unchanged.
```

The [portfolio's footer component](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/Components/Footer.jsx#L63-L118) already shows the email icon only when an address is set. A suggestion that sets `siteProps.email` to an empty string fits the request. One that removes every footer link doesn't.

### Best practices using GitHub Copilot

Use these techniques to refine a suggestion and check the result:

- **Refine a question in Chat.** For an explanation or a snippet to review yourself, select **Ask** in the [Chat agent picker](https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/chat-with-copilot/chat-in-ide?tool=vscode#using-ask-mode). Start with "What makes the email icon appear?" Then ask, "Show the one-line change that hides it by setting the email field to an empty string." A focused follow-up gives Copilot more useful direction than extra detail unrelated to the change.
- **Compare inline alternatives.** If alternatives appear, use the arrows in the suggestion toolbar, or `Alt+]` / `Alt+[` on Windows and Linux (`Option+]` / `Option+[` on macOS). Press <kbd>Tab</kbd> to accept a visible completion or <kbd>Esc</kbd> to dismiss it.
- **Check the result.** A clear prompt helps but doesn't guarantee correct code. [Review the proposed change](https://docs.github.com/en/copilot/tutorials/review-ai-generated-code) and compare the preview with the behavior you requested. If more changed than you intended, reject the suggestion or narrow the request.

> [!NOTE]
> Related open files can help Copilot generate inline completions. To tell **Chat** to use a specific file, drag **App.jsx** from the **src** folder in Explorer into the chat input, or choose **Add Context** > **Files**. Confirm that **App.jsx** appears as an attachment before sending your prompt. See [Add context to chat](https://code.visualstudio.com/docs/chat/copilot-chat-context#_add-files-as-context).