({
    
    handleClick : function (cmp, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        $A.get("e.force:refreshView").fire();
    }
   
 
})