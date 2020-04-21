> [!Note]
> **Sarah: Conversion feedback**
> 
> - I converted the bibliographic citation to a footnote reference. I added a link for the PDF.
>

> [!Note]
> **Sarah: Action items**
> 
> - Need output cell content. Search on TBD.
>

Let's look at a meteorological dataset collected by Cortez and Morais for 2007.<sup>[1][^1]</sup> They studied the burned area of forest fires in the northeast region of Portugal.

The dataset contains the following features:

- **X**: x-axis spatial coordinate within the Montesinho park map: 1 to 9
- **Y**: y-axis spatial coordinate within the Montesinho park map: 2 to 9
- **month**: Month of the year: "1" to "12" jan-dec
- **day**: Day of the week: "1" to "7" sun-sat
- **FFMC**: FFMC index from the FWI system: 18.7 to 96.20
- **DMC**: DMC index from the FWI system: 1.1 to 291.3
- **DC**: DC index from the FWI system: 7.9 to 860.6
- **ISI**: ISI index from the FWI system: 0.0 to 56.10
- **temp**: Temperature in Celsius degrees: 2.2 to 33.30
- **RH**: Relative humidity in %: 15.0 to 100
- **wind**: Wind speed in km/h: 0.40 to 9.40
- **rain**: Outside rain in mm/m2 : 0.0 to 6.4
- **area**: The burned area of the forest (in ha): 0.00 to 1090.84

Let's load the dataset and visualize the area that was burned in relation to the temperature in that region.

```Python
import pandas as pd
df = pd.DataFrame(pd.read_csv('../Data/forestfires.csv'))
%matplotlib inline
from ggplot import *
ggplot(aes(x='temp', y='area'), data=df) +  geom_line() + geom_point()
```

Here's the output:

```Output
TBD
```

Intuitively, the hotter the weather, the more hectares burned in forest fires.

***
### References

1. _Cortez, P., and Morais, A. (2007). [A Data Mining Approach to Predict Forest Fires using Meteorological Data - PDF](https://www.researchgate.net/publication/238767143_A_Data_Mining_Approach_to_Predict_Forest_Fires_using_Meteorological_Data?azure-portal=true). In J. Neves, M. F. Santos and J. Machado Eds., New Trends in Artificial Intelligence, Proceedings of the 13th EPIA 2007 - Portuguese Conference on Artificial Intelligence, December, Guimaraes, Portugal, pp. 512-523, 2007. APPIA, ISBN-13 978-989-95618-0-9._

***

[^1]: <https://www.researchgate.net/publication/238767143_A_Data_Mining_Approach_to_Predict_Forest_Fires_using_Meteorological_Data?azure-portal=true> "Cortez, P., and Morais, A. (2007). *A Data Mining Approach to Predict Forest Fires using Meteorological Data - PDF*. In J. Neves, M. F. Santos and J. Machado Eds., New Trends in Artificial Intelligence, Proceedings of the 13th EPIA 2007 - Portuguese Conference on Artificial Intelligence, December, Guimaraes, Portugal, pp. 512-523, 2007. APPIA, ISBN-13 978-989-95618-0-9."
