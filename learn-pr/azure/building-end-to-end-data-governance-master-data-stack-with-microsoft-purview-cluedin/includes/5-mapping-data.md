Now that the data has been onboarded into CluedIn in a staging area, we have to map the data from its current form into the new desired state. For this, we'll map the data in the CluedIn Studio.

Interestingly, CluedIn doesn't mandate that we onboard this data in any specific order. This simplifies the process since we don't need to do any upfront planning in order to provide referential integrity on the way into the CluedIn platform.

So, we can onboard the data in the order we find them in the datasources tab:

1. Navigate through Integrations in CluedIn to the ingestion endpoint called Companies.csv. It's worth mentioning that this isn't a CSV file hosted in CluedIn; it's the raw data hosted in the staging area in CluedIn. You'll see a preview of 10 rows of data, including the companies in our original CSV file.

    :::image type="content" source="../media/Data_Preview_Arca.png" alt-text="Screenshot of the CluedIn window, showing the companies.csv window.":::

1. CluedIn may prompt you to map the data, in which case you'll select the **Create Mapping** button. If not, you can select the **Map** tab and then the **Map** data button.

    :::image type="content" source="../media/Automapping_New_Employee.png" alt-text="Screenshot of the Create Mapping page in CluedIn, showing the configure tab.":::

1. Choose **Automated Mapping**.

1. On the **Configure** tab, you'll choose **Entity Type**. Add **Company** here.

    An Entity Type in CluedIn can be thought of as the Domain of the data we're working with. This is typically some type of noun such as a Person, Company, Vendor, or Dog.

    The concept of a **Company** might not exist within CluedIn already, but that's expected. CluedIn provides all of the domains in the Microsoft Common Data Model by default and some of the domains you'll need to master won't always fall into the ones that already exist.

1. Next, we're going to create a new **Vocabulary**. Think of this as the structure or "schema" of the domain. In the vocabulary box, you can search **Company**, but we're going to create a new structure that matches our data. Follow the prompts to create a new vocabulary, and you'll see a preview of the new structure that contains all the columns names the CSV has.

    :::image type="content" source="../media/Automapping_Create_Vocabulary.png" alt-text="Screenshot of the Create Mapping page in CluedIn, showing the vocabulary selector on the configure tab.":::

    Instead of creating the model of a **Company** upfront before ingesting data, we'll instead use the data to create our model and as we start to see more data on companies, we'll evolve and change the model as we need to. This agile approach yields an automated way for us to integrate the data - but also allows us to work with changes in model alongside the data.

1. Select **Create Mapping** to accept the default names. If you chose **Automated Mapping** as suggested, CluedIn will provide some automated *smarts* including the automated detection of potential unique identifiers of the data.

1. Let's investigate what CluedIn just did in the mapping, by selecting **Edit Mapping** on the lineage view.

    1. On the first screen, we can see that CluedIn has mapped the incoming data into a new column or attribute name that includes the name of the domain. If this name isn't something that we would like to keep, select the dropdown of any of the fields and add a new mapping to a name that you would prefer.

    1. Select the **Next** button and you will be taken to the entity mapping where we can see how CluedIn will interpret some of the data in its core properties.

    1. Notice that the Name of the entity in CluedIn has automatched to use the Company Name. Notice under the Origin Code Accordian that CluedIn has chosen the ID column as the Origin Code (Primary Key) and it has also chosen that both the ID and the Email most likely can be used as ways to uniquely look up each of the employees in this list.

    :::image type="content" source="../media/Remove_PersonId_Code.png" alt-text="Screenshot of the general details of the map entity tab of companies.csv.":::

1. Select **Next** to go to the next section that is called **Edges**.

    In this section we'll specify if there are columns that refer to records that aren't Companies, but are some type of relationship to another record. This could easily be a relationship to a Domain of the same type (Company) or in this example, it seems to be referring to a Person (from the column name person_id). We already that although it's a person, we could also say that it's referring to an Employee. The good part about CluedIn's mapping process, is that we can choose one type now and we can always come back and change this later, once we know more about our data. CluedIn will handle all the cleanup necessary.

    :::image type="content" source="../media/Person_Edge_Create.png" alt-text="Screenshot of the Add Edge menu on CluedIn.":::

1. Select the **Process** button where the 10 rows of data are submitted to the platform.

    :::image type="content" source="../media/Process_Companies.png" alt-text="Screenshot of the are you sure you want to process page in CluedIn.":::

1. Repeat the steps above for all the other files, until all the data is processed in the platform.

>[!NOTE]
> For the next part of the learning module, you will need to repeat the process above with the other 6 files with their respective Domains, Vocabularies, Identifiers and more.