When you were first introduced to Power BI, you probably learned how to get data from various sources such as SQL Server databases, Excel files, and even text files. Creating the same or similar dataset for each report is tedious work. Further, if others also want to develop reports on that exact dataset, what's your process for sharing?

## Create reusable core assets

Assets can mean datasets, dataflows, reports, and dashboards. We'll most commonly mean datasets in this module. In our example above, you spent precious time curating the perfect dataset, and now you can share and reuse it. Before creating visuals, publish the file to Power BI service and effectively create a "core" dataset.

Next time someone needs to create a report on that dataset, they can connect to a Power BI dataset from Power BI Desktop. Publish to a shared location to allow peers to use the same dataset. A single shared dataset protects data integrity with a validated copy of data. This trustworthy dataset also prevents orphaned datasets when someone recreates a report without deleting the earlier copies. As an enterprise data analyst, it's your responsibility to be a good data steward to encourage the democratization of data rather than disparate copies of data with questionable quality.

![Screenshot from Power B I Desktop, showing the Power B I dataset connection option](../media/power-bi-datasets-connect.png)

## Create specialized datasets

In our introduction example, we recognized the need to reduce report size and provide targeted reports across regions. To meet these goals, we create specialized datasets. Instead of creating a single report with global data and adding filtering or row-level security to limit what regional data users can see, consider creating a new dataset with the specific regional data.

To create a specialized dataset, open a new Power BI Desktop instance, connect to the core dataset

> [!NOTE]
> In order to make changes to the model for a specialized dataset, you must enable the preview feature, [Direct-query datasets](/power-bi/connect-data/desktop-directquery-datasets-azure-analysis-services).


<<<<include screenshot of the convert feature when using pbi datasets connector>>>>


We'll provide an exercise at the end of this module to help you visualize this concept more.

## Promote and certify datasets

Now that we're going to maintain and share our core dataset, we need to let people know it exists. Endorsement makes it easier for users to find high-quality content they need.

You can currently endorse:

* Datasets
* Dataflow
* Reports
* Apps

**Promotion** allows you to highlight content you believe is valuable and ready for others to use. To promote content, you need write permissions in the workspace.

**Certification** is a more rigorous process. Because certified content is being highly regarded, first a Power BI administrator enables certification, specify information about how content can be certified, and identify reviewers who can certify content. If your Power BI administrator has allowed certifiable content, you'll either have to follow the steps to certification, or you may be granted permissions to directly certify content.

> [!TIP]
> You will know if you can certify directly if the *Certified* option is not greyed out.

To promote or certify content, you need to:

* Navigate to workspace
* Open *settings* for content
* Expand *Endorsement and discovery* section
* Select *Promoted* or *Certified*

> [!NOTE]
> There is also a *Make discoverable* option that allows users to find this content by name, tables, columns, etc.

See a screenshot below of the Endorsement section, with Promoted and Make discoverable selected. Certified is greyed out and there's a link to learn *How do I get my dataset certified?*.

![Screenshot of the Endorsement section as described above, with Promoted and Make discoverable selected. Certified is greyed out.](../media/power-bi-request-content-certification.png)

> [!INFO]
> Full details about Endorsement can be found [at the Power BI service Endorsement overview](/power-bi/collaborate-share/service-endorsement-overview).
