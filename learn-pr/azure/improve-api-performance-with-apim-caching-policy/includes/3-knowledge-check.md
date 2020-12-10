You are planning API Management policies for your board games company. You have three APIs:

- **The Board Pricing API**. You manufacture boards of various sizes for partner companies to use with their games. Those partners can use this API to request a price estimate for manufacturing boards of different sizes.
- **The Stock Management API**. Your staff uses a mobile app that calls this API to determine the stock level of your company's games.
- **The Sales API**. The website uses this API to place orders from customers for your company's games.

You have added the Stock Management API and the Sales API to an API Management product named **Sales**.

For the Board Pricing API, you want to make sure that all responses are sent in XML, even though developers have written some operations to generate JSON text. The mobile app expects responses in XML, and the website expects responses in JSON.
