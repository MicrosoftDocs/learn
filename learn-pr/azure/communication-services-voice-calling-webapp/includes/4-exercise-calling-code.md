In this unit, we'll add additional code to the web app created in the previous unit in order to create calls with Azure Communication Services.

## Add input HTML elements

To make a call we'll need 2 important pieces of information:

1. Who the user making the call is. This will be in the form of an Azure Communication Services authentication token.
1. Who the user wants to call. This will be in the form of an Azure Communication Services user id.

To get this information from the user, we'll use some standard HTML form inputs. So let's add them to our `index.html` file:

1. Open the `index.html` in a text editor
1. Add the following into the body of the HTML file, under the `Calling HTML here` comment:

    ```html
    <input 
        id="token-input"
        type="text"
        placeholder="Your User access token"
    />
    <button id="token-submit" type="button">
        Submit
    </button>
    <br /><br />
    <input 
        id="callee-id-input"
        type="text"
        placeholder="Who would you like to call?"
        style="margin-bottom:1em; width: 200px; display: block;"
    />
    ```

The first input element will be for the token of the user making the call. The submit button will be used to instantiate some Azure Communication Services objects once the token has been provided. The second input will be for entering the user id of the person we want to call.

## Add basic call action buttons

We'll also need some buttons for some basic call actions that allow the user to control the call:

1. Start Call
1. Hang Up

So let's also add these underneath the inputs from the previous step:

```html
<button id="call-button" type="button" disabled="true">
    Start Call
</button>
&nbsp;
<button id="hang-up-button" type="button" disabled="true">
    Hang Up
</button>
```

## Testing the HTML

With this done, we've completed the majority of the HTML for this app. If you run the app with the same command as the previous unit: `npx parcel index.html` and then open the app, you should see the following in your browser:
:::image type="content" source="../media/4-html-complete.png" alt-text="Our blank web app showing in a browser.":::

This may not look like a lot, but its all we the visual elements we need to create a simple voice calling app.

## Create and link the JavaScript file

Next we'll need a JavaScript file to contain our app's code and actually make and handle the call. To do this create a new file in your app directory called `app.js`. Its ok to leave it blank just for now. Now inside `index.html` add the following HTML, just underneath our hang up button:

```html
<script src="./app.js" type="module"></script>
```

This links our JavaScript file into our HTML so it loads when we open the app. Its also the last line of HTML we need. The rest of this unit will deal with the JavaScript.

## Import some dependencies

Our first step within our `app.js` file is to import the dependencies for making Azure Communication Services calls. These dependencies come from the SDKs we installed earlier with NPM. To do this add the following import lines to the `app.js` file:

```javascript
import { CallClient } from "@azure/communication-calling";
import { AzureCommunicationTokenCredential } from '@azure/communication-common';
```

The first import, imports CallClient, which will be used later to actually make our calls. It handles microphones, audio etc all for you. The second import is used to handle the authentication requirements for Azure Communication Services such that we know who a user is when they place a call.

## Getting references to our HTML

Earlier, we created a lot of HTML elements which users will use to control the app. To listen to the user interacting with them we'll need to get references to them in our JavaScript.

Additionally we need a couple of variables to hold some items which are used throughout our code. Add the following code to `app.js` underneath the imports.

```javascript
const userToken = document.getElementById("token-input"); 
const submitToken = document.getElementById("token-submit");

const calleeInput = document.getElementById("callee-id-input");

const callButton = document.getElementById("call-button");
const hangUpButton = document.getElementById("hang-up-button");

let call;
let callAgent;
let tokenCredential;
```

## Handling authentication

Now we're done with some basic setup, we can start creating some functionality. The first thing we need functionally is to handle authentication. This will be handled by the user entering a user token into the token input element that we created and then clicking our "Submit Token". To handle this within our code we need to register a click handler to that submit token button which will process the user token. You can add this code right underneath our variables from before.

```javascript
submitToken.addEventListener("click", async () => {
  const callClient = new CallClient();
  const userTokenCredential = userToken.value;
    try {
      tokenCredential = new AzureCommunicationTokenCredential(userTokenCredential);
      callAgent = await callClient.createCallAgent(tokenCredential);
      callAgent.on('incomingCall', incomingCallHandler);

      callButton.disabled = false;
      submitToken.disabled = true;
    } catch(error) {
      window.alert("Please submit a valid token!");
    }
})
```

This code:

1. Creates an Azure Communication Services Call Client.
1. Retrieves the user token from the token input element, and creates an `AzureCommunicationTokenCredential` with it. This credential is used to make and handle all calls.
1. Creates a `CallAgent`, which we use to make and receive calls.
1. Registers an incoming call handler, which we'll write shortly.
1. Updates some of our buttons so the user can proceed.

## Making calls

With authentication out of the way we can start on some real functionality, lets start by allowing the user to make a call:

```javascript
callButton.addEventListener("click", () => {
  // start a call
  const userToCall = calleeInput.value;
  call = callAgent.startCall(
      [{ id: userToCall }],
      {}
  );

  // toggle button states
  hangUpButton.disabled = false;
  callButton.disabled = true;
});
```
This code, registers a click handler on the "Start Call" button. It retrieves the callee id from the matching input element and then uses the Call Agent to make a call.

## Hanging up

Once a call is open, we need to allow the user to hang up.

```javascript
hangUpButton.addEventListener("click", () => {
  // end the current call
  call.hangUp({ forEveryone: true });

  // toggle button states
  hangUpButton.disabled = true;
  callButton.disabled = false;
});
```

This code, registers a click handler on the "Hang Up" button and then just instructs the call to hang up.

## Receive a call

Now that we can make a call, we also need to handle receiving a call. To do this, we'll create the incoming call handler which we mentioned earlier.

```javascript
const incomingCallHandler = async (args) => {
  const incomingCall = args.incomingCall;

  // Accept the call
  await incomingCall.accept();

  // Subscribe to callEnded event and get the call end reason
  incomingCall.on('callEnded', args => {
      console.log(args.callEndReason);
  });
};
```

## Testing

We're done, If you run the app with the same command as the previous unit: `npx parcel index.html` and then open the app in your browser. You'll have a functional basic calling app!

### Getting test credentials

To test actually making a call you'll need some credentials. You can obtain these from the Azure Portal. Open your Azure Communication Services resource within the Azure Portal and click the "Identities & User Access Tokens" button within the left hand menu:

:::image type="content" source="../media/4-identities-menu-option.png" alt-text="Azure Portal, showing the Identities & User Access Tokens menu option highlighted.":::

On the page that appears, you can generate test credentials. For this app we just need the "Voice and video calling (VOIP)" permission so check this and press generate:

:::image type="content" source="../media/4-generate-button.png" alt-text="Token generation window with VOIP option checked.":::

This will then present you with a single Azure Communication Services identity which is suitable for testing. Make sure to copy the token AND ID to somewhere safe for testing, such as a blank notepad document.

:::image type="content" source="../media/4-test-credentials.png" alt-text="Token generation window with test credentials showing.":::

If you'd like to try calling another user then please generate **two sets of credentials**, one for the calling user and one for the receiving user.

In a real world app, you should use our identity systems and client libraries to create and store these credentials. This way a real-world user doesn't need to manually copy and enter these items. For more information on this concept check the links at the end of this module.

### Calling the Echo Bot

Azure Communication Services has an Echo Bot which you can call to test your microphone. It is compatible with this app. To call the Echo Bot:

1. Open the app in your browser
1. Paste a saved token into the user token input element.
1. Press the "Submit" button
1. Enter the Echo Bot's user ID `8:echo123`
1. Press "Start Call"

Your browser may prompt you with some microphone permission dialogs so please ensure you accept them. If everything worked out correctly you should be on a call with the Echo Bot. It will enable you to record a short message which it will then play back to you.

### Calling another user

You can also call another user with this app. To do this:

1. Open two copies of the app, multiple tabs or windows should be used to simulate calling another user.
1. In the first copy, enter the first user token saved from the credential generator and press "Submit"
1. In the second copy, enter the second user token saved from the credential generator and press "Submit"
1. From the first copy, enter the **second user id**, into the "Who would you like to call?" input element.
1. Again from the first copy, click "Start Call".

This will call the second window/tab's user. If both tabs/windows are on the same device this may result in echoes but it does show the process and calls working between two browser tabs. If you deploy your app to a web server that multiple machines can access, you'll be able to have a true voice call without echo.
