/**********************************************************************/
/* Author       : Sharan Kolluru                                      */
/* Created Date : 14.03.2022                                          */
/* Test Class   :                                                     */
/* Description  :                                                     */
/* ------------------------- Change Logs ---------------------------- */
/* Changed By   : Date      : Description                             */
/**********************************************************************/
public with sharing class AccountHistory {

    //Solution O1: Track History
    public static void OnUpdateAccountHistory(List < Account > newRecords, Map < ID, Account > oldRecordMap) {

        final List<Schema.FieldSetMember> trackedFields = SObjectType.Account.FieldSets.HistoryTracking.getFields();

        if(trackedFields.isEmpty()) {
            System.debug('No data found in Account.FieldSets.HistoryTracking');
            return;
        }

        final List<Account_History__c> fieldChanges = new List<Account_History__c> ();

        for(Account newAccount: newRecords) {

            final Account oldAccount = oldRecordMap.get(newAccount.Id);

            for(Schema.FieldSetMember fsm: trackedFields) {
                String fieldName = fsm.getFieldPath();
                String fieldLabel = fsm.getLabel();

                if(newAccount.get(fieldName) == oldAccount.get(fieldName)) {
                    continue;
                }

                String oldValue = String.valueOf(oldAccount.get(fieldName));
                String newValue = String.valueOf(newAccount.get(fieldName));

                if(oldValue != null && oldValue.length() > 255) {
                    oldValue = oldValue.substring(0, 255);
                }

                if(newValue != null && newValue.length() > 255) {
                    newValue = newValue.substring(0, 255);
                }

                final Account_History__c accHis = new Account_History__c();

                accHis.Field_Label__c = fieldLabel;
                accHis.API_Name__c = fieldName;
                accHis.Account_Id__c = newaccount.Id;
                accHis.Changed_By__c = UserInfo.getUserId();
                accHis.Old_Value__c = oldValue;
                accHis.New_Value__c = newValue;

                fieldChanges.add(accHis);
            }
        }

        if(!fieldChanges.isEmpty()) {
            insert fieldChanges;
        }
    }

    /*
		//Solution 02: Using Trigger Handler
    public static void HandleTrigger(List<Account> newRecords, Map<ID,Account> oldRecordMap, System.TriggerOperation triggerEvent) {
    		switch on triggerEvent {
					when AFTER_UPDATE { 
              OnUpdateAccountHistory(newRecords, oldRecordMap);
          }
      	}
    }
		*/
}
