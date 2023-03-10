@IsTest
public class LeadTriggerHandlerTest {

    @IsTest
    static void testHandleAfterInsert() {
        // Create test data
        Country__c country = new Country__c(Name='United States of America', CountryISOCode2__c='US', CountryISOCode3__c='USA', Capital__c='Washington, D.C.', Region__c='Americas', Subregion__c='', RegionalBlocs__c='');
        insert country;
        Country__c c1=[Select Id, Name__c, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, RegionalBlocs__c From Country__c Where CountryISOCode2__c='US'];
        List<Lead> leads = new List<Lead>{
            new Lead(FirstName='Test', LastName='Lead', Company='Test Company', CountryISOCode2__c=country.CountryISOCode2__c)
        };
            
        
        // Call the trigger handler method
        Test.startTest();
        Insert leads;
        Test.stopTest();
        
        // Verify that the lead country information was updated
        Lead lead = [SELECT Country__c, CountryName__c, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, RegionalBlocs__c FROM Lead WHERE Id = :leads[0].Id];
        System.assertEquals('United States of America', lead.CountryName__c);
        System.assertEquals('US', lead.CountryISOCode2__c);
        System.assertEquals('USA', lead.CountryISOCode3__c);
        System.assertEquals('Washington, D.C.', lead.Capital__c);
        System.assertEquals('Americas', lead.Region__c);
        System.assertEquals(null, lead.Subregion__c);
        System.assertEquals(null, lead.RegionalBlocs__c);
    }

}