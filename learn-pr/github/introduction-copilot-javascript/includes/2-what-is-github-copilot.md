When you know what you want the code to do but don't remember the syntax, GitHub Copilot can suggest an implementation in your editor. You decide whether it does what you need.

## How does it work?

The portfolio stores a GitHub username, not a URL. In the [starter profile in `src/App.jsx`](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/App.jsx#L26-L30), the username is `microsoft`. Suppose you want Copilot to suggest how to turn that value into the link behind the footer icon. A variable gives it context; a comment tells it what to do:

```javascript
const gitHub = "microsoft";
// Build the GitHub profile URL from the gitHub username.
```

On the next line, Copilot might suggest:

```javascript
const profileUrl = `https://github.com/${gitHub}`;
```

The result is `https://github.com/microsoft`. A suggestion that uses this URL literally looks right for `microsoft`, but it won't point to the new profile if you change the username. Compare the suggested expression with how [the starter's `Footer.jsx` sets the link destination](https://github.com/MicrosoftDocs/mslearn-copilot-codespaces-javascript/blob/4ee124077555bba7f613ca56b86f0a308402a8b8/src/Components/Footer.jsx#L73-L77):

```jsx
{gitHub && (
  <a href={`https://github.com/${gitHub}`} target="_blank" rel="noopener noreferrer">
    <img src={gitHubIcon} alt="GitHub" className="socialIcon" />
  </a>
)}
```

When `gitHub` is empty, the footer omits the icon. Otherwise, `href` points to the profile for that username. The footer already builds this link. In the exercise, you'll change the username, not the component.

## How it recognizes prompts

In the setup unit, you'll try this prompt in an untitled file with the language set to **JavaScript**. Starting a new line after the comment gives Copilot a place to suggest code. A Markdown README isn't a good first test: [automatic inline suggestions are off for Markdown by default](https://github.com/microsoft/vscode/blob/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/extensions/copilot/package.json#L3265-L3277).

## Accepting suggestions

An inline completion appears as dimmed text at your cursor. Read it, then press <kbd>Tab</kbd> to accept it or <kbd>Esc</kbd> to dismiss it.

If Copilot offers more than one suggestion, hover over the dimmed text and use the next and previous arrows. The default shortcuts are `Alt+]` (next) and `Alt+[` (previous) on Windows or Linux, and `Option+]` and `Option+[` on macOS. See [getting code suggestions in VS Code](https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/copilot-for-common-tasks/get-ide-code-suggestions?tool=vscode).
