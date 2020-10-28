

The Custom Vision APIs use a pair of *subscription keys* to control access to the two APIs of the service:

- **The training key** to access API members used to train the model.
- **The prediction key** to access API members used to classify images against a trained model.

The separation of Custom Vision API subscription keys makes it easy to provide keys based on application, business, or technical requirements. For example, a service requiring only prediction tasks will only be able to use that API and will only be charged against the prediction quota. Both of these keys are available in the portal when you create your Custom Vision service.

> [!TIP]
> You can also find the keys on the Azure portal page for the Custom Vision Azure resource associated with your project, on the **Keys** blade.

## Supplying a subscription key

Every programmatic call to the Custom Vision APIs requires that one of these subscription keys be passed to the service as a request header value. For example, if the code were calling the Prediction API in C#, you'd use the `DefaultRequestHeaders` collection to add the prediction key to the request with the key `Prediction-Key`:

```csharp
string predictionKey = "...";
HttpClient client = new HttpClient();
client.DefaultRequestHeaders.Add("Prediction-Key", predictionKey)
```

The same code in Ruby would look something like this example:

```ruby
request['Prediction-Key'] = '{prediction key}'
```

Because the Custom Vision APIs are divided into distinct training and prediction APIs, let's take a look at each API in more detail, starting with the Custom Vision Prediction API.