In this module, we connected the health bot to SQL Server in Azure. We used the data connection scenario step to seamlessly connect to the database. 

Initially, we used the data-connect block to insert data into the database by using the POST method. We used the next block to retrieve the data from the database by using the GET method. Although other HTTP methods are available on the health bot's data-connect block, we used a normal SQL database, which we provisioned in Azure. 

The connection strings played a major role to connect the database and the logic apps. The logic app helped us create our own customized API.
