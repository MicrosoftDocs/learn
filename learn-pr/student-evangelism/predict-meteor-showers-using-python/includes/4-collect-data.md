Now it's time to get data ready to create your prediction model. Remember, ideally we would have a meteor expert to guide this step, but that doesn't mean we can take a best guess at what data would help use accurately identify the best date to see a meteor shower. Before gathering data, it's important to first identify the kind of data that we want to find. We know a few things:
1. Meteor showers are typically from the meteoroids melted off of comets. 
2. Comets have a specific orbit around hte Sun that is observable and predicatable
3. A bright moon will make it harder to see a meteor shower
4. The orbit and spin of the Earth will effect where on Earth a meteor shower can be seen 

We also know that Chang'e from the Over the Moon film can cause meteor showers, but we will add in that data in a later unit.

## Selecting Comets to Focus On

While meteoroids can come from comets, asteroids, moons, and planters, this module is going to focus on those that come from popular comets. There are four comets that we often use to predict when and where meteor showers are visible:

### Comet Thatcher

[Comet Thatcher](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/comets/c-1861-g1-thatcher/in-depth/) was first discovered in 1861. It takes 415.5 years for comet Thatcher to orbit the Sun and the debris from this comet creates the [Lyrids meteor shower](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/lyrids/in-depth/) each April. The first recorded sighting of the Lyrid meteor shower goes back to 687 BC. The Lyrids meteor shower appears to come from the constellation Lyra. It is not the comet or meteor originates from this constellation, just that if you were to look into the sky you are likely to find the meteor shower coming from the same direction where you would see the constellation Lyra. 

### Comet Halley

[Comet Halley](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/comets/1p-halley/in-depth/) was first discovered in 1531, but it wasn't realized until 1705 that it was one comet during the 1531, 1607, and 1682 sightings. It takes 76 years for comet Halley to orbit the Sun and the debird from this comet creates the [Eta Aquarids meteor shower](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/eta-aquarids/in-depth/) each May and the [Orionids meteor shower](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/orionids/in-depth/) each October. The Eta Aquarids meteor shower appears to come from the constellation Aquarius and the Orionids meteor shower appears to come from the constellation Orion.

### Comet Swift-Tuttle

[Comet Swift-Tuttle](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/comets/109p-swift-tuttle/in-depth/) was first discovered in 1862. It takes 133 years to orbit the Sun and the debris from this comet creates the [Perseids meteor shower](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/perseids/in-depth/) each August. It wasn't until 1865 that it was realized that this meteor shower originated from this comet. The Perseids meteor shower appears to come from the constellation Perseus.

### Comet Tempel-Tuttle

[Comet Tempel-Tuttle](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/comets/55p-tempel-tuttle/in-depth/) was discovered *twice*, independently in 1865 and 1866. It takes 33 years to orbit the Sun and the debris from thsi comet creates the Leonids meteor shower each Novemver. Every 33 years, the [Leonids meteor shower](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/leonids/in-depth/) becomes a meteor storm. A meteor storm is when there are at least 1,000 meteors per hour! The Leonids meteor shower appears to come from the constellation Leo.

## Moon Phases

As [the Moon](https://solarsystem.nasa.gov/moons/earths-moon/overview/) orbits Earth, and Earth orbits the Sun, different amounts of sunlight are reflected off the Moon and visible from Earth. Each month, the Moon cycles through different phases, which are basically the names we apply to how much sunlight we can see on Earth reflected off what parts of the Moon. The eight phases of the moon are:
- new moon - Around the 15th of the month
- waxing
- crescent
- first quarter - Around the 23rd of the month
- waxing gibbous
- full moon - Around the 1st of the month
- waning gibbous
- third quarter  - Around the 10th of the month
- waning crescent
New moon, first quarter, full moon, and third quarter are the phases that are tracked more often. The phases cycle every 29 days, so the days can differ depending on how many days in the month. 

## Data Files

We have started to gather some data for the example in this module, however we encourage you to find additional data to explore the predicitions of meteor showers. This is what we have gathered for you:
1. [moonphases.csv]() - This file contains every day of 2020 and has the moon phase for each date. There is some missing data that will be filled in during the next unit. ([Data acquired from timeanddate.com](https://www.timeanddate.com/moon/phases/))
2. [meteorshowers.csv]() - This file contains each of the five meteor showers that we described above, their preferred viewing month, the months when they are visible, and the preferred hemisphere for viewing. ([Data acquired from NASA](https://solarsystem.nasa.gov/asteroids-comets-and-meteors/meteors-and-meteorites/in-depth/))
3. [constellations.csv]() - This file contains the four constellations that are radiants for the five meteor showers, the latitudes for which they are visible, and the month with the best viewing. ([Data qcquired from Wikipedia](https://en.wikipedia.org/wiki/IAU_designated_constellations))
4. [cities.csv]() - This file contains a list of country capitals with their associated latitude. ([Data acquired from Wikipedia](https://en.wikipedia.org/wiki/List_of_national_capitals_by_latitude)) 

Make sure you download these files and save them in your over-the-moon/meteor-showers/data folder like this:
![Showing all four csv data files in the data folder within Visual Studio Code](../media/data_downloaded.png)

## Other Data to Consider

While this module will focus on these four data files, you could also gather other types of data that might impact the likelihood of viewing a meteor shower, including:
- weather
- other comets or known meteors
- city light pollution