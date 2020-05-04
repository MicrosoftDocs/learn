In this section and the next (3.2), we will use national statistics gathered by the United Nations (UN) from 2009-2011 (accessed from the United Nations Statistics Division's [Social indicators page](https://unstats.un.org/unsd/demographic/products/socind/?azure-portal=true) on April 23, 2012). The data includes national health and welfare statistics for 199 countries and territories; these locations are mostly UN members, but the list also includes other areas that are not independent countries (such as Hong Kong).

The dataset includes 199 observations with the following features:

- **region:** Region of the world
- **group:** A factor (or categorical variable) with the following levels:

  - **oecd:** Countries that were members of the [Organisation for Economic Co-operation and Development](https://render.githubusercontent.com/view/www.oecd.org?azure-portal=true) (OECD) as of May 25, 2012
  - **africa:** Countries on the continent of Africa (note: no OECD countries are located in Africa)
  - **other:** For all other countries
- **fertility:** The total number of children born or likely to be born to a woman in her life time if she were subject to the prevailing rate of age-specific fertility in the population
- *ppgdp:** Per-capita gross domestic product (GDP) in 2012 US dollars
- **lifeExpF:** Female life expectancy in years
- **pctUrban:** Percent of the population urbanized

We will need to load several modules for this section to handle the ML and visualizations.

```python
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
```

```python
import matplotlib.pyplot as plt
%matplotlib inline
```

We'll then load the data.

```python
df = pd.read_csv('Data/UN11.csv')
df.head()
```

```python
df['pctUrban'].min()
```

> [!NOTE]
> The path name for `read_csv()` is case sensitive.
