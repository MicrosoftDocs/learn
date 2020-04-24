You will need to clean and prepare the data in order to conduct PCA on it, so pandas will be essential. You will also need NumPy, a bit of scikit-learn, and pyplot.

```python
import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
%matplotlib inline
```

The dataset we’ll use here is the same one drawn from the [U.S. Department of Agriculture National Nutrient Database for Standard Reference](https://www.ars.usda.gov/northeast-area/beltsville-md-bhnrc/beltsville-human-nutrition-research-center/nutrient-data-laboratory/docs/usda-national-nutrient-database-for-standard-reference/?azure-portal=true) that you prepared in Section 1.1. Remember to set the encoding to latin_1 (for those darn µg).

```python
df = pd.read_csv('Data/USDA-nndb-combined.csv', encoding='latin_1')
```

TBD output


We can check the number of columns and rows using the `info()` method for the DataFrame.

```python
df.info()
```
TBD output

### Try it yourself

Can you think of a more concise way to check the number of rows and columns in a DataFrame?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Use one of the attributes of the DataFrame.

TBD output

---

</details>
