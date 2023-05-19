trigger AccountGoldClassTrigger on Account (before insert,before update) {
 for (Account a : Trigger.new)
    {   if(a.IsFirstTimeGoldMember__c==true && a.Customer_classification__c =='GOLD')
    {
        a.IsFirstTimeGoldMember__c=false;
        SendTwiloSMS.messageAPI(a.Phone, a.Name,'new');
    }
      }
   
}