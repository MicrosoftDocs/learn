There are many scenarios where anomaly detection is helpful. The introduction of this module discussed evaluation of temperature recordings related to storing medications. Consideration must be given to the storage requirements for the medication such as:

- maximum allowable temperature
- minimum allowable temperature
- duration for temperatures outside the acceptable range

Your monitoring application can be configured with the above criteria and then perform anomaly detection using both streaming and batch detection techniques. Streaming detection is most useful for monitoring critical storage requirements that must be acted on immediately. Sensors will monitor the temperature inside the compartment and send these readings to your application or an event hub on Azure. Anomaly Detector will evaluate the streaming data points and determine if a point is an anomaly.

If you are interested in the temperature settings over a period of time, you can record the readings and write them to a file. When you want to evaluate a period of storage, you can extract the required time series data, package it into a JSON object, and send it to the API for evaluation. You will then have a historical view of the temperature readings over time. Anomalies can be evaluated to determine if the medications have been negatively impacted and help decide a course of action that may result in destroying the medications due to safety issues.

Another scenario where anomaly detection may be useful is in the carbonated beverage industry. Soft drinks are an example where carbon dioxide is added to the product during the bottling or canning process. There is a specific temperature range that the product must be kept at for the carbon dioxide to adhere to the product. 

Bottling systems use a device known as a carbo-cooler to achieve the refrigeration of the product for this process. If the temperature goes too low, the product will freeze in the carbo-cooler. Too warm, and the carbon dioxide will not adhere properly.  Either situation results in a product batch that cannot be sold to customers. 

This carbonated beverage scenario is an example of where you could use streaming detection for real-time decision making. It could be tied into an application that controls the bottling line equipment. You may use it to feed displays that depict the system temperatures for the quality control station. A service technician may also use it to identify equipment failure potential and servicing needs.
