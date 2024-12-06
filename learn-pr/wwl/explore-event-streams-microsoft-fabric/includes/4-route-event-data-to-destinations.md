The drag and drop eventstream editing interface offers a straightforward and user-friendly method for constructing complex event data processing workflows. 

## Eventstream transformations

You can transform data in an eventstream by applying the following transformations:

  - **Filter**: Use the Filter transformation to filter events based on the value of a field in the input. Depending on the data type (number or text), the transformation keeps the values that match the selected condition, such as is `null` or `is not null`.
  - **Manage fields**: This transformation allows you to add, remove, change data type, or rename fields coming in from an input or another transformation.
  - **Aggregate**: Use the Aggregate transformation to calculate an aggregation (Sum, Minimum, Maximum, or Average) every time a new event occurs over a period of time. This operation also allows for the renaming of these calculated columns, and filtering or slicing the aggregation based on other dimensions in your data. You can have one or more aggregations in the same transformation.
  - **Group by**: Use the Group by transformation to calculate aggregations across all events within a certain time window. You can group by the values in one or more fields. It's like the Aggregate transformation allows for the renaming of columns, but provides more options for aggregation and includes more complex options for time windows. Like Aggregate, you can add more than one aggregation per transformation.
  - **Union**: Use the Union transformation to connect two or more nodes and add events with shared fields (with the same name and data type) into one table. Fields that don't match are dropped and not included in the output.
  - **Expand**: Use this array transformation to create a new row for each value within an array.
  - **Join**: this join is a transformation to combine data from two streams based on a matching condition between them.

## Windowing functions in Eventstream

Windowing functions are a way to perform operations on the data contained in temporal windows, such as aggregating, filtering, or transforming streaming events that occur within a specified time period. Windowing functions are useful for analyzing streaming data that changes over time, such as sensor readings, web-clicks, on-line transactions, and more and provide great flexibility to keep an accurate record of events as they occur.

Earlier, we mentioned the **Group by** operator in the event processor editor. This graphical interface allows us to define the logic we need for processing, transforming, and routing event data. There are four parameters that need specified in the **Group by** operator settings to use these windowing functions that include:

- The **window type**, which can be **tumbling, sliding, snapshot, hopping**, or **session**.
  - **tumbling windows** divides incoming events into fixed and nonoverlapping intervals based on arrival time.

    This window shows a count of tweets per time zone every 10 seconds apart.
      
     ![Screenshot of the tumbling window concept.](./media/../../media/tumbling-window.png)

  - **sliding windows** takes the events into fixed and overlapping intervals based on time and divides them.
   
     A window is a 10-second sliding window that alerts the user whenever an article is mentioned more than three times in under 10 seconds
  
     ![Screenshot of the sliding window concept.](./../media/sliding-window.png)
 
    > [!NOTE]
    > All of the tweets belong to the same topic in this scenario

  - **session windows** simply divides events into variable and nonoverlapping intervals that are based on a gap of lack of activity.
    
     A window, which shows the total count of tweets that occur within five minutes of one another
  
     ![Screenshot of the session window concept.](./../media/session-window.png)

  - **hopping windows** hopping windows are different from **tumbling** windows as they model scheduled overlapping window.
  
     A 10 second hopping window, which refreshes every 5 seconds and provides the total count of tweets over the past 10 seconds.
    
      ![Screenshot of the hopping window concept.](./../media/hopping-window.png)

  - **snapshot windows** snapshot windows group event stream events that have the same timestamp and are unlike the other windowing functions, which require the function to be named. In snapshot windows you add the ```System.Timestamp()``` to the ```GROUP BY``` clause.

    This window provides a count of tweets with the same article type that occur at exactly the same time.

     ![Screenshot of the snapshot window concept.](./../media/snapshot-window.png)

- The **window duration** is the length of each window interval, which can be in seconds, minutes, hours, and even days. An example duration, such as 10 minutes, means simply that each window covers 10 minutes of event data.
- The **window offset** is an optional parameter that shifts the start and end of each window interval by a specified amount of time. An example of when this optional parameter is set might be a window offset of 2 minutes, which means that each window starts and ends 2 minutes later than usual.
- The **grouping key** is one or more columns in your event data that you wish to group by. For example, by sensor ID, or item category.
- The **Aggregation function** is one or more of the functions that you want to apply to each group of events in each window. Where the counts, sums, averages, min/max, and even custom functions become useful.