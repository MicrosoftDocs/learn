In the previous unit, we created an echo bot from a template. Let's take a look at the code and change the bot's behavior.

## Explore your bot code

Open your bot project in Visual Studio. To explore the bot code, we'll use Solution Explorer.

In the Solution Explorer tool window, expand your bot's project node. Expand the `Bots` folder next, and then select your bot code file, `EchoBot.cs`:

:::image type="content" source="../media/visual-studio-open-bot-code.png" alt-text="Screenshot that shows how to open your bot code in the Visual Studio Solution Explorer tool window.":::

If you're familiar with ASP.NET web development, you might recognize what looks like code for an ASP.NET website. In fact, the bot is designed to be a web application that defines the `/api/messages` endpoint.

If that explanation seems too complicated, don't worry. The main thing you need to know is that the `EchoBot.cs` file contains your bot's functionality.

## Add a dictionary of capital/major cities

Let's try to make our bot do something useful. Consider the problem of learning the capital/major cities of different countries/regions. Our first exercise is to turn our bot into a "capital dictionary" that returns the capital/major city of any given country/region.

The [list of capital/major cities][List of capital/major cities] on Wikipedia highlights an important fairness and data complexity problem. Some countries/regions, like Switzerland, might not have a *de jure* capital/major city. Other countries/regions, like Israel, have a capital/major city that's not officially recognized by all other countries/regions.

To make our bot as responsible as possible, we have to keep these tricky situations in mind. Unfortunately, there's no easy way to solve this problem.  For this module, we'll choose the simplest solution, which is to cite our data source. To implement a more complex approach, here are some options to consider:

- Program the bot to return different results based on the user's language.
- Make use of another technological mechanism to accommodate for the fairness and complexity issues.

There's one more important issue that we have to address: capital/major cities and countries/regions change. We need to update our bot periodically so that users maintain trust in the bot. Maybe we can display a "last updated" date to make it clear how recent our data is.

### Get the initial data

As a starting point for our data, let's use the World Cities Database from SimpleMaps.com.

1. Go to the [SimpleMaps][SimpleMaps] site.

1. Scroll to the **Databases** section. Under the **Basic** (free) option, select **Download**. When you're prompted, select **Download**.

1. Open the ZIP file, and extract the `worldcities.csv` file to the root folder of your bot project directory (`C:\bot-code` or similar).

   Here's a sample of the data in the `worldcities.csv` file:

   ```csv
   "city","city_ascii","lat","lng","country","iso2","iso3","admin_name","capital","population","id"
   "Tokyo","Tokyo","35.6897","139.6922","Japan","JP","JPN","Tōkyō","primary","37977000","1392685764"
   "New York","New York","40.6943","-73.9249","United States","US","USA","New York","","18713220","1840034016"
   ```

### Create classes to store the data

To represent the country data, we'll create a new class in the root of our project.

1. In the **Solution Explorer** tool window in Visual Studio, right-click the **EchoBot** project, and then select **Add** > **Class**.

1. In the **Add New Item** dialog, configure the new class:

   - In the middle pane, select **Class** to create an empty Visual C# class declaration.

   - At the bottom, enter the name of the class, `CountryData.cs`.

   Then select **Add**.

   :::image type="content" source="../media/visual-studio-add-new-class.png" alt-text="Screenshot that shows how to add a new class in Visual Studio.":::

   Visual Studio opens a new file for the *CountryData.cs* class and adds that file to your `EchoBot.sln` solution. The file contains an empty declaration for the `CountryData` class:

   :::image type="content" source="../media/visual-studio-empty-class.png" alt-text="Screenshot that shows the new empty class in Visual Studio.":::

1. The `CountryData` class will load the whole table of data from the `worldcities.csv` file. In the `CountryData.cs` file, replace the empty declaration on lines 8–10 with the following code:

   ```csharp
   public class CountryData
   {
       protected Country[] Countries { get; set; }
   
       public CountryData(string fn)
       {
           var data = System.IO.File.ReadAllLines(fn);
           Countries = (from z in data.Skip(1)
                        select new Country(z)).ToArray();
       }
   }
   ```

   This class uses a *language-integrated query (LINQ)* expression to go through each line of the data file. It converts the data to `Country` objects, and then stores the objects as an array. To do these tasks, the `CountryData` class uses another new class named `Country`. For simplicity, we'll add the definition for the `Country` class in the same `CountryData.cs` file.

1. In the `CountryData.cs` file, add the following code to define the `Country` class. Place the code after the definition for the `CountryData.cs` class, but before the closing curly parenthesis for the file.

   ```csharp
   public class Country
   {
       public Country(string s)
       {
           var t = s.Split(',');
           Capital = t[0].Trim('"');
           Name = t[4].Trim('"');
           float res;
           Population = float.TryParse(t[9].Trim('"'), out res) ? (int)res : 0;
        }
    
       public string Name { get; set; }
       public string Capital { get; set; }
       public int Population { get; set; }
   }
   ```

   The `Country` class takes one line from the `worldcities.csv` table loaded by the `CountryData` class and parses the data into corresponding fields.

### Add a function to get the capital city

We need to extend the behavior of the `CountryData` class definition to get the capital/major city for a given country/region. We'll create the `GetCapital` function inside the `CountryData` class. Add the following code to the end of the `CountryData` class definition, before the closing curly parenthesis for the class:

```csharp
public string GetCapital(string country)
{
     return Countries.FirstOrDefault(
         c => c.Name.ToLower() == country.ToLower())?.Capital;
}
```

The `GetCapital` function returns `null` if the country/region isn't found in the list.

### Implement the bot logic

Our last code update is to add the logic for our bot to the `Bots\EchoBot.cs` file.

To add this logic, we'll reprogram the primary function in that file, `OnMessageActivityAsync`. This function is called each time the bot receives a message from the user.

Currently, the code echoes the user's message. We'd like to change the function to respond with a capital when a user enters a country/region.

To make this change:

1. Open the `Bots\EchoBot.cs` file in Visual Studio.

1. Replace the body of the `OnMessageActivityAsync` function between the curly parentheses with the following code:

   ```csharp
       var name = turnContext.Activity.Text;
       var f = System.IO.Path.Combine(System.Environment.CurrentDirectory, @"worldcities.csv");
       var cd = new CountryData(f);
       var cap = cd.GetCapital(name);
       var replyText = cap == null
           ? "I do not know this country"
           : $"The capital of {name} is {cap}!" ;
       await turnContext.SendActivityAsync(replyText);
   ```

1. Save your changes.

In our code for these exercises, we haven't considered performance. Instead we're focusing on simplicity. In a proper implementation, we'd get faster access by using a hash table structure to store the dictionary of countries/regions and capital/major cities.

We've now programmed our bot to inform users about a countries'/regions' capital/major cities. In the next unit, we'll make one more code change. Then we'll test this functionality.

<!-- Links -->

[List of capitals/major cities]: https://en.wikipedia.org/wiki/List_of_national_capitals
[SimpleMaps]: https://simplemaps.com/data/world-cities?azure-portal=true
