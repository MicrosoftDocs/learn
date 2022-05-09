Your mobile app is now up and running and you've created the initial version of the Azure Functions. In this unit, you'll call the Azure Functions from the mobile app, passing in the user's location and the list of phone numbers the user wants to send SMS to.

## Call the Azure Functions from the mobile app

1. Open the `MainViewModel` in the ImHere project.

1. Add a using directive for `System.Net.Http`, `Newtonsoft.Json`, and `ImHere.Data`.

    ```cs
    using System.Net.Http;
    using ImHere.Data;
    using Newtonsoft.Json;
    ```

1. In this class, add a private `HttpClient` field called `client`.

    ```cs
    HttpClient client = new HttpClient();
    ```

1. Add a constant field for the base URL for the function. Set this to the address that the local Azure Functions runtime is listening on. Once the function is deployed to Azure, this constant can be changed to be the Azure URL.

    ```cs
    const string baseUrl = "http://localhost:7071";
    ```

1. In the `SendLocation` method, create a new instance of `PostData` using the location and the list of phone numbers entered by the user.

    ```cs
    PostData postData = new PostData
    {
        Latitude = location.Latitude,
        Longitude = location.Longitude,
        ToNumbers = PhoneNumbers.Split('\n')
    };
    ```

    > [!NOTE]
    > This assumes that the phone numbers have been entered in the correct format, one per line in the `Editor` control. In a production-quality app, there would be validation around this to ensure one or more phone numbers were entered and were in the correct format.

1. To serialize the `PostData` as JSON, the easiest way is to use the Newtonsoft.Json NuGet package. Add this NuGet package to the `ImHere`.

     - Right-click **Dependencies** under the ImHere project and select _Manage NuGet Packages..._.
     - In the **Browse** tab, search for Newtonsoft.Json package and select **Install**. The NuGet package will be added to your project.

1. Serialize the `PostData` to a `string` using the `JsonConvert` static class. Encode this string into a `StringContent` class so that it can be passed to the Azure Functions as JSON.

    ```cs
    string data = JsonConvert.SerializeObject(postData);
    StringContent content = new StringContent(data, Encoding.UTF8, "application/json");
    ```

1. Post this data to the function and get the result back.

   ```cs
    HttpResponseMessage result = await client.PostAsync($"{baseUrl}/api/SendLocation",
                                                        content);
   ```

   Azure Functions are accessed using `/api/<function name>`, so assuming the port chosen by the local Functions runtime is 7071, the `SendLocation` function will be accessible at `http://localhost:7071/api/SendLocation`.

1. Depending on the result, show a message on the UI.

    ```cs
    if (result.IsSuccessStatusCode)
        Message = "Location sent successfully";
    else
        Message = $"Error - {result.ReasonPhrase}";
    ```

The following is the full code for the MainViewModel, including the new fields for the `SendLocation` method.

```cs
using System.Threading.Tasks;
using System.Windows.Input;
using System.Text;
using Xamarin.Essentials;
using ImHere.Data;
using Newtonsoft.Json;
using System.Net.Http;
using Xamarin.Forms;


namespace ImHere
{
    public class MainViewModel : BaseViewModel
    {
        string message = "";
        public string Message
        {
            get => message;
            set => Set(ref message, value);
        }

        string phoneNumbers = "";
        public string PhoneNumbers
        {
            get => phoneNumbers;
            set => Set(ref phoneNumbers, value);
        }

        public MainViewModel()
        {
            SendLocationCommand = new Command(async () => await SendLocation());
        }

        public ICommand SendLocationCommand { get; }

        HttpClient client = new HttpClient();
        const string baseUrl = "http://localhost:7071";

        async Task SendLocation()
        {
            Location location = await Geolocation.GetLastKnownLocationAsync();

            if (location != null)
            {
                Message = $"Location found: {location.Latitude}, {location.Longitude}.";

                PostData postData = new PostData
                {
                    Latitude = location.Latitude,
                    Longitude = location.Longitude,
                    ToNumbers = PhoneNumbers.Split('\n')
                };

                string data = JsonConvert.SerializeObject(postData);
                StringContent content = new StringContent(data, Encoding.UTF8, "application/json");
                HttpResponseMessage result = await client.PostAsync($"{baseUrl}/api/SendLocation",
                                                                    content);

                if (result.IsSuccessStatusCode)
                    Message = "Location sent successfully";
                else
                    Message = $"Error - {result.ReasonPhrase}";
            }
        }
    }
}
```

## Testing it out

1. Make sure that your function is still running locally and the port matches the `SendLocation` method.

1. Set the UWP app as the startup app and run it. Select the **Send Location** button. You'll see output in the Functions runtime console window showing the function being called, and the logging showing the generated URL.

    :::image type="content" source="../media/6-function-called.png" alt-text="Screenshot of the output of the function being called.":::

1. To test the URL generation, paste it from the console into a browser. It should show your current location.

    > [!TIP]
    > The location you'll see is the location where the app is running, so will be near to the data center that the VM is running from. If this app was running on your local device then it would show your location.

## Summary

In this unit, you learned how to call the Azure Functions from the mobile app. This call passed the user's location and the phone numbers they entered as JSON. In the next unit, you'll bind your function to Twilio to send this location as an SMS message.
