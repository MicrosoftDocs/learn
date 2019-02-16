Azure Logic Apps allows you to automate your business processes and run them in the cloud without writing any code. 
 
The power of Logic Apps comes from all the systems it lets you talk to. You can connect to databases, social networks, messaging services, and cloud services like Azure Machine Learning. Logic Apps gives you predefined components to talk to hundreds of common systems like these.

It's difficult to get these services to work together because they each have a unique API. For example, talking to Oracle requires different code than accessing Cosmos DB or SQL Server. To build your own solution to integrate these services would require weeks of work and hundreds of lines of custom code.

Logic Apps builds a standard interface on top of these different APIs. This standardization lets you configure a few settings to allow services to speak to each other. Logic Apps handles the interaction without requiring you to write any code.

What if you need to use a service that doesn't have a built-in component? You can create a custom component to make that service available in your apps. For most services, a custom component is easy to do without writing any code. 
 
What if you need to include complex business rules or run any other type of custom code? You can put the code into an Azure Function and call the Function from your Logic App.
 
Let's look at an example to see how you assemble the pieces. Suppose you are launching a new product. You'd like to monitor social media to see how customers react to it. 
 
You want to watch for new social media postings about your product. When you find one, you'll use a machine learning algorithm to determine if the post is positive or negative. You'll then store the results in a database and send a notification so your marketing team is aware of the post.

To build the social-media monitor with Logic Apps, you'd start with a component that lets you monitor your preferred social media site. For example, you could watch for new tweets that contain the name of your product.

Then, you'd add components for each of the processing steps: one to connect to the Text Analytics service, one for your database, and one to send notifications.
 
If you change your process, you can swap out the components. For example, it's easy to switch from monitoring Twitter to watching an RSS feed. Or maybe you want post to Slack or send a text message instead of using email for notifications. You could replace the email component with one for Slack or Twilio.

You can also add decision-making into your app. Logic Apps has many of the control constructs you'd find in a programming language like loops and conditionals. For example, let's say you wanted to respond differently to positive and negative tweets. You can add an if statement to test the sentiment score and branch based on the result.

You use a graphical tool called the Logic Apps Designer to build your app. You add components and connect them to form your business process. Each component has a settings UI that lets you customize its configuration. There's no coding involved and anyone that understands your business process can do it.

Once you have your app created, it's time to run it. Your app runs in the cloud and the execution engine takes care of allocating the needed resources. They even scale automatically to handle large datasets. For example, suppose you get several tweets about your product all at once. Logic Apps can automatically create one instance of your app to process each tweet. The instances run in parallel.

Logic Apps can invoke other Logic Apps. This technique lets you factor out common subtasks and reuse them in multiple Logic Apps. 

If you build many Logic Apps that have the same structure, you should consider creating a template for it. A template is a prebuilt app that you instantiate as needed. When create an app from a template, you can use the templates as is or you can customize it to suit your needs. 

Logic Apps has a library of templates for common app patterns. This can save you time if there's a template that matches what you want to build.
 
In summary, Logic Apps lets you connect disparate systems together to form your business workflows. There's no code to write and they run automatically in the cloud.