trigger CreateTaskAfterOrder on Shipping_Order__c (after insert) {

    if (Trigger.isInsert && Trigger.isAfter) {

        List<Task> tasks = new List<Task>();
        List<Id> shippingProjectIds = new List<Id>();
    
        // add all shipping order ids into a list
        for (Shipping_Order__c order : Trigger.new) {
            shippingProjectIds.add(order.Shipping_Project__c);
        }
    
        // fetch all projects by shipping order id list into a map of id and shipping project
        Map<Id, Shipping_Project__c> ownersMap = new Map<Id, Shipping_Project__c>([SELECT Id, Shipping_Project__c.OwnerId FROM Shipping_Project__c WHERE id in :shippingProjectIds]); 
    
        for (Shipping_Order__c order : Trigger.new ){
                            
                Task task = new Task();
                // get owner id from shipping project map
                task.OwnerId = ownersMap.get(order.Shipping_Project__c).OwnerId;
                task.Description = 'New order has been created ' + order.Name;
                task.WhatId = order.Customer__c;
                task.Status ='New';
                task.Subject ='Other';
                task.Priority ='Normal';

                // add task to list
                tasks.add(task);
       }
    
       // save list of all tasks
       Database.insert(tasks);
    }

}

