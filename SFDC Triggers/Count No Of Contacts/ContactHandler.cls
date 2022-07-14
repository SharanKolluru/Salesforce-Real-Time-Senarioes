public with sharing class ContactHandler {
  public ContactHandler() {
  }

  public static void incrementCount(List<Contact> contactsList) {
    List<Account> tobeUpdatedAccountsMap = new List<Account>();
    List<Id> accountIds = new List<Id>();

    for (Contact c : contactsList) {
      accountIds.add(c.AccountId);
    }

    Map<Id, Account> accountsMap = new Map<Id, Account>(
      [SELECT Count__c FROM Account WHERE Id IN :accountIds]
    );

    for (Contact c : contactsList) {
      if (accountsMap.get(c.AccountId) != null) {
        Account a = new Account();
        a.Id = c.AccountId;
        System.debug(' 🚀 ' + c.Account.Count__c);
        a.count__c = accountsMap.get(c.AccountId).Count__c + 1;
        tobeUpdatedAccountsMap.add(a);
      }
    }

    update tobeUpdatedAccountsMap;
  }

  public static void decrementCount(
    Map<Id, Contact> oldContactsMap,
    Map<Id, Contact> newContactsMap
  ) {
    List<Id> accountIds = new List<Id>();

    for (Contact c : oldContactsMap.values()) {
      accountIds.add(c.AccountId);
    }
    for (Contact c : newContactsMap.values()) {
      accountIds.add(c.AccountId);
    }

    Map<Id, Account> accountsMap = new Map<Id, Account>(
      [SELECT Count__c FROM Account WHERE Id IN :accountIds]
    );

    List<Account> tobeUpdatedAccountsMap = new List<Account>();
    for (Contact c : newContactsMap.values()) {
      Id oldAccountId = oldContactsMap.get(c.Id).AccountId;
      Id newAccountId = newContactsMap.get(c.Id).AccountId;
      if (
        (oldAccountId != null && newAccountId != null) &&
        (oldAccountId != newAccountId)
      ) {
        Account a = new Account();
        a.Id = c.AccountId;
        a.count__c = accountsMap.get(c.AccountId).Count__c + 1;
        tobeUpdatedAccountsMap.add(a);
      }
    }

    for (Contact c : oldContactsMap.values()) {
      Id oldAccountId = oldContactsMap.get(c.Id).AccountId;
      Id newAccountId = newContactsMap.get(c.Id).AccountId;
      if (
        (oldAccountId != null && newAccountId != null) &&
        (oldAccountId != newAccountId)
      ) {
        Account a = new Account();
        a.Id = c.AccountId;
        a.count__c = accountsMap.get(c.AccountId).Count__c - 1;
        tobeUpdatedAccountsMap.add(a);
      }
    }
    update tobeUpdatedAccountsMap;
  }

  public static void decrementDeleteCount(Map<Id, Contact> oldContactsMap) {
    List<Id> accountIds = new List<Id>();

    for (Contact c : oldContactsMap.values()) {
      accountIds.add(c.AccountId);
    }

    Map<Id, Account> accountsMap = new Map<Id, Account>(
      [SELECT Count__c FROM Account WHERE Id IN :accountIds]
    );

    Map<Id, Account> tobeUpdatedAccountsMap = new Map<Id, Account>();
    for (Contact c : oldContactsMap.values()) {
      Id oldAccountId = oldContactsMap.get(c.Id).AccountId;
      if ((oldAccountId != null)) {
        Account a = new Account();
        a.Id = c.AccountId;
        a.count__c = accountsMap.get(c.AccountId).Count__c + 1;
        tobeUpdatedAccountsMap.put(a.Id, a);
      }
    }

    for (Contact c : oldContactsMap.values()) {
      Id oldAccountId = oldContactsMap.get(c.Id).AccountId;
      if ((oldAccountId != null)) {
        Account a = new Account();
        a.Id = c.AccountId;
        a.count__c = accountsMap.get(c.AccountId).Count__c - 1;
        tobeUpdatedAccountsMap.put(a.Id, a);
      }
    }
    update tobeUpdatedAccountsMap.values();
  }
}
