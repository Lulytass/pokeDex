trigger CallPokeApiBatchTrigger on Pokemon__c (before insert) {
   if (Trigger.isBefore) { 
       if (Trigger.isInsert) {     
	 		for(Pokemon__c p : Trigger.new) {
        		p.Name = p.Name.substring(0,1).toUpperCase() + p.Name.substring(1).toLowerCase();
            }
        }
    } 
}