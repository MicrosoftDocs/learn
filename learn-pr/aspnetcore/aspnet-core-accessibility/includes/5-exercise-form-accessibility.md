In this exercise, you will use Accessibility Insights for web to identify and fix forms accessibility issues.

## Install Accessibility Insights for Web browser extension

1. Browse to the [Accessibility Insights for Web](https://accessibilityinsights.io/docs/en/web/overview/) page in either Chrome or Microsoft Edge.
1. Click install button that corresponds to your browser. 
1. When the extension page is displayed, click the appropriate button for your browser ("Get" for Edge, "Add to Chrome" for Chrome) to install the extension.

## Inspect the form using Fast Pass

Accessibility Insights for Web include three different tools:

- **FastPass** - Run three tests to find the most common accessibility issues in less than 5 minutes.
- **Assessment** - Walk through a guided process for assessing accessibility compliance.
- **Ad hoc tools** - Get quick access to visualizations that help you identify accessibility issues.

For this exercise, we will be using the FastPass tool.

1. Open the Launch Pad for Accessibility Insights for Web by clicking on the extension toolbar button in the browser. You can also open  or by using the keyboard shortcuts Ctrl+Shift+K (⌘+Shift+K for macOS)

   :::image type="content" source="../media/launch-pad.png" alt-text="Accessibility Insights for Web Launch Pad.":::

1. Click on the **FastPass** link. A second window will open, which will list the accessibility issues that FastPass has detected using automated checks.

    :::image type="content" source="../media/automated-checks-first-run.png" alt-text="Accessibility Insights for Web Fast Pass.":::

   Automated Checks have detected many errors. We're going to focus on the form in this exercise.

1. There are two different ways to interact with the error message - we can use the list in the FastPass tool, or we can click on the error messages in the web page. In this case, the FastPass tool lists errors across the entire page, which can be a little overwhelming when we want to focus on the form. We'll use the in-page error message for now. Click on the exclamation point to the right of the *First Name* label.

    :::image type="content" source="../media/first-name-error-icon.png" alt-text="Error icon displayed for First Name label.":::

   This shows that this label has low contrast, and also brings to our attention the fact that we're using color coding to indicate required fields in this form. By clicking on the error icons for the other labels, we can see that they all have low contrast. Let's look at the HTML for the the First Name section of the form to understand the color contrast issue:

   ```html
   <div class="row">
     <div class="col-4 text-primary">
       First Name
     </div>
     <div class="col-8">
       <input type="text" id="Name">
     </div>
   </div>
   ```

   Here we can see that the *First Name* label is using a Bootstrap `text-primary` class to show a light blue text color, indicating a required field. Remove the `text-primary` class and add a `required` attribute to the `<input>` tag instead, like this:

   ```html
   <div class="row">
     <div class="col-4">
       First Name
     </div>
     <div class="col-8">
       <input type="text" id="Name" required>
     </div>
   </div>
   ```

1. Run the application again, then launch the *FastPass* as before. We can see that the error for the *First Name* label has been cleared.

    :::image type="content" source="../media/first-name-fixed.png" alt-text="Accessibility Insights showing First Name label has been fixed.":::

    Great! That wasn't too hard, and now that we know the fix we can do the same thing for the rest of the labels, too. 

1. Reviewing the HTML for the rest of the form, we can see that the labels are using either `text-primary` or `text-black-50` to color the labels. Remove these attributes, and add the `required` attribute to the *Last Name* and E-mail Address" input fields:

   ```html
   <form name="CustomerInfo">
     <div class="container w-50 p-3">
       <div class="row">
         <div class="col-4">
           First Name
         </div>
         <div class="col-8">
           <input type="text" id="Name" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           Last Name
         </div>
         <div class="col-8">
           <input type="text" id="Name" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           Phone
         </div>
         <div class="col-8">
           <input type="text" id="Phone">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           Birthday
         </div>
         <div class="col-8">
           <input type="text" id="Birthday">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           E-mail Address
         </div>
         <div class="col-8">
           <input type="text" id="E-mail" required>
         </div>
       </div>
       <div class="button">
         <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
           Submit Form
         </a>
       </div>
     </div>
   </form>
   ```

   Running the application and viewing **FastPass** again, we can see that all of the label error messages have been cleared.

1. While not strictly required, we can continue to show an indication for the required fields. Update the `<style>` block near the top of the page to include rules for required and optional fields: 

   ```css
   input:optional {
     border-color: #ccc;
   }
   input:required {
     border-color: mediumblue;
   }
   ```

   This will now show a blue border around the required fields.

1. We're now ready to fix up the form element. Clicking on the error indication for the *First Name* field shows that there are two errors. The first error indicates that the form `<input>` tag does not have a unique attribute. This is a problem, since HTML IDs are always assumed to be unique, and assistive technologies will often only act on the first element.

   :::image type="content" source="../media/id-attribute-required.png" alt-text="Error message showing a unique ID attribute is required for each input.":::

   Looking at the source code, we can see that we used `Name` as the ID for both the *First Name* and *Last Name* fields:

   ```html
   <div class="col-8">
       <input type="text" id="Name" required>
     </div>
   </div>
   <div class="row">
     <div class="col-4">
       Last Name
     </div>
     <div class="col-8">
       <input type="text" id="Name" required>
     </div>
   </div>
   ```

   Change the IDs to `FirstName` and `LastName` respectively:

   ```html
   <div class="col-8">
       <input type="text" id="FirstName" required>
     </div>
   </div>
   <div class="row">
     <div class="col-4">
       Last Name
     </div>
     <div class="col-8">
       <input type="text" id="LastName" required>
     </div>
   </div>
   ```

1. Run the application and check **FastPass** again. Clicking on the error indication for each of the input fields shows that we're getting close now, each has the same error message: each form field should have a label.

    :::image type="content" source="../media/label-error-message.png" alt-text="Error message showing each form element should have an associated label.":::

1. Update the *First Name* text to use a `<label>` tag as shown:

   ```html
   <div class="row">
     <div class="col-4">
       <label for="FirstName">First Name</label>
     </div>
     <div class="col-8">
       <input type="text" id="FirstName" required>
     </div>
   </div>
   ```

1. Run the application and **FastPass** again. You should see two things. First, the error message for the *First Name* element has cleared. Second, clicking on the *First Name* label now selects the *First Name* input.

1. Add `<label>` tags to the other form input fields. Your form code should look like this now:

   ```html
   <form name="CustomerInfo">
     <div class="container w-50 p-3">
       <div class="row">
         <div class="col-4">
           <label for="FirstName">First Name</label>
         </div>
         <div class="col-8">
           <input type="text" id="FirstName" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="LastName">Last Name</label>
         </div>
         <div class="col-8">
           <input type="text" id="LastName" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="Phone">Phone</label>
         </div>
         <div class="col-8">
           <input type="text" id="Phone">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="Birthday">Birthday</label>
         </div>
         <div class="col-8">
           <input type="text" id="Birthday">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="E-mail">E-mail Address</label>
         </div>
         <div class="col-8">
           <input type="text" id="E-mail" required>
         </div>
       </div>
       <div class="button">
         <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
           Submit Form
         </a>
       </div>
     </div>
   </form>   
   ```

   This clears all the form field errors!

1. Now it's time to fix the *Submit* button. There are a few problems here - low contrast (as shown in the error message), and an `onclick` event that runs custom JavaScript. We can fix all of that by replacing the button with a standard `<input type="submit">`.

   Find this code:

   ```html
   <div class="button">
     <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
       Submit Form
     </a>
   </div>   
   ```

   Replace it with this:

   ```html
   <div class="text-center">
      <input class="btn btn-primary" type="submit">
   </div>   
   ```

We've completed all of our required fixes, but there's one more quick improvement we can make - changing the input types from `text` to more specific input types where available.

1. Change the `type` attribute for the *Phone* field to `tel`.
1. Change the `type` attribute for the *Birthday* field to `date`.
1. Change the `type` attribute for the *E-mail* field to `email`. The completed code for the form should appear as follows:

   ```html
   <form name="CustomerInfo">
     <div class="container w-50 p-3">
       <div class="row">
         <div class="col-4">
           <label for="FirstName">First Name</label>
         </div>
         <div class="col-8">
           <input type="text" id="FirstName" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="LastName">Last Name</label>
         </div>
         <div class="col-8">
           <input type="text" id="LastName" required>
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="Phone">Phone</label>
         </div>
         <div class="col-8">
           <input type="tel" id="Phone">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="Birthday">Birthday</label>
         </div>
         <div class="col-8">
           <input type="date" id="Birthday">
         </div>
       </div>
       <div class="row">
         <div class="col-4">
           <label for="E-mail">E-mail Address</label>
         </div>
         <div class="col-8">
           <input type="email" id="E-mail" required>
         </div>
       </div>
       <div class="text-center">
          <input class="btn btn-primary" type="submit">
       </div>
     </div>
   </form>   
   ```

1. Run the application and check with **FastPass**. You'll see that we've improved the experience for all users while fixing our accessibility issues. The new form shows no errors in **FastPass**, and includes browser-native input controls with validation and required field checking with no another code.

    :::image type="content" source="../media/completed-form.png" alt-text="Completed form showing various input types and automatic validation.":::