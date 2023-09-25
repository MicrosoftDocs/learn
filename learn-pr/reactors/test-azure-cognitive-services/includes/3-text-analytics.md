Another area where cloud-based AI shines is Text Analytics. Like computer vision, identifying and pulling meaning from natural human languages is at the intersection of many specialized disciplines. Using cloud services provides an economical means of tapping a great amount of cognitive horsepower.

To prepare to use the Azure AI services Text Analytics API, the requests library must be imported. You also need the capability to print out JSON formats.

```python
import requests
# pprint is pretty print (formats the JSON)
from pprint import pprint
from IPython.display import HTML
```

Replace `ACCOUNT_KEY` with the API key that was created during the creation of the seven-day free trial account.

```python
subscription_key = 'ACCOUNT_KEY'
assert subscription_key

# If you're using a free trial account, this URL doesn't need to be updated.
# If you're using a paid account, verify that it matches the region where the Text Analytics service was set up.
text_analytics_base_url = "https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/"
```
