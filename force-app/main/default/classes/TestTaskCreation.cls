@isTest
public with sharing class TestTaskCreation {

@isTest static void testCreateTaskAfterOrder(){

        Test.startTest();
        Account account = new Account(Name = 'Test Account');
        Database.SaveResult resultAccount = Database.insert(account);

        Shipping_Project__c shippingProject = new Shipping_Project__c();
        Database.SaveResult resultsShippingProject = Database.insert(shippingProject);

        List<Shipping_Order__c> orders = new List<Shipping_Order__c>();

        for (Integer i = 0; i < 300; i++) {

            Shipping_Order__c order = new Shipping_Order__c();
            order.Status__c  ='New';
            order.Shipping_Project__c = shippingProject.id;
            order.Customer__c = account.id;
            order.Planned_TEU__c = i;
            orders.add(order);
        }

        List<Database.SaveResult> results = Database.insert(orders);

        for (Database.SaveResult result : results) {
            System.assertEquals(true, result.isSuccess());
        }

        List<Task> tasks = [SELECT Id, Status, Subject, Priority, WhatId, Description, OwnerId FROM Task];
        
        System.assertEquals(300, tasks.size());

        Task testedTask = tasks.get(1);
        System.assertEquals('New', testedTask.Status);
        System.assertEquals('Other', testedTask.Subject);
        System.assertEquals('Normal', testedTask.Priority);
        System.assertEquals(account.Id, testedTask.WhatId);
        System.assert(testedTask.Description.startsWith('New order has been created'));

        Test.stopTest();
        
    }
}
