A form a is section of HTML in which a user can fill in information into different input fields. The user can then go on to *submit* the form by pressing a submit button. What happens then is usually that the collected information is sent towards a backend service and the collected information is persisted. 

## Form

As part of the HTML standard you can declare a piece of markup known as a form. A form is a concept in the real world, usually a piece of paper we fill in. That's what it's used for in web pages as well, to fill in content. What you fill in varies, sometimes you need to enter some text, sometimes you need to make a choice and so on.

### Form elements

To help you create a form that caters to all types of input, there exist different input elements. These input elements take different types of input. Here's a subset of input elements available for you to use:

- **form element**, this element represents the form you are creating. The idea is to declare a form element with a number of input controls inside of it. Here's an example:

   ```html
   <form>
     <input type="text" placeholder="enter a value">
   </form>
   ```

- **text element**, this element has the following markup `<input type="text">`. The idea with this element is to have the user fill in some text
- **radio element**, this element has the following markup `<input type="radio">`. The idea with radio elements is for a user to select one radio element out of many. That chosen element should represent something specific like the color of a merchandise they are about to order for example.
- **button**, a button inside of a form has a specific meaning. A button has the semantic meaning of *submitting* a form. That means sending the content towards a specified location for persistence.

There's lot more elements you could use but the important part is to understand that the form is like a container that contains numerous different fields that the user can fill out.

### Validation

An important part of filling in a form is ensuring that what's filled in is *valid data*. So what's meant by valid data? Imagine you are filling out a form that is meant to ship an order to a specific location. It's important to fill out a correct address so the order can be delivered. What you want to ensure is that the user is made aware of mistakes they have committed in filling out the form so they can correct them. The input elements therefore have some built-in properties that will help you verify certain things. An input field can, for example,  define min and max values or state that only a certain pattern can be entered. It can look like so in markup:

```html
<input type="number" min="1" max="10">
```

Where you to fill in `11` the browser would by default stop you from submitting this form before you have entered a correct value. Given the above, a correct value is a value between `1-10`.

The browser together with these attributes on input elements is your first line of defense. However, sometimes you might have more complicated checks you need to make that only a backend service can answer. For that reason you might want to rely on *custom* validation and shut off the browsers built-in validation behavior. It's then up to you to handle the validation using JavaScript on the client side and possibly also do some validation on the server side.

### Submission process

You've already been told how a form can be *submitted* and sent to backend for persistence but let's talk more about this topic. You were told above how the button has a specific meaning and would help *submit* the form. Let's have a look at a basic form to try to understand this:

```javascript
<form>
  <input name="company" type="text" />
  <button>Submit</button>
</form>
```

You can set a few attributes on the form element and depending on what those values are it decides what happens when you click the submit button. Let's list some of them below:

- **action**, this attribute is a URL and points to where the submitted data should be sent
- **method**, this attribute expects an HTTP verb like GET or POST for example.
- **novalidate**, this attribute is what you need to set to `true` if you want to do your own validation and not rely on the browser to do it for you.
- **enctype**, if you set the `method` attribute to `POST` this will take effect. This attribute instructs how the data should be *encoded* when sent to the URL specified in the `action` attribute. Valid values here are:
  - **application/x-www-form-urlencoded**, this is the default values and what it does is to turn the form into one long URL string looking something like this `company=<what user entered for company>&name=<what user entered for name>`. It is possible to set this value both for method value `GET` and `POST`. If you set it for `GET` the values of the form gets appended to the URL. For `POST` the form is still URL encoded but becomes part of its body.
  - **multipart/form-data**, if your form contains a file upload element your form needs to have this value as it allows the file to be transmitted. You will learn more about this in an upcoming unit in this learn module.
  - **text/plain**, this encoding type is rarely used. If the selected method is , GET` you can't use this as the forms content would need to be URL encoded for it to be a valid URL. For ,POST` you can set `text/plain` but not all frameworks support it.

## Server-side submission

So you've pressed the submit button and the data is being sent to the URL where the `action` property is pointing, now what? Now you set up your Node.js application to handle a request towards the mentioned URL. More specifically you can build a Node.js application using Express. That application needs to do the following to receive the request

1. **Declare a route mapping** return a webpage with form. We need this page so the user is able to interact and submit a form
2. **Declare a route mapping**. This route will handle the incoming request from the submitted form.
3. **Listen** and transform the incoming data so it can be used. The data will arrive in a raw form, as chunks of data. We need to handle those chunks and ensure we can easily work with the submitted data.

### Declare route mappings

You've seen before how you can declare a route mapping like so:

```javascript
app.get('/<some route>', () => {
  // handler
})
```

One of the two routes we need has to return content back that the browser and should render as HTML. By setting a response header to , text/html` you can achieve just that.

The other route should handle the form submission and needs to ensure its path matches what's stated in the `action` attribute of the form tag and also what's specified in the `method` attribute. Let's say the form tag is specified like so:

```html
<form action="/submit" method="POST">
```

Then the corresponding code in Node.js needs to match the above by having a router mapping like so:

```javascript

app.post('/submit', () => {
  // handle request from the for submission
})
```

Note the use of the `post()` method and the path `/submit` matching what's declared in the form tag.

### Listen and transform incoming data

The Express framework is built on top of the http module. That means whatever the http module can do, Express can also do. You learned in the first unit of this module how the http module deals with requests in the following way:

```javascript
const server = createServer((req, res) => {})
```

`req` is a stream, a data structure that supports data that can arrive continuously over time. A stream gives you the option of listening for different events like `data`, `close`, `error` and more. These events signal what's going on and when it's safe to access the data. In Express you can do the same, like so:

```javascript
app.post('/submit', (req, res) => {
  req.on('data', () => {
   // chunk of data has arrived
  })
})
```

Express has better way to handle this though, to make it easier for you as a developer. When you install Express, it also installs the library `body-parser`. This library does the heavy lifting for you by listening to the stream of incoming data and once done place that in the `body` property of the request object. Instead of the above low-level code, to capture the submitted form, you can instead access submitted information like so:

```javascript
req.body.name // name value from a submitted form
```
