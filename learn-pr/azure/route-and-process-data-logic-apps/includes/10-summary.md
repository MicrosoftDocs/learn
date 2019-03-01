Logic Apps let us automate our social-media monitor workflow. Instead of spending the marketing team's time manually sampling a few tweets, our app lets us analyze *every* tweet about our product. This means we get extensive data that we can feed into in our analytics process to help shape future decisions.

Imagine how much work it would be to build an app like this from scratch. You'd need to write code to access each of the service's APIs. This would have to include a polling infrastructure to monitor Twitter and trigger your app when new tweets were available. Once all the code was ready, you'd need servers to host the app.

Logic Apps made it easy because the standard connectors already did the hard work of integrating systems that were never designed to work together. We pulled data from Twitter, sent it to Azure Cognitive Services, added it to SQL Server, and sent it via Outlook email. We did all this in under an hour without writing any code or setting up any servers. 

[!include[](../../../includes/azure-sandbox-cleanup.md)]