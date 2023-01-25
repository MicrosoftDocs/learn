

## Checkbox
<<display_name: Question 1>>
What is the default table structure within Azure Synapse Analytics if the data engineer doesn't define it within the Data Definition?

[x] Round-Robin  
[ ] Distributed  
[ ] Replicated  
[ ] Hash  

[explanation]  
Round-Robin is the defualt table type when loading data into Synapse Analytics unless otherwise defined by the data engineer or DBA?
[explanation]  

## Checkbox
<<display_name: Question 2>>
What type of slowly changing dimension over-writes existing data where no history is stored?

[x] Slowly changing dimension (SCD) 1  
[ ] Slowly changing dimension (SCD) 2  
[ ] Slowly changing dimension (SCD) 3  


[explanation]  
The SCD 1 will simply over-write the existing data and stores no history of the change as it was deemed as having no impact on historical reports.
[explanation]  

## Checkbox
<<display_name: Question 3>>
What is the simplest way to create a new Fact table in Synapse Analytics ?

[ ] Create External Table as Select (CETAS)  
[x] Create Table as Select (CTAS)  
[ ] Copy Command  


[explanation]  
The Create Table as Select (CTAS) is the simplest way to load data into a new table in Synapse Analytics.
[explanation]  