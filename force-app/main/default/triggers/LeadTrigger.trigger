trigger LeadTrigger on Lead (before insert, before Update) {
    LeadTriggerHandler.handleBeforeInsert(Trigger.new); 
}