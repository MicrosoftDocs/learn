> [!Note]
> **Sarah: Action items**
> 
> - Need output cell content. Search on TBD.
>

Another area where cloud-based AI shines is text analytics. Like computer vision, identifying and pulling meaning from natural human languages is really the intersection of a lot of specialized disciplines, so using cloud services for it provides an economical means of tapping a lot of cognitive horsepower.

To prepare to use the Cognitive Services Text Analytics API, the requests library must be imported, along with the ability to print out JSON formats.

```python
import requests
# pprint is pretty print (formats the JSON)
from pprint import pprint
from IPython.display import HTML
```

The output is:

```Output
TBD
```

Replace `ACCOUNT_KEY` with the API key that was created during the creation of the seven-day free trial account.

```python
subscription_key = 'ACCOUNT_KEY'
assert subscription_key

# If you're using a Free Trial account, this URL does not need to be updated.
# If you're using a paid account, verify that it matches the region where the Text Analytics Service was set up.
text_analytics_base_url = "https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/"
```

Here's the output:

```Output
TBD
```
