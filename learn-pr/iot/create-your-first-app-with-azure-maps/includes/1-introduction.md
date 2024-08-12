Finding your way on a map is fun, right up to the point where you become lost!

Getting lost isn't usually a desirable position to be in. In this module, we build an app that finds a route many thousands of miles long. Yet, the map is accurate to such a level of detail that a driver knows which turn to take to bypass road construction in the middle of a bustling city.

Route finding is just one of many features of Azure Maps. Other features haven't anything to do with roads and routes. It can be used to display any spatial data you can think of. For example, population changes, weather systems, industrial or agricultural output, construction cranes per square mile, or any census data.

However, route finding is fun to watch. It's one of the applications of mapping services that helps us understand just how detailed the maps are. It's a dynamic application that we can play with. Who isn't curious to know whether road and traffic data is good enough to help with our daily travels?

  [![Photograph of city street traffic.](../media/azure-maps-buildings.png)](../media/azure-maps-buildings.png#lightbox)

## Learning objectives

In this module, you:

- Create a free Azure Maps account.
- Create an HTML and JavaScript app, for cross-country route finding, using Visual Studio Code.
- Learn about route finding, map layers, hazardous materials, and integrating maps into your apps.

## Prerequisites

- An introductory knowledge of the purpose of Azure Maps.
- Ability to navigate the Azure portal.
- Ability to use HTML, and JavaScript, at the beginner level.
- Experience using Visual Studio Code, at the beginner level.

## The scenario

We're going to use Azure Maps route finding, to select a best route from a west coast city, to an east coast city. Arbitrarily, we chose Seattle, Portland, and San Francisco as the west coast cities, and New York, Charleston, and Miami as the east coast cities. You're able to change these locations to any favorites you might have.

Also, we want to find the route for various vehicles. We find the routes for a truck, a car, and a bicycle. OK, so cycling from Seattle to Miami might sound like madness to many. However, there's method to our madness. By including bicycles in our selection of vehicles, we can see the cross-country routes, the passenger only ferries, or the bike trails, that are included in the underlying Azure Maps data.

On a more professional note, we can also vary the contents of our truck. There are nine classifications of hazardous materials, and our test app allows us to specify any one of them. We add this feature so, again, we can see if the Azure Maps route finding algorithms can navigate through areas with road-use restrictions - "No flammable materials in the I-90 tunnel," for example.

Finally, we need to know that a route can consist of more than a start and ending location. There can be many intermediary points on any desired route. For our test app, we add the option of saying "hi" to Chicago when you pass through.

The following image shows the app we're going to build.

  [![Screenshot showing the complete Azure Maps app.](../media/azure-maps-app.png)](../media/azure-maps-app.png#lightbox)

Notice, far right, that the travel distance, and estimated time, are provided. The map view shows the route. At the scale shown in the previous image, you might wonder how much detail there really is. Look at the following image, it shows a route out of San Francisco, on a jaunt to Miami. The car and truck head north, the bicycle however, heads south. Every turn on every block is clear.

  [![Screenshot showing the route out of San Francisco.](../media/azure-maps-sf-miami.png)](../media/azure-maps-sf-miami.png#lightbox)

## First steps

To begin our journey into the wonderful world of route finding, we need to start at square one, and create an Azure Maps account. The next unit creates the basics.
