public with sharing class ShippingProjectController {

    @AuraEnabled
    public static List<Shipping_Project__c> getAllShippingProjects() {

        List<Shipping_Project__c> allProjects;

        if(
            Shipping_Project__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Shipping_Project__c.fields.Id.isAccessible() &&
            Schema.SObjectType.Shipping_Project__c.fields.Name.isAccessible()
        ){
            allProjects=[SELECT Id,Name FROM Shipping_Project__c];
        }

        return allProjects;
    }
}
