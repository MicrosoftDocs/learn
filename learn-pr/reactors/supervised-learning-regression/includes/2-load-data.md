In this section and the next (3.2), we'll use national statistics gathered by the United Nations (UN) from 2009-2011. This information came from the United Nations Statistics Division's [Social indicators page](https://unstats.un.org/unsd/demographic/products/socind/?azure-portal=true) on April 23, 2012. The data includes national health and welfare statistics for 199 countries and territories. These locations are mostly UN members, but the list also includes areas that are not independent countries (such as Hong Kong).

The dataset includes 199 observations with the following features:

- **region:** Region of the world.
- **group:** A factor (or categorical variable) with the following levels:

  - **oecd:** Countries that were members of the [Organisation for Economic Co-operation and Development](http://www.oecd.org) (OECD) as of May 25, 2012.
  - **africa:** Countries on the continent of Africa. (Note that no OECD countries are located in Africa.)
  - **other:** All other countries.
- **fertility:** The total number of children born or likely to be born to a woman in her lifetime if she were subject to the prevailing rate of age-specific fertility in the population.
- **ppgdp:** Per-capita gross domestic product (GDP) in 2012 US dollars.
- **lifeExpF:** Female life expectancy in years.
- **pctUrban:** Percentage of the population that's urbanized.

We'll need to load several modules for this section to handle the machine learning and visualizations.

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

> [!div class="alert is-tip"]
> Output
> 
> |  | region | group | fertility | ppgdp | lifeExpF | pctUrban |
> | --- | --- | --- | --- | --- | --- | --- |
> | 0 | Asia | other | 5.968 | 499.0 | 49.49 | 23 |
> | 1 | Europe | other | 1.525 | 3677.2 | 80.40 | 53 |
> | 2 | Africa | africa | 2.142 | 4473.0 | 75.00 | 67 |
> | 3 | Africa | africa | 5.135 | 4321.9 | 53.17 | 59 |
> | 4 | Caribbean | other | 2.000 | 13750.1 | 81.10 | 100 |

```python
df['pctUrban'].min()
```

```Output
11
```

> [!NOTE]
> The path name for `read_csv()` is case sensitive.
