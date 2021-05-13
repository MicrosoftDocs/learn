One of the most important ways users interact with our web applications is by using forms to submit information. There are several important considerations in how you write your forms to make sure they can be navigated, filled in, and submitted by all of your users.

The fundamental concept is to use HTML the way it was designed. Standard HTML form elements are built for accessibility, but it's easy to unconsciously override those accessibility features with the latest JavaScript library or overly clever CSS.

## Labels

Ever input tag on your forms should have an associated `<label>` to identify it. This is different than just putting some text on the screen next to the input element, since labels are programmatically associated with the input elements. For example, screen readers will read the label text when the input element has focus. Additionally, clicking on a label will activate the input, making interaction easier. This will also help users with touchscreen devices - no more poking around for a tiny checkbox on a phone; instead, they can just click on the label.

Here's an example of an input text field with an associated label:

```html
<label for="name">Name</label>
<input type="text" id="name">
```

## Validation and error messages

### Required fields

Let's start with the simplest case: required fields. Rather than indicating these using color coding or other custom user interface elements, you can use the `required` attribute on the HTML input element. Screen readers can handle this, and users on any browser will see the required field interaction using the standard UI for their platform.

```html
<input type="text" id="name" required>
```

If you do want to include additional visual design for required elements, you can use the CSS pseudo-selector for required elements so you can include additional design for required elements. It's fine to provide additional styling, but using the `required` attribute provides accessible indication to all users. The following CSS style will set the border color for required textboxes to red.

```css
input:required
{
  border-color: red;
}
```

### Input types

HTML form elements offer comprehensive validation support for a variety of common input types. Rather than using custom JavaScript and HTML to show a date picker, for instance, you can just use this:

```html
<input type="date" id="birthday">
```

This provides a native date picker popup for the user's browser and operating system that is already tested for accessibility, and it handles validation for you. There is broad support for a lot of input types that used to require custom regex validation, UI elements, and JavaScript:

- Email
- Date
- Month
- Week
- Time
- Range
- URL
- Color

So now you can write less code *and* it will be more accessible! It's a win-win!

## Tab order

Users who are navigating through your form using a keyboard or screen reader will rely on tab order. This will usually just work unless you've got a complicated form design or are trying to do something too fancy. It's actually kind of hard to mess this up for most forms. However, it's important to test. You can test just by hitting the tab key on your keyboard and testing the interaction, but Accessibility Insights for Web makes this a lot easier. We'll see that in the next exercise.

## Form submission

When a user is done filling out the form and ready to submit it, nothing is more frustrating than over-complicating the process. The best way to support form submission is a simple `<input type="submit">` element:

```html
<form>
  <input type="text" id="name" required>
  <input type="date" id="birthday">
  <input type="submit">
</form>
```

You've probably picked up the pattern by now: using the built-in HTML form behavior rather than wiring up custom JavaScript and UI will make your form more usable across a variety of browsing experiences.

Now that you know the basics, we're ready to fix up our pizza website in the next exercise.
