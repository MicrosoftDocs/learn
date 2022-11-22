A good report designer is always looking for ways to improve the end-user experience, and report speed is a common complaint. In an enterprise with many reports, every millisecond can improve the experience. By using Performance Analyzer, you can identify suboptimal report elements and adjust where possible.

## What is Performance Analyzer?

Performance Analyzer is a built-in feature in Power BI Desktop that measures how long report elements take to update and refresh, allowing you to see if certain elements are significantly slower.

## Monitor with Performance Analyzer

In Power BI Desktop, navigate to the **View** ribbon, then select **Performance Analyzer**. The Performance Analyzer pane will appear to the right of the canvas. When you're ready to interact with the report, select the **Start Recording** button, perform report actions like adjusting slicers, highlighting values, changing pages, etc. You can also **Refresh visuals**, and then **Stop** when you're done.

Some easy ways to improve performance include:

* **Limit visuals per page.** If the entire page is slow to load, consider spreading visuals across multiple pages instead.
* **Remove unnecessary columns and rows.** For slower queries, review the data and determine if anything can be removed.
* **Set data types.** By default, Power BI will assume data types for imported columns, which should be verified, and all new columns must be manually set.
* **Apply most restrictive filters.** More data will take more time to load, and isn't always the best user experience either. Consider limited results first, and allow drilling for more details.

> [!TIP]
> The best time to optimize your report is before sharing it with end-users as it allows you to improve performance before soliciting user feedback. However, improvement is a continual process and can and should be done regularly once the report is live as well. Stay informed with the [Optimization guide for Power BI](/power-bi/guidance/power-bi-optimization).
