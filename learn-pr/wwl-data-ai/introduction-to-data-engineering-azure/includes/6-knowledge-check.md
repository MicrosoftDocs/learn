

Choose the best response for each of the questions, then select **Check your answers**.

## Multiple Choice

What does a pipeline use to access data source and processing resources?

() Data Explorer pools {{That's incorrect. CosmsosDB is a globally distributed NoSQL document store.}}  
(x) Linked services {{That's correct.This is a built-in service from different products to support a replication-like synchronization of data.}}  
() External connections {{That's incorrect. This doesn't allow for processing resources.}}

## Multiple Choice

What kind of object should you add to a data flow to define a target to which data is loaded?

() Source {{That's incorrect. As the name indicates, this is where the data flows from, not to.}}  
() Transformation {{That's incorrect. Transformation is an in-line step which is prior to any movement to the target}}  
(x) Sink {{That's correct. This is the destination or target location of transformed data.}}

## Multiple Choice

What must you create to run a pipeline at scheduled intervals?

() A control flow {{That's incorrect. although there is a execute pipeline activity within the control flows, this executes another pipeline, not schedules it.}}  
(x) A trigger {{That's correct. Schedule trigger is a trigger that invokes a pipeline on a wall-clock schedule.}}  
() An activity {{That's incorrect. An activity is a step or process within a pipeline and doesn't schedule execution.}}