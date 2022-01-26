public with sharing class MyContactListController {

    public static List<Contact> getContacts(Id recordId) {
        
        List<Contact> listOfContact;


        if (
            Contact.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Contact.fields.Id.isAccessible() &&
            Schema.SObjectType.Contact.fields.FirstName.isAccessible()&&
            Schema.SObjectType.Contact.fields.LastName.isAccessible()&&
            Schema.SObjectType.Contact.fields.Email.isAccessible()&&
            Schema.SObjectType.Contact.fields.Phone.isAccessible()

        ) {
            listOfContact =[Select Id, FirstName, LastName, Email, Phone From Contact Where AccountId = :recordId];
        }
        
         return listOfContact;
    }
    
}