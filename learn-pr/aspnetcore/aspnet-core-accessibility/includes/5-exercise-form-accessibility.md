In this exercise, you use Accessibility Insights for Web to identify and fix accessibility issues in a form.

## Install the Accessibility Insights for Web browser extension

1. Go to the [Accessibility Insights for Web](https://accessibilityinsights.io/docs/en/web/overview/) page in either Google Chrome or Microsoft Edge.
1. Select the install button that corresponds to your browser. 
1. When the extension page appears, select the appropriate button for your browser (**Get** for Microsoft Edge, **Add to Chrome** for Chrome) to install the extension.

## Inspect the form using by FastPass

For this exercise, you use the FastPass tool. In FastPass, you run three tests to find the most common accessibility issues in less than five minutes.

1. Open **Launch pad** for Accessibility Insights for Web by selecting the extension's toolbar button in the browser. You can also use the keyboard shortcut Ctrl+Shift+K (⌘+Shift+K for macOS).

   :::image type="content" source="../media/launch-pad.png" alt-text="Screenshot that shows the launch pad in Accessibility Insights for Web.":::

1. Select the **FastPass** link. A second window opens and lists the accessibility issues that FastPass detected in automated checks.

    :::image type="content" source="../media/automated-checks-first-run.png" alt-text="Screenshot that shows automated checks in Accessibility Insights for Web.":::

   Automated checks detected many errors. We're going to focus on the form in this exercise.

1. There are two ways to interact with error messages. You can use the list in the FastPass tool, or you can select the error messages on the webpage. In this case, the FastPass tool lists errors across the entire page, which can be a little overwhelming when you want to focus on the form. Let's use the in-page error message for now.

   Select the exclamation point to the right of the **First Name** label.

    :::image type="content" source="../media/first-name-error-icon.png" alt-text="Screenshot that shows the error icon displayed for the First Name label.":::

   The UI shows that this label has low contrast. It also brings to your attention that you're using color coding to indicate required fields in this form.

   By selecting the error icons for the other labels, you can see that they all have low contrast. Let's look at the HTML for the **First Name** section of the form to understand the color contrast issue.

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

   Here, you can see that the **First Name** label is using a Bootstrap `text-primary` class to show a light blue text color that indicates a required field. Remove the `text-primary` class and add a `required` attribute to the `<input>` tag instead, like this.

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

1. Run the application again, and then run FastPass as before. You can see that the error for the **First Name** label is now cleared.

    :::image type="content" source="../media/first-name-fixed.png" alt-text="Screenshot of Accessibility Insights for Web, showing a fixed First Name label.":::

    Great! Now that you know the fix, you can do the same thing for the rest of the labels.

1. Review the HTML for the rest of the form. You can see that the labels are using either `text-primary` or `text-black-50` for color. Remove these attributes, and add the `required` attribute to the **Last Name** and **Email Address** input fields.

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
           Email Address
         </div>
         <div class="col-8">
           <input type="text" id="Email" required>
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

1. Run the application and view FastPass again. You can see that all of the label error messages are now cleared.

1. It isn't strictly required, but you can continue to show an indication for the required fields. Update the `<style>` block near the top of the page to include rules for required and optional fields.

   ```css
   input:optional {
     border-color: #ccc;
   }
   input:required {
     border-color: mediumblue;
   }
   ```

   There's now a blue border around the required fields.

1. You're now ready to fix the form element. Selecting the error indication for the **First Name** field shows that there are two errors. The first error indicates that the form's `<input>` tag doesn't have a unique attribute. This attribute value is a problem because HTML IDs are always assumed to be unique, and assistive technologies often only act on the first element.

   :::image type="content" source="../media/id-attribute-required.png" alt-text="Screenshot of an error message showing that a unique ID attribute is required for each input.":::

   In the source code, you can see that you used `Name` as the ID for both the **First Name** and **Last Name** fields.

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

   Change the IDs to `FirstName` and `LastName`, respectively.

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

1. Run the application and check FastPass again. Selecting the error indication for each input field shows that you're getting close now. Each input field has the same error message that says it needs a label.

    :::image type="content" source="../media/label-error-message.png" alt-text="Screenshot of an error message showing that each form element should have an associated label.":::

1. Update the **First Name** text to use a `<label>` tag.

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

1. Run the application and check FastPass again. You should see two things. First, the error message for the `FirstName` element is now cleared. Second, selecting the **First Name** label now selects the **First Name** input.

1. Add `<label>` tags to the other form input fields. Your form code should now look like this.

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
           <label for="Email">Email Address</label>
         </div>
         <div class="col-8">
           <input type="text" id="Email" required>
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

   This code clears all the form field errors!

1. Now it's time to fix the **Submit** button. The problems here are low contrast (as shown in the error message) and an `onclick` event that runs custom JavaScript. You can fix both of them by replacing the button with a standard `<input type="submit">` class.

   Find this code.

   ```html
   <div class="button">
     <a href="#" onclick="document.getElementById('CustomerInfo').Submit();">
       Submit Form
     </a>
   </div>   
   ```

   Replace it with this code.

   ```html
   <div class="text-center">
      <input class="btn btn-primary" type="submit">
   </div>   
   ```

You completed all the required fixes, but there's one more quick improvement that you can make. You can change the input types from `text` to something more specific where available.

1. Change the `type` attribute for the **Phone** field to `tel`.
1. Change the `type` attribute for the **Birthday** field to `date`.
1. Change the `type` attribute for the **Email** field to `email`. The completed code for the form should now look like this.

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
           <label for="Email">Email Address</label>
         </div>
         <div class="col-8">
           <input type="email" id="Email" required>
         </div>
       </div>
       <div class="text-center">
          <input class="btn btn-primary" type="submit">
       </div>
     </div>
   </form>   
   ```

1. Run the application and check FastPass. You can see that you improved the experience for all users while fixing accessibility issues. The new form shows no errors in FastPass. It includes browser-native input controls with validation and required field checking with no other code.

    :::image type="content" source="../media/completed-form.png" alt-text="Screenshot of a completed form that shows various input types and automatic validation.":::
