public with sharing class LeadTriggerHandler {
    
    public static void handleBeforeInsert(List<Lead> leads) {
        List<String> countryCodes = new List<String>();
        
        // Collect country ISO codes from Leads
        for (Lead lead : leads) {
            if (lead.CountryISOCode2__c != null) {
                countryCodes.add(lead.CountryISOCode2__c);
            }
        }
        
        // Query for Country records based on country ISO codes
        List<Country__c> countries = [
            SELECT Name, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, RegionalBlocs__c 
            FROM Country__c 
            WHERE CountryISOCode2__c IN :countryCodes
        ];
        
        // Create a map of Country records for easy lookup
        Map<String, Country__c> countryMap = new Map<String, Country__c>();
        for (Country__c country : countries) {
            countryMap.put(country.CountryISOCode2__c, country);
        }
        
        // Update Lead records with country information
        for (Lead lead : leads) {
            if (lead.CountryISOCode2__c != null) {
                Country__c country = countryMap.get(lead.CountryISOCode2__c);
                if (country != null) {
                    //lead.Country__c = country.Id;
                    lead.CountryName__c= country.name;
                    lead.CountryISOCode2__c = country.CountryISOCode2__c;
                    lead.CountryISOCode3__c = country.CountryISOCode3__c;
                    lead.Capital__c = country.Capital__c;
                    lead.Region__c = country.Region__c;
                    lead.Subregion__c = country.Subregion__c;
                    lead.RegionalBlocs__c = country.RegionalBlocs__c;
                }
            }
        }
    }
}