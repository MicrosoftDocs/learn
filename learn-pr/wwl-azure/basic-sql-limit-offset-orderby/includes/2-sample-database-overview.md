The sales database is designed to simulate a typical sales environment for a company that sells various products to customers. It's structured to store information about customers, products, suppliers, orders, employees, and shipping. This database allows you to:

* Track customer orders and purchase history
* Manage product inventory and pricing
* Analyze sales data and generate reports
* Track which employee handled which order
* Track which shipper was used for each order

## Key tables in this Database:

* customers: Stores customer details like names, addresses, and contact information
* products: Contains product information, including names, prices, and categories
* categories: Lists the categories to which the products belong
* suppliers: Holds information about the companies supplying the products
* orders: Records customer order details, including dates and customer IDs
* order_details: Provides line-item details for each order, linking products and quantities
* employees: Stores employee information
* shippers: Contains details about shipping companies

The tables are interconnected using foreign keys, allowing for comprehensive data analysis and reporting on sales activities.

Foreign keys are a concept in relational databases, used to establish and enforce a link between two tables. A foreign key is one table uniquely identifies a row in another table, creating relationships that enable data integrity and efficient cross-table queries.

## Sample Database Creation Script

<details>
    <summary>Click to expand</summary>

```sql
CREATE SCHEMA Sales;

CREATE TABLE Sales.Categories
(      
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(25),
    Description VARCHAR(255)
);

CREATE TABLE Sales.Customers
(      
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(50),
    ContactName VARCHAR(50),
    Address VARCHAR(50),
    City VARCHAR(20),
    PostalCode VARCHAR(10),
    Country VARCHAR(15)
);

CREATE TABLE Sales.Employees
(
    EmployeeID SERIAL PRIMARY KEY,
    LastName VARCHAR(15),
    FirstName VARCHAR(15),
    BirthDate TIMESTAMP,
    Photo VARCHAR(25),
    Notes VARCHAR(1024)
);

CREATE TABLE Sales.Shippers(
    ShipperID SERIAL PRIMARY KEY,
    ShipperName VARCHAR(25),
    Phone VARCHAR(15)
);

CREATE TABLE Sales.Suppliers(
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(50),
    ContactName VARCHAR(50),
    Address VARCHAR(50),
    City VARCHAR(20),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(15)
);

CREATE TABLE Sales.Products(
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(50),
    SupplierID INTEGER,
    CategoryID INTEGER,
    Unit VARCHAR(25),
    Price NUMERIC,
	FOREIGN KEY (CategoryID) REFERENCES Sales.Categories (CategoryID),
	FOREIGN KEY (SupplierID) REFERENCES Sales.Suppliers (SupplierID)
);

CREATE TABLE Sales.Orders(
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER,
    EmployeeID INTEGER,
    OrderDate TIMESTAMP,
    ShipperID INTEGER,
    FOREIGN KEY (EmployeeID) REFERENCES Sales.Employees (EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Sales.Customers (CustomerID),
    FOREIGN KEY (ShipperID) REFERENCES Sales.Shippers (ShipperID)
);

CREATE TABLE Sales.OrderDetails(
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER,
	FOREIGN KEY (OrderID) REFERENCES Sales.Orders (OrderID),
	FOREIGN KEY (ProductID) REFERENCES Sales.Products (ProductID)
);

INSERT INTO Sales.Categories VALUES(1,'Beverages','Soft drinks, coffees, teas, beers, and ales');
INSERT INTO Sales.Categories VALUES(2,'Condiments','Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO Sales.Categories VALUES(3,'Confections','Desserts, candies, and sweet breads');
INSERT INTO Sales.Categories VALUES(4,'Dairy Sales.Products','Cheeses');
INSERT INTO Sales.Categories VALUES(5,'Grains/Cereals','Breads, crackers, pasta, and cereal');
INSERT INTO Sales.Categories VALUES(6,'Meat/Poultry','Prepared meats');
INSERT INTO Sales.Categories VALUES(7,'Produce','Dried fruit and bean curd');
INSERT INTO Sales.Categories VALUES(8,'Seafood','Seaweed and fish');

INSERT INTO Sales.Customers VALUES(1,'Alfreds Futterkiste','Maria Anders','Obere Str. 57','Berlin','12209','Germany');
INSERT INTO Sales.Customers VALUES(2,'Ana Trujillo Emparedados y helados','Ana Trujillo','Avda. de la Constitución 2222','México D.F.','5021','Mexico');
INSERT INTO Sales.Customers VALUES(3,'Antonio Moreno Taquería','Antonio Moreno','Mataderos 2312','México D.F.','5023','Mexico');
INSERT INTO Sales.Customers VALUES(4,'Around the Horn','Thomas Hardy','120 Hanover Sq.','London','WA1 1DP','UK');
INSERT INTO Sales.Customers VALUES(5,'Berglunds snabbköp','Christina Berglund','Berguvsvägen 8','Luleå','S-958 22','Sweden');
INSERT INTO Sales.Customers VALUES(6,'Blauer See Delikatessen','Hanna Moos','Forsterstr. 57','Mannheim','68306','Germany');
INSERT INTO Sales.Customers VALUES(7,'Blondel père et fils','Frédérique Citeaux','24, place Kléber','Strasbourg','67000','France');
INSERT INTO Sales.Customers VALUES(8,'Bólido Comidas preparadas','Martín Sommer','C/ Araquil, 67','Madrid','28023','Spain');
INSERT INTO Sales.Customers VALUES(9,'Bon app''''','Laurence Lebihans','12, rue des Bouchers','Marseille','13008','France');
INSERT INTO Sales.Customers VALUES(10,'Bottom-Dollar Marketse','Elizabeth Lincoln','23 Tsawassen Blvd.','Tsawassen','T2F 8M4','Canada');
INSERT INTO Sales.Customers VALUES(11,'B''''s Beverages','Victoria Ashworth','Fauntleroy Circus','London','EC2 5NT','UK');
INSERT INTO Sales.Customers VALUES(12,'Cactus Comidas para llevar','Patricio Simpson','Cerrito 333','Buenos Aires','1010','Argentina');
INSERT INTO Sales.Customers VALUES(13,'Centro comercial Moctezuma','Francisco Chang','Sierras de Granada 9993','México D.F.','5022','Mexico');
INSERT INTO Sales.Customers VALUES(14,'Chop-suey Chinese','Yang Wang','Hauptstr. 29','Bern','3012','Switzerland');
INSERT INTO Sales.Customers VALUES(15,'Comércio Mineiro','Pedro Afonso','Av. dos Lusíadas, 23','São Paulo','05432-043','Brazil');
INSERT INTO Sales.Customers VALUES(16,'Consolidated Holdings','Elizabeth Brown','Berkeley Gardens 12 Brewery','London','WX1 6LT','UK');
INSERT INTO Sales.Customers VALUES(17,'Drachenblut Delikatessend','Sven Ottlieb','Walserweg 21','Aachen','52066','Germany');
INSERT INTO Sales.Customers VALUES(18,'Du monde entier','Janine Labrune','67, rue des Cinquante Otages','Nantes','44000','France');
INSERT INTO Sales.Customers VALUES(19,'Eastern Connection','Ann Devon','35 King George','London','WX3 6FW','UK');
INSERT INTO Sales.Customers VALUES(20,'Ernst Handel','Roland Mendel','Kirchgasse 6','Graz','8010','Austria');
INSERT INTO Sales.Customers VALUES(21,'Familia Arquibaldo','Aria Cruz','Rua Orós, 92','São Paulo','05442-030','Brazil');
INSERT INTO Sales.Customers VALUES(22,'FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','C/ Moralzarzal, 86','Madrid','28034','Spain');
INSERT INTO Sales.Customers VALUES(23,'Folies gourmandes','Martine Rancé','184, chaussée de Tournai','Lille','59000','France');
INSERT INTO Sales.Customers VALUES(24,'Folk och fä HB','Maria Larsson','Åkergatan 24','Bräcke','S-844 67','Sweden');
INSERT INTO Sales.Customers VALUES(25,'Frankenversand','Peter Franken','Berliner Platz 43','München','80805','Germany');
INSERT INTO Sales.Customers VALUES(26,'France restauration','Carine Schmitt','54, rue Royale','Nantes','44000','France');
INSERT INTO Sales.Customers VALUES(27,'Franchi S.p.A.','Paolo Accorti','Via Monte Bianco 34','Torino','10100','Italy');
INSERT INTO Sales.Customers VALUES(28,'Furia Bacalhau e Frutos do Mar','Lino Rodriguez','Jardim das rosas n. 32','Lisboa','1675','Portugal');
INSERT INTO Sales.Customers VALUES(29,'Galería del gastrónomo','Eduardo Saavedra','Rambla de Cataluña, 23','Barcelona','8022','Spain');
INSERT INTO Sales.Customers VALUES(30,'Godos Cocina Típica','José Pedro Freyre','C/ Romero, 33','Sevilla','41101','Spain');
INSERT INTO Sales.Customers VALUES(31,'Gourmet Lanchonetes','André Fonseca','Av. Brasil, 442','Campinas','04876-786','Brazil');
INSERT INTO Sales.Customers VALUES(32,'Great Lakes Food Market','Howard Snyder','2732 Baker Blvd.','Eugene','97403','USA');
INSERT INTO Sales.Customers VALUES(33,'GROSELLA-Restaurante','Manuel Pereira','5ª Ave. Los Palos Grandes','Caracas','1081','Venezuela');
INSERT INTO Sales.Customers VALUES(34,'Hanari Carnes','Mario Pontes','Rua do Paço, 67','Rio de Janeiro','05454-876','Brazil');
INSERT INTO Sales.Customers VALUES(35,'HILARIÓN-Abastos','Carlos Hernández','Carrera 22 con Ave. Carlos Soublette #8-35','San Cristóbal','5022','Venezuela');
INSERT INTO Sales.Customers VALUES(36,'Hungry Coyote Import Store','Yoshi Latimer','City Center Plaza 516 Main St.','Elgin','97827','USA');
INSERT INTO Sales.Customers VALUES(37,'Hungry Owl All-Night Grocers','Patricia McKenna','8 Johnstown Road','Cork','','Ireland');
INSERT INTO Sales.Customers VALUES(38,'Island Trading','Helen Bennett','Garden House Crowther Way','Cowes','PO31 7PJ','UK');
INSERT INTO Sales.Customers VALUES(39,'Königlich Essen','Philip Cramer','Maubelstr. 90','Brandenburg','14776','Germany');
INSERT INTO Sales.Customers VALUES(40,'La corne d''''abondance','Daniel Tonini','67, avenue de l''''Europe','Versailles','78000','France');
INSERT INTO Sales.Customers VALUES(41,'La maison d''''Asie','Annette Roulet','1 rue Alsace-Lorraine','Toulouse','31000','France');
INSERT INTO Sales.Customers VALUES(42,'Laughing Bacchus Wine Cellars','Yoshi Tannamuri','1900 Oak St.','Vancouver','V3F 2K1','Canada');
INSERT INTO Sales.Customers VALUES(43,'Lazy K Kountry Store','John Steel','12 Orchestra Terrace','Walla Walla','99362','USA');
INSERT INTO Sales.Customers VALUES(44,'Lehmanns Marktstand','Renate Messner','Magazinweg 7','Frankfurt a.M.','60528','Germany');
INSERT INTO Sales.Customers VALUES(45,'Let''''s Stop N Shop','Jaime Yorres','87 Polk St. Suite 5','San Francisco','94117','USA');
INSERT INTO Sales.Customers VALUES(46,'LILA-Supermercado','Carlos González','Carrera 52 con Ave. Bolívar #65-98 Llano Largo','Barquisimeto','3508','Venezuela');
INSERT INTO Sales.Customers VALUES(47,'LINO-Delicateses','Felipe Izquierdo','Ave. 5 de Mayo Porlamar','I. de Margarita','4980','Venezuela');
INSERT INTO Sales.Customers VALUES(48,'Lonesome Pine Restaurant','Fran Wilson','89 Chiaroscuro Rd.','Portland','97219','USA');
INSERT INTO Sales.Customers VALUES(49,'Magazzini Alimentari Riuniti','Giovanni Rovelli','Via Ludovico il Moro 22','Bergamo','24100','Italy');
INSERT INTO Sales.Customers VALUES(50,'Maison Dewey','Catherine Dewey','Rue Joseph-Bens 532','Bruxelles','B-1180','Belgium');
INSERT INTO Sales.Customers VALUES(51,'Mère Paillarde','Jean Fresnière','43 rue St. Laurent','Montréal','H1J 1C3','Canada');
INSERT INTO Sales.Customers VALUES(52,'Morgenstern Gesundkost','Alexander Feuer','Heerstr. 22','Leipzig','4179','Germany');
INSERT INTO Sales.Customers VALUES(53,'North/South','Simon Crowther','South House 300 Queensbridge','London','SW7 1RZ','UK');
INSERT INTO Sales.Customers VALUES(54,'Océano Atlántico Ltda.','Yvonne Moncada','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires','1010','Argentina');
INSERT INTO Sales.Customers VALUES(55,'Old World Delicatessen','Rene Phillips','2743 Bering St.','Anchorage','99508','USA');
INSERT INTO Sales.Customers VALUES(56,'Ottilies Käseladen','Henriette Pfalzheim','Mehrheimerstr. 369','Köln','50739','Germany');
INSERT INTO Sales.Customers VALUES(57,'Paris spécialités','Marie Bertrand','265, boulevard Charonne','Paris','75012','France');
INSERT INTO Sales.Customers VALUES(58,'Pericles Comidas clásicas','Guillermo Fernández','Calle Dr. Jorge Cash 321','México D.F.','5033','Mexico');
INSERT INTO Sales.Customers VALUES(59,'Piccolo und mehr','Georg Pipps','Geislweg 14','Salzburg','5020','Austria');
INSERT INTO Sales.Customers VALUES(60,'Princesa Isabel Vinhoss','Isabel de Castro','Estrada da saúde n. 58','Lisboa','1756','Portugal');
INSERT INTO Sales.Customers VALUES(61,'Que Delícia','Bernardo Batista','Rua da Panificadora, 12','Rio de Janeiro','02389-673','Brazil');
INSERT INTO Sales.Customers VALUES(62,'Queen Cozinha','Lúcia Carvalho','Alameda dos Canàrios, 891','São Paulo','05487-020','Brazil');
INSERT INTO Sales.Customers VALUES(63,'QUICK-Stop','Horst Kloss','Taucherstraße 10','Cunewalde','1307','Germany');
INSERT INTO Sales.Customers VALUES(64,'Rancho grande','Sergio Gutiérrez','Av. del Libertador 900','Buenos Aires','1010','Argentina');
INSERT INTO Sales.Customers VALUES(65,'Rattlesnake Canyon Grocery','Paula Wilson','2817 Milton Dr.','Albuquerque','87110','USA');
INSERT INTO Sales.Customers VALUES(66,'Reggiani Caseifici','Maurizio Moroni','Strada Provinciale 124','Reggio Emilia','42100','Italy');
INSERT INTO Sales.Customers VALUES(67,'Ricardo Adocicados','Janete Limeira','Av. Copacabana, 267','Rio de Janeiro','02389-890','Brazil');
INSERT INTO Sales.Customers VALUES(68,'Richter Supermarkt','Michael Holz','Grenzacherweg 237','Genève','1203','Switzerland');
INSERT INTO Sales.Customers VALUES(69,'Romero y tomillo','Alejandra Camino','Gran Vía, 1','Madrid','28001','Spain');
INSERT INTO Sales.Customers VALUES(70,'Santé Gourmet','Jonas Bergulfsen','Erling Skakkes gate 78','Stavern','4110','Norway');
INSERT INTO Sales.Customers VALUES(71,'Save-a-lot Markets','Jose Pavarotti','187 Suffolk Ln.','Boise','83720','USA');
INSERT INTO Sales.Customers VALUES(72,'Seven Seas Imports','Hari Kumar','90 Wadhurst Rd.','London','OX15 4NB','UK');
INSERT INTO Sales.Customers VALUES(73,'Simons bistro','Jytte Petersen','Vinbæltet 34','København','1734','Denmark');
INSERT INTO Sales.Customers VALUES(74,'Spécialités du monde','Dominique Perrier','25, rue Lauriston','Paris','75016','France');
INSERT INTO Sales.Customers VALUES(75,'Split Rail Beer & Ale','Art Braunschweiger','P.O. Box 555','Lander','82520','USA');
INSERT INTO Sales.Customers VALUES(76,'Suprêmes délices','Pascale Cartrain','Boulevard Tirou, 255','Charleroi','B-6000','Belgium');
INSERT INTO Sales.Customers VALUES(77,'The Big Cheese','Liz Nixon','89 Jefferson Way Suite 2','Portland','97201','USA');
INSERT INTO Sales.Customers VALUES(78,'The Cracker Box','Liu Wong','55 Grizzly Peak Rd.','Butte','59801','USA');
INSERT INTO Sales.Customers VALUES(79,'Toms Spezialitäten','Karin Josephs','Luisenstr. 48','Münster','44087','Germany');
INSERT INTO Sales.Customers VALUES(80,'Tortuga Restaurante','Miguel Angel Paolino','Avda. Azteca 123','México D.F.','5033','Mexico');
INSERT INTO Sales.Customers VALUES(81,'Tradição Hipermercados','Anabela Domingues','Av. Inês de Castro, 414','São Paulo','05634-030','Brazil');
INSERT INTO Sales.Customers VALUES(82,'Trail''''s Head Gourmet Provisioners','Helvetius Nagy','722 DaVinci Blvd.','Kirkland','98034','USA');
INSERT INTO Sales.Customers VALUES(83,'Vaffeljernet','Palle Ibsen','Smagsløget 45','Århus','8200','Denmark');
INSERT INTO Sales.Customers VALUES(84,'Victuailles en stock','Mary Saveley','2, rue du Commerce','Lyon','69004','France');
INSERT INTO Sales.Customers VALUES(85,'Vins et alcools Chevalier','Paul Henriot','59 rue de l''''Abbaye','Reims','51100','France');
INSERT INTO Sales.Customers VALUES(86,'Die Wandernde Kuh','Rita Müller','Adenauerallee 900','Stuttgart','70563','Germany');
INSERT INTO Sales.Customers VALUES(87,'Wartian Herkku','Pirkko Koskitalo','Torikatu 38','Oulu','90110','Finland');
INSERT INTO Sales.Customers VALUES(88,'Wellington Importadora','Paula Parente','Rua do Mercado, 12','Resende','08737-363','Brazil');
INSERT INTO Sales.Customers VALUES(89,'White Clover Markets','Karl Jablonski','305 - 14th Ave. S. Suite 3B','Seattle','98128','USA');
INSERT INTO Sales.Customers VALUES(90,'Wilman Kala','Matti Karttunen','Keskuskatu 45','Helsinki','21240','Finland');
INSERT INTO Sales.Customers VALUES(91,'Wolski','Zbyszek','ul. Filtrowa 68','Walla','01-012','Poland');

INSERT INTO Sales.Employees VALUES(1,'Davolio','Nancy','1968-12-08','EmpID1.pic','Education includes a BA in psychology from Colorado State University. She also completed (The Art of the Cold Call). Nancy is a member of ''Toastmasters International''.');
INSERT INTO Sales.Employees VALUES(2,'Fuller','Andrew','1952-02-19','EmpID2.pic','Andrew received his BTS commercial and a Ph.D. in international marketing from the University of Dallas. He is fluent in French and Italian and reads German. He joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales. Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.');
INSERT INTO Sales.Employees VALUES(3,'Leverling','Janet','1963-08-30','EmpID3.pic','Janet has a BS degree in chemistry from Boston College). She has also completed a certificate program in food retailing management. Janet was hired as a sales associate and was promoted to sales representative.');
INSERT INTO Sales.Employees VALUES(4,'Peacock','Margaret','1958-09-19','EmpID4.pic','Margaret holds a BA in English literature from Concordia College and an MA from the American Institute of Culinary Arts. She was temporarily assigned to the London office before returning to her permanent post in Seattle.');
INSERT INTO Sales.Employees VALUES(5,'Buchanan','Steven','1955-03-04','EmpID5.pic','Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree. Upon joining the company as a sales representative, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London, where he was promoted to sales manager. Mr. Buchanan has completed the courses ''Successful Telemarketing'' and ''International Sales Management''. He is fluent in French.');
INSERT INTO Sales.Employees VALUES(6,'Suyama','Michael','1963-07-02','EmpID6.pic','Michael is a graduate of Sussex University (MA, economics) and the University of California at Los Angeles (MBA, marketing). He has also taken the courses ''Multi-Cultural Selling'' and ''Time Management for the Sales Professional''. He is fluent in Japanese and can read and write French, Portuguese, and Spanish.');
INSERT INTO Sales.Employees VALUES(7,'King','Robert','1960-05-29','EmpID7.pic','Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan and then joining the company. After completing a course entitled ''Selling in Europe'', he was transferred to the London office.');
INSERT INTO Sales.Employees VALUES(8,'Callahan','Laura','1958-01-09','EmpID8.pic','Laura received a BA in psychology from the University of Washington. She has also completed a course in business French. She reads and writes French.');
INSERT INTO Sales.Employees VALUES(9,'Dodsworth','Anne','1969-07-02','EmpID9.pic','Anne has a BA degree in English from St. Lawrence College. She is fluent in French and German.');
INSERT INTO Sales.Employees VALUES(10,'West','Adam','1928-09-19','EmpID10.pic','An old chum.');

INSERT INTO Sales.Shippers VALUES(1, 'Speedy Express', '(503) 555-9831');
INSERT INTO Sales.Shippers VALUES(2, 'United Package', '(503) 555-3199');
INSERT INTO Sales.Shippers VALUES(3, 'Federal Shipping', '(503) 555-9931');

INSERT INTO Sales.Suppliers VALUES(1,'Exotic Liquid','Charlotte Cooper','49 Gilbert St.','Londona','EC1 4SD','UK','(171) 555-2222');
INSERT INTO Sales.Suppliers VALUES(2,'New Orleans Cajun Delights','Shelley Burke','P.O. Box 78934','New Orleans','70117','USA','(100) 555-4822');
INSERT INTO Sales.Suppliers VALUES(3,'Grandma Kelly''s Homestead','Regina Murphy','707 Oxford Rd.','Ann Arbor','48104','USA','(313) 555-5735');
INSERT INTO Sales.Suppliers VALUES(4,'Tokyo Traders','Yoshi Nagase','9-8 Sekimai Musashino-shi','Tokyo','100','Japan','(03) 3555-5011');
INSERT INTO Sales.Suppliers VALUES(5,'Cooperativa de Quesos ''Las Cabras''','Antonio del Valle Saavedra','Calle del Rosal 4','Oviedo','33007','Spain','(98) 598 76 54');
INSERT INTO Sales.Suppliers VALUES(6,'Mayumi''s','Mayumi Ohno','92 Setsuko Chuo-ku','Osaka','545','Japan','(06) 431-7877');
INSERT INTO Sales.Suppliers VALUES(7,'Pavlova, Ltd.','Ian Devling','74 Rose St. Moonie Ponds','Melbourne','3058','Australia','(03) 444-2343');
INSERT INTO Sales.Suppliers VALUES(8,'Specialty Biscuits, Ltd.','Peter Wilson','29 King''s Way','Manchester','M14 GSD','UK','(161) 555-4448');
INSERT INTO Sales.Suppliers VALUES(9,'PB Knäckebröd AB','Lars Peterson','Kaloadagatan 13','Göteborg','S-345 67','Sweden','031-987 65 43');
INSERT INTO Sales.Suppliers VALUES(10,'Refrescos Americanas LTDA','Carlos Diaz','Av. das Americanas 12.890','São Paulo','5442','Brazil','(11) 555 4640');
INSERT INTO Sales.Suppliers VALUES(11,'Heli Süßwaren GmbH & Co. KG','Petra Winkler','Tiergartenstraße 5','Berlin','10785','Germany','(010) 9984510');
INSERT INTO Sales.Suppliers VALUES(12,'Plutzer Lebensmittelgroßmärkte AG','Martin Bein','Bogenallee 51','Frankfurt','60439','Germany','(069) 992755');
INSERT INTO Sales.Suppliers VALUES(13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Petersen','Frahmredder 112a','Cuxhaven','27478','Germany','(04721) 8713');
INSERT INTO Sales.Suppliers VALUES(14,'Formaggi Fortini s.r.l.','Elio Rossi','Viale Dante, 75','Ravenna','48100','Italy','(0544) 60323');
INSERT INTO Sales.Suppliers VALUES(15,'Norske Meierier','Beate Vileid','Hatlevegen 5','Sandvika','1320','Norway','(0)2-953010');
INSERT INTO Sales.Suppliers VALUES(16,'Bigfoot Breweries','Cheryl Saylor','3400 - 8th Avenue Suite 210','Bend','97101','USA','(503) 555-9931');
INSERT INTO Sales.Suppliers VALUES(17,'Svensk Sjöföda AB','Michael Björn','Brovallavägen 231','Stockholm','S-123 45','Sweden','08-123 45 67');
INSERT INTO Sales.Suppliers VALUES(18,'Aux joyeux ecclésiastiques','Guylène Nodier','203, Rue des Francs-Bourgeois','Paris','75004','France','(1) 03.83.00.68');
INSERT INTO Sales.Suppliers VALUES(19,'New England Seafood Cannery','Robb Merchant','Order Processing Dept. 2100 Paul Revere Blvd.','Boston','2134','USA','(617) 555-3267');
INSERT INTO Sales.Suppliers VALUES(20,'Leka Trading','Chandra Leka','471 Serangoon Loop, Suite #402','Singapore','512','Singapore','555-8787');
INSERT INTO Sales.Suppliers VALUES(21,'Lyngbysild','Niels Petersen','Lyngbysild Fiskebakken 10','Lyngby','2800','Denmark','43844108');
INSERT INTO Sales.Suppliers VALUES(22,'Zaanse Snoepfabriek','Dirk Luchte','Verkoop Rijnweg 22','Zaandam','9999 ZZ','Netherlands','(12345) 1212');
INSERT INTO Sales.Suppliers VALUES(23,'Karkki Oy','Anne Heikkonen','Valtakatu 12','Lappeenranta','53120','Finland','(953) 10956');
INSERT INTO Sales.Suppliers VALUES(24,'G''day, Mate','Wendy Mackenzie','170 Prince Edward Parade Hunter''s Hill','Sydney','2042','Australia','(02) 555-5914');
INSERT INTO Sales.Suppliers VALUES(25,'Ma Maison','Jean-Guy Lauzon','2960 Rue St. Laurent','Montréal','H1J 1C3','Canada','(514) 555-9022');
INSERT INTO Sales.Suppliers VALUES(26,'Pasta Buttini s.r.l.','Giovanni Giudici','Via dei Gelsomini, 153','Salerno','84100','Italy','(089) 6547665');
INSERT INTO Sales.Suppliers VALUES(27,'Escargots Nouveaux','Marie Delamare','22, rue H. Voiron','Montceau','71300','France','85.57.00.07');
INSERT INTO Sales.Suppliers VALUES(28,'Gai pâturage','Eliane Noz','Bat. B 3, rue des Alpes','Annecy','74000','France','38.76.98.06');
INSERT INTO Sales.Suppliers VALUES(29,'Forêts d''érables','Chantal Goulet','148 rue Chasseur','Ste-Hyacinthe','J2S 7S8','Canada','(514) 555-2955');

INSERT INTO Sales.Products VALUES(1,'Chais',1,1,'10 boxes x 20 bags',18);
INSERT INTO Sales.Products VALUES(2,'Chang',1,1,'24 - 12 oz bottles',19);
INSERT INTO Sales.Products VALUES(3,'Aniseed Syrup',1,2,'12 - 550 ml bottles',10);
INSERT INTO Sales.Products VALUES(4,'Chef Anton''s Cajun Seasoning',2,2,'48 - 6 oz jars',22);
INSERT INTO Sales.Products VALUES(5,'Chef Anton''s Gumbo Mix',2,2,'36 boxes',21.35);
INSERT INTO Sales.Products VALUES(6,'Grandma''s Boysenberry Spread',3,2,'12 - 8 oz jars',25);
INSERT INTO Sales.Products VALUES(7,'Uncle Bob''s Organic Dried Pears',3,7,'12 - 1 lb pkgs.',30);
INSERT INTO Sales.Products VALUES(8,'Northwoods Cranberry Sauce',3,2,'12 - 12 oz jars',40);
INSERT INTO Sales.Products VALUES(9,'Mishi Kobe Niku',4,6,'18 - 500 g pkgs.',97);
INSERT INTO Sales.Products VALUES(10,'Ikura',4,8,'12 - 200 ml jars',31);
INSERT INTO Sales.Products VALUES(11,'Queso Cabrales',5,4,'1 kg pkg.',21);
INSERT INTO Sales.Products VALUES(12,'Queso Manchego La Pastora',5,4,'10 - 500 g pkgs.',38);
INSERT INTO Sales.Products VALUES(13,'Konbu',6,8,'2 kg box',6);
INSERT INTO Sales.Products VALUES(14,'Tofu',6,7,'40 - 100 g pkgs.',23.25);
INSERT INTO Sales.Products VALUES(15,'Genen Shouyu',6,2,'24 - 250 ml bottles',15.5);
INSERT INTO Sales.Products VALUES(16,'Pavlova',7,3,'32 - 500 g boxes',17.45);
INSERT INTO Sales.Products VALUES(17,'Alice Mutton',7,6,'20 - 1 kg tins',39);
INSERT INTO Sales.Products VALUES(18,'Carnarvon Tigers',7,8,'16 kg pkg.',62.5);
INSERT INTO Sales.Products VALUES(19,'Teatime Chocolate Biscuits',8,3,'10 boxes x 12 pieces',9.2);
INSERT INTO Sales.Products VALUES(20,'Sir Rodney''s Marmalade',8,3,'30 gift boxes',81);
INSERT INTO Sales.Products VALUES(21,'Sir Rodney''s Scones',8,3,'24 pkgs. x 4 pieces',10);
INSERT INTO Sales.Products VALUES(22,'Gustaf''s Knäckebröd',9,5,'24 - 500 g pkgs.',21);
INSERT INTO Sales.Products VALUES(23,'Tunnbröd',9,5,'12 - 250 g pkgs.',9);
INSERT INTO Sales.Products VALUES(24,'Guaraná Fantástica',10,1,'12 - 355 ml cans',4.5);
INSERT INTO Sales.Products VALUES(25,'NuNuCa Nuß-Nougat-Creme',11,3,'20 - 450 g glasses',14);
INSERT INTO Sales.Products VALUES(26,'Gumbär Gummibärchen',11,3,'100 - 250 g bags',31.23);
INSERT INTO Sales.Products VALUES(27,'Schoggi Schokolade',11,3,'100 - 100 g pieces',43.9);
INSERT INTO Sales.Products VALUES(28,'Rössle Sauerkraut',12,7,'25 - 825 g cans',45.6);
INSERT INTO Sales.Products VALUES(29,'Thüringer Rostbratwurst',12,6,'50 bags x 30 sausgs.',123.79);
INSERT INTO Sales.Products VALUES(30,'Nord-Ost Matjeshering',13,8,'10 - 200 g glasses',25.89);
INSERT INTO Sales.Products VALUES(31,'Gorgonzola Telino',14,4,'12 - 100 g pkgs',12.5);
INSERT INTO Sales.Products VALUES(32,'Mascarpone Fabioli',14,4,'24 - 200 g pkgs.',32);
INSERT INTO Sales.Products VALUES(33,'Geitost',15,4,'500 g',2.5);
INSERT INTO Sales.Products VALUES(34,'Sasquatch Ale',16,1,'24 - 12 oz bottles',14);
INSERT INTO Sales.Products VALUES(35,'Steeleye Stout',16,1,'24 - 12 oz bottles',18);
INSERT INTO Sales.Products VALUES(36,'Inlagd Sill',17,8,'24 - 250 g jars',19);
INSERT INTO Sales.Products VALUES(37,'Gravad lax',17,8,'12 - 500 g pkgs.',26);
INSERT INTO Sales.Products VALUES(38,'Côte de Blaye',18,1,'12 - 75 cl bottles',263.5);
INSERT INTO Sales.Products VALUES(39,'Chartreuse verte',18,1,'750 cc per bottle',18);
INSERT INTO Sales.Products VALUES(40,'Boston Crab Meat',19,8,'24 - 4 oz tins',18.4);
INSERT INTO Sales.Products VALUES(41,'Jack''s New England Clam Chowder',19,8,'12 - 12 oz cans',9.65);
INSERT INTO Sales.Products VALUES(42,'Singaporean Hokkien Fried Mee',20,5,'32 - 1 kg pkgs.',14);
INSERT INTO Sales.Products VALUES(43,'Ipoh Coffee',20,1,'16 - 500 g tins',46);
INSERT INTO Sales.Products VALUES(44,'Gula Malacca',20,2,'20 - 2 kg bags',19.45);
INSERT INTO Sales.Products VALUES(45,'Røgede sild',21,8,'1k pkg.',9.5);
INSERT INTO Sales.Products VALUES(46,'Spegesild',21,8,'4 - 450 g glasses',12);
INSERT INTO Sales.Products VALUES(47,'Zaanse koeken',22,3,'10 - 4 oz boxes',9.5);
INSERT INTO Sales.Products VALUES(48,'Chocolate',22,3,'10 pkgs.',12.75);
INSERT INTO Sales.Products VALUES(49,'Maxilaku',23,3,'24 - 50 g pkgs.',20);
INSERT INTO Sales.Products VALUES(50,'Valkoinen suklaa',23,3,'12 - 100 g bars',16.25);
INSERT INTO Sales.Products VALUES(51,'Manjimup Dried Apples',24,7,'50 - 300 g pkgs.',53);
INSERT INTO Sales.Products VALUES(52,'Filo Mix',24,5,'16 - 2 kg boxes',7);
INSERT INTO Sales.Products VALUES(53,'Perth Pasties',24,6,'48 pieces',32.8);
INSERT INTO Sales.Products VALUES(54,'Tourtière',25,6,'16 pies',7.45);
INSERT INTO Sales.Products VALUES(55,'Pâté chinois',25,6,'24 boxes x 2 pies',24);
INSERT INTO Sales.Products VALUES(56,'Gnocchi di nonna Alice',26,5,'24 - 250 g pkgs.',38);
INSERT INTO Sales.Products VALUES(57,'Ravioli Angelo',26,5,'24 - 250 g pkgs.',19.5);
INSERT INTO Sales.Products VALUES(58,'Escargots de Bourgogne',27,8,'24 pieces',13.25);
INSERT INTO Sales.Products VALUES(59,'Raclette Courdavault',28,4,'5 kg pkg.',55);
INSERT INTO Sales.Products VALUES(60,'Camembert Pierrot',28,4,'15 - 300 g rounds',34);
INSERT INTO Sales.Products VALUES(61,'Sirop d''érable',29,2,'24 - 500 ml bottles',28.5);
INSERT INTO Sales.Products VALUES(62,'Tarte au sucre',29,3,'48 pies',49.3);
INSERT INTO Sales.Products VALUES(63,'Vegie-spread',7,2,'15 - 625 g jars',43.9);
INSERT INTO Sales.Products VALUES(64,'Wimmers gute Semmelknödel',12,5,'20 bags x 4 pieces',33.25);
INSERT INTO Sales.Products VALUES(65,'Louisiana Fiery Hot Pepper Sauce',2,2,'32 - 8 oz bottles',21.05);
INSERT INTO Sales.Products VALUES(66,'Louisiana Hot Spiced Okra',2,2,'24 - 8 oz jars',17);
INSERT INTO Sales.Products VALUES(67,'Laughing Lumberjack Lager',16,1,'24 - 12 oz bottles',14);
INSERT INTO Sales.Products VALUES(68,'Scottish Longbreads',8,3,'10 boxes x 8 pieces',12.5);
INSERT INTO Sales.Products VALUES(69,'Gudbrandsdalsost',15,4,'10 kg pkg.',36);
INSERT INTO Sales.Products VALUES(70,'Outback Lager',7,1,'24 - 355 ml bottles',15);
INSERT INTO Sales.Products VALUES(71,'Fløtemysost',15,4,'10 - 500 g pkgs.',21.5);
INSERT INTO Sales.Products VALUES(72,'Mozzarella di Giovanni',14,4,'24 - 200 g pkgs.',34.8);
INSERT INTO Sales.Products VALUES(73,'Röd Kaviar',17,8,'24 - 150 g jars',15);
INSERT INTO Sales.Products VALUES(74,'Longlife Tofu',4,7,'5 kg pkg.',10);
INSERT INTO Sales.Products VALUES(75,'Rhönbräu Klosterbier',12,1,'24 - 0.5 l bottles',7.75);
INSERT INTO Sales.Products VALUES(76,'Lakkalikööri',23,1,'500 ml',18);
INSERT INTO Sales.Products VALUES(77,'Original Frankfurter grüne Soße',12,2,'12 boxes',13);

INSERT INTO Sales.Orders VALUES(10248,90,5,'1996-07-04',3);
INSERT INTO Sales.Orders VALUES(10249,81,6,'1996-07-05',1);
INSERT INTO Sales.Orders VALUES(10250,34,4,'1996-07-08',2);
INSERT INTO Sales.Orders VALUES(10251,84,3,'1996-07-08',1);
INSERT INTO Sales.Orders VALUES(10252,76,4,'1996-07-09',2);
INSERT INTO Sales.Orders VALUES(10253,34,3,'1996-07-10',2);
INSERT INTO Sales.Orders VALUES(10254,14,5,'1996-07-11',2);
INSERT INTO Sales.Orders VALUES(10255,68,9,'1996-07-12',3);
INSERT INTO Sales.Orders VALUES(10256,88,3,'1996-07-15',2);
INSERT INTO Sales.Orders VALUES(10257,35,4,'1996-07-16',3);
INSERT INTO Sales.Orders VALUES(10258,20,1,'1996-07-17',1);
INSERT INTO Sales.Orders VALUES(10259,13,4,'1996-07-18',3);
INSERT INTO Sales.Orders VALUES(10260,55,4,'1996-07-19',1);
INSERT INTO Sales.Orders VALUES(10261,61,4,'1996-07-19',2);
INSERT INTO Sales.Orders VALUES(10262,65,8,'1996-07-22',3);
INSERT INTO Sales.Orders VALUES(10263,20,9,'1996-07-23',3);
INSERT INTO Sales.Orders VALUES(10264,24,6,'1996-07-24',3);
INSERT INTO Sales.Orders VALUES(10265,7,2,'1996-07-25',1);
INSERT INTO Sales.Orders VALUES(10266,87,3,'1996-07-26',3);
INSERT INTO Sales.Orders VALUES(10267,25,4,'1996-07-29',1);
INSERT INTO Sales.Orders VALUES(10268,33,8,'1996-07-30',3);
INSERT INTO Sales.Orders VALUES(10269,89,5,'1996-07-31',1);
INSERT INTO Sales.Orders VALUES(10270,87,1,'1996-08-01',1);
INSERT INTO Sales.Orders VALUES(10271,75,6,'1996-08-01',2);
INSERT INTO Sales.Orders VALUES(10272,65,6,'1996-08-02',2);
INSERT INTO Sales.Orders VALUES(10273,63,3,'1996-08-05',3);
INSERT INTO Sales.Orders VALUES(10274,85,6,'1996-08-06',1);
INSERT INTO Sales.Orders VALUES(10275,49,1,'1996-08-07',1);
INSERT INTO Sales.Orders VALUES(10276,80,8,'1996-08-08',3);
INSERT INTO Sales.Orders VALUES(10277,52,2,'1996-08-09',3);
INSERT INTO Sales.Orders VALUES(10278,5,8,'1996-08-12',2);
INSERT INTO Sales.Orders VALUES(10279,44,8,'1996-08-13',2);
INSERT INTO Sales.Orders VALUES(10280,5,2,'1996-08-14',1);
INSERT INTO Sales.Orders VALUES(10281,69,4,'1996-08-14',1);
INSERT INTO Sales.Orders VALUES(10282,69,4,'1996-08-15',1);
INSERT INTO Sales.Orders VALUES(10283,46,3,'1996-08-16',3);
INSERT INTO Sales.Orders VALUES(10284,44,4,'1996-08-19',1);
INSERT INTO Sales.Orders VALUES(10285,63,1,'1996-08-20',2);
INSERT INTO Sales.Orders VALUES(10286,63,8,'1996-08-21',3);
INSERT INTO Sales.Orders VALUES(10287,67,8,'1996-08-22',3);
INSERT INTO Sales.Orders VALUES(10288,66,4,'1996-08-23',1);
INSERT INTO Sales.Orders VALUES(10289,11,7,'1996-08-26',3);
INSERT INTO Sales.Orders VALUES(10290,15,8,'1996-08-27',1);
INSERT INTO Sales.Orders VALUES(10291,61,6,'1996-08-27',2);
INSERT INTO Sales.Orders VALUES(10292,81,1,'1996-08-28',2);
INSERT INTO Sales.Orders VALUES(10293,80,1,'1996-08-29',3);
INSERT INTO Sales.Orders VALUES(10294,65,4,'1996-08-30',2);
INSERT INTO Sales.Orders VALUES(10295,85,2,'1996-09-02',2);
INSERT INTO Sales.Orders VALUES(10296,46,6,'1996-09-03',1);
INSERT INTO Sales.Orders VALUES(10297,7,5,'1996-09-04',2);
INSERT INTO Sales.Orders VALUES(10298,37,6,'1996-09-05',2);
INSERT INTO Sales.Orders VALUES(10299,67,4,'1996-09-06',2);
INSERT INTO Sales.Orders VALUES(10300,49,2,'1996-09-09',2);
INSERT INTO Sales.Orders VALUES(10301,86,8,'1996-09-09',2);
INSERT INTO Sales.Orders VALUES(10302,76,4,'1996-09-10',2);
INSERT INTO Sales.Orders VALUES(10303,30,7,'1996-09-11',2);
INSERT INTO Sales.Orders VALUES(10304,80,1,'1996-09-12',2);
INSERT INTO Sales.Orders VALUES(10305,55,8,'1996-09-13',3);
INSERT INTO Sales.Orders VALUES(10306,69,1,'1996-09-16',3);
INSERT INTO Sales.Orders VALUES(10307,48,2,'1996-09-17',2);
INSERT INTO Sales.Orders VALUES(10308,2,7,'1996-09-18',3);
INSERT INTO Sales.Orders VALUES(10309,37,3,'1996-09-19',1);
INSERT INTO Sales.Orders VALUES(10310,77,8,'1996-09-20',2);
INSERT INTO Sales.Orders VALUES(10311,18,1,'1996-09-20',3);
INSERT INTO Sales.Orders VALUES(10312,86,2,'1996-09-23',2);
INSERT INTO Sales.Orders VALUES(10313,63,2,'1996-09-24',2);
INSERT INTO Sales.Orders VALUES(10314,65,1,'1996-09-25',2);
INSERT INTO Sales.Orders VALUES(10315,38,4,'1996-09-26',2);
INSERT INTO Sales.Orders VALUES(10316,65,1,'1996-09-27',3);
INSERT INTO Sales.Orders VALUES(10317,48,6,'1996-09-30',1);
INSERT INTO Sales.Orders VALUES(10318,38,8,'1996-10-01',2);
INSERT INTO Sales.Orders VALUES(10319,80,7,'1996-10-02',3);
INSERT INTO Sales.Orders VALUES(10320,87,5,'1996-10-03',3);
INSERT INTO Sales.Orders VALUES(10321,38,3,'1996-10-03',2);
INSERT INTO Sales.Orders VALUES(10322,58,7,'1996-10-04',3);
INSERT INTO Sales.Orders VALUES(10323,39,4,'1996-10-07',1);
INSERT INTO Sales.Orders VALUES(10324,71,9,'1996-10-08',1);
INSERT INTO Sales.Orders VALUES(10325,39,1,'1996-10-09',3);
INSERT INTO Sales.Orders VALUES(10326,8,4,'1996-10-10',2);
INSERT INTO Sales.Orders VALUES(10327,24,2,'1996-10-11',1);
INSERT INTO Sales.Orders VALUES(10328,28,4,'1996-10-14',3);
INSERT INTO Sales.Orders VALUES(10329,75,4,'1996-10-15',2);
INSERT INTO Sales.Orders VALUES(10330,46,3,'1996-10-16',1);
INSERT INTO Sales.Orders VALUES(10331,9,9,'1996-10-16',1);
INSERT INTO Sales.Orders VALUES(10332,51,3,'1996-10-17',2);
INSERT INTO Sales.Orders VALUES(10333,87,5,'1996-10-18',3);
INSERT INTO Sales.Orders VALUES(10334,84,8,'1996-10-21',2);
INSERT INTO Sales.Orders VALUES(10335,37,7,'1996-10-22',2);
INSERT INTO Sales.Orders VALUES(10336,60,7,'1996-10-23',2);
INSERT INTO Sales.Orders VALUES(10337,25,4,'1996-10-24',3);
INSERT INTO Sales.Orders VALUES(10338,55,4,'1996-10-25',3);
INSERT INTO Sales.Orders VALUES(10339,51,2,'1996-10-28',2);
INSERT INTO Sales.Orders VALUES(10340,9,1,'1996-10-29',3);
INSERT INTO Sales.Orders VALUES(10341,73,7,'1996-10-29',3);
INSERT INTO Sales.Orders VALUES(10342,25,4,'1996-10-30',2);
INSERT INTO Sales.Orders VALUES(10343,44,4,'1996-10-31',1);
INSERT INTO Sales.Orders VALUES(10344,89,4,'1996-11-01',2);
INSERT INTO Sales.Orders VALUES(10345,63,2,'1996-11-04',2);
INSERT INTO Sales.Orders VALUES(10346,65,3,'1996-11-05',3);
INSERT INTO Sales.Orders VALUES(10347,21,4,'1996-11-06',3);
INSERT INTO Sales.Orders VALUES(10348,86,4,'1996-11-07',2);
INSERT INTO Sales.Orders VALUES(10349,75,7,'1996-11-08',1);
INSERT INTO Sales.Orders VALUES(10350,41,6,'1996-11-11',2);
INSERT INTO Sales.Orders VALUES(10351,20,1,'1996-11-11',1);
INSERT INTO Sales.Orders VALUES(10352,28,3,'1996-11-12',3);
INSERT INTO Sales.Orders VALUES(10353,59,7,'1996-11-13',3);
INSERT INTO Sales.Orders VALUES(10354,58,8,'1996-11-14',3);
INSERT INTO Sales.Orders VALUES(10355,4,6,'1996-11-15',1);
INSERT INTO Sales.Orders VALUES(10356,86,6,'1996-11-18',2);
INSERT INTO Sales.Orders VALUES(10357,46,1,'1996-11-19',3);
INSERT INTO Sales.Orders VALUES(10358,41,5,'1996-11-20',1);
INSERT INTO Sales.Orders VALUES(10359,72,5,'1996-11-21',3);
INSERT INTO Sales.Orders VALUES(10360,7,4,'1996-11-22',3);
INSERT INTO Sales.Orders VALUES(10361,63,1,'1996-11-22',2);
INSERT INTO Sales.Orders VALUES(10362,9,3,'1996-11-25',1);
INSERT INTO Sales.Orders VALUES(10363,17,4,'1996-11-26',3);
INSERT INTO Sales.Orders VALUES(10364,19,1,'1996-11-26',1);
INSERT INTO Sales.Orders VALUES(10365,3,3,'1996-11-27',2);
INSERT INTO Sales.Orders VALUES(10366,29,8,'1996-11-28',2);
INSERT INTO Sales.Orders VALUES(10367,83,7,'1996-11-28',3);
INSERT INTO Sales.Orders VALUES(10368,20,2,'1996-11-29',2);
INSERT INTO Sales.Orders VALUES(10369,75,8,'1996-12-02',2);
INSERT INTO Sales.Orders VALUES(10370,14,6,'1996-12-03',2);
INSERT INTO Sales.Orders VALUES(10371,41,1,'1996-12-03',1);
INSERT INTO Sales.Orders VALUES(10372,62,5,'1996-12-04',2);
INSERT INTO Sales.Orders VALUES(10373,37,4,'1996-12-05',3);
INSERT INTO Sales.Orders VALUES(10374,91,1,'1996-12-05',3);
INSERT INTO Sales.Orders VALUES(10375,36,3,'1996-12-06',2);
INSERT INTO Sales.Orders VALUES(10376,51,1,'1996-12-09',2);
INSERT INTO Sales.Orders VALUES(10377,72,1,'1996-12-09',3);
INSERT INTO Sales.Orders VALUES(10378,24,5,'1996-12-10',3);
INSERT INTO Sales.Orders VALUES(10379,61,2,'1996-12-11',1);
INSERT INTO Sales.Orders VALUES(10380,37,8,'1996-12-12',3);
INSERT INTO Sales.Orders VALUES(10381,46,3,'1996-12-12',3);
INSERT INTO Sales.Orders VALUES(10382,20,4,'1996-12-13',1);
INSERT INTO Sales.Orders VALUES(10383,4,8,'1996-12-16',3);
INSERT INTO Sales.Orders VALUES(10384,5,3,'1996-12-16',3);
INSERT INTO Sales.Orders VALUES(10385,75,1,'1996-12-17',2);
INSERT INTO Sales.Orders VALUES(10386,21,9,'1996-12-18',3);
INSERT INTO Sales.Orders VALUES(10387,70,1,'1996-12-18',2);
INSERT INTO Sales.Orders VALUES(10388,72,2,'1996-12-19',1);
INSERT INTO Sales.Orders VALUES(10389,10,4,'1996-12-20',2);
INSERT INTO Sales.Orders VALUES(10390,20,6,'1996-12-23',1);
INSERT INTO Sales.Orders VALUES(10391,17,3,'1996-12-23',3);
INSERT INTO Sales.Orders VALUES(10392,59,2,'1996-12-24',3);
INSERT INTO Sales.Orders VALUES(10393,71,1,'1996-12-25',3);
INSERT INTO Sales.Orders VALUES(10394,36,1,'1996-12-25',3);
INSERT INTO Sales.Orders VALUES(10395,35,6,'1996-12-26',1);
INSERT INTO Sales.Orders VALUES(10396,25,1,'1996-12-27',3);
INSERT INTO Sales.Orders VALUES(10397,60,5,'1996-12-27',1);
INSERT INTO Sales.Orders VALUES(10398,71,2,'1996-12-30',3);
INSERT INTO Sales.Orders VALUES(10399,83,8,'1996-12-31',3);
INSERT INTO Sales.Orders VALUES(10400,19,1,'1997-01-01',3);
INSERT INTO Sales.Orders VALUES(10401,65,1,'1997-01-01',1);
INSERT INTO Sales.Orders VALUES(10402,20,8,'1997-01-02',2);
INSERT INTO Sales.Orders VALUES(10403,20,4,'1997-01-03',3);
INSERT INTO Sales.Orders VALUES(10404,49,2,'1997-01-03',1);
INSERT INTO Sales.Orders VALUES(10405,47,1,'1997-01-06',1);
INSERT INTO Sales.Orders VALUES(10406,62,7,'1997-01-07',1);
INSERT INTO Sales.Orders VALUES(10407,56,2,'1997-01-07',2);
INSERT INTO Sales.Orders VALUES(10408,23,8,'1997-01-08',1);
INSERT INTO Sales.Orders VALUES(10409,54,3,'1997-01-09',1);
INSERT INTO Sales.Orders VALUES(10410,10,3,'1997-01-10',3);
INSERT INTO Sales.Orders VALUES(10411,10,9,'1997-01-10',3);
INSERT INTO Sales.Orders VALUES(10412,87,8,'1997-01-13',2);
INSERT INTO Sales.Orders VALUES(10413,41,3,'1997-01-14',2);
INSERT INTO Sales.Orders VALUES(10414,21,2,'1997-01-14',3);
INSERT INTO Sales.Orders VALUES(10415,36,3,'1997-01-15',1);
INSERT INTO Sales.Orders VALUES(10416,87,8,'1997-01-16',3);
INSERT INTO Sales.Orders VALUES(10417,73,4,'1997-01-16',3);
INSERT INTO Sales.Orders VALUES(10418,63,4,'1997-01-17',1);
INSERT INTO Sales.Orders VALUES(10419,68,4,'1997-01-20',2);
INSERT INTO Sales.Orders VALUES(10420,88,3,'1997-01-21',1);
INSERT INTO Sales.Orders VALUES(10421,61,8,'1997-01-21',1);
INSERT INTO Sales.Orders VALUES(10422,27,2,'1997-01-22',1);
INSERT INTO Sales.Orders VALUES(10423,31,6,'1997-01-23',3);
INSERT INTO Sales.Orders VALUES(10424,51,7,'1997-01-23',2);
INSERT INTO Sales.Orders VALUES(10425,41,6,'1997-01-24',2);
INSERT INTO Sales.Orders VALUES(10426,29,4,'1997-01-27',1);
INSERT INTO Sales.Orders VALUES(10427,59,4,'1997-01-27',2);
INSERT INTO Sales.Orders VALUES(10428,66,7,'1997-01-28',1);
INSERT INTO Sales.Orders VALUES(10429,37,3,'1997-01-29',2);
INSERT INTO Sales.Orders VALUES(10430,20,4,'1997-01-30',1);
INSERT INTO Sales.Orders VALUES(10431,10,4,'1997-01-30',2);
INSERT INTO Sales.Orders VALUES(10432,75,3,'1997-01-31',2);
INSERT INTO Sales.Orders VALUES(10433,60,3,'1997-02-03',3);
INSERT INTO Sales.Orders VALUES(10434,24,3,'1997-02-03',2);
INSERT INTO Sales.Orders VALUES(10435,16,8,'1997-02-04',2);
INSERT INTO Sales.Orders VALUES(10436,7,3,'1997-02-05',2);
INSERT INTO Sales.Orders VALUES(10437,87,8,'1997-02-05',1);
INSERT INTO Sales.Orders VALUES(10438,79,3,'1997-02-06',2);
INSERT INTO Sales.Orders VALUES(10439,51,6,'1997-02-07',3);
INSERT INTO Sales.Orders VALUES(10440,71,4,'1997-02-10',2);
INSERT INTO Sales.Orders VALUES(10441,55,3,'1997-02-10',2);
INSERT INTO Sales.Orders VALUES(10442,20,3,'1997-02-11',2);
INSERT INTO Sales.Orders VALUES(10443,66,8,'1997-02-12',1);

INSERT INTO Sales.OrderDetails VALUES(1,10248,11,12);
INSERT INTO Sales.OrderDetails VALUES(2,10248,42,10);
INSERT INTO Sales.OrderDetails VALUES(3,10248,72,5);
INSERT INTO Sales.OrderDetails VALUES(4,10249,14,9);
INSERT INTO Sales.OrderDetails VALUES(5,10249,51,40);
INSERT INTO Sales.OrderDetails VALUES(6,10250,41,10);
INSERT INTO Sales.OrderDetails VALUES(7,10250,51,35);
INSERT INTO Sales.OrderDetails VALUES(8,10250,65,15);
INSERT INTO Sales.OrderDetails VALUES(9,10251,22,6);
INSERT INTO Sales.OrderDetails VALUES(10,10251,57,15);
INSERT INTO Sales.OrderDetails VALUES(11,10251,65,20);
INSERT INTO Sales.OrderDetails VALUES(12,10252,20,40);
INSERT INTO Sales.OrderDetails VALUES(13,10252,33,25);
INSERT INTO Sales.OrderDetails VALUES(14,10252,60,40);
INSERT INTO Sales.OrderDetails VALUES(15,10253,31,20);
INSERT INTO Sales.OrderDetails VALUES(16,10253,39,42);
INSERT INTO Sales.OrderDetails VALUES(17,10253,49,40);
INSERT INTO Sales.OrderDetails VALUES(18,10254,24,15);
INSERT INTO Sales.OrderDetails VALUES(19,10254,55,21);
INSERT INTO Sales.OrderDetails VALUES(20,10254,74,21);
INSERT INTO Sales.OrderDetails VALUES(21,10255,2,20);
INSERT INTO Sales.OrderDetails VALUES(22,10255,16,35);
INSERT INTO Sales.OrderDetails VALUES(23,10255,36,25);
INSERT INTO Sales.OrderDetails VALUES(24,10255,59,30);
INSERT INTO Sales.OrderDetails VALUES(25,10256,53,15);
INSERT INTO Sales.OrderDetails VALUES(26,10256,77,12);
INSERT INTO Sales.OrderDetails VALUES(27,10257,27,25);
INSERT INTO Sales.OrderDetails VALUES(28,10257,39,6);
INSERT INTO Sales.OrderDetails VALUES(29,10257,77,15);
INSERT INTO Sales.OrderDetails VALUES(30,10258,2,50);
INSERT INTO Sales.OrderDetails VALUES(31,10258,5,65);
INSERT INTO Sales.OrderDetails VALUES(32,10258,32,6);
INSERT INTO Sales.OrderDetails VALUES(33,10259,21,10);
INSERT INTO Sales.OrderDetails VALUES(34,10259,37,1);
INSERT INTO Sales.OrderDetails VALUES(35,10260,41,16);
INSERT INTO Sales.OrderDetails VALUES(36,10260,57,50);
INSERT INTO Sales.OrderDetails VALUES(37,10260,62,15);
INSERT INTO Sales.OrderDetails VALUES(38,10260,70,21);
INSERT INTO Sales.OrderDetails VALUES(39,10261,21,20);
INSERT INTO Sales.OrderDetails VALUES(40,10261,35,20);
INSERT INTO Sales.OrderDetails VALUES(41,10262,5,12);
INSERT INTO Sales.OrderDetails VALUES(42,10262,7,15);
INSERT INTO Sales.OrderDetails VALUES(43,10262,56,2);
INSERT INTO Sales.OrderDetails VALUES(44,10263,16,60);
INSERT INTO Sales.OrderDetails VALUES(45,10263,24,28);
INSERT INTO Sales.OrderDetails VALUES(46,10263,30,60);
INSERT INTO Sales.OrderDetails VALUES(47,10263,74,36);
INSERT INTO Sales.OrderDetails VALUES(48,10264,2,35);
INSERT INTO Sales.OrderDetails VALUES(49,10264,41,25);
INSERT INTO Sales.OrderDetails VALUES(50,10265,17,30);
INSERT INTO Sales.OrderDetails VALUES(51,10265,70,20);
INSERT INTO Sales.OrderDetails VALUES(52,10266,12,12);
INSERT INTO Sales.OrderDetails VALUES(53,10267,40,50);
INSERT INTO Sales.OrderDetails VALUES(54,10267,59,70);
INSERT INTO Sales.OrderDetails VALUES(55,10267,76,15);
INSERT INTO Sales.OrderDetails VALUES(56,10268,29,10);
INSERT INTO Sales.OrderDetails VALUES(57,10268,72,4);
INSERT INTO Sales.OrderDetails VALUES(58,10269,33,60);
INSERT INTO Sales.OrderDetails VALUES(59,10269,72,20);
INSERT INTO Sales.OrderDetails VALUES(60,10270,36,30);
INSERT INTO Sales.OrderDetails VALUES(61,10270,43,25);
INSERT INTO Sales.OrderDetails VALUES(62,10271,33,24);
INSERT INTO Sales.OrderDetails VALUES(63,10272,20,6);
INSERT INTO Sales.OrderDetails VALUES(64,10272,31,40);
INSERT INTO Sales.OrderDetails VALUES(65,10272,72,24);
INSERT INTO Sales.OrderDetails VALUES(66,10273,10,24);
INSERT INTO Sales.OrderDetails VALUES(67,10273,31,15);
INSERT INTO Sales.OrderDetails VALUES(68,10273,33,20);
INSERT INTO Sales.OrderDetails VALUES(69,10273,40,60);
INSERT INTO Sales.OrderDetails VALUES(70,10273,76,33);
INSERT INTO Sales.OrderDetails VALUES(71,10274,71,20);
INSERT INTO Sales.OrderDetails VALUES(72,10274,72,7);
INSERT INTO Sales.OrderDetails VALUES(73,10275,24,12);
INSERT INTO Sales.OrderDetails VALUES(74,10275,59,6);
INSERT INTO Sales.OrderDetails VALUES(75,10276,10,15);
INSERT INTO Sales.OrderDetails VALUES(76,10276,13,10);
INSERT INTO Sales.OrderDetails VALUES(77,10277,28,20);
INSERT INTO Sales.OrderDetails VALUES(78,10277,62,12);
INSERT INTO Sales.OrderDetails VALUES(79,10278,44,16);
INSERT INTO Sales.OrderDetails VALUES(80,10278,59,15);
INSERT INTO Sales.OrderDetails VALUES(81,10278,63,8);
INSERT INTO Sales.OrderDetails VALUES(82,10278,73,25);
INSERT INTO Sales.OrderDetails VALUES(83,10279,17,15);
INSERT INTO Sales.OrderDetails VALUES(84,10280,24,12);
INSERT INTO Sales.OrderDetails VALUES(85,10280,55,20);
INSERT INTO Sales.OrderDetails VALUES(86,10280,75,30);
INSERT INTO Sales.OrderDetails VALUES(87,10281,19,1);
INSERT INTO Sales.OrderDetails VALUES(88,10281,24,6);
INSERT INTO Sales.OrderDetails VALUES(89,10281,35,4);
INSERT INTO Sales.OrderDetails VALUES(90,10282,30,6);
INSERT INTO Sales.OrderDetails VALUES(91,10282,57,2);
INSERT INTO Sales.OrderDetails VALUES(92,10283,15,20);
INSERT INTO Sales.OrderDetails VALUES(93,10283,19,18);
INSERT INTO Sales.OrderDetails VALUES(94,10283,60,35);
INSERT INTO Sales.OrderDetails VALUES(95,10283,72,3);
INSERT INTO Sales.OrderDetails VALUES(96,10284,27,15);
INSERT INTO Sales.OrderDetails VALUES(97,10284,44,21);
INSERT INTO Sales.OrderDetails VALUES(98,10284,60,20);
INSERT INTO Sales.OrderDetails VALUES(99,10284,67,5);
INSERT INTO Sales.OrderDetails VALUES(100,10285,1,45);
INSERT INTO Sales.OrderDetails VALUES(101,10285,40,40);
INSERT INTO Sales.OrderDetails VALUES(102,10285,53,36);
INSERT INTO Sales.OrderDetails VALUES(103,10286,35,100);
INSERT INTO Sales.OrderDetails VALUES(104,10286,62,40);
INSERT INTO Sales.OrderDetails VALUES(105,10287,16,40);
INSERT INTO Sales.OrderDetails VALUES(106,10287,34,20);
INSERT INTO Sales.OrderDetails VALUES(107,10287,46,15);
INSERT INTO Sales.OrderDetails VALUES(108,10288,54,10);
INSERT INTO Sales.OrderDetails VALUES(109,10288,68,3);
INSERT INTO Sales.OrderDetails VALUES(110,10289,3,30);
INSERT INTO Sales.OrderDetails VALUES(111,10289,64,9);
INSERT INTO Sales.OrderDetails VALUES(112,10290,5,20);
INSERT INTO Sales.OrderDetails VALUES(113,10290,29,15);
INSERT INTO Sales.OrderDetails VALUES(114,10290,49,15);
INSERT INTO Sales.OrderDetails VALUES(115,10290,77,10);
INSERT INTO Sales.OrderDetails VALUES(116,10291,13,20);
INSERT INTO Sales.OrderDetails VALUES(117,10291,44,24);
INSERT INTO Sales.OrderDetails VALUES(118,10291,51,2);
INSERT INTO Sales.OrderDetails VALUES(119,10292,20,20);
INSERT INTO Sales.OrderDetails VALUES(120,10293,18,12);
INSERT INTO Sales.OrderDetails VALUES(121,10293,24,10);
INSERT INTO Sales.OrderDetails VALUES(122,10293,63,5);
INSERT INTO Sales.OrderDetails VALUES(123,10293,75,6);
INSERT INTO Sales.OrderDetails VALUES(124,10294,1,18);
INSERT INTO Sales.OrderDetails VALUES(125,10294,17,15);
INSERT INTO Sales.OrderDetails VALUES(126,10294,43,15);
INSERT INTO Sales.OrderDetails VALUES(127,10294,60,21);
INSERT INTO Sales.OrderDetails VALUES(128,10294,75,6);
INSERT INTO Sales.OrderDetails VALUES(129,10295,56,4);
INSERT INTO Sales.OrderDetails VALUES(130,10296,11,12);
INSERT INTO Sales.OrderDetails VALUES(131,10296,16,30);
INSERT INTO Sales.OrderDetails VALUES(132,10296,69,15);
INSERT INTO Sales.OrderDetails VALUES(133,10297,39,60);
INSERT INTO Sales.OrderDetails VALUES(134,10297,72,20);
INSERT INTO Sales.OrderDetails VALUES(135,10298,2,40);
INSERT INTO Sales.OrderDetails VALUES(136,10298,36,40);
INSERT INTO Sales.OrderDetails VALUES(137,10298,59,30);
INSERT INTO Sales.OrderDetails VALUES(138,10298,62,15);
INSERT INTO Sales.OrderDetails VALUES(139,10299,19,15);
INSERT INTO Sales.OrderDetails VALUES(140,10299,70,20);
INSERT INTO Sales.OrderDetails VALUES(141,10300,66,30);
INSERT INTO Sales.OrderDetails VALUES(142,10300,68,20);
INSERT INTO Sales.OrderDetails VALUES(143,10301,40,10);
INSERT INTO Sales.OrderDetails VALUES(144,10301,56,20);
INSERT INTO Sales.OrderDetails VALUES(145,10302,17,40);
INSERT INTO Sales.OrderDetails VALUES(146,10302,28,28);
INSERT INTO Sales.OrderDetails VALUES(147,10302,43,12);
INSERT INTO Sales.OrderDetails VALUES(148,10303,40,40);
INSERT INTO Sales.OrderDetails VALUES(149,10303,65,30);
INSERT INTO Sales.OrderDetails VALUES(150,10303,68,15);
INSERT INTO Sales.OrderDetails VALUES(151,10304,49,30);
INSERT INTO Sales.OrderDetails VALUES(152,10304,59,10);
INSERT INTO Sales.OrderDetails VALUES(153,10304,71,2);
INSERT INTO Sales.OrderDetails VALUES(154,10305,18,25);
INSERT INTO Sales.OrderDetails VALUES(155,10305,29,25);
INSERT INTO Sales.OrderDetails VALUES(156,10305,39,30);
INSERT INTO Sales.OrderDetails VALUES(157,10306,30,10);
INSERT INTO Sales.OrderDetails VALUES(158,10306,53,10);
INSERT INTO Sales.OrderDetails VALUES(159,10306,54,5);
INSERT INTO Sales.OrderDetails VALUES(160,10307,62,10);
INSERT INTO Sales.OrderDetails VALUES(161,10307,68,3);
INSERT INTO Sales.OrderDetails VALUES(162,10308,69,1);
INSERT INTO Sales.OrderDetails VALUES(163,10308,70,5);
INSERT INTO Sales.OrderDetails VALUES(164,10309,4,20);
INSERT INTO Sales.OrderDetails VALUES(165,10309,6,30);
INSERT INTO Sales.OrderDetails VALUES(166,10309,42,2);
INSERT INTO Sales.OrderDetails VALUES(167,10309,43,20);
INSERT INTO Sales.OrderDetails VALUES(168,10309,71,3);
INSERT INTO Sales.OrderDetails VALUES(169,10310,16,10);
INSERT INTO Sales.OrderDetails VALUES(170,10310,62,5);
INSERT INTO Sales.OrderDetails VALUES(171,10311,42,6);
INSERT INTO Sales.OrderDetails VALUES(172,10311,69,7);
INSERT INTO Sales.OrderDetails VALUES(173,10312,28,4);
INSERT INTO Sales.OrderDetails VALUES(174,10312,43,24);
INSERT INTO Sales.OrderDetails VALUES(175,10312,53,20);
INSERT INTO Sales.OrderDetails VALUES(176,10312,75,10);
INSERT INTO Sales.OrderDetails VALUES(177,10313,36,12);
INSERT INTO Sales.OrderDetails VALUES(178,10314,32,40);
INSERT INTO Sales.OrderDetails VALUES(179,10314,58,30);
INSERT INTO Sales.OrderDetails VALUES(180,10314,62,25);
INSERT INTO Sales.OrderDetails VALUES(181,10315,34,14);
INSERT INTO Sales.OrderDetails VALUES(182,10315,70,30);
INSERT INTO Sales.OrderDetails VALUES(183,10316,41,10);
INSERT INTO Sales.OrderDetails VALUES(184,10316,62,70);
INSERT INTO Sales.OrderDetails VALUES(185,10317,1,20);
INSERT INTO Sales.OrderDetails VALUES(186,10318,41,20);
INSERT INTO Sales.OrderDetails VALUES(187,10318,76,6);
INSERT INTO Sales.OrderDetails VALUES(188,10319,17,8);
INSERT INTO Sales.OrderDetails VALUES(189,10319,28,14);
INSERT INTO Sales.OrderDetails VALUES(190,10319,76,30);
INSERT INTO Sales.OrderDetails VALUES(191,10320,71,30);
INSERT INTO Sales.OrderDetails VALUES(192,10321,35,10);
INSERT INTO Sales.OrderDetails VALUES(193,10322,52,20);
INSERT INTO Sales.OrderDetails VALUES(194,10323,15,5);
INSERT INTO Sales.OrderDetails VALUES(195,10323,25,4);
INSERT INTO Sales.OrderDetails VALUES(196,10323,39,4);
INSERT INTO Sales.OrderDetails VALUES(197,10324,16,21);
INSERT INTO Sales.OrderDetails VALUES(198,10324,35,70);
INSERT INTO Sales.OrderDetails VALUES(199,10324,46,30);
INSERT INTO Sales.OrderDetails VALUES(200,10324,59,40);
INSERT INTO Sales.OrderDetails VALUES(201,10324,63,80);
INSERT INTO Sales.OrderDetails VALUES(202,10325,6,6);
INSERT INTO Sales.OrderDetails VALUES(203,10325,13,12);
INSERT INTO Sales.OrderDetails VALUES(204,10325,14,9);
INSERT INTO Sales.OrderDetails VALUES(205,10325,31,4);
INSERT INTO Sales.OrderDetails VALUES(206,10325,72,40);
INSERT INTO Sales.OrderDetails VALUES(207,10326,4,24);
INSERT INTO Sales.OrderDetails VALUES(208,10326,57,16);
INSERT INTO Sales.OrderDetails VALUES(209,10326,75,50);
INSERT INTO Sales.OrderDetails VALUES(210,10327,2,25);
INSERT INTO Sales.OrderDetails VALUES(211,10327,11,50);
INSERT INTO Sales.OrderDetails VALUES(212,10327,30,35);
INSERT INTO Sales.OrderDetails VALUES(213,10327,58,30);
INSERT INTO Sales.OrderDetails VALUES(214,10328,59,9);
INSERT INTO Sales.OrderDetails VALUES(215,10328,65,40);
INSERT INTO Sales.OrderDetails VALUES(216,10328,68,10);
INSERT INTO Sales.OrderDetails VALUES(217,10329,19,10);
INSERT INTO Sales.OrderDetails VALUES(218,10329,30,8);
INSERT INTO Sales.OrderDetails VALUES(219,10329,38,20);
INSERT INTO Sales.OrderDetails VALUES(220,10329,56,12);
INSERT INTO Sales.OrderDetails VALUES(221,10330,26,50);
INSERT INTO Sales.OrderDetails VALUES(222,10330,72,25);
INSERT INTO Sales.OrderDetails VALUES(223,10331,54,15);
INSERT INTO Sales.OrderDetails VALUES(224,10332,18,40);
INSERT INTO Sales.OrderDetails VALUES(225,10332,42,10);
INSERT INTO Sales.OrderDetails VALUES(226,10332,47,16);
INSERT INTO Sales.OrderDetails VALUES(227,10333,14,10);
INSERT INTO Sales.OrderDetails VALUES(228,10333,21,10);
INSERT INTO Sales.OrderDetails VALUES(229,10333,71,40);
INSERT INTO Sales.OrderDetails VALUES(230,10334,52,8);
INSERT INTO Sales.OrderDetails VALUES(231,10334,68,10);
INSERT INTO Sales.OrderDetails VALUES(232,10335,2,7);
INSERT INTO Sales.OrderDetails VALUES(233,10335,31,25);
INSERT INTO Sales.OrderDetails VALUES(234,10335,32,6);
INSERT INTO Sales.OrderDetails VALUES(235,10335,51,48);
INSERT INTO Sales.OrderDetails VALUES(236,10336,4,18);
INSERT INTO Sales.OrderDetails VALUES(237,10337,23,40);
INSERT INTO Sales.OrderDetails VALUES(238,10337,26,24);
INSERT INTO Sales.OrderDetails VALUES(239,10337,36,20);
INSERT INTO Sales.OrderDetails VALUES(240,10337,37,28);
INSERT INTO Sales.OrderDetails VALUES(241,10337,72,25);
INSERT INTO Sales.OrderDetails VALUES(242,10338,17,20);
INSERT INTO Sales.OrderDetails VALUES(243,10338,30,15);
INSERT INTO Sales.OrderDetails VALUES(244,10339,4,10);
INSERT INTO Sales.OrderDetails VALUES(245,10339,17,70);
INSERT INTO Sales.OrderDetails VALUES(246,10339,62,28);
INSERT INTO Sales.OrderDetails VALUES(247,10340,18,20);
INSERT INTO Sales.OrderDetails VALUES(248,10340,41,12);
INSERT INTO Sales.OrderDetails VALUES(249,10340,43,40);
INSERT INTO Sales.OrderDetails VALUES(250,10341,33,8);
INSERT INTO Sales.OrderDetails VALUES(251,10341,59,9);
INSERT INTO Sales.OrderDetails VALUES(252,10342,2,24);
INSERT INTO Sales.OrderDetails VALUES(253,10342,31,56);
INSERT INTO Sales.OrderDetails VALUES(254,10342,36,40);
INSERT INTO Sales.OrderDetails VALUES(255,10342,55,40);
INSERT INTO Sales.OrderDetails VALUES(256,10343,64,50);
INSERT INTO Sales.OrderDetails VALUES(257,10343,68,4);
INSERT INTO Sales.OrderDetails VALUES(258,10343,76,15);
INSERT INTO Sales.OrderDetails VALUES(259,10344,4,35);
INSERT INTO Sales.OrderDetails VALUES(260,10344,8,70);
INSERT INTO Sales.OrderDetails VALUES(261,10345,8,70);
INSERT INTO Sales.OrderDetails VALUES(262,10345,19,80);
INSERT INTO Sales.OrderDetails VALUES(263,10345,42,9);
INSERT INTO Sales.OrderDetails VALUES(264,10346,17,36);
INSERT INTO Sales.OrderDetails VALUES(265,10346,56,20);
INSERT INTO Sales.OrderDetails VALUES(266,10347,25,10);
INSERT INTO Sales.OrderDetails VALUES(267,10347,39,50);
INSERT INTO Sales.OrderDetails VALUES(268,10347,40,4);
INSERT INTO Sales.OrderDetails VALUES(269,10347,75,6);
INSERT INTO Sales.OrderDetails VALUES(270,10348,1,15);
INSERT INTO Sales.OrderDetails VALUES(271,10348,23,25);
INSERT INTO Sales.OrderDetails VALUES(272,10349,54,24);
INSERT INTO Sales.OrderDetails VALUES(273,10350,50,15);
INSERT INTO Sales.OrderDetails VALUES(274,10350,69,18);
INSERT INTO Sales.OrderDetails VALUES(275,10351,38,20);
INSERT INTO Sales.OrderDetails VALUES(276,10351,41,13);
INSERT INTO Sales.OrderDetails VALUES(277,10351,44,77);
INSERT INTO Sales.OrderDetails VALUES(278,10351,65,10);
INSERT INTO Sales.OrderDetails VALUES(279,10352,24,10);
INSERT INTO Sales.OrderDetails VALUES(280,10352,54,20);
INSERT INTO Sales.OrderDetails VALUES(281,10353,11,12);
INSERT INTO Sales.OrderDetails VALUES(282,10353,38,50);
INSERT INTO Sales.OrderDetails VALUES(283,10354,1,12);
INSERT INTO Sales.OrderDetails VALUES(284,10354,29,4);
INSERT INTO Sales.OrderDetails VALUES(285,10355,24,25);
INSERT INTO Sales.OrderDetails VALUES(286,10355,57,25);
INSERT INTO Sales.OrderDetails VALUES(287,10356,31,30);
INSERT INTO Sales.OrderDetails VALUES(288,10356,55,12);
INSERT INTO Sales.OrderDetails VALUES(289,10356,69,20);
INSERT INTO Sales.OrderDetails VALUES(290,10357,10,30);
INSERT INTO Sales.OrderDetails VALUES(291,10357,26,16);
INSERT INTO Sales.OrderDetails VALUES(292,10357,60,8);
INSERT INTO Sales.OrderDetails VALUES(293,10358,24,10);
INSERT INTO Sales.OrderDetails VALUES(294,10358,34,10);
INSERT INTO Sales.OrderDetails VALUES(295,10358,36,20);
INSERT INTO Sales.OrderDetails VALUES(296,10359,16,56);
INSERT INTO Sales.OrderDetails VALUES(297,10359,31,70);
INSERT INTO Sales.OrderDetails VALUES(298,10359,60,80);
INSERT INTO Sales.OrderDetails VALUES(299,10360,28,30);
INSERT INTO Sales.OrderDetails VALUES(300,10360,29,35);
INSERT INTO Sales.OrderDetails VALUES(301,10360,38,10);
INSERT INTO Sales.OrderDetails VALUES(302,10360,49,35);
INSERT INTO Sales.OrderDetails VALUES(303,10360,54,28);
INSERT INTO Sales.OrderDetails VALUES(304,10361,39,54);
INSERT INTO Sales.OrderDetails VALUES(305,10361,60,55);
INSERT INTO Sales.OrderDetails VALUES(306,10362,25,50);
INSERT INTO Sales.OrderDetails VALUES(307,10362,51,20);
INSERT INTO Sales.OrderDetails VALUES(308,10362,54,24);
INSERT INTO Sales.OrderDetails VALUES(309,10363,31,20);
INSERT INTO Sales.OrderDetails VALUES(310,10363,75,12);
INSERT INTO Sales.OrderDetails VALUES(311,10363,76,12);
INSERT INTO Sales.OrderDetails VALUES(312,10364,69,30);
INSERT INTO Sales.OrderDetails VALUES(313,10364,71,5);
INSERT INTO Sales.OrderDetails VALUES(314,10365,11,24);
INSERT INTO Sales.OrderDetails VALUES(315,10366,65,5);
INSERT INTO Sales.OrderDetails VALUES(316,10366,77,5);
INSERT INTO Sales.OrderDetails VALUES(317,10367,34,36);
INSERT INTO Sales.OrderDetails VALUES(318,10367,54,18);
INSERT INTO Sales.OrderDetails VALUES(319,10367,65,15);
INSERT INTO Sales.OrderDetails VALUES(320,10367,77,7);
INSERT INTO Sales.OrderDetails VALUES(321,10368,21,5);
INSERT INTO Sales.OrderDetails VALUES(322,10368,28,13);
INSERT INTO Sales.OrderDetails VALUES(323,10368,57,25);
INSERT INTO Sales.OrderDetails VALUES(324,10368,64,35);
INSERT INTO Sales.OrderDetails VALUES(325,10369,29,20);
INSERT INTO Sales.OrderDetails VALUES(326,10369,56,18);
INSERT INTO Sales.OrderDetails VALUES(327,10370,1,15);
INSERT INTO Sales.OrderDetails VALUES(328,10370,64,30);
INSERT INTO Sales.OrderDetails VALUES(329,10370,74,20);
INSERT INTO Sales.OrderDetails VALUES(330,10371,36,6);
INSERT INTO Sales.OrderDetails VALUES(331,10372,20,12);
INSERT INTO Sales.OrderDetails VALUES(332,10372,38,40);
INSERT INTO Sales.OrderDetails VALUES(333,10372,60,70);
INSERT INTO Sales.OrderDetails VALUES(334,10372,72,42);
INSERT INTO Sales.OrderDetails VALUES(335,10373,58,80);
INSERT INTO Sales.OrderDetails VALUES(336,10373,71,50);
INSERT INTO Sales.OrderDetails VALUES(337,10374,31,30);
INSERT INTO Sales.OrderDetails VALUES(338,10374,58,15);
INSERT INTO Sales.OrderDetails VALUES(339,10375,14,15);
INSERT INTO Sales.OrderDetails VALUES(340,10375,54,10);
INSERT INTO Sales.OrderDetails VALUES(341,10376,31,42);
INSERT INTO Sales.OrderDetails VALUES(342,10377,28,20);
INSERT INTO Sales.OrderDetails VALUES(343,10377,39,20);
INSERT INTO Sales.OrderDetails VALUES(344,10378,71,6);
INSERT INTO Sales.OrderDetails VALUES(345,10379,41,8);
INSERT INTO Sales.OrderDetails VALUES(346,10379,63,16);
INSERT INTO Sales.OrderDetails VALUES(347,10379,65,20);
INSERT INTO Sales.OrderDetails VALUES(348,10380,30,18);
INSERT INTO Sales.OrderDetails VALUES(349,10380,53,20);
INSERT INTO Sales.OrderDetails VALUES(350,10380,60,6);
INSERT INTO Sales.OrderDetails VALUES(351,10380,70,30);
INSERT INTO Sales.OrderDetails VALUES(352,10381,74,14);
INSERT INTO Sales.OrderDetails VALUES(353,10382,5,32);
INSERT INTO Sales.OrderDetails VALUES(354,10382,18,9);
INSERT INTO Sales.OrderDetails VALUES(355,10382,29,14);
INSERT INTO Sales.OrderDetails VALUES(356,10382,33,60);
INSERT INTO Sales.OrderDetails VALUES(357,10382,74,50);
INSERT INTO Sales.OrderDetails VALUES(358,10383,13,20);
INSERT INTO Sales.OrderDetails VALUES(359,10383,50,15);
INSERT INTO Sales.OrderDetails VALUES(360,10383,56,20);
INSERT INTO Sales.OrderDetails VALUES(361,10384,20,28);
INSERT INTO Sales.OrderDetails VALUES(362,10384,60,15);
INSERT INTO Sales.OrderDetails VALUES(363,10385,7,10);
INSERT INTO Sales.OrderDetails VALUES(364,10385,60,20);
INSERT INTO Sales.OrderDetails VALUES(365,10385,68,8);
INSERT INTO Sales.OrderDetails VALUES(366,10386,24,15);
INSERT INTO Sales.OrderDetails VALUES(367,10386,34,10);
INSERT INTO Sales.OrderDetails VALUES(368,10387,24,15);
INSERT INTO Sales.OrderDetails VALUES(369,10387,28,6);
INSERT INTO Sales.OrderDetails VALUES(370,10387,59,12);
INSERT INTO Sales.OrderDetails VALUES(371,10387,71,15);
INSERT INTO Sales.OrderDetails VALUES(372,10388,45,15);
INSERT INTO Sales.OrderDetails VALUES(373,10388,52,20);
INSERT INTO Sales.OrderDetails VALUES(374,10388,53,40);
INSERT INTO Sales.OrderDetails VALUES(375,10389,10,16);
INSERT INTO Sales.OrderDetails VALUES(376,10389,55,15);
INSERT INTO Sales.OrderDetails VALUES(377,10389,62,20);
INSERT INTO Sales.OrderDetails VALUES(378,10389,70,30);
INSERT INTO Sales.OrderDetails VALUES(379,10390,31,60);
INSERT INTO Sales.OrderDetails VALUES(380,10390,35,40);
INSERT INTO Sales.OrderDetails VALUES(381,10390,46,45);
INSERT INTO Sales.OrderDetails VALUES(382,10390,72,24);
INSERT INTO Sales.OrderDetails VALUES(383,10391,13,18);
INSERT INTO Sales.OrderDetails VALUES(384,10392,69,50);
INSERT INTO Sales.OrderDetails VALUES(385,10393,2,25);
INSERT INTO Sales.OrderDetails VALUES(386,10393,14,42);
INSERT INTO Sales.OrderDetails VALUES(387,10393,25,7);
INSERT INTO Sales.OrderDetails VALUES(388,10393,26,70);
INSERT INTO Sales.OrderDetails VALUES(389,10393,31,32);
INSERT INTO Sales.OrderDetails VALUES(390,10394,13,10);
INSERT INTO Sales.OrderDetails VALUES(391,10394,62,10);
INSERT INTO Sales.OrderDetails VALUES(392,10395,46,28);
INSERT INTO Sales.OrderDetails VALUES(393,10395,53,70);
INSERT INTO Sales.OrderDetails VALUES(394,10395,69,8);
INSERT INTO Sales.OrderDetails VALUES(395,10396,23,40);
INSERT INTO Sales.OrderDetails VALUES(396,10396,71,60);
INSERT INTO Sales.OrderDetails VALUES(397,10396,72,21);
INSERT INTO Sales.OrderDetails VALUES(398,10397,21,10);
INSERT INTO Sales.OrderDetails VALUES(399,10397,51,18);
INSERT INTO Sales.OrderDetails VALUES(400,10398,35,30);
INSERT INTO Sales.OrderDetails VALUES(401,10398,55,120);
INSERT INTO Sales.OrderDetails VALUES(402,10399,68,60);
INSERT INTO Sales.OrderDetails VALUES(403,10399,71,30);
INSERT INTO Sales.OrderDetails VALUES(404,10399,76,35);
INSERT INTO Sales.OrderDetails VALUES(405,10399,77,14);
INSERT INTO Sales.OrderDetails VALUES(406,10400,29,21);
INSERT INTO Sales.OrderDetails VALUES(407,10400,35,35);
INSERT INTO Sales.OrderDetails VALUES(408,10400,49,30);
INSERT INTO Sales.OrderDetails VALUES(409,10401,30,18);
INSERT INTO Sales.OrderDetails VALUES(410,10401,56,70);
INSERT INTO Sales.OrderDetails VALUES(411,10401,65,20);
INSERT INTO Sales.OrderDetails VALUES(412,10401,71,60);
INSERT INTO Sales.OrderDetails VALUES(413,10402,23,60);
INSERT INTO Sales.OrderDetails VALUES(414,10402,63,65);
INSERT INTO Sales.OrderDetails VALUES(415,10403,16,21);
INSERT INTO Sales.OrderDetails VALUES(416,10403,48,70);
INSERT INTO Sales.OrderDetails VALUES(417,10404,26,30);
INSERT INTO Sales.OrderDetails VALUES(418,10404,42,40);
INSERT INTO Sales.OrderDetails VALUES(419,10404,49,30);
INSERT INTO Sales.OrderDetails VALUES(420,10405,3,50);
INSERT INTO Sales.OrderDetails VALUES(421,10406,1,10);
INSERT INTO Sales.OrderDetails VALUES(422,10406,21,30);
INSERT INTO Sales.OrderDetails VALUES(423,10406,28,42);
INSERT INTO Sales.OrderDetails VALUES(424,10406,36,5);
INSERT INTO Sales.OrderDetails VALUES(425,10406,40,2);
INSERT INTO Sales.OrderDetails VALUES(426,10407,11,30);
INSERT INTO Sales.OrderDetails VALUES(427,10407,69,15);
INSERT INTO Sales.OrderDetails VALUES(428,10407,71,15);
INSERT INTO Sales.OrderDetails VALUES(429,10408,37,10);
INSERT INTO Sales.OrderDetails VALUES(430,10408,54,6);
INSERT INTO Sales.OrderDetails VALUES(431,10408,62,35);
INSERT INTO Sales.OrderDetails VALUES(432,10409,14,12);
INSERT INTO Sales.OrderDetails VALUES(433,10409,21,12);
INSERT INTO Sales.OrderDetails VALUES(434,10410,33,49);
INSERT INTO Sales.OrderDetails VALUES(435,10410,59,16);
INSERT INTO Sales.OrderDetails VALUES(436,10411,41,25);
INSERT INTO Sales.OrderDetails VALUES(437,10411,44,40);
INSERT INTO Sales.OrderDetails VALUES(438,10411,59,9);
INSERT INTO Sales.OrderDetails VALUES(439,10412,14,20);
INSERT INTO Sales.OrderDetails VALUES(440,10413,1,24);
INSERT INTO Sales.OrderDetails VALUES(441,10413,62,40);
INSERT INTO Sales.OrderDetails VALUES(442,10413,76,14);
INSERT INTO Sales.OrderDetails VALUES(443,10414,19,18);
INSERT INTO Sales.OrderDetails VALUES(444,10414,33,50);
INSERT INTO Sales.OrderDetails VALUES(445,10415,17,2);
INSERT INTO Sales.OrderDetails VALUES(446,10415,33,20);
INSERT INTO Sales.OrderDetails VALUES(447,10416,19,20);
INSERT INTO Sales.OrderDetails VALUES(448,10416,53,10);
INSERT INTO Sales.OrderDetails VALUES(449,10416,57,20);
INSERT INTO Sales.OrderDetails VALUES(450,10417,38,50);
INSERT INTO Sales.OrderDetails VALUES(451,10417,46,2);
INSERT INTO Sales.OrderDetails VALUES(452,10417,68,36);
INSERT INTO Sales.OrderDetails VALUES(453,10417,77,35);
INSERT INTO Sales.OrderDetails VALUES(454,10418,2,60);
INSERT INTO Sales.OrderDetails VALUES(455,10418,47,55);
INSERT INTO Sales.OrderDetails VALUES(456,10418,61,16);
INSERT INTO Sales.OrderDetails VALUES(457,10418,74,15);
INSERT INTO Sales.OrderDetails VALUES(458,10419,60,60);
INSERT INTO Sales.OrderDetails VALUES(459,10419,69,20);
INSERT INTO Sales.OrderDetails VALUES(460,10420,9,20);
INSERT INTO Sales.OrderDetails VALUES(461,10420,13,2);
INSERT INTO Sales.OrderDetails VALUES(462,10420,70,8);
INSERT INTO Sales.OrderDetails VALUES(463,10420,73,20);
INSERT INTO Sales.OrderDetails VALUES(464,10421,19,4);
INSERT INTO Sales.OrderDetails VALUES(465,10421,26,30);
INSERT INTO Sales.OrderDetails VALUES(466,10421,53,15);
INSERT INTO Sales.OrderDetails VALUES(467,10421,77,10);
INSERT INTO Sales.OrderDetails VALUES(468,10422,26,2);
INSERT INTO Sales.OrderDetails VALUES(469,10423,31,14);
INSERT INTO Sales.OrderDetails VALUES(470,10423,59,20);
INSERT INTO Sales.OrderDetails VALUES(471,10424,35,60);
INSERT INTO Sales.OrderDetails VALUES(472,10424,38,49);
INSERT INTO Sales.OrderDetails VALUES(473,10424,68,30);
INSERT INTO Sales.OrderDetails VALUES(474,10425,55,10);
INSERT INTO Sales.OrderDetails VALUES(475,10425,76,20);
INSERT INTO Sales.OrderDetails VALUES(476,10426,56,5);
INSERT INTO Sales.OrderDetails VALUES(477,10426,64,7);
INSERT INTO Sales.OrderDetails VALUES(478,10427,14,35);
INSERT INTO Sales.OrderDetails VALUES(479,10428,46,20);
INSERT INTO Sales.OrderDetails VALUES(480,10429,50,40);
INSERT INTO Sales.OrderDetails VALUES(481,10429,63,35);
INSERT INTO Sales.OrderDetails VALUES(482,10430,17,45);
INSERT INTO Sales.OrderDetails VALUES(483,10430,21,50);
INSERT INTO Sales.OrderDetails VALUES(484,10430,56,30);
INSERT INTO Sales.OrderDetails VALUES(485,10430,59,70);
INSERT INTO Sales.OrderDetails VALUES(486,10431,17,50);
INSERT INTO Sales.OrderDetails VALUES(487,10431,40,50);
INSERT INTO Sales.OrderDetails VALUES(488,10431,47,30);
INSERT INTO Sales.OrderDetails VALUES(489,10432,26,10);
INSERT INTO Sales.OrderDetails VALUES(490,10432,54,40);
INSERT INTO Sales.OrderDetails VALUES(491,10433,56,28);
INSERT INTO Sales.OrderDetails VALUES(492,10434,11,6);
INSERT INTO Sales.OrderDetails VALUES(493,10434,76,18);
INSERT INTO Sales.OrderDetails VALUES(494,10435,2,10);
INSERT INTO Sales.OrderDetails VALUES(495,10435,22,12);
INSERT INTO Sales.OrderDetails VALUES(496,10435,72,10);
INSERT INTO Sales.OrderDetails VALUES(497,10436,46,5);
INSERT INTO Sales.OrderDetails VALUES(498,10436,56,40);
INSERT INTO Sales.OrderDetails VALUES(499,10436,64,30);
INSERT INTO Sales.OrderDetails VALUES(500,10436,75,24);
INSERT INTO Sales.OrderDetails VALUES(501,10437,53,15);
INSERT INTO Sales.OrderDetails VALUES(502,10438,19,15);
INSERT INTO Sales.OrderDetails VALUES(503,10438,34,20);
INSERT INTO Sales.OrderDetails VALUES(504,10438,57,15);
INSERT INTO Sales.OrderDetails VALUES(505,10439,12,15);
INSERT INTO Sales.OrderDetails VALUES(506,10439,16,16);
INSERT INTO Sales.OrderDetails VALUES(507,10439,64,6);
INSERT INTO Sales.OrderDetails VALUES(508,10439,74,30);
INSERT INTO Sales.OrderDetails VALUES(509,10440,2,45);
INSERT INTO Sales.OrderDetails VALUES(510,10440,16,49);
INSERT INTO Sales.OrderDetails VALUES(511,10440,29,24);
INSERT INTO Sales.OrderDetails VALUES(512,10440,61,90);
INSERT INTO Sales.OrderDetails VALUES(513,10441,27,50);
INSERT INTO Sales.OrderDetails VALUES(514,10442,11,30);
INSERT INTO Sales.OrderDetails VALUES(515,10442,54,80);
INSERT INTO Sales.OrderDetails VALUES(516,10442,66,60);
INSERT INTO Sales.OrderDetails VALUES(517,10443,11,6);
INSERT INTO Sales.OrderDetails VALUES(518,10443,28,12);

```
</details>

## Sample Database Diagram

![Sample Database Schema](../media/sample-database.png)