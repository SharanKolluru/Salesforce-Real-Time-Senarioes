/************************************************************************************/
/* Author       : Sharan Kolluru                                                    */
/* Created Date :                                                                   */
/* Description  : Get FieldSet using FieldSetName & SObjectName                     */
/************************************************************************************/
public with sharing class GetFieldSet {
    public static List<FieldWrapper> getFieldSet(String fieldSetName, String ObjectName) {
        List<FieldWrapper> lstfieldWrapper = new List<FieldWrapper>();
        if(String.isNotBlank(fieldSetName) && String.isNotBlank(ObjectName)) {
          Map<String,Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();
          Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(ObjectName).getDescribe().FieldSets.getMap().get(fieldSetName);
              if(fieldSetObj != null) {
                  for(Schema.FieldSetMember fieldSet : fieldSetObj.getFields() ) {
                      lstfieldWrapper.add( new FieldWrapper(
                          String.ValueOf(fieldSet.getLabel()),
                          String.ValueOf(fieldSet.getFieldPath()), 
                          (fieldSet.getDBRequired() || fieldSet.getRequired()),
                          fieldMap.get(String.ValueOf(fieldSet.getFieldPath())).getDescribe().getInlineHelpText(),
                          fieldMap.get(String.ValueOf(fieldSet.getFieldPath())).getDescribe().isHtmlFormatted() &&
                          fieldMap.get(String.ValueOf(fieldSet.getFieldPath())).getDescribe().isCalculated(),
                          fieldSet.getType().name()
                      ));
                  }
              }
          }
          return lstfieldWrapper; 
      }
      
    public class FieldWrapper {
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public String fieldLabel {get;set;}
        @AuraEnabled public Boolean isRequired {get;set;}
        @AuraEnabled public String helpText {get;set;}
        @AuraEnabled public Boolean isHtmlFormatted {get;set;}
        @AuraEnabled public String fieldType {get;set;}
          
        public FieldWrapper(String fieldLabel,String fieldName,Boolean isRequired, String helpText, Boolean isHtmlFormatted, String fieldType) {
            this.fieldLabel  = fieldLabel;
            this.fieldName   = fieldName;
            this.isRequired  = isRequired;
            this.helpText    = helpText;
            this.isHtmlFormatted = isHtmlFormatted;
            this.fieldType    = fieldType;
        }
    }
}
