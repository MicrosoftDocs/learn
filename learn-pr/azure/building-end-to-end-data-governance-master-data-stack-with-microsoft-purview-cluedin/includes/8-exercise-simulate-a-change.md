Exercise - Simulating a change in underlying data model

One of CluedIn's major strengths is that it can adapt to change very well. If there is a change in data model being sent to CluedIn, even on a per record level, CluedIn can adapt without having to stop the flow of data to downstream systems. 

In this exercise we are going to walk through a simulated experience where we will change the data model we are sending to CluedIn and then see how you can adapt to these changes in the user interface of CluedIn. 

Start by opening a Powershell Terminal and posting the following Json to the ingestion endpoint you just wrote. 

{
    "name": "Bill Gates"
}

Then post another record

{
    "name": "Satya Nadella"
}

Notice that this second record does not need mapping as it already has instructions it understands. 

Now let's make a small change to the object model

{
    "name": "Keanu Reeves",
    "age": 64
}

Notice that nothing broke down. You still have a record in CluedIn for Keanu Reeves, we have an age.

Now post something similar

{
    "name": "Elon Musk",
    "age": "51"
}

and post the same record again:

{
    "name": "Elon Musk",
    "age": "51"
}

Notice that these records merge together. This is because there is a requirement to have at least one unique way to refer to this record. 

There is a subtle difference here, in that the types are different for the age. This is 100% fine in CluedIn, this is just the nature of systems changing underneath it. 

{
    "name": "Steve Ballmer", 
    "ageRange": "50-75"
}

For this, you have a choice to make, but it doesn't have to happen straight away, we can make the choice when we are ready to make the choice. Do you map ageRange to age? Do you map age to ageRange? Do you keep them as separate keys?

{
    "id": "1234567890", 
    "name": "Elon Musk", 
    "age": "51"
}

We now have a situation where we did not have a unique id before and we were using CluedIn to auto-generate a unique key based of a calculated hasd of all the properties. What happens to all the records that may have been merged together before because they had the same hash? Simple, when making the Id an Entity Code now, you will see that CluedIn prompts you if you would like to split all records that merged off the auto-generated key now that we have something a bit more explicit as an identifier. Or you can tell it to only do this from now on. 

{
    "id": "1234567890", 
    "name": "Elon Dusk", 
    "age": "52", 
    "companyName": "Tesla", 
    "jobTitle": "CEO", 
    "companyIndustry": "Automotive"
}

In this example above, when we inspect the data we can see that the properties for this record do really span across different Domains i.e. Person and Company. Considering that we want to be consuming data as Domains we need to split this record into two different records and create a relationship on it. The good news is that data is still flowing, nothing has broken down, but we would like to retroactively make this cahnge and not have to cleanup. In reality, there is cleanup that will happen, but it will be handled by CluedIn. 

There is no Company Id in the data above, but we can use CluedIn to artifically generate a relationship. You can either split this data in CluedIn or you can update your Azure Data Factory job to send data to CluedIn already split - both are possible - but in the spirit of having CluedIn manage any model changes, we will do this in CluedIn. 

{
    "id": "1234567890", 
    "name": "Elon Dusk", 
    "age": "52", 
    "jobTitle": "CEO", 
    "companyId": 0987654321
}

CluedIn is smart enough to realise that denormalisation has occured and will offer to remove the 2 company properties off the Person record. 

On another ingestion stream, we are receiving

{
    "companyId": 0987654321,
    "companyName": "Tesla", 
    "companyIndustry": "Automotive"
}

Looks like reality hit us and that the underlying system figured this out like we did and change the model to do the denormlisation. We may think that we have generated some technical debt in generating the relationship, but this is 100% expected to happen and it is not debt, we still have an identifier on the Tesla copmany that will never be linked to again, but it won't get in our way. 

Let's really throw it off

{
    "cat": "1234567890", 
    "dog": "Elon Musk", 
    "person": "51"
}

Let's also assume that we now learn the the id column is actually not unique. Let's change the mapping to reflect this and then have CluedIn reprocess the data now knowing that this could not have ever been used as an identifier. 


In fact, let's assume that the same underlying system has gone through a drastic remodelling phase where the models we have been sent don't connect in the same way anymore. 

{
    "employeeId": "elon_musk_1", 
    "employeeStartDate": 11/05/2007, 
    "employeeEndDate": 11/11/2024
}

{
    "employeeId": "elon_musk_1", 
    "id": "1234567890", 
    "name": "Elon Musk", 
    "age": 51, 
    "JobPositionId": 124, 
}

{
     "JobPositionId": 124, 
     "Name": "CEO"
}

*You will notice that the Process button in the mapping UI will allow an end user to essentially reprocess all the history that has been sent to this endpoint. This is only necessary when you have these model changes happen. 