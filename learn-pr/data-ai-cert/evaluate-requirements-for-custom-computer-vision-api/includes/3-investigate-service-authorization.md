## Investigate Service Authorization

The Custom Vision API uses a pair of _subscription keys_ to control access to the two aspects of the service.

1. **Training key** to access APIs used to train the model.
1. **Prediction key** to access APIs used to classify images against a trained model.

The separation of Custom Vision API subscription keys makes it easy to provide keys based on application, business, or technical requirements. For example, a service requiring only prediction tasks will only be able to use that API and only be charged against the prediction quota. Both of these keys are available in the portal when you create your Custom Vision Service.

> [!TIP]
> The keys can also be found in the Azure portal page for the Custom Vision Azure Resource associated with your project, under the Keys blade.

## Supplying a subscription key

Every programmatic call to the Custom Vision API requires one of these subscription keys to be passed to the service as a request header value. For example, if the code were calling the Prediction API in C#, you would use the `DefaultRequestHeaders` collection to add the prediction key to the request with the key `Prediction-Key.`

```csharp
string predictionKey = "...";
HttpClient client = new HttpClient();
client.DefaultRequestHeaders.Add("Prediction-Key", predictionKey)
```

The same code in Ruby would look something like:

```ruby
request['Prediction-Key'] = '{prediction key}'
```

Since the Custom Vision API is divided into distinct training and prediction tasks, let's take a look at each API in more detail, starting with the **Custom Vision Prediction API**.